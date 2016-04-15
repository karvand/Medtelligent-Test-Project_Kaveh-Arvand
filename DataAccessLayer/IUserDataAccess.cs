using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataAccessLayer
{
    public interface IUserDataAccess : IDataAccess
    {
        IEnumerable<User> FindUsers();
        int InsertUser(string insertedUserName, string insertedPassword, string insertedFirstName, string insertedLastName);
        bool FindUserByUsernamePassword(string insertedUsername, string insertedPassword);
        int UpdateUserProfile(int userId, string insertedFirstName, string insertedLastName);
    }
}
