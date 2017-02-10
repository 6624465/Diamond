using Microsoft.Practices.EnterpriseLibrary.Data;
using NetStock.Contract;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;



namespace NetStock.DataFactory
{
    public class CompanyDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public CompanyDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<Company> GetList()
        {
            var lstCompany = db.ExecuteSprocAccessor(DBRoutine.LISTCOMPANY, MapBuilder<Company>
                                                    .MapAllProperties()
                                                    .DoNotMap(c => c.Logo)
                                                    .DoNotMap(c => c.CompanyAddress)
                                                    .Build()).ToList();



            foreach (var companyitem in lstCompany)
            {
                companyitem.BranchList = new BranchDAL().GetListByCompanyCode(companyitem.CompanyCode);

                companyitem.CompanyAddress = new AddressDAL().GetContactsByCustomer(new Address { AddressLinkID = companyitem.CompanyCode, AddressType = "Company" }).FirstOrDefault();

                if (companyitem.BranchList.Count > 0)
                {
                    foreach (var branchItem in companyitem.BranchList)
                    {
                        branchItem.BranchAddress = new AddressDAL().GetContactsByCustomer(new Address { AddressLinkID = branchItem.BranchCode, AddressType = "Branch" }).FirstOrDefault();
                    }
                }
            }

            return lstCompany;

        }


        public bool Save<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Save(item);

        }




        public bool Save<T>(T item) where T : IContract
        {
            var result = 0;

            var company = (Company)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVECOMPANY);

                db.AddInParameter(savecommand, "CompanyCode", System.Data.DbType.String, company.CompanyCode);
                db.AddInParameter(savecommand, "CompanyName", System.Data.DbType.String, company.CompanyName);
                db.AddInParameter(savecommand, "RegNo", System.Data.DbType.String, company.RegNo);
                //db.AddInParameter(savecommand, "Logo", System.Data.DbType.Object, company.Logo);
                db.AddInParameter(savecommand, "IsActive", System.Data.DbType.Boolean, company.IsActive);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, company.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, company.ModifiedBy);



                result = db.ExecuteNonQuery(savecommand, transaction);

                if (result > 0)
                {
                    AddressDAL addressDAL = new AddressDAL();
                    company.CompanyAddress.CreatedBy = company.CreatedBy;
                    company.CompanyAddress.ModifiedBy = company.ModifiedBy;
                    company.CompanyAddress.AddressLinkID = company.CompanyCode;
                    result = addressDAL.Save(company.CompanyAddress, transaction) == true ? 1 : 0;
                }



                if (result > 0)
                {
                    if (currentTransaction == null)
                        transaction.Commit();
                }
                else
                {
                    if (currentTransaction == null)
                        transaction.Rollback();
                }

            }
            catch (Exception ex)
            {
                if (currentTransaction == null)
                    transaction.Rollback();

                throw ex;
            }

            return (result > 0 ? true : false);

        }

        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var company = (Company)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETECOMPANY);

                db.AddInParameter(deleteCommand, "CompanyCode", System.Data.DbType.String, company.CompanyCode);


                result = Convert.ToBoolean(db.ExecuteNonQuery(deleteCommand, transaction));

                transaction.Commit();

            }
            catch (Exception ex)
            {
                transaction.Rollback();
                throw ex;
            }

            return result;
        }

        public IContract GetItem<T>(IContract lookupItem) where T : IContract
        {
            var item = ((Company)lookupItem);

            var companyItem = db.ExecuteSprocAccessor(DBRoutine.SELECTCOMPANY,
                                                    MapBuilder<Company>
                                                    .MapAllProperties()
                                                    .DoNotMap(ad => ad.CompanyAddress)
                                                    .DoNotMap(ad => ad.Logo)
                                                    .Build(),
                                                    item.CompanyCode).FirstOrDefault();

            if (companyItem == null)
            {
                return null;
            }

            companyItem.CompanyAddress = GetCompanyAddress(companyItem);


            return companyItem;
        }

        #endregion


        public Address GetCompanyAddress(Company companyItem)
        {
            var contactItem = new NetStock.Contract.Address
            {
                AddressLinkID = companyItem.CompanyCode,
                AddressType = "Company"
            };

            var currentAddress = new AddressDAL().GetContactsByCustomer(contactItem).FirstOrDefault();


            //companyItem.ContactItem =  new ContactDAL().GetItem(contactItem);

            return currentAddress;



        }



    }
}

