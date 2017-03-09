using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace ROW_DB
{
    public partial class PermitsTable : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void fwdButton_Command(object sender, CommandEventArgs e)
        {
            DataSet ds = new DataSet();
            SqlConnection con = new SqlConnection();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["ROW_PermitsConnectionString"].ConnectionString;
            SqlCommand cmd = new SqlCommand("[ROW].Forward_Permit", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@username", System.Web.HttpContext.Current.Request.LogonUserIdentity.Name);
            cmd.Parameters.AddWithValue("ID", e.CommandArgument);
            //cmd.Parameters.Add("@Status", SqlDbType.Text).Value = "Forwarded";
            con.Open();
            cmd.ExecuteNonQuery();
            permitList.DataBind();
            con.Close();
        }
        protected void closeButton_Command(object sender, CommandEventArgs e)
        {
            DataSet ds = new DataSet();
            SqlConnection con = new SqlConnection("ROW_PermitsConnectionString");
            SqlCommand cmd = new SqlCommand("[ROW].Cancel_Permit", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@username", System.Web.HttpContext.Current.Request.LogonUserIdentity.Name);
            cmd.Parameters.AddWithValue("ID", e.CommandArgument);
            //cmd.Parameters.Add("@Status", SqlDbType.Text).Value = "Forwarded";
            con.Open();
            cmd.ExecuteNonQuery();
            permitList.DataBind();
            con.Close();
        }
        protected void ENGbutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Engineer.aspx");
        }

        protected void INSbutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Inspector.aspx");
        }

        protected void ADMbutton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
    }
}