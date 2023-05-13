using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnSignup_Click(object sender, EventArgs e)
    {
        Response.Redirect("Signup.aspx");
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        SqlConnection conn = new SqlConnection(connectionString);
        conn.Open();
        Response.Write("Connection Open");
        SqlCommand cm;
        // Retrieve user input values
        string email = Request.Form["email"];
        string password = Request.Form["password"];
        string loginType = "s";

        // Create the SQL query
        string query = "Select UserID from Users where email = '"+email+"' AND password ='"+password+"'";
        cm = new SqlCommand(query, conn);
        SqlDataReader res = cm.ExecuteReader();

        // Execute the query

        if (res.HasRows)
        {
            res.Close();
            var result = cm.ExecuteScalar();
            Response.Redirect("Studentmain.aspx?userNum=" + result);
        }
        else
        {
            string script = "<script type='text/javascript'> showPopupImage(); </script>";
            ClientScript.RegisterStartupScript(this.GetType(), "PopupScript", script);
        }
        cm.Dispose();
        conn.Close();
    }

}