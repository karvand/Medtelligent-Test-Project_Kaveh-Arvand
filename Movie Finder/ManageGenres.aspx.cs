using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataAccessLayer;
using System.Drawing;

namespace Movie_Finder
{
    public partial class ManageGenres : System.Web.UI.Page
    {
        readonly IGenreDataAccess _dataAccess = new GenreDataAccess();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.BindGrid();
            }
        }

        private void BindGrid()
        {
            GridView1.DataSource = _dataAccess.FindGenres();
            GridView1.DataBind();
        }

        protected void CheckGenreAvailability(object sender, EventArgs e)
        {
            TextBox txtBox = (TextBox)sender;
            string insertedGenre = txtBox.Text;
            int result = _dataAccess.FindAvailableEntity(insertedGenre);
            if (result != 0)
            {
                duplicateGenre.Text = "The genre already exists";
                AddButton.Enabled = false;
                AddButton.CssClass = "btn btn-lg btn-primary disabled";
            }
            else
            {
                AddButton.Enabled = true;
                AddButton.CssClass = "btn btn-lg btn-primary active";
            }
        }


        protected void AddGenre(object sender, EventArgs e)
        {
            redundantGenre.Visible = false;
            RequiredFieldValidator1.Enabled = true;
            string insertedGenre = nameOfGenre.Text;
            if (!string.IsNullOrWhiteSpace(insertedGenre))
            {
                int result = _dataAccess.InsertGenre(insertedGenre);
                if (result > 0)
                {
                    AddButton.Enabled = false;
                    AddButton.CssClass = "btn btn-lg btn-primary disabled";
                    this.BindGrid();
                }
                else
                {
                    redundantGenre.Visible = true;
                    redundantGenre.Text = "An Error Occured";
                }
            }

        }

        protected void OnRowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            this.BindGrid();
        }

        protected void OnRowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            RequiredFieldValidator1.Enabled = false;
            Page.Validate();
            GridViewRow row = GridView1.Rows[e.RowIndex];
            int genreId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            string insertedGenre = (row.FindControl("genreName") as TextBox).Text;
            int result = _dataAccess.UpdateGenre(genreId, insertedGenre);
            if (!(result > 0))
            {
                redundantGenre.Text = "An Error Occured";
            }
            GridView1.EditIndex = -1;
            this.BindGrid();
        }

        protected void TextValidate(object source, ServerValidateEventArgs args)
        {
            ((CustomValidator)source).ForeColor = Color.Red;
            int result1 = _dataAccess.FindAvailableEntity(args.Value);
            if (result1 == 0)
                args.IsValid = true;
            else
                args.IsValid = false;
        }

        protected void OnRowCancelingEdit(object sender, EventArgs e)
        {
            GridView1.EditIndex = -1;
            this.BindGrid();
            redundantGenre.Visible = false;
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int genreId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            string genreName = (_dataAccess.FindGenreById(genreId)).GenreName.ToString();
            bool result1 = checkGenreForDeletion(genreName);
            if (result1)
            {
                int result2 = _dataAccess.DeleteEntity(genreId);
                if (!(result2 > 0))
                {
                    redundantGenre.Visible = true;
                    redundantGenre.Text = "An Error Occured";
                }
            }
            else
            {
                redundantGenre.Visible = true;
                redundantGenre.Text = "The genre is in use and cannot be deleted.";
            }
            this.BindGrid();
        }

        protected bool checkGenreForDeletion(string genreName)
        {
            bool result = false;
            IEnumerable<GetMovies_Result> outcome = _dataAccess.FindMoviesByGenre(genreName);
            if (outcome.ToList().Count == 0)
            {
                result = true;
                return result;
            }
            return result;
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                foreach (Button button in e.Row.Cells[2].Controls.OfType<Button>())
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