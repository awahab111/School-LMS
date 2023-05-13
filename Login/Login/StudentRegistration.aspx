<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StudentRegistration.aspx.cs" Inherits="StudentRegistration" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="style.css">
    <link rel="icon" type="image/png" href="resources/logo.png">

    <title>Student Registration</title>
 
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
        margin-top:10px;
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
        height: 35px;
    }

    .form-actions {
        grid-column: span 3;
        display: flex;
        justify-content: flex-end;
    }
    </style>
</head>
<body>
     <form id="studentreg" runat="server" style="width:1200px;height: 550px" >
        <h3>Student Registration</h3>
        <div class="form-container">
            <div class="form-group">
                <label for="rollNumber">Roll Number:</label>
                <input type="text" name="rollNumber" required>
            </div>

            <div class="form-group">
                <label for="firstName">First Name:</label>
                <input type="text" name="firstName" required>
            </div>

            <div class="form-group">
                <label for="lastName">Last Name:</label>
                <input type="text" name="lastName" required>
            </div>

            <div class="form-group">
                <label for="cnic">CNIC:</label>
                <input type="text" name="cnic" required>
            </div>

            <div class="form-group">
                <label for="dob">Date of Birth:</label>
                <input type="date" name="dob" required>
            </div>

          <div class="gender-type">
            <label for="gender" class="gender-label" style="margin-right:38px">Gender:</label>
            <select id="gender" class="gender-dropdown" name="gender">
                <option value="" selected disabled>Select an option</option> <!-- Default option -->
                <option value="M">Male</option>
                <option value="F">Female</option>
                <option value="O">Other</option>
            </select>
        </div>

            <div class="form-group">
                <label for="section">Section:</label>
                <input type="number" name="section" step="1" required>
            </div>

              <div class="form-group">
                <label for="section">Batch:</label>
                <input type="text" name="batch" required>
            </div>

              <div class="form-group">
                <label for="section">Degree:</label>
                <input type="text" name="degree" required>
            </div>
            <br />
            
            <div class="form-group" style="margin-top:25px">
                <label for="cgpa">Semester:</label>
                <input type="text" name="semester" required>
            </div>

            <!-- Add more input fields as needed -->

        </div>
         <br />
        <div class="form-actions">
           <asp:Button ID="bruh" runat="server" Text="Register" OnClick="btnReg_Click" CssClass="buttoncs" />
        </div>
    </form>
</body>
</html>

