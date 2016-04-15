using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public interface IGenreDataAccess : IDataAccess
    {
        IEnumerable<Genre> FindGenres();
        Genre FindGenreById(int genreId);
        int InsertGenre(string insertedGenreName);
        int UpdateGenre(int genreId, string insertedGenre);
        IEnumerable<GetMovies_Result> FindMoviesByGenre(string genreName);
    }
}
