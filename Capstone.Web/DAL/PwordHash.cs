using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Security.Cryptography;
using System.Text;

namespace Capstone.Web.DAL
{
    public class PwordHash
    {
        /// <summary>
        /// Generates a single string from password, returns SALT and HASH seperated by a : (colon)
        /// </summary>
        /// <param name="password"></param>
        /// <returns></returns>
        public string SQLSaltHashStore(string password)
        {
            string salt = CreateSalt(10);

            string hashedpassword = GenerateSHA256Hash(password, salt);

            string stored = $"{salt}:{hashedpassword}";

            return stored;

        }

        /// <summary>
        /// Checks if Users password (hashed with salt) match's Database data
        /// </summary>
        /// <param name="password"></param>
        /// <param name="salthashstored"></param>
        /// <returns></returns>
        public bool LoginCheck(string password, string salthashstored)
        {
            bool verify = false;

            string[] s1 = salthashstored.Split(':');
            string salt = s1[0];
            string hashed = s1[1];

            string toCheck = GenerateSHA256Hash(password, salt);

            if (toCheck==hashed)
            {
                verify = true;
            }

            return verify;
        }


        private string CreateSalt(int size)
        {
            var rng = new RNGCryptoServiceProvider();
            var buff = new byte[size];
            rng.GetBytes(buff);
            return Convert.ToBase64String(buff);
        }


        private string GenerateSHA256Hash(string input, string salt)
        {
            byte[] bytes = Encoding.UTF8.GetBytes(input + salt);

            SHA256Managed sHA256hashstring = new SHA256Managed();

            byte[] hash = sHA256hashstring.ComputeHash(bytes);

            var sb = new StringBuilder();

            foreach (var b in hash) sb.AppendFormat("{0:x2}", b);

            return sb.ToString();
        }

    }
}