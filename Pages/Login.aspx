<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="style.css">
    <link rel="icon" type="image/png" href="resources/logo.png">

    <title>Login</title>
 
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;500;600&display=swap" rel="stylesheet">
</head>
<body>
    <div class="background"></div>


    <form class="form-login" id="formLogin" runat="server">
        <h3>Login</h3>
         <div id="popupImage" style="display: none; text-align:center; margin-top:10px">
            <img src="resources/among-us.gif" alt="Popup Image" style="width:50px; height:50px; align-self:center;">
        </div>
        <label for="username" style="margin-top:10px">Email</label>
        <input type="text" placeholder="" id="email" name="email">

        <label for="password">Password</label>
        <input type="password" placeholder="" id="password" name="password">

        <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click" CssClass="buttoncs" />
        <asp:Button ID="btnSignup" runat="server" Text="Signup" OnClick="btnSignup_Click" CssClass="buttoncs" />
        <div class="additional-buttons">
        </div>
        <div class="social">
          <a href="https://www.twitter.com" class="go"><i class="fab fa-twitter"></i></a>
          <a href="https://www.facebook.com" class="fb"><i class="fab fa-facebook"></i></a>
          <a href="https://www.instagram.com" class="insta"><i class="fab fa-instagram"></i></a>

        </div>
       

    <script>
        // Function to display the popup image
        function showPopupImage() {
            var popup = document.getElementById("popupImage");
            popup.style.display = "block";
        }
    </script>

    </form>
</body>
</html>
