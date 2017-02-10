using Microsoft.Practices.EnterpriseLibrary.Data;
using NetStock.Contract;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;

namespace NetStock.DataFactory
{
    public class DashBoardDAL
    {
        private Database db;
        private DbTransaction currentTransaction = null;
        private DbConnection connection = null;

        /// <summary>
        /// Constructor
        /// </summary>
        public DashBoardDAL()
        {

            db = DatabaseFactory.CreateDatabase("netStock");

        }


        public MonthlyFiguresDashboard GetMonthlyFigures()
        {
            var item = db.ExecuteSprocAccessor(DBRoutine.MONTHLYFIGUREDASHBOARDATA,
                                                      MapBuilder<MonthlyFiguresDashboard>.BuildAllProperties()).FirstOrDefault();


            return item;
        
        }


    }
}
