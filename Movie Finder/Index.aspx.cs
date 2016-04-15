using DataAccessLayer;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Movie_Finder
{
    public partial class Index : System.Web.UI.Page
    {
        readonly IMovieDataAccess _dataAccess = new MovieDataAccess();
        protected void Page_Load(object sender, EventArgs e)
        {
            SearchResult.Visible = false;
            Label1.Text = _dataAccess.FindMoviesGroupedByGenre();
        }

        protected void SearchMovie(object sender, EventArgs e)
        {
            GridView1.DataSource = _dataAccess.FindMoviesByKeyword(txtSearch.Text);
            GridView1.DataBind();
            SearchResult.Visible = true;
        }
    }
}