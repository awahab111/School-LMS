<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Signup.aspx.cs" Inherits="Signup" %>

<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="style.css">
    <link rel="icon" type="image/png" href="resources/logo.png">

    <title>Signup</title>
 
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>
<body style="height: 109vh;">
    <div class="background">
    </div>
    <form style="height: 700px" id="formSignUp" runat="server">
        <h3 style="line-height: 22px;">Sign Up</h3>

        <label for="email">Email</label>
        <input type="text" placeholder="" id="email" name="email" required>

        <label for="password">Password</label>
        <input type="password" placeholder="" id="password" name="password" required>

        <label for="confirm-password">Confirm Password</label>
        <input type="password" placeholder="" id="confirm-password" required>

        <div class="account-type">
            <label for="account-type">Account Type:</label>
            <select id="account-type" name="account-type">
                <option value="" selected disabled>Select an option</option> <!-- Default option -->
                <option id="s" value="s">Student</option>
                <option value="f">Faculty</option>
                <option value="a">Academic Officer</option>
            </select>
        </div>

        <asp:Button ID="Button1" runat="server" Text="Signup" OnClick="btnSignup_Click" CssClass="buttoncs" />
        <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="buttoncs" />
        <div class="additional-buttons">
        </div>
        <div class="social">
            <a href="https://www.twitter.com" class="go"><i class="fab fa-twitter"></i></a>
            <a href="https://www.facebook.com" class="fb"><i class="fab fa-facebook"></i></a>
            <a href="https://www.instagram.com" class="insta"><i class="fab fa-instagram"></i></a>
        </div>
    </form>
</body>
</html>
