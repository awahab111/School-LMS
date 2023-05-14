<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Studentmain.aspx.cs" Inherits="Studentmain" %>

<!DOCTYPE html>
<html>
<head>
    <title>Student Interface</title>

    <link rel="stylesheet" href="style.css">
    <link rel="icon" type="image/png" href="resources/logo.png">

 
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
    <style>
       .profile-container {
        font-family: 'Poppins', sans-serif;
        width: 1100px;
        background-color: #0093dd45;
        border-radius: 10px;
        backdrop-filter: blur(50px);
        border: 2px solid rgba(255, 255, 255, 0.1);
        box-shadow: 0 0 40px rgba(8, 7, 16, 0.5);
        padding: 15px 35px;
        color: white;
        margin: 50px;
        transform: translateX(14%);
    }
        .sidebar {
           font-family: 'Poppins', sans-serif;
            width: 100%;
            height: 100px;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 15px;
            background-color: #0093dd45;
            backdrop-filter: blur(50px);
            border: 2px solid rgba(255,255,255,0.1);
            box-shadow: 0 0 40px rgba(8,7,16,0.5);
        }
        
        .sidebar img {
            width: 90px;
        }


        .sidebar a {
            display: block;
            color: #000;
            padding: 12px 16px; /* Increase the padding for more gap */
            text-decoration: none;
        }
        
        .sidebar a:hover {
            background-color: #ddd;
        }
        
        .content {
            margin-left: 200px;
            padding: 20px;
        }
        
    .profile {
        border: 1px solid #ccc;
        padding: 0px;
        margin-bottom: 0px;
    }

    .profile-section {
        display: flex;
    }

    .profile-info {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        font-size:20px;
    }

    .profile-info p {
        margin: 25px 35px;
        text-align: center;
    }

    .profile-info p span.label {
        color: white;
        margin-right: 60px;
    }

    table {
      border-collapse: separate;
      border-spacing: 25px 50px ;
    }   

    tr {
      margin-bottom: 5px; /* Add space between table rows */
    }

    </style>
</head>
<body style="background-color: #333c3e38; background-image:none;">
    <div class="sidebar">
        <img src="resources/logo.png" alt="Logo">
    </div>

    <div class="profile-container">
        <h3 style="font-size: 32px">Student Information</h3>
        <br />
        <div class="profile-section">
            <div class="profile-info">
                <p><span>Name:</span> <asp:Label ID="lblStudentName" runat="server"></asp:Label></p>
                <p><span>Roll number:</span> <asp:Label ID="lblRollNumber" runat="server"></asp:Label></p>
                <p><span>CNIC:</span> <asp:Label ID="cnic" runat="server"></asp:Label></p>
                <p><span>Date of Birth:</span> <asp:Label ID="lbldob" runat="server"></asp:Label></p>
                <p><span>Degree:</span> <asp:Label ID="lbldegree" runat="server"></asp:Label></p>
                <p><span>Batch: </span> <asp:Label ID="lblbatch" runat="server"></asp:Label></p>
                <p><span>Semester: </span> <asp:Label ID="lblsem" runat="server"></asp:Label></p>
                <!-- Add more labels here -->
            </div>
        </div>
    </div>

    <div class="profile-container">
        <h3 style="font-size: 32px">Registered Courses</h3>
        <br />
        <div class="profile-section">
            <div class="profile-info">
                <div style="display:flex;margin: 0 100px;">
                    <p><span>Course Code:</span> <asp:Label ID="course1_code" runat="server"></asp:Label></p>
                    <p><span>Course Name:</span> <asp:Label ID="course1_name" runat="server"></asp:Label></p>
                </div>
                <div style="display:flex;margin: 0 100px;">
                    <p><span>Course Code:</span> <asp:Label ID="course2_code" runat="server"></asp:Label></p>
                    <p><span>Course Name:</span> <asp:Label ID="course2_name" runat="server"></asp:Label></p>
                </div>
                <div style="display:flex;margin: 0 100px;">
                    <p><span>Course Code:</span> <asp:Label ID="course3_code" runat="server"></asp:Label></p>
                    <p><span>Course Name:</span> <asp:Label ID="course3_name" runat="server"></asp:Label></p>
                </div>
                <div style="display:flex;margin: 0 100px;">
                    <p><span>Course Code:</span> <asp:Label ID="course4_code" runat="server"></asp:Label></p>
                    <p><span>Course Name:</span> <asp:Label ID="course4_name" runat="server"></asp:Label></p>
                </div>
                <div style="display:flex;margin: 0 100px;">
                    <p><span>Course Code:</span> <asp:Label ID="course5_code" runat="server"></asp:Label></p>
                    <p><span>Course Name:</span> <asp:Label ID="course5_name" runat="server"></asp:Label></p>
                </div>

                <!-- Add more labels here -->
            </div>
        </div>
    </div>
  <form runat="server" style="text-align:center">
    <div class="profile-container">
        <h3 style="font-size: 32px">Attendance</h3>
        <br />
        <div class="profile-section">
            <div class="profile-info">
                <div style="display:flex;margin: 0 420px;">
                        <div class="account-type" >
                            <asp:DropDownList ID="courseDropdown" runat="server" AutoPostBack="True" OnSelectedIndexChanged="AttendancecourseDropdown_SelectedIndexChanged">
                                        <asp:ListItem Text="Select a Course" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                </div>
               <div id="attendanceContainer" name="attendanceContainer" runat="server" style="text-align: center;">
                    <!-- Attendance table will be displayed here -->
                </div>
                <!-- Add more labels here -->
            </div>
        </div>
    </div>

     <div class="profile-container">
        <h3 style="font-size: 32px">Course Evaluation</h3>
        <br />
        <div class="profile-section">
            <div class="profile-info">
                <div style="margin: 0 420px;">
                        <div class="account-type" >
                            <asp:DropDownList ID="evaluationCourseDropdown" runat="server" AutoPostBack="True" OnSelectedIndexChanged="EvaluationcourseDropdown_SelectedIndexChanged">
                                        <asp:ListItem Text="Select a Course" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                </div>
               <div style="display:flex;margin: 0 100px;">
                      <div class="data-table">
                          <table id="evaluation-table" name="evaluation-table">
                              <thead>
                                  <tr>
                                      <th>Evaluation Name</th>
                                      <th>Weightage</th>
                                  </tr>
                              </thead>
                              <tbody>
                                  <tr>
                                      <td>Assignments</td>
                                      <td>
                                          <input type="number" value="<%= evaluation.AssignmentWeightage %>" readonly></td>
                                  </tr>
                                  <tr>
                                      <td>Quiz</td>
                                      <td>
                                          <input type="number" value="<%= evaluation.QuizWeightage %>" readonly></td>
                                  </tr>
                                   <tr>
                                      <td>Project</td>
                                      <td>
                                          <input type="number" value="<%= evaluation.ProjectWeightage %>" readonly></td>
                                  </tr>
                                   <tr>
                                      <td>Class participation</td>
                                      <td>
                                          <input type="number"value="<%= evaluation.CPWeightage %>" readonly></td>
                                  </tr>
                                  <tr>
                                      <td>Sessional-I</td>
                                      <td>
                                          <input type="number" value="<%= evaluation.Sessional1Weightage %>" readonly></td>
                                  </tr>
                                  <tr>
                                      <td>Sessional-II</td>
                                      <td>
                                          <input type="number" value="<%= evaluation.Sessional2Weightage %>" readonly></td>
                                  </tr>
                                  <tr>
                                      <td>Final exam</td>
                                      <td>
                                          <input type="number" value="<%= evaluation.FinalExamWeightage %>" readonly></td>
                                  </tr>
                                  <!-- Add more rows as needed -->
                              </tbody>
                          </table>
                      </div>
                   </div>
                <!-- Add more labels here -->
            </div>
        </div>
    </div>
      <div style="height:50px"></div>
</form>

    <!-- Add more profile containers if needed -->

</body>
    </html>