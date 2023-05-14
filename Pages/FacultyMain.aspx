<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FacultyMain.aspx.cs" Inherits="FacultyMain" %>


    <!DOCTYPE html>
    <html>
    <head>
        <title>Faculty Interface</title>

        <link rel="stylesheet" href="style.css">
        <link rel="icon" type="image/png" href="resources/logo.png">

 
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
        <style>
           .profile-container {
            font-family: 'Poppins', sans-serif;
            width: 1100px;
            background-color: rgba(255, 255, 255, 0.13);
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

            .nextTo{
                display: flex;
                justify-content: center;
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

        </style>
    </head>
    <body style="background-color: darkslategray;">
       <div class="foreground">
        <div class="sidebar">
            <img src="resources/logo.png" alt="Logo">
        </div>

        <div class="profile-container">
            <h3 style="font-size: 32px">Profile</h3>
            <br />
            <div class="profile-section">
                <div class="profile-info">
                    <p><span>Name:</span> <asp:Label ID="lblFacultyName" runat="server"></asp:Label></p>
                    <p><span>CNIC:</span> <asp:Label ID="lblFacultyCNIC" runat="server"></asp:Label></p>
                    <!-- Add more labels here -->
                </div>
            </div>
        </div>
  <form runat="server" style="text-align:center">

        <div class="profile-container">
            <h3 style="font-size: 32px">Assigned Courses</h3>
            <br />
            <div class="profile-section" >
                <div class="profile-info" id="CourseContainer" name="CourseContainer" runat="server">
                    
                   

                    <!-- Add more labels here -->
                </div>
            </div>
        </div>
        <div class="profile-container">
            <h3 style="font-size: 32px">Marks distribution</h3>
            <br />

            <center>
                <div style="margin: 0 420px;">
                        <div class="account-type" >
                            <asp:DropDownList ID="evaluationCourseDropdown" runat="server" AutoPostBack="True" OnSelectedIndexChanged="EvaluationcourseDropdown_SelectedIndexChanged">
                                        <asp:ListItem Text="Select a Course" Value=""></asp:ListItem>
                            </asp:DropDownList>
                        </div>

                </div>
            </center>

            <br />
            

                    <div style="display:flex;margin: 0 100px;">
                      <div class="data-table">
                          <table id="evaluation-table" name="evaluationTable">
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
                                          <input id="txtAssignmentWeightage" runat="server" type="number" value="<%= evaluation.AssignmentWeightage %>"></td>
                                  </tr>
                                  <tr>
                                      <td>Quiz</td>
                                      <td>
                                          <input id="txtQuizWeightage" runat="server" type="number" value="<%= evaluation.QuizWeightage %>" ></td>
                                  </tr>
                                   <tr>
                                      <td>Project</td>
                                      <td>
                                          <input id="txtProjectWeightage" runat="server" type="number" value="<%= evaluation.ProjectWeightage %>" ></td>
                                  </tr>
                                   <tr>
                                      <td>Class participation</td>
                                      <td>
                                          <input id="txtCPWeightage" runat="server" type="number" value="<%= evaluation.CPWeightage %>"></td>
                                  </tr>
                                  <tr>
                                      <td>Sessional-I</td>
                                      <td>
                                          <input id="txtSessional1Weightage" runat="server" type="number" value="<%= evaluation.Sessional1Weightage %>" ></td>
                                  </tr>
                                  <tr>
                                      <td>Sessional-II</td>
                                      <td>
                                          <input id="txtSessional2Weightage" runat="server" type="number" value="<%= evaluation.Sessional2Weightage %>"></td>
                                  </tr>
                                  <tr>
                                      <td>Final exam</td>
                                      <td>
                                          <input id="txtFPWeightage" runat="server" type="number" value="<%= evaluation.FinalExamWeightage %>" ></td>
                                  </tr>
                                  <!-- Add more rows as needed -->
                              </tbody>
                          </table>
                            <asp:Button ID="saveEval" runat="server" Text="Save" OnClick="btnSave_Click" CssClass="buttoncs" />

                      </div>
                   </div>
      </div>
           <div class="profile-container">
               <h3 style="font-size: 32px">Mark Attendance</h3>

               <div class="nextTo">
                   <div style="width: 160px;" class="account-type">
                       <label for="account-type">Lecture number</label>
                       <input style="width: 150px;" type="number" value="0"></td>
                   </div>
                   <div style="width: 50px"></div>

                   <div style="width: 160px;" class="account-type">
                       <label for="account-type">Course</label>
                       <asp:DropDownList ID="coursedropdown" runat="server" AutoPostBack="True">
                                        <asp:ListItem Text="Select a Course" Value=""></asp:ListItem>
                            </asp:DropDownList>
                   </div>

                   <div style="width: 50px"></div>
                   <div style="width: 160px;" class="account-type">
                       <label for="account-type">Section</label>
                            <asp:DropDownList ID="secitonsdrop" runat="server" AutoPostBack="True" OnSelectedIndexChanged="AttendancecourseDropdown_SelectedIndexChanged">
                                        <asp:ListItem Text="Select a section" Value=""></asp:ListItem>
                            </asp:DropDownList>
                   </div>

                   <div style="width: 50px"></div>

                   <div class="form-group" style="">
                   </div>
               </div>



               <div style="margin-top:50px"></div>

               <div>
                   <table>
                       <thead>
                           <tr>
                               <th>Student Name</th>
                               <th>Attendance Status</th>
                           </tr>
                       </thead>
                       <tbody id="AttendanceContainer" name="AttendanceContainer" runat="server">
                           <tr>
                               <td>John Doe</td>
                               <td>
                                   <center>
                                       <div style="width: 150px;" class="account-type">
                                           <select name="account-type">
                                               <option value="" selected disabled>Select an option</option>
                                               <option value="present">Present</option>
                                               <option value="absent">Absent</option>
                                               <option value="late">Late</option>
                                           </select>
                                       </div>
                                   </center>
                               </td>
                           </tr>

                       </tbody>
                   </table>
               </div>
               <center>
            <button id="submitAttendance" style="width:400px;" >Submit</button>
                   </center>


               <br />
           </div>
      </form>
           </div>
           <!-- Add more profile containers if needed -->

    </body>
        </html>