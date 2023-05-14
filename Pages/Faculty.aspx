<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Faculty.aspx.vb" Inherits="_Default" %>


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
    <body style="background-color: darkslategray;
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

        <div class="profile-container">
            <h3 style="font-size: 32px">Assigned Courses</h3>
            <br />
            <div class="profile-section">
                <div class="profile-info">
                    <div style="display:flex;margin: 0 100px;">
                        <p><span>Course Code:</span> <asp:Label ID="course1_code" runat="server"></asp:Label></p>
                        <p><span>Course Name:</span> <asp:Label ID="course1_name" runat="server"></asp:Label></p>
                    </div>
                   

                    <!-- Add more labels here -->
                </div>
            </div>
        </div>
        <div class="profile-container">
            <h3 style="font-size: 32px">Marks distribution</h3>
            <br />

            <center>
                <div style="width: 150px;" class="account-type">
                    <label for="account-type">Account Type:</label>
                    <select id="account-type" name="account-type">
                        <option value="" selected disabled>Select an option</option>
                        <!-- Default option -->
                        <option id="" value="s">Course_1</option>
                        <option value="f">Course_2</option>
                        <option value="a">Course_3</option>
                    </select>
                </div>
            </center

            <br />
            
                    <div style="display:flex;margin: 0 200px;">
                      <div class="data-table">
                          <table>
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
                                          <input type="number" value="10"></td>
                                  </tr>
                                  <tr>
                                      <td>Quiz</td>
                                      <td>
                                          <input type="number" value="10"></td>
                                  </tr>
                                   <tr>
                                      <td>Project</td>
                                      <td>
                                          <input type="number" value="10"></td>
                                  </tr>
                                   <tr>
                                      <td>Class participation</td>
                                      <td>
                                          <input type="number" value="10"></td>
                                  </tr>
                                  <tr>
                                      <td>Sessional-I</td>
                                      <td>
                                          <input type="number" value="10"></td>
                                  </tr>
                                  <tr>
                                      <td>Sessional-II</td>
                                      <td>
                                          <input type="number" value="10"></td>
                                  </tr>
                                  <tr>
                                      <td>Final exam</td>
                                      <td>
                                          <input type="number" value="10"></td>
                                  </tr>
                                  <!-- Add more rows as needed -->
                              </tbody>
                          </table>
                          <button id="saveEval">Save</button>
                      </div>


                        <!-- Add more labels here -->
  
        </div>
      </div>
           <div class="profile-container">
               <h3 style="font-size: 32px">Mark Attendance</h3>

               <div class="nextTo">
                   <div style="width: 150px;" class="account-type">
                       <label for="account-type">Lecture number</label>
                       <input style="width: 150px;" type="number" value="0"></td>
                   </div>
                   <div style="width: 50px"></div>

                   <div style="width: 150px;" class="account-type">
                       <label for="account-type">Course</label>
                       <select id="account-type" name="account-type">
                           <option value="" selected disabled>Select an option</option>
                           <!-- Default option -->
                           <option id="" value="s">Course_1</option>
                           <option value="f">Course_2</option>
                           <option value="a">Course_3</option>
                       </select>
                   </div>

                   <div style="width: 50px"></div>
                   <div style="width: 150px;" class="account-type">
                       <label for="account-type">Section</label>
                       <select id="account-type" name="account-type">
                           <option value="" selected disabled>Select an option</option>
                           <!-- Default option -->
                           <option id="" value="s">Course_1</option>
                           <option value="f">Course_2</option>
                           <option value="a">Course_3</option>
                       </select>
                   </div>

                   <div style="width: 50px"></div>

                   <div class="form-group" style="">
                       <label for="dob">Date:</label>
                       <input type="date" name="dob" required>
                   </div>
               </div>



               <div style="height: 50px"></div>

               <div>
                   <table>
                       <thead>
                           <tr>
                               <th>Student Name</th>
                               <th>Attendance Status</th>
                           </tr>
                       </thead>
                       <tbody>
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


           <!-- Add more profile containers if needed -->

    </body>
        </html>