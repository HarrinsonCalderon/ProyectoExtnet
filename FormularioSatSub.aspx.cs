using Ext.Net;
using Oracle.DataAccess.Client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Ext.Net;
namespace ProyectoExtnet
{
    public partial class FormularioSatSub : System.Web.UI.Page
    {
        string bandera = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //ban = "guardar";
                Session["ban"] = "guardar";
                getPersonas();
            }
            if(WindowAgregar.Hidden){
                guardar.Text = "Guardar";
            }
            //if (Session["ban"].ToString() == "guardar")
            //{
            //    guardar.Text = "Guardar";
            //}
            //else { 
            //    guardar.Text = "Actualizar";

            //}

        }
        private void getPersonas()
        {
            try
            {
                OracleConnection Con = new OracleConnection("Data Source =DESKTOP-LJ09AOA;Password=oracle;User Id=SYSTEM;");
                Con.Open();
                OracleCommand comando = new OracleCommand("select * from PersonaN order by idPersona", Con);
                OracleDataReader lector = comando.ExecuteReader();

                List<Persona> l = new List<Persona>();

                while (lector.Read())
                {

                    Persona p = new Persona();

                    string id = lector.GetValue(0).ToString();
                    string nom = lector.GetString(1).ToString();
                    string email = lector.GetString(2).ToString();

                    p.id = id;
                    p.nombre = nom;
                    p.email = email;
                    l.Add(p);
                }

                TiendaStore.DataSource = l;
                TiendaStore.DataBind();
                Con.Close();
                //Console.WriteLine(1);
            }
            catch (Exception e)
            {
                X.Msg.Alert("Error", "Error").Show();
            }

        }
        [Ext.Net.DirectMethod]
        public void agregarNuevo(object sender, DirectEventArgs e) {
            WindowAgregar.Show();
        }
        [Ext.Net.DirectMethod]
        protected void AgregarTarea(object sender, DirectEventArgs e)
        {
            try
            {
                if (Session["ban"].ToString() == "guardar") {


                    OracleConnection Con = new OracleConnection("Data Source =DESKTOP-LJ09AOA;Password=oracle;User Id=SYSTEM;");
                    OracleCommand comando = new OracleCommand("p_agregarPersona", Con);
                    comando.CommandType = System.Data.CommandType.StoredProcedure;
                    comando.Parameters.Add("nombre", OracleDbType.Varchar2).Value = Nombre.Text.Trim();
                    comando.Parameters.Add("email", OracleDbType.Varchar2).Value = Email.Text.Trim();

                    Con.Open();
                    comando.ExecuteNonQuery();
                    Con.Close();
                    WindowAgregar.Hide();
                    getPersonas();
                    Nombre.Text = "";
                    Email.Text = "";
                    X.Msg.Alert("Agregado", "Registro agregado").Show();
                } else if (Session["ban"].ToString() == "actualizar") {

                    OracleConnection Con = new OracleConnection("Data Source =DESKTOP-LJ09AOA;Password=oracle;User Id=SYSTEM;");
                    OracleCommand comando = new OracleCommand("p_actualizarPersona", Con);
                    comando.CommandType = System.Data.CommandType.StoredProcedure;
                    comando.Parameters.Add("nombre", OracleDbType.Varchar2).Value = Nombre.Text.Trim();
                    comando.Parameters.Add("email", OracleDbType.Varchar2).Value = Email.Text.Trim();
                    comando.Parameters.Add("idd", OracleDbType.Int64).Value = Int64.Parse(hiddenId.Text.ToString());

                    Con.Open();
                    comando.ExecuteNonQuery();
                    Con.Close();
                    getPersonas();
                    Nombre.Text = "";
                    Email.Text = "";
                    X.Msg.Alert("Actualizado", "Registro actualizado").Show();
                    Session["ban"] = "guardar";
                    guardar.Text = "guardar";
                    WindowAgregar.Hide();

                }
            }
            catch (Exception ea)
            {
                X.Msg.Alert("Error", "Error" + ea.Message).Show();
            }
        }

        [Ext.Net.DirectMethod(ShowMask = true, Msg = "Por favor espera")]
        public void EditarPersona(int id)
        {
            try
            {
                OracleConnection Con = new OracleConnection("Data Source =DESKTOP-LJ09AOA;Password=oracle;User Id=SYSTEM;");
                Con.Open();
                OracleCommand comando = new OracleCommand("select * from PersonaN where idpersona=" + id, Con);
                OracleDataReader lector = comando.ExecuteReader();

                List<Persona> l = new List<Persona>();

                while (lector.Read())
                {

                    Persona p = new Persona();

                    string id2 = lector.GetValue(0).ToString();
                    string nom = lector.GetString(1).ToString();
                    string email = lector.GetString(2).ToString();

                    p.id = id2;
                    p.nombre = nom;
                    p.email = email;
                    l.Add(p);
                }
                Con.Close();
                hiddenId.Text = l[0].id.ToString();
                Nombre.Text = l[0].nombre.ToString();
                Email.Text = l[0].email.ToString();
                guardar.Text = "Actualizar";
                Session["ban"] = "actualizar";
                WindowAgregar.Show();
               
                //Console.WriteLine(1);
            }
            catch (Exception e)
            {
                X.Msg.Alert("Error", "Error").Show();
            }
        }
        [Ext.Net.DirectMethod(ShowMask = true, Msg = "Por favor espera")]
        public void EliminarPersona(int id)
        {

            try
            {
                OracleConnection Con = new OracleConnection("Data Source =DESKTOP-LJ09AOA;Password=oracle;User Id=SYSTEM;");
                OracleCommand comando = new OracleCommand("p_eliminarPersona", Con);
                comando.CommandType = System.Data.CommandType.StoredProcedure;
                comando.Parameters.Add("idd", OracleDbType.Int64).Value = id;


                Con.Open();
                comando.ExecuteNonQuery();
                Con.Close();
                getPersonas();

                X.Msg.Alert("Eliminado", "Registro eliminado correctamente").Show();
            }
            catch (Exception e)
            {
                X.Msg.Alert("Error", "Error").Show();
            }
        }
    }
}
    