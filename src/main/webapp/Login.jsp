<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>

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
    }

    /* Main Content */
    .main-content {
        width: 40%;
        border-radius: 20px;
        box-shadow: 0 5px 5px rgba(0,0,0,.4);
        margin: 5em auto;
        display: flex;
        overflow: hidden;
    }

    /* Left Side */
    .company__info {
        background-color: #008080;
        width: 33.33%;
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

    /* Right Side */
    .login_form {
        background-color: #fff;
        width: 66.67%;
        border-top-right-radius: 20px;
        border-bottom-right-radius: 20px;
        border-top: 1px solid #ccc;
        border-right: 1px solid #ccc;
        text-align: center;
    }

    .login_form h2 {
        color: #008080;
    }

    /* Form */
    form {
        padding: 0 2em;
    }

    .form__input {
        width: 100%;
        border: 0;
        border-radius: 0;
        border-bottom: 1px solid #aaa;
        padding: 1em .3em .3em;
        padding-left: 2em;
        outline: none;
        margin: 1.2em auto;
        transition: all .5s ease;
    }

    .form__input:focus {
        border-bottom-color: #008080;
        box-shadow: 0 0 5px rgba(0,80,80,.4);
        border-radius: 4px;
    }

    /* Links */
    .forgot-password {
        text-align: center;
        margin-top: .5em;
    }

    .forgot-password a {
        color: #008080;
        text-decoration: none;
    }

    /* Submit Button */
    .btn {
        display: block;
        margin: 1.5em auto 1em;
        transition: all .5s ease;
        width: 70%;
        border-radius: 30px;
        color: #008080;
        font-weight: 600;
        background-color: #fff;
        border: 1px solid #008080;
        padding: 8px;
        cursor: pointer;
    }

    .btn:hover,
    .btn:focus {
        background-color: #008080;
        color: #fff;
    }

    /* Register */
    .register {
        margin-top: 15px;
    }

    .register a {
        color: #008080;
        text-decoration: none;
    }

    /* Mobile */
    @media screen and (max-width: 640px) {

        .main-content {
            width: 90%;
        }

        .company__info {
            display: none;
        }

        .login_form {
            width: 100%;
            border-top-left-radius: 20px;
            border-bottom-left-radius: 20px;
        }
    }

    /* Tablet */
    @media screen and (min-width: 642px) and (max-width: 800px) {

        .main-content {
            width: 70%;
        }
    }

</style>
</head>
<body>
<!-- Main Content -->
<div class="main-content">

    <!-- Company Information -->
    <div class="company__info">
        <span class="company__logo">
            <h2> <span class="fa fa-android"></span> </h2>
        </span>
        <h4 class="company_title">Your Company Logo</h4>
    </div>

	<!-- Login Form -->
    <div class="login_form">
        <h2>Log In</h2>
        <form action="LoginServlet" method="post">
            <input type="text" name="email" id="email" class="form__input" placeholder="Email">
            <% String emailerror = (String)request.getAttribute("emailError"); 
            	if(emailerror != null) {
            %>
            	<div class="errormessage"> 
            		<%= emailerror %>
            	</div>
            	<%
            	}
            	%>
            	
			<input type="password" name="password" id="password" class="form__input" placeholder="Password">
				
				 <% String passworderror = (String)request.getAttribute("passwordError"); 
            		if(passworderror != null) {
            	 %>
            	
            	<div class="errormessage"> 
            		<%= passworderror %>
            	</div>
            	<% 
            	}
            	%>
			<div class="forgot-password">
				<a href="UpdatePassword.jsp">forgot password</a>
            </div>
            <input type="submit" value="Submit" class="btn">
            
		</form>


        <div class="register">
            <p>Don't have an account?
                <a href="/foodapp/Registration.jsp">Register Here</a>
            </p>
        </div>
        
    </div>

</div>

<script>
    setTimeout(function() {
        const errors = document.querySelectorAll(".errormessage");

        errors.forEach(function(error) {
            error.style.display = "none";
        });
    }, 5000);
</script>
</body>
</html>