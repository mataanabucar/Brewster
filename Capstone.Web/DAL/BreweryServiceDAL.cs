﻿using Capstone.Web.Models;
using Capstone.Web.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Capstone.Web.DAL
{
    public class BreweryServiceDAL : IBreweryServiceDAL
    {

        #region --- Contructors ---

        private const string _getLastIdSQL = " SELECT CAST(SCOPE_IDENTITY() as int);";

        private string connectionString;

        public BreweryServiceDAL()
        {
        }

        public BreweryServiceDAL(string connectionString)
        {
            this.connectionString = connectionString;
        }

        #endregion



        #region --- User Methods ---

        public User GetUser(string email, string userName)
        {
            User thisUser = new User();

            string sqlGetOne = "Select * from users WHERE users.email = @email OR users.username = @user;";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sqlGetOne, conn);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@user", userName);

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    thisUser = MapUserFromReader(reader);
                }
                return thisUser;
            }


        }

        public User LoginUser(string email)
        {
            User thisUser = new User();


            string sqlGetOne = "Select * from users WHERE users.email = @email;";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sqlGetOne, conn);
                cmd.Parameters.AddWithValue("@email", email);

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    thisUser = MapUserFromReader(reader);
                }

            }



            return thisUser;

        }




        public User SearchUserToAddBrewery(string email)
        {


            User users = new User();

            string sql = @"SELECT * FROM users WHERE email = @email";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@email", email);

                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    users = MapUserFromReader(reader);
                }
            }
            return users;
        }

        //This varia

        //public bool UserRegistration(User user)
        //{
        //    bool IsSuccessful = false;
        //    string sqlregistration = @"Insert into users(username, password, email) Values(@userName, @passWord, @email)";
        //    using (SqlConnection conn = new SqlConnection(connectionString))
        //    {
        //        conn.Open();
        //        SqlCommand cmd = new SqlCommand(sqlregistration, conn);
        //        cmd.Parameters.AddWithValue("@userName", user.UserName);
        //        cmd.Parameters.AddWithValue("@passWord", user.Password);
        //        cmd.Parameters.AddWithValue("@email", user.EmailAddress);

        //        IsSuccessful = (cmd.ExecuteNonQuery() > 0);
        //    }

        //    PwordHash p = new PwordHash();

        //    p.GenerateSHA256Hash("", "");

        //    return IsSuccessful;
        //}

        public bool UserRegistration(User user)
        {
            bool IsSuccessful = false;

            PwordHash p = new PwordHash();

            string hashed =  p.SQLSaltHashStore(user.Password);


            string sqlregistration = @"Insert into users(username, slowhashsalt, email) Values(@userName, @slowhashsalt, @email)";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sqlregistration, conn);
                cmd.Parameters.AddWithValue("@userName", user.UserName);
                cmd.Parameters.AddWithValue("@slowhashsalt", hashed);
                cmd.Parameters.AddWithValue("@email", user.EmailAddress);

                IsSuccessful = (cmd.ExecuteNonQuery() > 0);
            }


            return IsSuccessful;
        }



        #endregion



        #region --- Brewery Methods ---

        public int AddNewBrewery(string breweryName)
        {
            int brewID = 0;
            string sql = "INSERT INTO breweries (name) VALUES (@brewname);";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql + _getLastIdSQL, conn);
                cmd.Parameters.AddWithValue("@brewname", breweryName);
                brewID = (int)cmd.ExecuteScalar();

                
            }
            string picsetup = "insert into breweryPhotos values('defaultPhoto.jpg',@brewid,1)";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(picsetup, conn);
                cmd.Parameters.AddWithValue("@brewid", brewID);
                cmd.ExecuteNonQuery();
            }
            return brewID;

        }

        public bool LinkBrewerToBrewery(int userID, int breweryID)
        {
            string sql = "UPDATE users SET is_brewer = 1, brewery_id = @breweryID WHERE id = @userID";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql + _getLastIdSQL, conn);
                cmd.Parameters.AddWithValue("@userID", userID);
                cmd.Parameters.AddWithValue("@breweryID", breweryID);
                cmd.ExecuteNonQuery();

            }
            return true;

        }

        public bool AddNewBrewer(string username, string password, bool isBrewer, int breweryID, string email)
        {
            string sql = "INSERT INTO users values (@email, @username, @slowhashsalt, @isBrewer, @breweryID, @admin)";

            PwordHash p = new PwordHash();

            string hashed = p.SQLSaltHashStore(password);

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql + _getLastIdSQL, conn);
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@slowhashsalt", hashed);
                cmd.Parameters.AddWithValue("@isBrewer", isBrewer);
                cmd.Parameters.AddWithValue("@breweryID", breweryID);
                cmd.Parameters.AddWithValue("@email", email);
                cmd.Parameters.AddWithValue("@admin", false);
                int brewID = (int)cmd.ExecuteScalar();

            }
            return true;

        }

        public void UpdateUserBrewer(int brewID, string email)
        {

            string sql = @"UPDATE users SET is_brewer = @isbrewer, brewery_id = @brewID WHERE email = @email";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql + _getLastIdSQL, conn);
                cmd.Parameters.AddWithValue("@isbrewer", true);
                cmd.Parameters.AddWithValue("@brewID", brewID);
                cmd.Parameters.AddWithValue("@email", email);

                var reader = cmd.ExecuteReader();

            }
        }


        public List<Brewery> GetAllBrewerys()
        {
            string sql = "Select * from breweries";
            List<Brewery> brews = new List<Brewery>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql + _getLastIdSQL, conn);
                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    brews.Add(GetBrewery(reader));
                } 

            }
            foreach (var brewery in brews)
            {
                brewery.BreweryPhoto = GetBreweryProfilePhoto(brewery.BreweryID);
                brewery.OtherPhotos = GetBreweryOtherPhotos(brewery.BreweryID);

                if (brewery.BreweryPhoto.Filename == null)
                {
                    brewery.BreweryPhoto.Filename = "defaultPhoto.jpg";
                }

            }
            return brews;

        }

        public Brewery GetBreweryByID(int brewID)
        {
            string sql = "SELECT * FROM breweries WHERE id=@id";
            Brewery brews = new Brewery();


            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql + _getLastIdSQL, conn);
                cmd.Parameters.AddWithValue("@id", brewID);
                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    brews = GetBrewery(reader);
                }

                brews.BreweryPhoto = GetBreweryProfilePhoto(brewID);
                brews.OtherPhotos = GetBreweryOtherPhotos(brewID);
            }

            brews.Hours = GetHoursForBrewery(brewID);

            return brews;
        }

        public void UpdateBreweryInfo(Brewery b)
        {
            string sql = @"UPDATE breweries SET history=@history, address=@address, contact_name=@cname, contact_email=@email ,contact_phone=@phone WHERE breweries.id=@brewid";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@history", b.History);
                cmd.Parameters.AddWithValue("@address", b.Address);
                cmd.Parameters.AddWithValue("@cname", b.ContactName);
                cmd.Parameters.AddWithValue("@email", b.ContactEmail);
                cmd.Parameters.AddWithValue("@phone", b.ContactPhone);
                cmd.Parameters.AddWithValue("@brewid", b.BreweryID);
                cmd.ExecuteNonQuery();

            }
        }


        //string open0, string close0, string open1, string close1, string open2, string close2, string open3, string close3, string open4, string close4, string open5, string close5, string open6, string close6
        //public void UpdateBreweryHours(HoursViewModel m)


        public void UpdateBreweryHours(int brewID, string open0, string close0, string open1, string close1, string open2, string close2, string open3, string close3, string open4, string close4, string open5, string close5, string open6, string close6)
        {

            //DaysHoursOperation day = new DaysHoursOperation();

            HoursViewModel m = new HoursViewModel();
            m.DaysHours = new List<DaysHoursOperation>() {

                new DaysHoursOperation(){DayOfWeek = "Monday"},
                new DaysHoursOperation(){DayOfWeek = "Tuesday"},
                new DaysHoursOperation(){DayOfWeek = "Wednesday"},
                new DaysHoursOperation(){DayOfWeek = "Thursday"},
                new DaysHoursOperation(){DayOfWeek = "Friday"},
                new DaysHoursOperation(){DayOfWeek = "Saturday"},
                new DaysHoursOperation(){ DayOfWeek = "Sunday" }
            };
            m.BrewID = brewID;

            m.DaysHours[0].Opens = open0 ?? "CLOSED";
            m.DaysHours[1].Opens = open1 ?? "CLOSED";
            m.DaysHours[2].Opens = open2 ?? "CLOSED";
            m.DaysHours[3].Opens = open3 ?? "CLOSED";
            m.DaysHours[4].Opens = open4 ?? "CLOSED";
            m.DaysHours[5].Opens = open5 ?? "CLOSED";
            m.DaysHours[6].Opens = open6 ?? "CLOSED";

            m.DaysHours[0].Closes = close0 ?? "CLOSED";
            m.DaysHours[1].Closes = close1 ?? "CLOSED";
            m.DaysHours[2].Closes = close2 ?? "CLOSED";
            m.DaysHours[3].Closes = close3 ?? "CLOSED";
            m.DaysHours[4].Closes = close4 ?? "CLOSED";
            m.DaysHours[5].Closes = close5 ?? "CLOSED";
            m.DaysHours[6].Closes = close6 ?? "CLOSED";



            foreach (var day in m.DaysHours)
            {
                if (day.Opens == null)
                {
                    day.Opens = "CLOSED";
                }
                if (day.Closes == null)
                {
                    day.Closes = "CLOSED";
                }
            }




            string removeOLD = @"delete from operation where brewery_id = @brewID";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(removeOLD, conn);
                cmd.Parameters.AddWithValue("@brewID", m.BrewID);
                cmd.ExecuteNonQuery();
            }

            foreach (var day in m.DaysHours)
            {
                string sql = @"INSERT INTO OPERATION VALUES (@brewID, @day, @open, @close);";
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(sql + _getLastIdSQL, conn);
                    cmd.Parameters.AddWithValue("@brewID", m.BrewID);
                    cmd.Parameters.AddWithValue("@day", day.DayOfWeek);
                    cmd.Parameters.AddWithValue("@open", day.Opens);
                    cmd.Parameters.AddWithValue("@close", day.Closes);
                    cmd.ExecuteNonQuery();
                }
            }
        }



        public List<DaysHoursOperation> GetHoursForBrewery(int brewID)
        {
            List<DaysHoursOperation> hours = new List<DaysHoursOperation>();
            string sql = "SELECT * FROM OPERATION WHERE brewery_id = @brewid";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql + _getLastIdSQL, conn);
                cmd.Parameters.AddWithValue("@brewid", brewID);

                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    hours.Add(GetOps(reader));
                }
            }

            //foreach (var day in hours)
            //{

            //    if (day.Opens == "Not Set")
            //    {
            //        day.Opens = "";
            //    }
            //    if (day.Closes == "Not Set")
            //    {
            //        day.Closes = "";
            //    }
            //}

            return hours;
        }



        #endregion



        #region --- Photos ---



        public int GetLastAddedBrewPhotoID(int brewID)
        {
            int photoID = 0;
            BreweryPhoto photo = new BreweryPhoto();

            //string sql = "select SCOPE_IDENTITY() as BreweryPhotoID, FILE_NAME, brewery_id,profile_pic from breweryPhotos where brewery_id = @brewID";
            string sql = "SELECT cast(max(BreweryPhotoID) as int) as BreweryPhotoID from breweryPhotos where brewery_id=@brewID";

            //SELECT COALESCE(max(BreweryPhotoID), 1) FROM breweryPhotos WHERE brewery_id = 1;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@brewID", brewID);
                photoID = (int)cmd.ExecuteScalar();
            }
            return photoID;
        }

        public void UploadBreweryPhoto(string filename, int brewID, bool profilePic)
        {

            string sql = @"INSERT INTO breweryPhotos VALUES( @FILE_NAME, @brewery_id, @profile_pic)";
            int id = 0;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql + _getLastIdSQL, conn);
                cmd.Parameters.AddWithValue("@FILE_NAME", filename);
                cmd.Parameters.AddWithValue("@brewery_id", brewID);
                cmd.Parameters.AddWithValue("@profile_pic", profilePic);
                id = (int)cmd.ExecuteScalar();
            }
            string updateSQL = @"UPDATE breweryPhotos SET profile_pic = 0 WHERE BreweryPhotoID <> @id and brewery_id = @brewID";
            if (profilePic==true)
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(updateSQL, conn);
                    cmd.Parameters.AddWithValue("@brewID", brewID);
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public void UploadBeerPhoto(string filename, int beerID)
        {
            string sql = @"INSERT INTO beerPhotos VALUES( @FILE_NAME, @beer_id)";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql + _getLastIdSQL, conn);
                cmd.Parameters.AddWithValue("@FILE_NAME", filename);
                cmd.Parameters.AddWithValue("@beer_id", beerID);
                cmd.ExecuteReader();
            }
        }

        private BreweryPhoto GetBreweryProfilePhoto(int brewID)
        {
            string sql = @" SET LOCK_TIMEOUT 600; SELECT * FROM breweryPhotos WHERE brewery_id = @brewID and profile_pic = 1";

            BreweryPhoto brewphoto = new BreweryPhoto();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(sql + _getLastIdSQL, conn);
                    cmd.Parameters.AddWithValue("@brewID", brewID);
                    var reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        brewphoto = (MakeBreweryPhoto(reader));
                    }
                }
            }
            catch (Exception)
            {
                return brewphoto;
            }
            return brewphoto;
        }

        private List<BreweryPhoto> GetBreweryOtherPhotos(int brewID)
        {
            string sql = @" SET LOCK_TIMEOUT 600; SELECT * FROM breweryPhotos WHERE brewery_id = @brewID and profile_pic = 0";

            List<BreweryPhoto> brewphotos = new List<BreweryPhoto>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(sql + _getLastIdSQL, conn);
                    cmd.Parameters.AddWithValue("@brewID", brewID);
                    //cmd.ExecuteReader();
                    //cmd.ExecuteNonQuery();

                    var reader = cmd.ExecuteReader();

                    while (reader.Read())
                    {
                        brewphotos.Add(MakeBreweryPhoto(reader));
                    }
                }
            }
            catch (Exception)
            {
                return brewphotos;
            }
            return brewphotos;
        }



        #endregion



        #region --- Beer Methods ---


        public bool AddNewBeer(AddBeerModel newBeer, string photoname)
        {
            //add image later
            string SQL_AddBeer = "Insert into beers (name, description, abv, beer_type, brewery_id) Values(@Name, @Description, @AlcoholByVolume, @BeerType, @brewId);";
            int beerID = 0;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(SQL_AddBeer + _getLastIdSQL, conn);
                cmd.Parameters.Add(new SqlParameter("@Name", newBeer.Name));
                cmd.Parameters.Add(new SqlParameter("@Description", newBeer.Description));
                //cmd.Parameters.Add(new SqlParameter("@image", newBeer.Image));
                cmd.Parameters.Add(new SqlParameter("@AlcoholByVolume", newBeer.AlcoholByVolume));
                cmd.Parameters.Add(new SqlParameter("@BeerType", newBeer.BeerType));
                cmd.Parameters.Add(new SqlParameter("@brewId", newBeer.BreweryId));
                beerID = (int)cmd.ExecuteScalar();

            }
            string picsetup = "insert into beerPhotos values(@photoname, @beerid,@breweryid)";

            if (photoname==null)
            {
                photoname = "defaultPhoto.jpg";
            }


            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(picsetup, conn);
                cmd.Parameters.AddWithValue("@photoname", photoname);
                cmd.Parameters.AddWithValue("@beerid", beerID);
                cmd.Parameters.AddWithValue("@breweryid", newBeer.BreweryId);
                cmd.ExecuteNonQuery();
            }

            return true;
        }
        //This method will update the values of a beer that already exists within the database
        public void UpdateBeer(Beer b)
        {
            string SQL_UpdateBeer = "UPDATE beers SET name = @Name, description = @Description, abv = @AlcoholByVolume, beer_type = @BeerType WHERE beers.id =@BeerId;";

            using(SqlConnection conn = new SqlConnection(connectionString))
            {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_UpdateBeer + _getLastIdSQL, conn);
                    cmd.Parameters.AddWithValue("@Name", b.Name);
                    cmd.Parameters.AddWithValue("@Description", b.Description);
                    cmd.Parameters.AddWithValue("@AlcoholByVolume", b.AlcoholByVolume);
                    cmd.Parameters.AddWithValue("@BeerType", b.BeerType);
                    cmd.Parameters.AddWithValue("@BeerId", b.BeerID);
                    cmd.ExecuteNonQuery();
            }
        }

        //get beers from DB for dropdown in showhide
        public List<Beer> GetAllBeersFromBrewery(int breweryId)
        {
            string SQL_Beers = "Select * from beers where brewery_id = @breweryId";
            List<Beer> shb = new List<Beer>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {

                conn.Open();
                SqlCommand cmd = new SqlCommand(SQL_Beers, conn);
                cmd.Parameters.AddWithValue("@breweryId", breweryId);
                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    shb.Add(GetBeerFromReader(reader));
                }

                return shb;
            }
        }

        public List<Beer> GetAllBeers()
        {
            string SQL_Beers = "Select * from beers";
            List<Beer> beer = new List<Beer>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(SQL_Beers, conn);

                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    beer.Add(GetBeerFromReader(reader));
                }

            }


            return beer;

        }

        public Beer GetBeersById(int beerId)
        {
            string sql = "Select * from beers where id= @id";
            Beer beer = new Beer();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql + _getLastIdSQL, conn);
                cmd.Parameters.AddWithValue("@id", beerId);
                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    beer = (GetBeerFromReader(reader));
                }

            }
            return beer;
        }

       

        public void UpdateShowHide(int beerID, int showHide)
        {
            string SQL_ShowHide = @"UPDATE beers SET show_hide=@showhide WHERE id=@beerID ";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(SQL_ShowHide, conn);

                cmd.Parameters.AddWithValue("@showhide", showHide);
                cmd.Parameters.AddWithValue("@beerID", beerID);
                cmd.ExecuteNonQuery();
                
            }
        }

        public bool DeleteBeer(DeleteBeer beer)
        {
            string SQL_DeleteBeer = "Delete from beerPhotos WHERE beer_id = @BeerId; Delete from reviews WHERE beer_id = @BeerId; Delete from beers where id = @BeerId;";

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    SqlCommand cmd = new SqlCommand(SQL_DeleteBeer, conn);
                    cmd.Parameters.Add(new SqlParameter("@BeerId", beer.BeerId));
                    cmd.ExecuteNonQuery();

                }

                return true;
            
            
        }




        #endregion



        #region --- Beer Reviews ---
        //--------------------------BEER REVIEW-------------------------------------------

        public bool AddBeerReview(ReviewModel m)
        {
            string SQL_BeerReview = "Insert into reviews (user_id, beer_id, rating, review, review_date) Values(@userId, @beerId, @rating, @review, @date);";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                SqlCommand cmd = new SqlCommand(SQL_BeerReview, conn);
                cmd.Parameters.Add(new SqlParameter("@userId", m.UserId));
                cmd.Parameters.Add(new SqlParameter("@beerId", m.BeerId));
                cmd.Parameters.Add(new SqlParameter("@rating", m.Rating));
                cmd.Parameters.Add(new SqlParameter("@review", m.ReviewPost));
                cmd.Parameters.Add(new SqlParameter("@date", m.Date));
                cmd.ExecuteNonQuery();

            }

            return true;
        }



        public List<Beer> GetTopRatedBeers()
        {
            string sql = @" SELECT TOP 10 beer_id AS id, beers.name, beers.abv, beers.beer_type,
                                         CONVERT(DECIMAL(8, 2), ROUND(AVG(rating + 0.0), 2)) AS 'Average Rating',
                                         COUNT(*) AS 'Total Votes'
                            FROM reviews join beers on reviews.beer_id = beers.id
                            GROUP BY beer_id,beers.name, beers.abv, beers.beer_type
                            ORDER BY 'Total Votes' DESC;";
            List<Beer> topbeers = new List<Beer>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(sql, conn);
                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    topbeers.Add(GetTOPBeerFromReader(reader));
                }

            }
                return topbeers;
        }

        public List<Review> GetBeerReviewsById(int beerId)
        {
            string SQL_GetReviews = "SELECT username, rating, review, review_date FROM reviews JOIN users ON reviews.user_id = users.id WHERE beer_id = @beerId;";
            List<Review> reviews = new List<Review>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {

                conn.Open();
                SqlCommand cmd = new SqlCommand(SQL_GetReviews, conn);
                cmd.Parameters.AddWithValue("@beerId", beerId);
                var reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    reviews.Add(GetReviewsFromReader(reader));
                }

                return reviews;
            }
        }


        #endregion



        #region --- SQL Readers ---

        public User MapUserFromReader(SqlDataReader reader)
        {
            User thisUser = new User()
            {
                EmailAddress = Convert.ToString(reader["email"]),
                UserName = Convert.ToString(reader["username"]),
                //Password = Convert.ToString(reader["password"]),
                SaltHash = Convert.ToString(reader["slowhashsalt"]),
                IsBrewer = Convert.ToBoolean(reader["is_brewer"]),
                IsAdmin = Convert.ToBoolean(reader["is_admin"]),
                UserId = Convert.ToInt32(reader["id"])
            };
            var nullCheck = (reader["brewery_id"]);

            if (nullCheck != DBNull.Value)
            {
                thisUser.BreweryId = Convert.ToInt32(reader["brewery_id"]);
            }
            else
            {
                thisUser.BreweryId = 0;
            }

            return thisUser;
        }


        private DaysHoursOperation GetOps(SqlDataReader reader)
        {

            DaysHoursOperation hours = new DaysHoursOperation()
            {

                DayOfWeek = Convert.ToString(reader["day"]),
                Opens = Convert.ToString(reader["opens"]),
                Closes = Convert.ToString(reader["closes"])
            };

            return hours;
        }

        private BeerPhoto MakeBeerPhoto(SqlDataReader reader)
        {
            BeerPhoto beerpic = new BeerPhoto()
            {
                BeerPhotoID = Convert.ToInt32(reader["BeerPhotoID"]),
                Filename = Convert.ToString(reader["FILE_NAME"]),
                BeerID = Convert.ToInt32(reader["beer_id"]),
                BreweryID = Convert.ToInt32(reader["breweryID"])

            };
            return beerpic;
        }

        private BreweryPhoto MakeBreweryPhoto(SqlDataReader reader)
        {
            BreweryPhoto breweryPhoto = new BreweryPhoto();


            breweryPhoto.BreweryPhotoID = Convert.ToInt32(reader["BreweryPhotoID"]);

            
            breweryPhoto.Filename = Convert.ToString(reader["FILE_NAME"]);
            breweryPhoto.BreweryID = Convert.ToInt32(reader["brewery_id"]);
            breweryPhoto.ProfilePic = Convert.ToBoolean(reader["profile_pic"]);
            breweryPhoto.BreweryPhotoID = 0;

            var nullCheck = (reader["FILE_NAME"]);

            if (nullCheck != DBNull.Value)
            {
                breweryPhoto.Filename = Convert.ToString(reader["FILE_NAME"]);
            }
            else
            {
                breweryPhoto.Filename = "empty";
            }
            return breweryPhoto;
        }



        private Brewery GetBrewery(SqlDataReader reader)
        {
            Brewery brewery = new Brewery()
            {
                BreweryName = Convert.ToString(reader["name"]),
                Address = Convert.ToString(reader["address"]),
                ContactEmail = Convert.ToString(reader["contact_email"]),
                ContactName = Convert.ToString(reader["contact_name"]),
                ContactPhone = Convert.ToString(reader["contact_phone"]),
                History = Convert.ToString(reader["history"]),
                Imagery = Convert.ToString(reader["imagery"]),
                BreweryID = Convert.ToInt32(reader["id"])
            };
            return brewery;
        }

        private Beer GetBeerFromReader(SqlDataReader reader)
        {
            Beer beer = new Beer()
            {
                BeerID = Convert.ToInt32(reader["id"]),
                BreweryId = Convert.ToInt32(reader["brewery_id"]),
                Name = Convert.ToString(reader["name"]),
                Description = Convert.ToString(reader["description"]),
                AlcoholByVolume =Convert.ToString(reader["abv"]),
                BeerType = Convert.ToString(reader["beer_type"]),
                ShowHide = Convert.ToInt32(reader["show_hide"]),
                Image = Convert.ToString(reader["image"])

            };
            return beer;
        }

        private Beer GetTOPBeerFromReader(SqlDataReader reader)
        {
            Beer beer = new Beer()
            {
                BeerID = Convert.ToInt32(reader["id"]),
                Name = Convert.ToString(reader["name"]),
                AlcoholByVolume = Convert.ToString(reader["abv"]),
                BeerType = Convert.ToString(reader["beer_type"]),
                AverageRating = Convert.ToDecimal(reader["Average Rating"]),
                TotalVotes = Convert.ToInt32(reader["Total Votes"])

            };
            return beer;
        }


        private Review GetReviewsFromReader(SqlDataReader reader)
        {
            Review r = new Review()
            {
                Username = Convert.ToString(reader["username"]),
                Rating = Convert.ToInt32(reader["rating"]),
                ReviewPost = Convert.ToString(reader["review"]),
                Date = Convert.ToDateTime(reader["review_date"]),
            };
            return r;
        }


        #endregion




    }
}
