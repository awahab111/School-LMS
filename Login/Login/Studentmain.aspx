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
        margin: 25px 25px;
        text-align: center;
    }

    .profile-info p span.label {
        color: white;
        margin-right: 50px;
    }
    </style>
</head>
<body style="background-color: darkslategray;">
    <div class="sidebar">
        <img src="resources/logo.png" alt="Logo">
    </div>

    <div class="profile-container">
        <h3 style="font-size: 32px">University Information</h3>
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
        <h3 style="font-size: 32px">Courses</h3>
        <br />
        <div class="profile-section">
            <div class="profile-info">
                <p><span>Name:</span> <asp:Label ID="Label1" runat="server"></asp:Label></p>
                <p><span>Roll number:</span> <asp:Label ID="Label2" runat="server"></asp:Label></p>
                <p><span>CNIC:</span> <asp:Label ID="Label3" runat="server"></asp:Label></p>
                <p><span>Date of Birth:</span> <asp:Label ID="Label4" runat="server"></asp:Label></p>
                <p><span>Degree:</span> <asp:Label ID="Label5" runat="server"></asp:Label></p>
                <p><span>Batch: </span> <asp:Label ID="Label6" runat="server"></asp:Label></p>
                <p><span>Semester: </span> <asp:Label ID="Label7" runat="server"></asp:Label></p>
                <!-- Add more labels here -->
            </div>
        </div>
    </div>

    <!-- Add more profile containers if needed -->

</body>
    </html>