<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Change Password</title>

    <style>

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #f5f5f5;
        }

        .password-container {
            width: 400px;
            background: white;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
        }

        .password-container h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #333;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #444;
            font-weight: bold;
        }

        .form-group input {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
            outline: none;
        }

        .form-group input:focus {
            border-color: #008080;
        }

        .submit-btn {
            width: 100%;
            padding: 13px;
            border: none;
            border-radius: 6px;
            background: #008080;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        .submit-btn:hover {
            background: #006666;
        }

        .message {
            text-align: center;
            margin-bottom: 15px;
            color: red;
        }

        .success {
            color: green;
        }
        
        .login {
        	text-decoration : none;
        	text-align : center;
        }
        

    </style>

</head>

<body>

    <div class="password-container">

        <h2>Change Password</h2>

        <%
            String error = (String) request.getAttribute("error");
            String success = (String) request.getAttribute("success");

            if (error != null) {
        %>
            <div class="message"><%= error %></div>
        <%
            }

            if (success != null) {
        %>
            <div class="message success"><%= success %></div>
        <%
            }
        %>

        <form action="<%= request.getContextPath() %>/UpdatePassword"
              method="post">
			
			<div class="form-group">

                <label for="Email">
                    Enter email id
                </label>

                <input type="email"
                       id="email"
                       name="email"
                       placeholder="Enter your email"
                       required>

            </div>
            
            <div class="form-group">

                <label for="password">
                    Create New Password
                </label>

                <input type="password"
                       id="password"
                       name="password"
                       placeholder="Enter new password"
                       required>

            </div>


            <div class="form-group">

                <label for="confirmPassword">
                    Confirm Password
                </label>

                <input type="password"
                       id="confirmPassword"
                       name="confirmPassword"
                       placeholder="Confirm new password"
                       required>

            </div>


            <button type="submit" class="submit-btn">
                Change Password
            </button>

        </form>
        <div class="login">
        	<a href="Login.jsp">login here</a>
		</div>
    </div>

</body>
</html>