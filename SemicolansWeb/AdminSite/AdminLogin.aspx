<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="eCommerce.AdminSite.AdminLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
<!--===============================================================================================-->	
	<link rel="icon" type="image/png" href="AdminLoginAssets/images/icons/favicon.ico"/>
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="AdminLoginAssets/vendor/bootstrap/css/bootstrap.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="AdminLoginAssets/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="AdminLoginAssets/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="AdminLoginAssets/vendor/animate/animate.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="AdminLoginAssets/vendor/css-hamburgers/hamburgers.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="AdminLoginAssets/vendor/animsition/css/animsition.min.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="AdminLoginAssets/vendor/select2/select2.min.css">
<!--===============================================================================================-->	
	<link rel="stylesheet" type="text/css" href="AdminLoginAssets/vendor/daterangepicker/daterangepicker.css">
<!--===============================================================================================-->
	<link rel="stylesheet" type="text/css" href="AdminLoginAssets/css/util.css">
	<link rel="stylesheet" type="text/css" href="AdminLoginAssets/css/main.css">
<!--===============================================================================================-->

</head>
<body>
    <form id="form1" runat="server">
	    <div class="limiter">
		    <div class="container-login100">
			    <div class="wrap-login100 p-l-85 p-r-85 p-t-55 p-b-55">
				    <div class="login100-form validate-form flex-sb flex-w">
					    <span class="login100-form-title p-b-32">
						    Admin Login
					    </span>

					    <span class="txt1 p-b-11">
						    Username
					    </span>
					    <div class="wrap-input100 validate-input m-b-36" data-validate = "Username is required">
                            <asp:TextBox ID="txtUserName" class="input100" contentplaceholder="xyz@abc.com" runat="server"></asp:TextBox>
						    <span class="focus-input100"></span>
					    </div>
					
					    <span class="txt1 p-b-11">
						    Password
					    </span>
					    <div class="wrap-input100 validate-input m-b-12" data-validate = "Password is required">
						    <span class="btn-show-pass">
							    <i class="fa fa-eye"></i>
						    </span>
                            <asp:TextBox ID="txtPassword" class="input100" type="password" contentplaceholder="Input Password" runat="server"></asp:TextBox>
						    <span class="focus-input100"></span>
					    </div>
					
					    <div class="flex-sb-m w-full p-b-48">
						    <div class="contact100-form-checkbox">
							    <label class="label-checkbox100" for="ckb1">
								    Remember me
							    </label>
						    </div>

						    <div>
							    <a href="#" class="txt3">
								    Forgot Password?
							    </a>
						    </div>
					    </div>

					    <div class="container-login100-form-btn">
                            <asp:Button ID="btnLogin" runat="server" class="login100-form-btn" Text="Login" OnClick="btnLogin_Click"/>
					    </div>

				    </div>
			    </div>
		    </div>
	    </div>
	    <div id="dropDownSelect1"></div>

        <!--===============================================================================================-->
	        <script src="AdminLoginAssets/vendor/jquery/jquery-3.2.1.min.js"></script>
        <!--===============================================================================================-->
	        <script src="AdminLoginAssets/vendor/animsition/js/animsition.min.js"></script>
        <!--===============================================================================================-->
	        <script src="AdminLoginAssets/vendor/bootstrap/js/popper.js"></script>
	        <script src="AdminLoginAssets/vendor/bootstrap/js/bootstrap.min.js"></script>
        <!--===============================================================================================-->
	        <script src="AdminLoginAssets/vendor/select2/select2.min.js"></script>
        <!--===============================================================================================-->
	        <script src="AdminLoginAssets/vendor/daterangepicker/moment.min.js"></script>
	        <script src="AdminLoginAssets/vendor/daterangepicker/daterangepicker.js"></script>
        <!--===============================================================================================-->
	        <script src="AdminLoginAssets/vendor/countdowntime/countdowntime.js"></script>
        <!--===============================================================================================-->
	        <script src="AdminLoginAssets/js/main.js"></script>
    </form>
</body>
</html>
