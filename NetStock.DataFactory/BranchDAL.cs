using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Practices.EnterpriseLibrary.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using NetStock.Contract;
using System.Data.Common;



namespace NetStock.DataFactory
{
    public class BranchDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public BranchDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<Branch> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTBRANCH, MapBuilder<Branch>.MapAllProperties()
                                                            .DoNotMap(c => c.BranchAddress)
                                                            .Build()).ToList();
        }


        public List<Branch> GetListByCompanyCode(string companycode)
        {

            return db.ExecuteSprocAccessor(DBRoutine.LISTBRANCHBYCOMPANY, MapBuilder<Branch>
                                                            .MapAllProperties()
                                                            .DoNotMap(c => c.BranchAddress)
                                                            .Build(), companycode).ToList();
        }

        public bool Save<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Save(item);

        }




        public bool Save<T>(T item) where T : IContract
        {
            var result = 0;

            var branch = (Branch)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEBRANCH);

                db.AddInParameter(savecommand, "BranchID", System.Data.DbType.Int16, branch.BranchID);
                db.AddInParameter(savecommand, "BranchCode", System.Data.DbType.String, branch.BranchCode);
                db.AddInParameter(savecommand, "BranchName", System.Data.DbType.String, branch.BranchName);
                db.AddInParameter(savecommand, "RegNo", System.Data.DbType.String, branch.RegNo);
                db.AddInParameter(savecommand, "IsActive", System.Data.DbType.Boolean, branch.IsActive);
                db.AddInParameter(savecommand, "CompanyCode", System.Data.DbType.String, branch.CompanyCode);
                 
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, branch.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, branch.ModifiedBy);

                
                result = db.ExecuteNonQuery(savecommand, transaction);
                if (result > 0)
                {
                    AddressDAL addressDAL = new AddressDAL();
                    branch.BranchAddress.CreatedBy = branch.CreatedBy;
                    branch.BranchAddress.ModifiedBy = branch.ModifiedBy;
                    branch.BranchAddress.AddressLinkID = branch.BranchCode;
                    result = addressDAL.Save(branch.BranchAddress, transaction) == true ? 1 : 0;
                }
                if (result > 0)
                    transaction.Commit();
                else
                    transaction.Rollback();

            }
            catch (Exception)
            {
                transaction.Rollback();

                throw;
            }

            return (result > 0 ? true : false);

        }

        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var branch = (Branch)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEBRANCH);

                db.AddInParameter(deleteCommand, "BranchID", System.Data.DbType.Int16, branch.BranchID);

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
            var item = ((Branch)lookupItem);

            var branchItem = db.ExecuteSprocAccessor(DBRoutine.SELECTBRANCH,
                                                    MapBuilder<Branch>
                                                    .MapAllProperties()
                                                    .DoNotMap(b => b.BranchAddress)
                                                    .Build()
                                                    ,
                                                    item.BranchCode).FirstOrDefault();


            if (branchItem == null)
            {
                return null;
            }
            var contactItem = new NetStock.Contract.Address
            {
                AddressLinkID = branchItem.BranchCode,
                AddressType = "Branch"
            };

            branchItem.BranchAddress = new AddressDAL().GetContactsByCustomer(contactItem).FirstOrDefault();
            return branchItem;

        }

        #endregion






    }
}

