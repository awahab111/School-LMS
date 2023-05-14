using System;
using System.Activities.Expressions;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class FacultyMain : System.Web.UI.Page
{
    protected Evaluation evaluation = new Evaluation();
    public string evaluationcourse_Selected = String.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string name = string.Empty , cnic = string.Empty;
            GetProfileInfo(ref name, ref cnic);
            DisplayCourses();
            lblFacultyName.Text = name;
            lblFacultyCNIC.Text = cnic;
            PopulateCourseDropdown();

        }
    }

    protected void AttendancecourseDropdown_SelectedIndexChanged(object sender, EventArgs e)
    {
        string selectedcourse= coursedropdown.SelectedItem.Text;
        string selectedsection = secitonsdrop.SelectedItem.Text;
        List<Student> StudentData = GetStudentsData(ref selectedsection, ref selectedcourse);
        string studentTable = GenerateStudentTable(StudentData);

        // Update the attendanceContainer div with the attendance table
        AttendanceContainer.InnerHtml = studentTable;

    }

    protected List<Student> GetStudentsData(ref string section, ref string coursename)
    {

        List<Student> StudentData = new List<Student>();
        int userNum = Convert.ToInt32(Request.QueryString["userNum"]);

        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "select first_name,last_name from students inner join SectionsTeaching on SectionsTeaching.sectionID= Students.sectionID where CourseID = @coursename AND Students.sectionID = (select sectionID from SectionsTeaching where CourseID=@coursename AND InstructorID=(select facultyID from Faculty where user_num =@userNum)) AND InstructorID=(select facultyID from Faculty where user_num = @userNum)";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@coursename", coursename);
            command.Parameters.AddWithValue("@section", section);
            command.Parameters.AddWithValue("@userNum", userNum);

            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                Student stud= new Student();
                string first_name = reader["first_name"].ToString();
                string last_name = reader["last_name"].ToString();
                stud.StudentName = first_name + " " + last_name;
                StudentData.Add(stud);
            }
            connection.Close();
        }

        return StudentData;
        // Update the attendanceContainer div with the attendance table

    }

    private string GenerateStudentTable(List<Student> StudentData)
    {
        // Generate the HTML markup for the attendance table dynamically
        StringBuilder sb = new StringBuilder();

        foreach (Student attendance in StudentData)
        {
            sb.Append(" <tr><td>"+attendance.StudentName.ToString()+"</td><td><center><div style=\"width: 150px;\" class=\"account-type\"><select name=\"account-type\"><option value=\"\" selected disabled>Select an option</option><option value=\"present\">Present</option><option value=\"absent\">Absent</option><option value=\"late\">Late</option></select></div></center></td></tr>");
        }
        return sb.ToString();
    }


    private string GenerateCoursesTable(List<Course> CourseData)
    {
        // Generate the HTML markup for the attendance table dynamically
        StringBuilder sb = new StringBuilder();


        sb.Append("<p><span style=\"margin-right:70px\">Course Code </span><span style=\"margin-right:70px\">Course Name </span><span style=\"margin-right:50px\">Section </span></p>");
        foreach (Course course in CourseData)
        {
            sb.Append("<div style=\"display:flex;margin: 0 40px;\">");
            sb.Append("<p><Label>"+ course.CourseID.ToString() +"</Label></p>");
            sb.Append("<p><Label>" + course.CourseName.ToString() + "</Label></p >");
            sb.Append("<p><Label>" + course.section.ToString() + "</Label></p >");
            sb.Append("</div>");
        }
        return sb.ToString();
    }


    private List<Course> GetCoursesFromDatabase()
    {
        int userNum = Convert.ToInt32(Request.QueryString["userNum"]);
        List<Course> courses = new List<Course>();

        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "select CourseName, CourseID, Section.section from SectionsTeaching inner join section on section.SectionID=SectionsTeaching.SectionID inner join course on Course.CourseCode=CourseID where InstructorID = (select facultyID from Faculty where user_num = 28)";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@userNum", userNum);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                Course course = new Course
                {
                    CourseID = reader["CourseID"].ToString(),
                    CourseName = reader["CourseName"].ToString(),
                    section = reader["section"].ToString(),
                };
                secitonsdrop.Items.Add(course.section.ToString());

                courses.Add(course);
            }
            connection.Close();
        }

        return courses;
    }

    private void DisplayCourses()
    {
        List<Course> courses = GetCoursesFromDatabase();
        string CourseTable = GenerateCoursesTable(courses);
        CourseContainer.InnerHtml = CourseTable;


    }



    private void GetProfileInfo(ref string name, ref string cnic)
    {
        int userNum = Convert.ToInt32(Request.QueryString["userNum"]);

        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "select FacultyName, Cnic from Faculty where user_num = @userNum";
            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@userNum", userNum);
            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                name = reader["FacultyName"].ToString();
                cnic = reader["cnic"].ToString();

            }
            connection.Close();
        }
    }


    protected void btnSave_Click(object sender, EventArgs e)
    {
        // Get the updated weightage values from the textboxes
        evaluation.AssignmentWeightage = txtAssignmentWeightage.Value;
        evaluation.QuizWeightage = txtQuizWeightage.Value;
        evaluation.FinalExamWeightage = txtFPWeightage.Value;
        evaluation.Sessional1Weightage = txtSessional1Weightage.Value;
        evaluation.Sessional2Weightage = txtSessional2Weightage.Value;
        evaluation.ProjectWeightage = txtProjectWeightage.Value;
        evaluation.CPWeightage = txtCPWeightage.Value;

        // Save the updated weightage values to the database
        SaveEvaluationWeightageToDatabase(evaluation);

        // Rebind the data to update the textboxes
    }

    private void SaveEvaluationWeightageToDatabase(Evaluation evaluation)
    {
        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";
        string courseselected = evaluationCourseDropdown.SelectedItem.Text;

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "UPDATE Evaluations SET AssignmentWeightage = @A, QuizWeightage = @Q,FinalExamWeightage = @F, Sessional1Weightage = @S1, Sessional2Weightage = @S2,  ProjectWeightage = @P, CPWeightage = @CP WHERE CourseID = @courseID";
            SqlCommand command = new SqlCommand(query, connection);

            // Add parameters and set their values
            command.Parameters.AddWithValue("@A", evaluation.AssignmentWeightage);
            command.Parameters.AddWithValue("@Q", evaluation.QuizWeightage);
            command.Parameters.AddWithValue("@F", evaluation.FinalExamWeightage);
            command.Parameters.AddWithValue("@S1", evaluation.Sessional1Weightage);
            command.Parameters.AddWithValue("@S2", evaluation.Sessional2Weightage);
            command.Parameters.AddWithValue("@P", evaluation.ProjectWeightage);
            command.Parameters.AddWithValue("@CP", evaluation.CPWeightage);
            command.Parameters.AddWithValue("@courseID", courseselected);
            connection.Open();
            command.ExecuteNonQuery();
            connection.Close();

        }
    }


    protected void BindData()
    {
        // Bind the evaluation object to the ASPX controls
        txtAssignmentWeightage.Value = evaluation.AssignmentWeightage.ToString();
        txtQuizWeightage.Value = evaluation.QuizWeightage.ToString();
        txtFPWeightage.Value = evaluation.FinalExamWeightage.ToString();
        txtSessional1Weightage.Value = evaluation.Sessional1Weightage.ToString();
        txtSessional2Weightage.Value = evaluation.Sessional2Weightage.ToString();
        txtProjectWeightage.Value = evaluation.ProjectWeightage.ToString();
        txtCPWeightage.Value = evaluation.CPWeightage.ToString();

        // Bind other controls as needed
    }


    private void PopulateEvaluationData()
    {

        // Find the table body element
        HtmlTable table = (HtmlTable)FindControl("evaluation-table"); // Replace "evaluationTable" with the actual ID of the table

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

            connection.Open();
            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                evaluationdata.AssignmentWeightage = reader["AssignmentWeightage"].ToString();
                evaluationdata.QuizWeightage = reader["QuizWeightage"].ToString();
                evaluationdata.FinalExamWeightage = reader["FinalExamWeightage"].ToString();
                evaluationdata.Sessional1Weightage = reader["Sessional1Weightage"].ToString();
                evaluationdata.Sessional2Weightage = reader["Sessional2Weightage"].ToString();
                evaluationdata.ProjectWeightage = reader["ProjectWeightage"].ToString();
                evaluationdata.CPWeightage = reader["CPWeightage"].ToString();
            }
            connection.Close();
        }

        return evaluationdata;
    }

    protected void EvaluationcourseDropdown_SelectedIndexChanged(object sender, EventArgs e)
    {
        string courseselected = evaluationCourseDropdown.SelectedItem.Text;
        evaluationcourse_Selected = courseselected;

        Evaluation evaluationdata = GetEvaluationDataFromDatabase(courseselected);
        evaluation = evaluationdata;
        if (evaluation.Sessional1Weightage != null) { BindData(); }
        

    }

    private void PopulateCourseDropdown()
    {
        int userNum = Convert.ToInt32(Request.QueryString["userNum"]);
        string connectionString = "Data Source=DESKTOP-ENSHTE4\\SQLEXPRESS;Initial Catalog=sms;Integrated Security=True";

        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            string query = "select CourseID from SectionsTeaching where InstructorID = (select facultyID from Faculty where user_num = @userNum) ";

            SqlCommand command = new SqlCommand(query, connection);
            command.Parameters.AddWithValue("@userNum", userNum);

            connection.Open();

            SqlDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                string courseName = reader["CourseID"].ToString();
                evaluationCourseDropdown.Items.Add(courseName);
                coursedropdown.Items.Add(courseName);
            }

            connection.Close();
        }
    }

}


public class Student
{
    public string StudentName { get; set; }
    public string Presence { get; set; }

}



public class Course
{
    public string CourseID { get; set; }
    public string CourseName { get; set; }
    public string section{ get; set; }


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