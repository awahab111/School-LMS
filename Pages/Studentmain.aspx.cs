using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class Studentmain : System.Web.UI.Page
{
    protected Evaluation evaluation = new Evaluation();

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
            string CID = string.Empty;
            string Cname = string.Empty;

            GetCourseFromDatabase(ref CID, ref Cname);

            DisplayCourses();

            // Display the retrieved data in the profile section
            lblStudentName.Text = studentName;
            lblRollNumber.Text = rollNumber;
            cnic.Text = cnic_;
            lbldob.Text = dob;
            lbldegree.Text = degree;
            lblbatch.Text = batch;
            lblsem.Text = sem;  

            //Course
            course1_name.Text = Cname;
            course1_code.Text = CID;
            // Add more labels and display data accordingly

            PopulateCourseDropdown();

        }

    }

    private void PopulateEvaluationData()
    {

        // Find the table body element
        HtmlTable table = (HtmlTable)FindControl("evaluationTable"); // Replace "evaluationTable" with the actual ID of the table

        // Iterate over each row in the table body
    }

    private Evaluation GetEvaluationDataFromDatabase(string selectedCourse)
    {
        Evaluation evaluationdata = new Evaluation();
        int userNum = Convert.ToInt32(Request.QueryString["userNum"]);

        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "select AssignmentWeightage, QuizWeightage,FinalExamWeightage ,Sessional1Weightage, Sessional2Weightage, ProjectWeightage,CPWeightage from Evaluations where CourseID=@selectedCourse";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@selectedCourse", selectedCourse);
            command.Parameters.AddWithValue("@userNum", userNum);

            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                evaluationdata.AssignmentWeightage = reader["AssignmentWeightage"].ToString();
                evaluationdata.QuizWeightage= reader["QuizWeightage"].ToString();
                evaluationdata.FinalExamWeightage= reader["FinalExamWeightage"].ToString();
                evaluationdata.Sessional1Weightage= reader["Sessional1Weightage"].ToString();
                evaluationdata.Sessional2Weightage= reader["Sessional2Weightage"].ToString();
                evaluationdata.ProjectWeightage= reader["ProjectWeightage"].ToString();
                evaluationdata.CPWeightage= reader["CPWeightage"].ToString();
            }
            connection.Close();
        }

        return evaluationdata;
    }

    protected void EvaluationcourseDropdown_SelectedIndexChanged(object sender, EventArgs e)
    {
        string selectedCourse = evaluationCourseDropdown.SelectedItem.Text;
        Evaluation evaluationdata = GetEvaluationDataFromDatabase(selectedCourse);
        evaluation = evaluationdata;
        // Update the attendanceContainer div with the attendance table

    }

    protected void AttendancecourseDropdown_SelectedIndexChanged(object sender, EventArgs e)
    {
        string selectedCourse = courseDropdown.SelectedItem.Text;
        List<Attendance> attendanceData = GetAttendanceData(selectedCourse);
        string attendanceTable = GenerateAttendanceTable(attendanceData);

        // Update the attendanceContainer div with the attendance table
        attendanceContainer.InnerHtml = attendanceTable;

    }

    private string GenerateAttendanceTable(List<Attendance> attendanceData)
    {
        // Generate the HTML markup for the attendance table dynamically
        StringBuilder sb = new StringBuilder();

        sb.Append("<table>");
        sb.Append("<tr><th>Lecture No.</th><th>Duration</th><th>Date</th><th>Presence</th></tr>");

        foreach (Attendance attendance in attendanceData)
        {
            sb.Append("<tr>");
            sb.Append("<td>" + attendance.LectureNum + "</td>");
            sb.Append("<td>" + attendance.Duration + "</td>");
            sb.Append("<td>" + attendance.Date+ "</td>");
            sb.Append("<td>" + attendance.presence + "</td>");
            sb.Append("</tr>");
        }
        sb.Append("</table>");
        return sb.ToString();
    }





    private List<Attendance> GetAttendanceData(string selectedCourse)
    {
        List<Attendance> attendanceData = new List<Attendance>();
        int userNum = Convert.ToInt32(Request.QueryString["userNum"]);

        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "select LectureNo, AttendanceDate, Duration,Presence from Attendance inner join Students on StudentID=roll_number where Students.roll_number = (select roll_number from Students where user_num = @userNum) AND CourseID = @selectedCourse";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@selectedCourse", selectedCourse);
            command.Parameters.AddWithValue("@userNum", userNum);

            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                Attendance attendance = new Attendance();
                attendance.LectureNum = reader["LectureNo"].ToString();
                DateTime dobDateTime = Convert.ToDateTime(reader["AttendanceDate"]);
                attendance.Date = dobDateTime.ToString("dd-MM-yyyy"); // Modify the format according to your preference
                bool presence = (bool)reader["Presence"];
                attendance.presence = presence ? "P" : "A";
                attendance.Duration = reader["Duration"].ToString();

                attendanceData.Add(attendance);
            }
            connection.Close();
        }

        return attendanceData;
    }

    private void PopulateCourseDropdown()
    {
        int userNum = Convert.ToInt32(Request.QueryString["userNum"]);
        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "SELECT CourseID FROM Enrollments INNER JOIN Students ON Students.roll_number = Enrollments.StudentID INNER JOIN Course ON Course.CourseCode = Enrollments.CourseID WHERE Students.roll_number = (SELECT roll_number FROM Students WHERE user_num = @userNum)";

            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@userNum", userNum);

            connection.Open();

            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                string courseName = reader["CourseID"].ToString();
                evaluationCourseDropdown.Items.Add(courseName);
                courseDropdown.Items.Add(courseName);
            }

            connection.Close();
        }
    }



    private List<Course> GetCoursesFromDatabase()
    {
        int userNum = Convert.ToInt32(Request.QueryString["userNum"]);
        List<Course> courses = new List<Course>();

        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "select CourseID, CourseName from Enrollments inner join students on Students.roll_number=Enrollments.StudentID inner join Course on Course.CourseCode=Enrollments.CourseID where Students.roll_number = (select roll_number from Students where user_num = @userNum)";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@userNum", userNum);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                Course course = new Course
                {
                    CourseID = reader["CourseID"].ToString(),
                    CourseName = reader["CourseName"].ToString()
                };
                courses.Add(course);
            }
            connection.Close();
        }

        return courses;
    }

    private void DisplayCourses()
    {
        List<Course> courses = GetCoursesFromDatabase();

        // Retrieve the labels from the HTML and ensure they have matching IDs
        Label[] codeLabels = { course1_code, course2_code, course3_code, course4_code, course5_code };
        Label[] nameLabels = { course1_name, course2_name, course3_name, course4_name , course5_name };

        // Iterate over the list of courses and assign the data to the labels
        for (int i = 0; i < courses.Count; i++)
        {
            if (i < codeLabels.Length)
            {
                codeLabels[i].Text = courses[i].CourseID;
                nameLabels[i].Text = courses[i].CourseName;
            }
            else
            {
                break; // Break the loop if there are more courses than labels
            }
        }
    }


    private void GetCourseFromDatabase(ref string CID, ref string Cname)
    {
        int userNum = Convert.ToInt32(Request.QueryString["userNum"]);

        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "select CourseID, CourseName from Enrollments inner join students on Students.roll_number=Enrollments.StudentID inner join Course on Course.CourseCode=Enrollments.CourseID where Students.roll_number = (select roll_number from Students where user_num = @userNum)";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@userNum", userNum);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                CID = reader["CourseID"].ToString();
                Cname = reader["CourseName"].ToString();
            }
            connection.Close();
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

public class Course
{
    public string CourseID { get; set; }
    public string CourseName { get; set; }
}

public class Attendance
{
    public string LectureNum { get; set; }
    public string Date { get; set; }

    public string Duration { get; set; }

    public string presence { get; set; }
}

public class Evaluation
{
    public string AssignmentWeightage { get; set; }
    public string QuizWeightage { get; set; }
    public string FinalExamWeightage { get; set; }
    public string Sessional1Weightage { get; set; }
    public string Sessional2Weightage { get; set; }
    public string ProjectWeightage { get; set; }
    public string CPWeightage { get; set; }
}

