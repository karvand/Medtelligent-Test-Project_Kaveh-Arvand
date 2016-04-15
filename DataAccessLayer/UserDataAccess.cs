using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
     public class UserDataAccess : IUserDataAccess
    {

        public int FindAvailableEntity(string insertedUsername)
        {
            int result = 0;

            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                User user = (entities.GetUserByUsername(insertedUsername)).FirstOrDefault();
                if (user != null)
                {
                    return result = 1;
                }
            }
            return result;
        }

        public IEnumerable<User> FindUsers()
        {
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                IEnumerable<User> users = (entities.GetUsers()).ToList();
                return users;
            }
        }

        public int InsertUser(string insertedUserName, string insertedPassword, string insertedFirstName, string insertedLastName)
        {
            int result = 0;
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                User user = new User
                {
                    UserName = insertedUserName,
                    Password = insertedPassword,
                    FirstName = insertedFirstName,
                    LastName = insertedLastName
                };
                entities.Users.Add(user);
                result = entities.SaveChanges();
            }
            return result;
        }

        public bool FindUserByUsernamePassword(string insertedUsername, string insertedPassword)
        {
            bool result = false;

            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                User user = (entities.GetUserByUsernamePassword(insertedUsername, insertedPassword)).FirstOrDefault();
                if (user != null)
                {
                    return result = true;
                }
            }
            return result;
        }

        public int UpdateUserProfile(int userId, string insertedFirstName, string insertedLastName)
        {
            int result = 0;
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                result = entities.UpdateUser(userId, insertedFirstName, insertedLastName);
            }
            return result;
        }

        public int DeleteEntity(int userId)
        {
            int result = 0;
            using (MovieFinderEntities entities = new MovieFinderEntities())
            {
                User user = (entities.GetUserByUserId(userId)).FirstOrDefault();
                entities.Users.Remove(user);
                result = entities.SaveChanges();
            }
            return result;
        }
    }
}
