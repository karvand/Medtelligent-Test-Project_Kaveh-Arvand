using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class GenreDataAccess : IGenreDataAccess
    {
        public int FindAvailableEntity(string insertedGenre)
        {
            int result = 0;
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                Genre genre = (entities.sp_GetGenreByName(insertedGenre)).FirstOrDefault();
                if (genre != null)
                {
                    return result = 1;
                }
            }
            return result;
        }

        public IEnumerable<Genre> FindGenres()
        {
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                IEnumerable<Genre> genres = (entities.sp_GetGenres()).ToList();
                return genres;
            }
        }

        public Genre FindGenreById(int genreId)
        {
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                Genre genre = (entities.sp_GetGenreById(genreId)).FirstOrDefault();
                return genre;
            }
        }


        public IEnumerable<GetMovies_Result> FindMoviesByGenre(string genre)
        {
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                ObjectResult<GetMovies_Result> movies = entities.GetMoviesByGenre(genre);
                IEnumerable<GetMovies_Result> movieList = new List<GetMovies_Result>();
                movieList = (from a in movies select a).ToList();
                return movieList;
            }
        }

        public int InsertGenre(string insertedGenre)
        {
            int result = 0;
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                Genre genre = new Genre
                {
                    GenreName = insertedGenre
                };
                entities.Genres.Add(genre);
                result = entities.SaveChanges();
            }
            return result;
        }

        public int UpdateGenre(int genreId, string insertedGenre)
        {
            int result = 0;
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                result = entities.sp_UpdateGenre(genreId, insertedGenre);
            }
            return result;
        }

        public int DeleteEntity(int genreId)
        {
            int result = 0;
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                Genre genre = (entities.sp_GetGenreById(genreId)).FirstOrDefault();
                entities.Genres.Remove(genre);
                result = entities.SaveChanges();
            }
            return result;
        }
    }
}
