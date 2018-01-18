using Demo.Classes;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace Demo.Models
{
    public class DatabaseHandler
    {
        #region Declaration

        Singleton instance = Singleton.InstanceCreation();

        private SqlCommand command;

        private SqlDataReader reader;

        #endregion

        #region Public Methods

        /// <summary>
        /// Gets list of all users
        /// </summary>
        /// <returns>Users list</returns>
        public List<User> GetAllUser()
        {
            var lst = new List<User>();
            using (var connection = new SqlConnection(instance.connectionString))
            {
                connection.Open();
                command = new SqlCommand("[dbo].[tmUser_SelectAll]", connection);
                command.CommandType = CommandType.StoredProcedure;
                reader = command.ExecuteReader();
                while (reader.Read())
                {
                    lst.Add(new User
                    {
                        UserId = Convert.ToInt32(reader["Id"]),
                        Name = reader["Name"].ToString(),
                        Age = Convert.ToInt32(reader["Age"])
                    });
                }
                return lst;
            }
        }

        /// <summary>
        /// Adds or updates a record in database
        /// </summary>
        /// <param name="user">User object</param>
        /// <returns>Rows affected</returns>
        public int AddUpdateUser(User user)
        {
            int i;
            using (var connection = new SqlConnection(instance.connectionString))
            {
                connection.Open();
                command = new SqlCommand("[dbo].[tmUser_InserUpdate]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Id", user.UserId);
                command.Parameters.AddWithValue("@Name", user.Name);
                command.Parameters.AddWithValue("@Age", user.Age);
                i = command.ExecuteNonQuery();
            }
            return i;
        }

        /// <summary>
        /// Deletes user's record from database
        /// </summary>
        /// <param name="ID">User Id</param>
        /// <returns>Rows affected</returns>
        public int DeleteUser(int userId)
        {
            int i;
            using (var connection = new SqlConnection(instance.connectionString))
            {
                connection.Open();
                command = new SqlCommand("[dbo].[tmUser_Delete]", connection);
                command.CommandType = CommandType.StoredProcedure;
                command.Parameters.AddWithValue("@Id", userId);
                i = command.ExecuteNonQuery();
            }
            return i;
        }

        #endregion
    }
}
