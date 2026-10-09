<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Registration</title>

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            background-color: #fff;
        }

        /* Main container */
        .main-content {
            width: 45%;
            border-radius: 20px;
            box-shadow: 0 5px 5px rgba(0, 0, 0, .4);
            margin: 5em auto;
            display: flex;
            overflow: hidden;
        }

        /* Left section */
        .company__info {
            width: 33.33%;
            background-color: #008080;

            border-top-left-radius: 20px;
            border-bottom-left-radius: 20px;

            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;

            color: #fff;
            text-align: center;
        }

        .company__logo h2 {
            margin: 0;
        }

        .fa-android {
            font-size: 3em;
        }

        .company_title {
            margin-top: 25px;
        }

        /* Right section */
        .registration_form {
            width: 66.67%;
            background-color: #fff;

            border-top-right-radius: 20px;
            border-bottom-right-radius: 20px;

            border-top: 1px solid #ccc;
            border-right: 1px solid #ccc;

            text-align: center;

            padding: 20px 40px;
        }

        .registration_form h2 {
            color: #008080;
            margin-bottom: 20px;
        }

        /* Form */
        form {
            padding: 0 0.5em;
        }

        .form__input {
            width: 100%;

            border: 0;
            border-radius: 0;

            border-bottom: 1px solid #aaa;

            padding: 0.8em 0.5em 0.5em;

            outline: none;

            margin: 0.8em auto;

            transition: all .5s ease;
        }

        .form__input:focus {
            border-bottom-color: #008080;

            box-shadow: 0 0 5px rgba(0, 80, 80, .4);

            border-radius: 4px;
        }

        /* Register button */
        .btn {
            display: block;

            width: 70%;

            margin: 1.2em auto 1em;

            padding: 8px;

            border-radius: 30px;

            color: #008080;

            font-weight: 600;

            background-color: #fff;

            border: 1px solid #008080;

            cursor: pointer;

            transition: all .5s ease;
        }

        .btn:hover,
        .btn:focus {
            background-color: #008080;
            color: #fff;
        }

        /* Login link */
        .login-link {
            margin-top: 10px;
        }

        .login-link a {
            color: #008080;
            text-decoration: none;
        }

        .form__select {
            width: 100%;
            border: 0;
            border-radius: 0;
            border-bottom: 1px solid #aaa;
            padding: 0.8em 0.5em 0.5em;
            outline: none;
            margin: 0.8em auto;
            background-color: #fff;
            transition: all .5s ease;
        }

        .form__select:focus {
            border-bottom-color: #008080;
            box-shadow: 0 0 5px rgba(0, 80, 80, .4);
            border-radius: 4px;
        }

        /* Error message */
        .error-message {
            color: red;
            margin: 10px 0;
            font-size: 14px;
        }

        /* Mobile */
        @media screen and (max-width: 640px) {

            .main-content {
                width: 90%;
            }

            .company__info {
                display: none;
            }

            .registration_form {
                width: 100%;

                border-top-left-radius: 20px;
                border-bottom-left-radius: 20px;
            }
        }

        /* Tablet */
        @media screen and (min-width: 642px)
               and (max-width: 800px) {

            .main-content {
                width: 70%;
            }
        }

    </style>

</head>


<body>

    <!-- Main Content -->
    <div class="main-content">

        <!-- Left Side -->
        <div class="company__info">

            <span class="company__logo">
                <h2><span class="fa fa-android"></span></h2>
            </span>

            <h4 class="company_title">Your Company Logo</h4>

        </div>


        <!-- Registration Form -->
        <div class="registration_form">

            <h2>Registration</h2>

            <!-- Server-side error message -->
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");

                if (errorMessage != null) {
            %>

                <div class="error-message">
                    <%= errorMessage %>
                </div>

            <%
                }
            %>


            <form action="RegisterServlet" method="post" id="registrationForm">

                <input type="text" name="username" id="username" class="form__input" placeholder="Username"
                       value="<%= request.getAttribute("username") != null
                                ? request.getAttribute("username") : "" %>"
                       required>


                <input type="email" name="email" id="email" class="form__input" placeholder="Email"
                       value="<%= request.getAttribute("email") != null
                                ? request.getAttribute("email") : "" %>"
                       required>

                <input type="tel" name="mobile" id="mobile" class="form__input" pattern="[6-9][0-9]{9}" placeholder="Mobile"
                       value="<%= request.getAttribute("mobile") != null
                                ? request.getAttribute("mobile") : "" %>"
                       required>

                <select name="role" id="role" class="form__select" required>
						<option value="CUSTOMER" selected> Customer</option>
                    	<option value="ADMIN">Admin</option>
				 </select>

                <input type="text" name="city" id="city" class="form__input" placeholder="City"
                       value="<%= request.getAttribute("city") != null
                                ? request.getAttribute("city") : "" %>"
                       required>


                <input type="password" name="password" id="password" class="form__input" placeholder="Password" required>

                <input type="password" name="cpassword" id="cpassword" class="form__input" placeholder="Confirm Password" required>

                <!-- JavaScript password error -->
                <small id="passwordError" style="color: red; display: none;">
					Passwords do not match.
                    Please enter the same password.
                </small>

                <input type="submit" value="Register" class="btn">

            </form>


            <!-- Login link -->
            <div class="login-link">

                <p>Already have an account?
                    <a href="Login.html"> Login Here</a>
                </p>

            </div>

        </div>

    </div>

    <!-- Password Verification -->
    <script>

        document.getElementById("registrationForm")
        .addEventListener("submit", function(event) {

            let password = document.getElementById("password").value;

            let cpassword = document.getElementById("cpassword").value;

            let passwordError = document.getElementById("passwordError");

			if (password !== cpassword) {
				event.preventDefault();
				passwordError.style.display = "block";
			}

            else {
			    passwordError.style.display = "none";
			}

        });

    </script>
</body>

</html>