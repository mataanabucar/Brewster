﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Capstone.Web.Models.ViewModels
{
    public class ReviewModel
    {
        public int UserId { get; set; }
        public int BeerId { get; set; }
        public int Rating { get; set; }
        public string ReviewPost { get; set; }
        public DateTime Date { get; set; }
    }
}