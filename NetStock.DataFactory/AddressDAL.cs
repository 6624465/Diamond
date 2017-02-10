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
    public class AddressDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public AddressDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }

        #region IDataFactory Members

        public List<Address> GetList()
        {
            return db.ExecuteSprocAccessor(DBRoutine.LISTADDRESS, MapBuilder<Address>.BuildAllProperties()).ToList();
        }

        public bool Save<T>(T item, DbTransaction parentTransaction) where T : IContract
        {
            currentTransaction = parentTransaction;
            return Save(item);

        }




        public bool Save<T>(T item) where T : IContract
        {
            var result = 0;

            var address = (Address)(object)item;

            if (currentTransaction == null)
            {
                connection = db.CreateConnection();
                connection.Open();
            }

            var transaction = (currentTransaction == null ? connection.BeginTransaction() : currentTransaction);


            try
            {
                var savecommand = db.GetStoredProcCommand(DBRoutine.SAVEADDRESS);

                db.AddInParameter(savecommand, "AddressId", System.Data.DbType.Int32, address.AddressId);
                db.AddInParameter(savecommand, "AddressLinkID", System.Data.DbType.String, address.AddressLinkID);
                db.AddInParameter(savecommand, "SeqNo", System.Data.DbType.Int16, address.SeqNo);
                db.AddInParameter(savecommand, "AddressType", System.Data.DbType.String, address.AddressType);
                db.AddInParameter(savecommand, "Address1", System.Data.DbType.String, address.Address1==null?"":address.Address1);
                db.AddInParameter(savecommand, "Address2", System.Data.DbType.String, address.Address2 == null ? "" : address.Address2);
                db.AddInParameter(savecommand, "Address3", System.Data.DbType.String, address.Address3 == null ? "" : address.Address3);
                db.AddInParameter(savecommand, "Address4", System.Data.DbType.String, address.Address4 == null ? "" : address.Address4);
                db.AddInParameter(savecommand, "CityName", System.Data.DbType.String, address.CityName==null? "": address.CityName);
                db.AddInParameter(savecommand, "StateName", System.Data.DbType.String, address.StateName==null? "" : address.StateName);
                db.AddInParameter(savecommand, "CountryCode", System.Data.DbType.String, address.CountryCode==null? "" : address.CountryCode);
                db.AddInParameter(savecommand, "ZipCode", System.Data.DbType.String, address.ZipCode==null?"" :address.ZipCode);
                db.AddInParameter(savecommand, "TelNo", System.Data.DbType.String, address.TelNo==null?"" :address.TelNo);
                db.AddInParameter(savecommand, "FaxNo", System.Data.DbType.String, address.FaxNo==null?"" :address.FaxNo);
                db.AddInParameter(savecommand, "MobileNo", System.Data.DbType.String, address.MobileNo==null?"" :address.MobileNo);
                db.AddInParameter(savecommand, "Contact", System.Data.DbType.String, address.Contact==null?"" :address.Contact);
                db.AddInParameter(savecommand, "Email", System.Data.DbType.String, address.Email==null?"" :address.Email);
                db.AddInParameter(savecommand, "WebSite", System.Data.DbType.String, address.WebSite==null?"" :address.WebSite);
                db.AddInParameter(savecommand, "IsBilling", System.Data.DbType.Boolean, address.IsBilling==null?false :address.IsBilling);
                db.AddInParameter(savecommand, "IsActive", System.Data.DbType.Boolean, address.IsActive == null ? false : address.IsActive);
                db.AddInParameter(savecommand, "CreatedBy", System.Data.DbType.String, address.CreatedBy);
                db.AddInParameter(savecommand, "ModifiedBy", System.Data.DbType.String, address.ModifiedBy);


                result = db.ExecuteNonQuery(savecommand, transaction);

                if (currentTransaction == null)
                    transaction.Commit();

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
            var address = (Address)(object)item;

            var connnection = db.CreateConnection();
            connnection.Open();

            var transaction = connnection.BeginTransaction();

            try
            {
                var deleteCommand = db.GetStoredProcCommand(DBRoutine.DELETEADDRESS);

                db.AddInParameter(deleteCommand, "AddressId", System.Data.DbType.Int64, address.AddressId);

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
            var item = ((Address)lookupItem);

            var addressItem = db.ExecuteSprocAccessor(DBRoutine.SELECTADDRESS,
                                                    MapBuilder<Address>.BuildAllProperties(),
                                                    item.AddressId).FirstOrDefault();
            return addressItem;
        }

        #endregion


        public List<Address> GetContactsByCustomer(IContract lookupItem)
        {
            return db.ExecuteSprocAccessor(DBRoutine.CONTACTLISTBYCUSTOMER,
                                                      MapBuilder<Address>
                                                      .MapAllProperties()
                                                      .Build(),
                                                      ((Address)lookupItem).AddressLinkID,
                                                      ((Address)lookupItem).AddressType).ToList();

        }



    }
}

