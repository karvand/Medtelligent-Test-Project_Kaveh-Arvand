using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Movie_Finder
{
    public partial class Login : System.Web.UI.Page
    {
        readonly IUserDataAccess _dataAccess = new UserDataAccess();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LoginUser(object sender, EventArgs e)
        {
            LoginMessage.Text = "";
            string insertedUsername = (Username.Text).Trim();
            string insertedPassword = EncryptDecrypt.Encrypt((Password.Text).Trim());
            bool loginStatus = _dataAccess.FindUserByUsernamePassword(insertedUsername, insertedPassword);
            if (loginStatus)
            {
                Session["username"] = (insertedUsername).ToLower();
                Response.Redirect("AdminMain.aspx", false);
            }
            else
            {
                LoginMessage.Text = "Invalid Username or Password";
            }
        }

    }
}