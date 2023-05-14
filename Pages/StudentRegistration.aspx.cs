using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class StudentRegistration : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void btnReg_Click(object sender, EventArgs e)
    {
        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        SqlConnection conn = new SqlConnection(connectionString);
        conn.Open();
        Response.Write("Connection Open");
        SqlCommand cm;
        string rollNumber = Request.Form["rollNumber"];
        string firstName = Request.Form["firstName"];
        string lastName = Request.Form["lastName"];
        string cnic = Request.Form["cnic"];
        DateTime dob = DateTime.Parse(Request.Form["dob"]);
        string gender = Request.Form["gender"];
        int sectionID = int.Parse(Request.Form["section"]);
        int userNum = GetLatestUserNum();

        string query = "INSERT INTO Students (roll_number, first_name, last_name, cnic, dob, gender, sectionID, user_num) " +
                      "VALUES ('" + rollNumber + "', '" + firstName + "', '" + lastName + "', '" + cnic + "', '" + dob + "', '" + gender + "', " + sectionID + ", '" + userNum + "')";
        cm = new SqlCommand(query, conn);
        // Execute the query
        int rowsAffected = cm.ExecuteNonQuery();

        if (rowsAffected > 0)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            Response.Write("Failed to insert user data.");
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

}