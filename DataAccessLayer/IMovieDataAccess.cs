using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public interface IMovieDataAccess :IDataAccess
    {
        IEnumerable<GetMovies_Result> FindMovies();
        IEnumerable<Genre> FindGenres();
        IEnumerable<string> FindTitlesByKeyword(string keyword);
        IEnumerable<GetMovies_Result> FindMoviesByKeyword(string keyword);
        string FindMoviesGroupedByGenre();
        int InsertMovie(string insertedTitle, string insertedDirector, short insertedReleaseYear, int insertedGenreId);
        int UpdateMovie(int movieId, string insertedTitle, short insertedReleaseYear, string insertedDirector, int insertedGenreId);
    }
}
