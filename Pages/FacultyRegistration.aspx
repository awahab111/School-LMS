<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FacultyRegistration.aspx.cs" Inherits="FacultyRegistration" %>


<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="style.css">
    <link rel="icon" type="image/png" href="resources/logo.png">

    <title>Faculty Registration</title>
 
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">

 <style>
        .form-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 10px;
        }

        .form-group {
            display: flex;
            align-items: center;
        }

        .form-group label {
            width: 100px;
            margin-right: 10px;
        }

        .form-group input,
        .form-group select {
            flex: 1px;
            height: 40px;
        }

        .form-actions {
            grid-column: span 3;
            display: flex;
            justify-content: flex-end;
        }
    </style>
</head>
<body>
     <form method="post" style="width:1200px;height: 350px" class="form-login" runat="server">
        <h3>Faculty</h3>
        <div class="form-container">
            <div class="form-group">
                <label for="Name">Name:</label>
                <input type="text" name="Name" required>
            </div>

            <div class="form-group">
                <label for="cnic">CNIC:</label>
                <input type="text" name="cnic" required>
            </div>

            <div class="form-group">
                <label for="subjects">Course Code:</label>
                <input type="text" name="coursecode" required>
            </div>

            <br />

            <div class="gender-type">
                <label for="job" class="gender-label">Job:</label>
                <select id="job" class="gender-dropdown" name="faculty-dropdown">
                    <option value="C">Course Instructor</option>
                    <option value="L">Lab Instructor</option>
                </select>
            </div>
            <!-- Add more input fields as needed -->

        </div>
         <br />
        <div class="form-actions">
               <asp:Button ID="btnReg" runat="server" Text="Register" OnClick="btnReg_Click" CssClass="buttoncs" />
        </div>
    </form>
</body>
</html>
