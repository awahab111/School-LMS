using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Studentmain : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Retrieve student data from the database
            string studentName = GetStudentNameFromDatabase();
            string rollNumber = GetRollNumberFromDatabase();
            string cnic_ = GetcnicFromDatabase();
            string dob = GetdobFromDatabase();
            string degree = string.Empty;
            string batch = string.Empty;
            string sem = string.Empty;
            GetdetailsFromDatabase(ref degree, ref batch, ref sem);



            // Display the retrieved data in the profile section
            lblStudentName.Text = studentName;
            lblRollNumber.Text = rollNumber;
            cnic.Text = cnic_;
            lbldob.Text = dob;
            lbldegree.Text = degree;
            lblbatch.Text = batch;
            lblsem.Text = sem;  
            // Add more labels and display data accordingly
        }

    }


    private void GetdetailsFromDatabase(ref string degree, ref string batch, ref string sem)
    {
        int userNum = Convert.ToInt32(Request.QueryString["userNum"]);

        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "select degree_program, semester_no, batch from section inner join students on Section.sectionID=Students.sectionID where Students.sectionID = (select sectionID from Students where user_num = @userNum)";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@userNum", userNum);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                degree = reader["degree_program"].ToString();
                sem = reader["semester_no"].ToString();
                batch = reader["batch"].ToString();
            }

            connection.Close();
        }
    }



    private string GetdobFromDatabase()
    {
        string dob = string.Empty;
        int userNum = Convert.ToInt32(Request.QueryString["userNum"]);

        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "SELECT dob FROM Students WHERE user_num = @userNum";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@userNum", userNum);

            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                DateTime dobDateTime = Convert.ToDateTime(reader["dob"]);
                dob = dobDateTime.ToString("dd-MM-yyyy"); // Modify the format according to your preference
            }

            connection.Close();
        }

        return dob;
    }



    private string GetcnicFromDatabase()
    {
        string cnic_ = string.Empty;
        int userNum = Convert.ToInt32(Request.QueryString["userNum"]);

        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "SELECT cnic FROM Students WHERE user_num = @userNum";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@userNum", userNum);

            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                cnic_= reader["cnic"].ToString();
            }

            connection.Close();
        }

        return cnic_;
    }


    private string GetStudentNameFromDatabase()
    {
        string studentName = string.Empty;
        int userNum = Convert.ToInt32(Request.QueryString["userNum"]);

        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "SELECT first_name, last_name FROM Students WHERE user_num = @userNum";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@userNum", userNum);

            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                string firstName = reader["first_name"].ToString();
                string lastName = reader["last_name"].ToString();
                studentName = firstName + " " + lastName;
            }

            connection.Close();
        }

        return studentName;
    }

    private string GetRollNumberFromDatabase()
    {
        string rollNumber = string.Empty;
        int userNum = Convert.ToInt32(Request.QueryString["userNum"]);

        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "SELECT roll_number FROM Students WHERE user_num = @userNum";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@userNum", userNum);

            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                rollNumber = reader["roll_number"].ToString();
            }

            connection.Close();
        }

        return rollNumber;
    }

}