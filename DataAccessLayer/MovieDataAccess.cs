using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public class MovieDataAccess : IMovieDataAccess
    {
        public int FindAvailableEntity(string insertedMovie)
        {
            int result = 0;
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                Movie movie = (entities.sp_GetMoviesByName(insertedMovie)).FirstOrDefault();
                if (movie != null)
                {
                    return result = 1;
                }
            }
            return result;
        }

        public IEnumerable<GetMovies_Result> FindMovies()
        {
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                ObjectResult<GetMovies_Result> movies = entities.GetMovies();
                IEnumerable<GetMovies_Result> movieList = new List<GetMovies_Result>();

                movieList = (from a in movies select a).ToList();
                return movieList;
            }
        }

        public IEnumerable<Genre> FindGenres()
        {
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                IEnumerable<Genre> genres = (entities.sp_GetGenres()).ToList();
                return genres;
            }
        }

        public IEnumerable<string> FindTitlesByKeyword(string keyword)
        {
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                ObjectResult<string> titles = entities.GetMoviesByKeyword(keyword);
                IEnumerable<string> titleList = new List<string>();
                titleList = (from a in titles select a).ToList();
                return titleList;
            }
        }

        public IEnumerable<GetMovies_Result> FindMoviesByKeyword(string keyword)
        {
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                ObjectResult<GetMovies_Result> movies = entities.GetMovieCompleteByKeyword(keyword);
                IEnumerable<GetMovies_Result> movieList = new List<GetMovies_Result>();
                movieList = (from a in movies select a).ToList();
                return movieList;
            }
        }


        public string FindMoviesGroupedByGenre()
        {
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                var movies = from g in entities.Genres
                             orderby g.GenreName
                             join m in entities.Movies on g.GenreId equals m.GenreId into genreGroup
                             select new
                             {
                                 GenreName = g.GenreName,
                                 Movies = (from m2 in genreGroup
                                           orderby m2.MovieId descending
                                           select m2).Take(5)
                             };
                string result = null;
                foreach (var genreGroup in movies)
                {
                    result += "<h3><a href=MovieByGenre.aspx?g=" + System.Web.HttpContext.Current.Server.UrlEncode(genreGroup.GenreName) + ">" + genreGroup.GenreName + ":</a></h3>";
                    foreach (var movieItem in genreGroup.Movies)
                    {
                        result += "<br/><ul><li><b>" + movieItem.Title + " (" + movieItem.ReleaseYear + ") </b><br/> " + "Director: "
                            + movieItem.Director + "  " + movieItem.MovieId + "</li></ul>";
                    }

                    result += "<br/><hr/>";
                }
                return result;
            }
        }


        public int InsertMovie(string insertedTitle, string insertedDirector, short insertedReleaseYear, int insertedGenreId)
        {
            int result = 0;
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                Movie movie = new Movie
                {
                    Title = insertedTitle,
                    Director = insertedDirector,
                    ReleaseYear = insertedReleaseYear,
                    GenreId = insertedGenreId
                };
                entities.Movies.Add(movie);
                result = entities.SaveChanges();
            }
            return result;
        }

        public int UpdateMovie(int movieId, string insertedTitle, short insertedReleaseYear, string insertedDirector, int insertedGenreId)
        {
            int result = 0;
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                result = entities.sp_UpdateMovie(movieId, insertedTitle, insertedReleaseYear, insertedDirector, insertedGenreId);
            }
            return result;
        }

        public int DeleteEntity(int movieId)
        {
            int result = 0;
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                Movie movie = (entities.sp_GetMovieById(movieId)).FirstOrDefault();
                entities.Movies.Remove(movie);
                result = entities.SaveChanges();
            }
            return result;
        }
    }
}
