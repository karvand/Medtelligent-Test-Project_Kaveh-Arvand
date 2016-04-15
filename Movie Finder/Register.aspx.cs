using DataAccessLayer;
using Movie_Finder;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Movie_Finder
{
    public partial class Register : System.Web.UI.Page
    {
         IUserDataAccess _dataAccess = new UserDataAccess();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CheckUsernameAvailability(object sender, EventArgs e)
        {
            TextBox txtBox = (TextBox)sender;
            string insertedUsername = txtBox.Text;
            
            int result = ((IDataAccess)_dataAccess).FindAvailableEntity(insertedUsername);
            if (result != 0)
            {
                duplicateUsername.Text = "The user already exists";
            }
        }

        protected void AddUser(object sender, EventArgs e)
        {
            RequiredFieldValidator1.Enabled = true;
            string insertedUserName = Username.Text;
            string insertedPassword = EncryptDecrypt.Encrypt(Password.Text);
            string insertedFirstName = FirstName.Text;
            string insertedLastName = LastName.Text;
            if (!string.IsNullOrWhiteSpace(insertedUserName) && !string.IsNullOrWhiteSpace(insertedPassword) &&
                !string.IsNullOrWhiteSpace(insertedFirstName) && !string.IsNullOrWhiteSpace(insertedLastName))
            {
                int result = _dataAccess.InsertUser(insertedUserName, insertedPassword, insertedFirstName, insertedLastName);
                if (result > 0)
                {
                    SignUpMessage.ForeColor = System.Drawing.Color.Green;
                    SignUpMessage.Text = "You have signed up successfully.";
                }
                else
                {
                    SignUpMessage.Visible = true;
                    SignUpMessage.Text = "An Error Occured";
                }
            }
        }
    }
}