using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;

namespace AdventuresInCrud_Miller
{
    class db
    {
        public static string getConnection()
        {
            string connString = System.Configuration.ConfigurationManager.AppSettings["connString"].ToString();
            return connString;
        }
        
    }
}
