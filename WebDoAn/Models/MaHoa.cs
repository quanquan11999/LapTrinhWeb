using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Security.Cryptography;
using System.Text;
namespace WebDoAn.Models
{
    public class MaHoa
    {

        public static string encryptSHA256(string PlainText)
        {
            string result = "";
            using(SHA256 mh = SHA256.Create())
            {
                //----- Convert plain text to a bytes array
                byte[] sourceData = Encoding.UTF8.GetBytes(PlainText);
                //------ Compute Hash and return a byte array------
                byte[] hashResult = mh.ComputeHash(sourceData);
                result = BitConverter.ToString(hashResult);
            }
            return result;
        } 
    }
}