<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodHub - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            background: linear-gradient(135deg, #ff758c, #ff7eb3);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .login-container {
            background: #fff;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0px 10px 25px rgba(0, 0, 0, 0.2);
            width: 100%;
            max-width: 400px;
        }
        .login-container h2 {
            margin-bottom: 20px;
            font-weight: bold;
            color: #333;
        }
        .login-icon {
            font-size: 80px;
            color: #ff758c;
            margin-bottom: 20px;
        }
        .form-control {
            border-radius: 12px;
            padding: 10px;
        }
        .btn-primary {
            background: linear-gradient(135deg, #ff758c, #ff7eb3);
            border: none;
            border-radius: 12px;
            font-size: 18px;
            font-weight: bold;
            padding: 10px;
            transition: 0.3s;
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, #ff4a6e, #ff658a);
        }
        .register-link {
            color: #ff4a6e;
            font-weight: bold;
            text-decoration: none;
        }
        .register-link:hover {
            text-decoration: underline;
        }
        .input-group-text {
            background: #fff;
            border-right: none;
        }
        .form-control {
            border-left: none;
        }
        .password-toggle {
            cursor: pointer;
            position: absolute;
            right: 15px;
            top: 10px;
            color: gray;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="login-container text-center">
            <i class="bi bi-person-circle login-icon"></i>
            <h2>Login to FoodHub</h2>
            <% String errorMessage = (String) request.getAttribute("errorMessage"); 
			   if (errorMessage != null) { %>
			    <div class="alert alert-danger text-center" role="alert">
			        <%= errorMessage %>
			    </div>
			<% } %>
            
            <form action="CallLoginServ" id="loginForm">
                <!-- Username field -->
                <div class="mb-4">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                        <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" required>
                    </div>
                </div>
                <!-- Password field -->
                <div class="mb-4">
                    <div class="input-group position-relative">
                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                        <span class="password-toggle" onclick="togglePassword()">
                            <i class="bi bi-eye" id="toggleIcon"></i>
                        </span>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary w-100 mb-3">Login</button>
            </form>
            <p class="mt-3">New user? <a href="register.jsp" class="register-link">Register Here</a></p>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('loginForm').addEventListener('submit', function(event) {
            var username = document.getElementById('username').value;
            var password = document.getElementById('password').value;
            
            if (username.trim() === '' || password.trim() === '') {
                event.preventDefault();
                alert('Please fill in all fields!');
            }
        });

        function togglePassword() {
            var passwordInput = document.getElementById('password');
            var toggleIcon = document.getElementById('toggleIcon');
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('bi-eye');
                toggleIcon.classList.add('bi-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('bi-eye-slash');
                toggleIcon.classList.add('bi-eye');
            }
        }
    </script>
</body>
</html>
