using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

public partial class Signup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Response.Redirect("Login.aspx");
    }
    protected void btnSignup_Click(object sender, EventArgs e)
    {
        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        SqlConnection conn = new SqlConnection(connectionString);
        conn.Open();
        Response.Write("Connection Open");
        SqlCommand cm;
        // Retrieve user input values
        string email = Request.Form["email"];
        string password = Request.Form["password"];
        string loginType = Request.Form["account-type"];

        // Create the SQL query
        string query = "INSERT INTO Users (Email, Password, LoginType) VALUES ('"+email+ "', '"+password+ "', '"+ loginType + "')";
        cm = new SqlCommand(query, conn);
        //SqlDataReader res = cm.ExecuteReader();
        // Execute the query
        int rowsAffected = cm.ExecuteNonQuery();

        if (rowsAffected > 0)
        {
            if (loginType == "s")
            {
                Response.Redirect("StudentRegistration.aspx");
            }
            if(loginType == "a")
            {
                Response.Redirect("AcademicRegistration.aspx");
            }
            if (loginType == "f")
            {
                Response.Redirect("AcademicRegistration.aspx");
            }
        }
        else
        {
            //Response.Write("Failed to insert user data.");
        }
        cm.Dispose();
        conn.Close();
    }


}