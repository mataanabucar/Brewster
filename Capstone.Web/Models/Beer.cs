﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Capstone.Web.Models
{
    public class Beer
    {
        public int BeerID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public string Image { get; set; }
        public string AlcoholByVolume { get; set; }
        public string BeerType { get; set; }
        public string BreweryName { get; set; }
        public int BreweryId { get; set; }
        public int ShowHide { get; set; }
        public decimal AverageRating { get; set; }
        public int TotalVotes { get; set; }
        public BeerPhoto Photo { get; set; }
    }

 
}