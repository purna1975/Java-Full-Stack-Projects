<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Registration</title>
    <style>
        /* Reset default margin/padding */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #74ebd5, #9face6);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .register-container {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            width: 400px;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }

        .register-container h2 {
            margin-bottom: 20px;
            color: #333;
        }

        .register-container label {
            display: block;
            text-align: left;
            margin-bottom: 5px;
            font-weight: bold;
            color: #444;
        }

        .register-container input {
            width: 100%;
            padding: 12px;
            margin-bottom: 18px;
            border: 1px solid #ccc;
            border-radius: 8px;
            transition: all 0.3s;
        }

        .register-container input:focus {
            border-color: #6c63ff;
            outline: none;
            box-shadow: 0 0 8px rgba(108, 99, 255, 0.5);
        }

        .register-container button {
            background: #6c63ff;
            color: #fff;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s, transform 0.2s;
            width: 100%;
        }

        .register-container button:hover {
            background: #574b90;
            transform: scale(1.05);
        }

        .register-container p {
            margin-top: 15px;
            font-size: 14px;
            color: #555;
        }

        .register-container a {
            color: #6c63ff;
            text-decoration: none;
            font-weight: bold;
        }

        .register-container a:hover {
            text-decoration: underline;
        }

        /* Fade-in animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .error {
            color: red;
            font-size: 13px;
            margin-bottom: 10px;
        }
    </style>

    <script>
        function validateForm() {
            const password = document.getElementById("password").value;
            const cpassword = document.getElementById("cpassword").value;
            const errorBox = document.getElementById("errorBox");

            if (password !== cpassword) {
                errorBox.innerText = "Passwords do not match!";
                return false;
            }
            return true;
        }
    </script>
</head>
<body>

    <div class="register-container">
        <h2>Register</h2>

        <form action="RegisterServlet" method="post" onsubmit="return validateForm()">
            <div id="errorBox" class="error"></div>

            <label for="name">Name</label>
            <input type="text" id="name" name="name" required>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>

            <label for="cpassword">Confirm Password</label>
            <input type="password" id="cpassword" name="cpassword" required>

            <label for="phonenumber">Phone Number</label>
            <input type="tel" id="phonenumber" name="phonenumber" pattern="[0-9]{10}" 
                   placeholder="Enter 10-digit number" required>

            <button type="submit">Register</button>
        </form>

        <p>Already have an account? <a href="login.jsp">Login Here</a></p>
    </div>

</body>
</html>
