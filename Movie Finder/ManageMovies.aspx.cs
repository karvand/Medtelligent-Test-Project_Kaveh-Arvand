using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Movie_Finder
{
    public partial class ManageMovies : System.Web.UI.Page
    {
        readonly IMovieDataAccess _dataAccess = new MovieDataAccess();
        const int _endYear = 2016;
        public static List<int> createYears(int endYear)
        {
            List<int> years = new List<int>();
            for (int i = 1900; i <= endYear; ++i)
            {
                years.Add(i);
            }
            return years;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            redundantMovie.Text = "";
            if (!this.IsPostBack)
            {
                this.BindGrid();
                this.BindDropDownList1();
                this.BindDropDownList2();
            }
        }

        private void BindGrid()
        {
            GridView1.DataSource = _dataAccess.FindMovies();
            GridView1.DataBind();
        }

        private void BindDropDownList1()
        {
            DropDownListForGenres.DataSource = _dataAccess.FindGenres();
            DropDownListForGenres.DataBind();
        }

        private void BindDropDownList2()
        {
            List<int> years = createYears(_endYear);
            DropDownListForYears.DataSource = years;
            DropDownListForYears.DataBind();
        }

        protected void CheckMovieAvailability(object sender, EventArgs e)
        {
            TextBox txtBox = (TextBox)sender;
            string insertedMovie = txtBox.Text;
            int result = _dataAccess.FindAvailableEntity(insertedMovie);
            if (result != 0)
            {
                duplicateMovie.Text = "The movie already exists";
                AddButton.Enabled = false;
                AddButton.CssClass = "btn btn-lg btn-primary disabled";
            }
            else
            {
                AddButton.Enabled = true;
                AddButton.CssClass = "btn btn-lg btn-primary";
            }
        }

        protected void AddMovie(object sender, EventArgs e)
        {
            RequiredFieldValidator3.Enabled = true;
            RequiredFieldValidator4.Enabled = true;
            string insertedTitle = MovieTitle.Text;
            int insertedGenreId = Convert.ToInt16(DropDownListForGenres.SelectedValue);
            string insertedDirector = Director.Text;
            short insertedReleaseYear = Convert.ToInt16(DropDownListForYears.SelectedItem.Text);
            if (!string.IsNullOrWhiteSpace(insertedTitle) && !string.IsNullOrWhiteSpace(insertedDirector) &&
                 DropDownListForGenres.SelectedValue != "0" && DropDownListForYears.SelectedValue != "0")
            {
                int result = _dataAccess.InsertMovie(insertedTitle, insertedDirector, insertedReleaseYear, insertedGenreId);
                if (result > 0)
                {
                    AddButton.Enabled = false;
                    AddButton.CssClass = "btn btn-lg btn-primary disabled";
                    MovieTitle.Text = string.Empty;
                    this.BindGrid();
                }
                else
                {
                    redundantMovie.Visible = true;
                    redundantMovie.Text = "An Error Occured";
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
            RequiredFieldValidator3.Enabled = false;
            RequiredFieldValidator4.Enabled = false;
            Page.Validate();
            GridViewRow row = GridView1.Rows[e.RowIndex];
            int movieId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            string insertedTitle = (row.FindControl("movieTitle") as TextBox).Text;
            int insertedGenreId = Convert.ToInt16((row.FindControl("movieGenre") as DropDownList).SelectedValue);
            string insertedDirector = (row.FindControl("movieDirector") as TextBox).Text;
            short insertedReleaseYear = Convert.ToInt16((row.FindControl("movieReleaseYear") as DropDownList).SelectedItem.Text);
            int result = _dataAccess.UpdateMovie(movieId, insertedTitle, insertedReleaseYear, insertedDirector, insertedGenreId);
            if (!(result > 0))
            {
                redundantMovie.Visible = true;
                redundantMovie.Text = "An Error Occured";
            }
            GridView1.EditIndex = -1;
            this.BindGrid();
            RequiredFieldValidator3.Enabled = true;
            RequiredFieldValidator4.Enabled = true;
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
            redundantMovie.Visible = false;
        }

        protected void OnRowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int movieId = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Values[0]);
            int result =_dataAccess.DeleteEntity(movieId);
            if (!(result > 0))
            {
                redundantMovie.Visible = true;
                redundantMovie.Text = "An Error Occured";
            }
            this.BindGrid();
        }

        protected void OnRowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                foreach (Button button in e.Row.Cells[5].Controls.OfType<Button>())
                {
                    if (button.CommandName == "Delete")
                    {
                        button.Attributes["onclick"] = "if(!confirm('Do you want to delete this row?')){ return false; };";
                    }
                }
            }
            if (e.Row.RowType == DataControlRowType.DataRow && GridView1.EditIndex == e.Row.RowIndex)
            {
                DropDownList ddList1 = (DropDownList)e.Row.FindControl("movieGenre");
                ddList1.DataSource = _dataAccess.FindGenres();
                ddList1.DataTextField = "GenreName";
                ddList1.DataValueField = "GenreId";
                ddList1.DataBind();
                ddList1.Items.FindByText((e.Row.FindControl("lblGenre") as Label).Text).Selected = true;
                DropDownList ddList2 = (DropDownList)e.Row.FindControl("movieReleaseYear");
                ddList2.DataSource = createYears(_endYear);
                ddList2.DataBind();
                ddList2.Items.FindByText((e.Row.FindControl("lblReleaseYear") as Label).Text).Selected = true;
            }
        }
    }
}