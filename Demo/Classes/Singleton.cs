using System.Configuration;

namespace Demo.Classes
{
    public sealed class Singleton
    {
        #region Declaration

        private static Singleton instance = null;

        private static readonly object instanceLocked = new object();

        public string connectionString = ConfigurationManager.ConnectionStrings["DemoConnectionString"].ToString();

        public string insertUpdate = "[dbo].[tmUser_InserUpdate]";

        public string selectAll = "[dbo].[tmUser_SelectAll]";

        public string delete = "[dbo].[tmUser_Delete]";

        #endregion

        #region Constructor

        Singleton()
        {
        }

        #endregion

        #region Public Methods

        public static Singleton InstanceCreation()
        {
            if (instance == null)
            {
                lock (instanceLocked)
                {
                    if (instance == null)
                    {
                        instance = new Singleton();
                    }
                }
            }
            return instance;
        }

        #endregion
    }
}