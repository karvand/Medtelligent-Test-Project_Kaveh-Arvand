using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using DataAccessLayer;

namespace Movie_Finder
{

    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class AutoComplete : System.Web.Services.WebService
    {
        readonly IMovieDataAccess _dataAccess = new MovieDataAccess();
        [WebMethod]
        public List<string> SearchMovies(string prefixText, int count)
        {
            List<string> titles = new List<string>();
            titles = _dataAccess.FindTitlesByKeyword(prefixText).ToList();
            return titles;
        }
    }
}