using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Movie_Finder
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        readonly IUserDataAccess _dataAccess = new UserDataAccess() ;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.BindGrid();
            }
        }

        private void BindGrid()
        {
            GridView1.DataSource = _dataAccess.FindUsers();
            GridView1.DataBind();
        }

        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            this.BindGrid();
        }

        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            Page.Validate();
            GridViewRow row = GridView1.Rows[e.RowIndex];
            int userId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            string insertedFirstName = (row.FindControl("FirstName") as TextBox).Text;
            string insertedLastName = (row.FindControl("LastName") as TextBox).Text;
            int result = _dataAccess.UpdateUserProfile(userId, insertedFirstName, insertedLastName);
            if (!(result > 0))
            {
                Message.Text = "An Error Occured";
            }
            GridView1.EditIndex = -1;
            this.BindGrid();
        }

        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            GridView1.EditIndex = -1;
            this.BindGrid();
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int userId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            int result = _dataAccess.DeleteEntity(userId);
            if (!(result > 0))
            {
                Message.Text = "An Error Occured";
            }
            this.BindGrid();
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                foreach (Button button in e.Row.Cells[4].Controls.OfType<Button>())
                {
                    if (button.CommandName == "Delete")
                    {
                        button.Attributes["onclick"] = "if(!confirm('Do you want to delete this row?')){ return false; };";
                    }
                }
            }
        }
    }
}