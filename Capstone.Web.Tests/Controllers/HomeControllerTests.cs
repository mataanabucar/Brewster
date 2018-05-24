using Microsoft.VisualStudio.TestTools.UnitTesting;
using Capstone.Web.Controllers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;
using Capstone.Web.DAL;
using Moq;
using Capstone.Web.Models;

namespace Capstone.Web.Controllers.Tests
{
    [TestClass()]
    public class HomeControllerTests
    {
        [TestMethod()]
        public void HomeController_IndexAction_ReturnIndexView()
        {
            Mock<IBreweryServiceDAL> mockdal = new Mock<IBreweryServiceDAL>();
            //Arrange
            HomeController controller = new HomeController(mockdal.Object);

            //Act

            ViewResult result = controller.Index() as ViewResult;

            //Assert
            Assert.AreEqual("Index", result.ViewName);
        }


        [TestMethod()]
        public void AddBrewery()
        {
            Mock<IBreweryServiceDAL> mockdal = new Mock<IBreweryServiceDAL>();
            HomeController controller = new HomeController(mockdal.Object);
            Mock<ControllerContext> mock = new Mock<ControllerContext>();
            mock.Setup(c => c.HttpContext.Session["Admin"]).Returns("MyValue");
            controller.ControllerContext = mock.Object;




            //Act
            ViewResult result = controller.AddBrewery() as ViewResult;

            //Assert
            Assert.AreEqual("AddBrewery", result.ViewName);

        }

    }
}