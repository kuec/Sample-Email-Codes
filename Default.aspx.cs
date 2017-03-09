using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data.Sql;
using System.Data;
using System.Configuration;
using ArlingtonTx.Gov.Security;
using BiddersWebVersion.Permissions;



namespace BiddersWebVersion
{
    public partial class WebForm1 : System.Web.UI.Page

    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["BiddersDBconnection"].ConnectionString);
        
        protected void Page_Load(object sender, EventArgs e)
        {
            //if (ValidatePermission() == false) { Response.Redirect("noAccess.html"); };
            try { 
                con.Open();
                con.Close();
            }
            catch (SqlException) { 
                Response.Redirect("error.html");
            }

            finally
            {
                if (ValidatePermission() == false)
                {
                    Response.Redirect("noAccess.html");
                }

                con.Close();

                if(!this.IsPostBack)
                {
                    SearchContractors();
                }
            }

            //if (ValidatePermission() == false)
            //{
            //    Response.Redirect("noAccess.html");
            //}

        }

        protected void ListBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {

        }


        protected void nameBox_TextChanged(object sender, EventArgs e)
        {

        }

        protected void IdBox_TextChanged(object sender, EventArgs e)
        {

        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            SearchContractors();
        }

        private void SearchContractors()
        {
            //string connectionString = ConfigurationManager.ConnectionStrings["BiddersDBConnection"].ConnectionString;
            //SqlConnection conn = new SqlConnection(connectionString);
            //SqlCommand cmd = new SqlCommand("SELECT_DefaultContractors", conn);
            //cmd.CommandType = CommandType.StoredProcedure;

            //SqlParameter Name = new SqlParameter("@Name", SqlDbType.VarChar);
            //Name.Value = SearchBox.Text.ToString().Replace("'", "['']").Trim();
            //cmd.Parameters.Add(Name);


            string connectionString = ConfigurationManager.ConnectionStrings["BiddersDBConnection"].ConnectionString;
            SqlConnection conn = new SqlConnection(connectionString);

            SqlCommand cmd = new SqlCommand();
            cmd.Connection = conn;

            cmd.CommandType = CommandType.StoredProcedure;

            string nameSearch = SearchBox.Text.Replace("'", "'''");
            //string nameSearch = SearchBox.Text.Replace("'", @"\'");
            //string nameSearch = SearchBox.Text;
            cmd.CommandText = ("SELECT_AllBidders");
            cmd.Parameters.AddWithValue("@Name", nameSearch);

            conn.Open();
            cmd.ExecuteNonQuery();

            //string value = SearchBox.Text;
            //value = value.Replace("'", "['']").Trim();

            //cmd.Parameters
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            //string OpnEdit = "Edit.aspx";

            //string edt = "window.open('" + OpnEdit + "', 'popup_window', 'width=400,height=300,left=100,top=100,resizable=yes');";
            //ClientScript.RegisterStartupScript(this.GetType(), "script", edt, true);
        }


        protected void addBtn_Click(object sender, EventArgs e)
        {
            //BiddersDatabase.InsertParameters["Name"].DefaultValue = ((TextBox)GridView1.FooterRow.FindControl("txtName")).Text;

            //BiddersDatabase.InsertParameters["Address"].DefaultValue = ((TextBox)GridView1.FooterRow.FindControl("txtAddress")).Text;

            //BiddersDatabase.InsertParameters["City"].DefaultValue = ((TextBox)GridView1.FooterRow.FindControl("txtCity")).Text;

            //BiddersDatabase.Insert();

        }


        protected void AddBidder_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                con.Close();
            }
            catch (SqlException)
            {
                Response.Redirect("error.html");
            }
            if (ValidatePermission() == false)
            {
                Response.Redirect("noAccess.html");
            }

            string url = "Add.aspx";

            string s = "window.open('" + url + "', 'popup_window', 'width=1015,height=650,left=100,top=100,resizable=yes');";
            ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
        }

        protected void DetailsView1_PageIndexChanging(object sender, DetailsViewPageEventArgs e)
        {

        }

        protected void ReportsBTN_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                con.Close();
            }
            catch (SqlException)
            {
                Response.Redirect("error.html");
            }
            if (ValidatePermission() == false)
            {
                Response.Redirect("noAccess.html");
            }

            string url = "ReportModule.aspx";

            string s = "window.open('" + url + "', 'popup_window', 'width=1000,height=800,left=100,top=100,resizable=yes');";
            ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
        
        }

        protected void AdminBtn_Click(object sender, EventArgs e)
        {

            try
            {
                con.Open();
                con.Close();
            }
            catch (SqlException)
            {
                Response.Redirect("error.html");
            }
            if (ValidatePermission() == false)
            {
                Response.Redirect("noAccess.html");
            }

            //string url = "AdminPanel.aspx";

            //string s = "window.open('" + url + "', 'popup_window', 'width=1000,height=800,left=100,top=100,resizable=yes');";
            //ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);

            string url = "AdminPanel.aspx";

            string s = "window.open('" + url + "', '_blank');";
            ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);

            //Response.Redirect("AdminPanel.aspx");

            //string url = "AdminPanel.aspx";
            //Response.Write("<script>");
            //Response.Write("window.open('" + url + "','_blank')");
            //Response.Write("</script>");
        
        }

        //protected void AllList_Click(object sender, EventArgs e)
        //{
        //}

        protected void ExportBtn3_Click1(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                con.Close();
            }
            catch (SqlException)
            {
                Response.Redirect("error.html");
            }
            if (ValidatePermission() == false)
            {
                Response.Redirect("noAccess.html");
            }

            Response.Redirect("ReportModule.aspx?Export=yes&SourceURL=Default.aspx&Stemplate=ListwPreq");

        }

        protected void ExportBtn1_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                con.Close();
            }
            catch (SqlException)
            {
                Response.Redirect("error.html");
            }
            if (ValidatePermission() == false)
            {
                Response.Redirect("noAccess.html");
            }

            Response.Redirect("ReportModule.aspx?Sstatus=Active&Export=yes&SourceURL=Default.aspx&Stemplate=ListwPreq");
        }

        protected void resetForm(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                con.Close();
            }
            catch (SqlException)
            {
                Response.Redirect("error.html");
            }
            if (ValidatePermission() == false)
            {
                Response.Redirect("noAccess.html");
            }

            Response.Redirect("Default.aspx");
        }

        //protected void ActiveList_Click(object sender, EventArgs e)
        //{
        //    string url = "ReportModule.aspx?Status=Active&Export=yes&SourceURL=Default.aspx&Stemplate=ListwPreq";

        //    string s = "window.open('" + url + "', 'popup_window', 'width=1000,height=800,left=100,top=100,resizable=yes');";
        //    ClientScript.RegisterStartupScript(this.GetType(), "script", s, true);
        //}


        //protected void DetailsView1_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        //{
        //    GridView.DataBind();
        //    GridView.SelectRow(-1);
        //}

        //protected void DetailsView1_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        //{
        //    GridView.DataBind();
        //    GridView.SelectRow(-1);
        //}

        //protected void DetailsView1_ItemInserted(object sender, DetailsViewInsertedEventArgs e)
        //{
        //    GridView.DataBind();
        //    GridView.SelectRow(-1);
        //}

        protected bool ValidatePermission()
        {
            //****GET CURRENT USER INFO
            string CU = "";
            CU = System.Web.HttpContext.Current.Request.LogonUserIdentity.Name;
            CU = CU.Substring(CU.IndexOf("\\") + 1);
            return ValidateAccess.CheckAccessLevel(CU,1);
        }

        protected void SearchBox_TextChanged(object sender, EventArgs e)
        {
            
        }

    }
}
