using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace Movie_Finder
{
    public class EncryptDecrypt
    {
        public static string Encrypt(string clearText)
        {
            const string encryptionKey = "V4ZVSAJI9GD6K5P"; //MAKV2SPBNI99212
            byte[] clearBytes = Encoding.Unicode.GetBytes(clearText);
            using (Aes encryptorAes = Aes.Create())
            {
                Rfc2898DeriveBytes deriveBytes = new Rfc2898DeriveBytes(encryptionKey, new byte[]
                {
                    0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76               
                });
                if (encryptorAes != null)
                {
                    encryptorAes.Key = deriveBytes.GetBytes(32);
                    encryptorAes.IV = deriveBytes.GetBytes(16);
                    using (MemoryStream memoryStream = new MemoryStream())
                    {
                        using (CryptoStream cryptoStream = new CryptoStream(memoryStream, encryptorAes.CreateEncryptor(),
                                CryptoStreamMode.Write))
                        {
                            cryptoStream.Write(clearBytes, 0, clearBytes.Length);
                            cryptoStream.Close();
                        }
                        clearText = Convert.ToBase64String(memoryStream.ToArray());
                    }
                }
            }
            return clearText;
        }

        public static string Decrypt(string cipherText)
        {
            const string encryptionKey = "V4ZVSAJI9GD6K5P";
            cipherText = cipherText.Replace(" ", "+");
            byte[] cipherBytes = Convert.FromBase64String(cipherText);
            using (Aes encryptorAes = Aes.Create())
            {
                Rfc2898DeriveBytes deriveBytes = new Rfc2898DeriveBytes(encryptionKey, new byte[]
                {
                    0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76               
                });
                if (encryptorAes != null)
                {
                    encryptorAes.Key = deriveBytes.GetBytes(32);
                    encryptorAes.IV = deriveBytes.GetBytes(16);
                    using (MemoryStream memoryStream = new MemoryStream())
                    {
                        using (
                            CryptoStream cryptoStream = new CryptoStream(memoryStream, encryptorAes.CreateDecryptor(),
                                CryptoStreamMode.Write))
                        {
                            cryptoStream.Write(cipherBytes, 0, cipherBytes.Length);
                            cryptoStream.Close();
                        }
                        cipherText = Encoding.Unicode.GetString(memoryStream.ToArray());
                    }
                }
            }
            return cipherText;
        }
    }
}