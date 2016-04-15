using DataAccessLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Movie_Finder
{
    public partial class MovieByGenre : System.Web.UI.Page
    {
        protected string genreName;
        readonly IGenreDataAccess _dataAccess = new GenreDataAccess();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["g"] != null)
                {
                    genreName = Request.QueryString["g"];
                    this.BindGrid();
                }
            }
        }

        private void BindGrid()
        {
            GridView1.DataSource = _dataAccess.FindMoviesByGenre(genreName);
            GridView1.DataBind();
        }
    }
}