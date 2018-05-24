using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Transactions;
using Capstone.Web.DAL;
using Capstone.Web.Models;
using Microsoft.VisualStudio.TestTools.UnitTesting;
//using System.Activities.Statements;

namespace Capstone.Web.Tests.DAL
{
    [TestClass()]
    public class BreweryTests
    {
        //private TransactionScope tran;
        //private const string _getLastIdSQL = " SELECT CAST(SCOPE_IDENTITY() as int);";
        //private string connectionString = @"Data Source=.\SQLEXPRESS;Initial Catalog=Brewery;Integrated Security=true;MultipleActiveResultSets=true;";
        ////private string connectionString = @"Server=e97f9259-7b19-4e1f-a69e-a8de004f3e34.sqlserver.sequelizer.com;Database=dbe97f92597b194e1fa69ea8de004f3e34;User ID=lnsbovcbcuoyrfab;Password=2LT7AwajNV2JoqeUQu4YN6UtDQnjwYvh6cUdsWSeFHvV8CYXRWrusjw4YyBSiXUW;MultipleActiveResultSets=True;";
        //private int breweryCount = 0;
        //private int breweryID = 0;

        //[TestInitialize]
        //public void Initialize()
        //{
        //    tran = new TransactionScope();
            
        //    using (SqlConnection conn = new SqlConnection(connectionString))
        //    {
        //        SqlCommand cmd;
        //        conn.Open();

        //        cmd = new SqlCommand("select count(*) from breweries", conn);
        //        breweryCount = (int)cmd.ExecuteScalar();

        //        cmd = new SqlCommand(@"INSERT INTO breweries(name, history, address, contact_name, contact_email, contact_phone)
        //                               VALUES('dummy brewery', 'dummy history', '123 street', 'unitTest', 'unit@test.com', '(513) 513-5135')" + _getLastIdSQL, conn);
        //        breweryID = (int)cmd.ExecuteScalar();
        //    }
        //}

        //[TestCleanup]
        //public void Cleanup()
        //{
        //    tran.Dispose();
        //}

        //[TestMethod()]
        //public void GetBreweryById()
        //{
        //    BreweryServiceDAL brew = new BreweryServiceDAL(connectionString);

        //    Brewery brewery = brew.GetBreweryByID(breweryID);

        //    Assert.IsNotNull(brewery);
        //    Assert.AreEqual(brewery.BreweryName, "dummy brewery");
            
        //}


        //[TestMethod()]
        //public void GetBreweryCount()
        //{
        //    BreweryServiceDAL brew = new BreweryServiceDAL(connectionString);

        //    List<Brewery> breweries = brew.GetAllBrewerys();

        //    Assert.AreEqual(breweryCount + 1, breweries.Count);

        //}

    }
}
