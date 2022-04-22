using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProyectoExtnet
{
    public partial class Menu : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            OracleConnection Con = new OracleConnection("Data Source =DESKTOP-LJ09AOA;Password=oracle;User Id=SYSTEM;");
            Con.Open();
            OracleCommand comando = new OracleCommand("select * from PersonaN", Con);
            OracleDataReader lector = comando.ExecuteReader();
            List<string> l = new List<string>();
            while (lector.Read())
            {
                string column = lector.GetString(2).ToString();
                l.Add(column);
            }
        }
    }
}