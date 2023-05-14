using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AcademicRegistration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnReg_Click(object sender, EventArgs e)
    {
        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        SqlConnection conn = new SqlConnection(connectionString);
        conn.Open();
        SqlCommand cm;
        // Retrieve user input values
        string name = Request.Form["Name"];
        string cnic = Request.Form["cnic"];
        int job = GetJobID(Request.Form["job-type"].ToString());
        int userNum = GetLatestUserNum();

        // Create the SQL query
        string query = "INSERT INTO AcademicOfficers (Name, JobID, CNIC, user_num) VALUES ('" + name + "', '" + job + "', '" + cnic + "', " + userNum + ")";
        cm = new SqlCommand(query, conn);
        // Execute the query
        try
        {
            var rowsAffected = cm.ExecuteNonQuery();

            if (rowsAffected > 0)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                Response.Write("Failed to insert user data.");
            }
        }
        catch (SqlException ex)
        {
            if (ex.Number == 2627) // Unique key constraint violation error number
            {
                Response.Write("The CNIC is already registered.");
            }
            else
            {
                // Handle other SQL exceptions or log the error
                Response.Write("An error occurred while inserting user data.");
            }
        }


        cm.Dispose();
        conn.Close();
    }

    private int GetLatestUserNum()
    {
        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        int userNum = 0;

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();

            string query = "SELECT MAX(UserID) FROM Users";

            SqlCommand command = new SqlCommand(query, connection);
            var result = command.ExecuteScalar();

            if (result != null && result != DBNull.Value)
            {
                userNum = Convert.ToInt32(result);
            }

            connection.Close();
        }

        return userNum;
    }

    private int GetJobID(string jobname)
    {
        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        int jobno = 0;

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            connection.Open();
            string query = "select jobid from jobs where jobname = @jobname";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@jobname", jobname);
            var result = command.ExecuteScalar();

            if (result != null && result != DBNull.Value)
            {
                jobno = Convert.ToInt32(result);
            }

            connection.Close();
        }

        return jobno;
    }

}