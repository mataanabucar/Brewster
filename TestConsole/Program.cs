using Capstone.Web.DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TestConsole
{
    class Program
    {
        static void Main(string[] args)
        {


            while (true)
            {
                PwordHash p = new PwordHash();

                string password = Console.ReadLine();

                string storedSaltHash = p.SQLSaltHashStore(password);

                Console.WriteLine(storedSaltHash);
                Console.ReadKey();

                string password2 = Console.ReadLine();

                bool check = p.LoginCheck(password2, storedSaltHash);



            }


        }
    }
}
