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
    public class CustomerDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public CustomerDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<Customer> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTCUSTOMER, MapBuilder<Customer>
                                                                   .MapAllProperties()
                                                                   .DoNotMap(cs=> cs.CustomerAddress)
                                                                   .Build()).ToList();
        }

        public bool Save<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Save(item);

        }




        public bool Save<T>(T item) where T : IContract
        {
            var result = 0;

            var customer = (Customer)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVECUSTOMER);

                db.AddInParameter(savecommand, "CustomerCode", System.Data.DbType.String, customer.CustomerCode);
                db.AddInParameter(savecommand, "CustomerName", System.Data.DbType.String, customer.CustomerName);
                db.AddInParameter(savecommand, "RegistrationNo", System.Data.DbType.String, customer.RegistrationNo==null?"":customer.RegistrationNo);
                db.AddInParameter(savecommand, "CustomerType", System.Data.DbType.String, customer.CustomerType);
                db.AddInParameter(savecommand, "Status", System.Data.DbType.Boolean, customer.Status);
                db.AddInParameter(savecommand, "Remark", System.Data.DbType.String, customer.Remark==null? "":customer.Remark);
                db.AddInParameter(savecommand, "CreditTerm", System.Data.DbType.Int16, customer.CreditTerm);
                db.AddInParameter(savecommand, "CustomerMode", System.Data.DbType.String, customer.CustomerMode);
                db.AddInParameter(savecommand, "AddressID", System.Data.DbType.String, customer.AddressID == null ? "" : customer.AddressID);
                db.AddInParameter(savecommand, "ContactPerson", System.Data.DbType.String, customer.ContactPerson == null ? "" : customer.ContactPerson);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, customer.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, customer.ModifiedBy);
                db.AddOutParameter(savecommand, "NewCustomerCode", System.Data.DbType.String, 25);




                result = db.ExecuteNonQuery(savecommand, transaction);

                if (result > 0)
                {

                    customer.CustomerCode = savecommand.Parameters["@NewCustomerCode"].Value.ToString();

                    AddressDAL addressDAL = new AddressDAL();
                    customer.CustomerAddress.CreatedBy = customer.CreatedBy;
                    customer.CustomerAddress.ModifiedBy = customer.ModifiedBy;
                    customer.CustomerAddress.AddressLinkID = customer.CustomerCode;
                    result = addressDAL.Save(customer.CustomerAddress, transaction) == true ? 1 : 0;
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
            catch (Exception)
            {
                if (currentTransaction == null)
                    transaction.Rollback();

                throw;
            }

            return (result > 0 ? true : false);

        }

        public bool Delete<T>(T item) where T : IContract
        {
            var result = false;
            var customer = (Customer)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETECUSTOMER);

                db.AddInParameter(deleteCommand, "CustomerCode", System.Data.DbType.String, customer.CustomerCode);
                db.AddInParameter(deleteCommand, "ModifiedBy", System.Data.DbType.String, customer.ModifiedBy);

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
            var item = ((Customer)lookupItem);

            var customerItem = db.ExecuteSprocAccessor(DBRoutine.SELECTCUSTOMER,
                                                    MapBuilder<Customer>
                                                    .MapAllProperties()
                                                    .DoNotMap(cs=> cs.CustomerAddress)
                                                    .Build(),
                                                    item.CustomerCode).FirstOrDefault();

            if (customerItem == null)
            {
                return null;
            }

            customerItem.CustomerAddress = GetCustomerAddress(customerItem);

            return customerItem;
        }

        #endregion



        public Address GetCustomerAddress(Customer companyItem)
        {
            var contactItem = new NetStock.Contract.Address
            {
                AddressLinkID = companyItem.CustomerCode,
                AddressType = companyItem.CustomerType
            };

            var currentAddress = new AddressDAL().GetContactsByCustomer(contactItem).FirstOrDefault();

            return currentAddress;



        }



    }
}

