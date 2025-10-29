<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodHub - Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        :root {
            --primary: #fc8019;
            --primary-dark: #e67312;
            --secondary: #02060c;
            --text-color: #535665;
        }

        body {
            background-color: #f8f9fa;
            font-family: 'ProximaNova', Arial, sans-serif;
        }

        .register-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 20px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.1);
        }

        .register-container h2 {
            color: var(--primary);
            margin-bottom: 30px;
            font-weight: 700;
        }

        .form-control {
            border-radius: 10px;
            padding: 12px;
            border: 1px solid #ddd;
        }

        .form-control:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.2rem rgba(252, 128, 25, 0.25);
        }

        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
            border-radius: 10px;
            padding: 12px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
            transform: translateY(-2px);
        }

        .login-link {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .login-link:hover {
            color: var(--primary-dark);
        }

        .input-group-text {
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            border-right: none;
            border-radius: 10px 0 0 10px;
        }

        .password-toggle {
            cursor: pointer;
            padding: 12px;
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            border-left: none;
            border-radius: 0 10px 10px 0;
        }

        .message {
            position: fixed;
            top: 20px;
            left: 50%;
            transform: translateX(-50%);
            padding: 15px 30px;
            border-radius: 5px;
            color: #fff;
            font-weight: bold;
            z-index: 1000;
            opacity: 0;
            transition: opacity 0.5s ease-in-out;
        }

        .message.success {
            background-color: #28a745;
        }

        .message.error {
            background-color: #dc3545;
        }

        .message.show {
            opacity: 1;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="register-container">
            <h2 class="text-center">Register for FoodHub</h2>
            <form action="RegisterServlet"  id="registerForm">
                <div class="mb-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person"></i></span>
                        <input type="text" class="form-control" id="name" name="name" placeholder="Full Name" required>
                    </div>
                </div>
                <div class="mb-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                        <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                    </div>
                </div>
                <div class="mb-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-phone"></i></span>
                        <input type="tel" class="form-control" id="phonenumber" name="phone" placeholder="Phone Number" required>
                    </div>
                </div>
                <div class="mb-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-geo-alt"></i></span>
                        <textarea class="form-control" id="address" name="address" rows="3" placeholder="Address" required></textarea>
                    </div>
                </div>
                <div class="mb-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person-badge"></i></span>
                        <input type="text" class="form-control" id="username" name="username" placeholder="Username" required>
                    </div>
                </div>
                <div class="mb-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                        <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                        <span class="password-toggle" onclick="togglePassword('password')">
                            <i class="bi bi-eye" id="toggleIconPassword"></i>
                        </span>
                    </div>
                </div>
                <div class="mb-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-lock"></i></span>
                        <input type="password" class="form-control" id="cpassword" name="cpassword" placeholder="Confirm Password" required>
                        <span class="password-toggle" onclick="togglePassword('cpassword')">
                            <i class="bi bi-eye" id="toggleIconCPassword"></i>
                        </span>
                    </div>
                </div>
                <div class="mb-3">
                    <div class="input-group">
                        <span class="input-group-text"><i class="bi bi-person-gear"></i></span>
                        <select class="form-control" id="role" name="role" required>
                            <option value="">Select Role</option>
                            <option value="ADMIN">ADMIN</option>
							<option value="CUSTOMER">CUSTOMER</option>
							<option value="DELIVERY">DELIVERY</option>
							<option value="RESTAURANT">RESTAURANT</option>
                        </select>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary w-100">Register</button>
            </form>
            <p class="mt-3 text-center">Already have an account? <a href="login.jsp" class="login-link">Login Here</a></p>
        </div>
    </div>

    <div id="message" class="message"></div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
    document.getElementById('registerForm').addEventListener('submit', function(event) {
        var password = document.getElementById('password').value;
        var cpassword = document.getElementById('cpassword').value;
        var role = document.getElementById('role').value;

        if (password !== cpassword) {
            event.preventDefault(); // Stop submission only if invalid
            showMessage('Passwords do not match!', 'error');
        } else if (role === "") {
            event.preventDefault();
            showMessage('Please select a role!', 'error');
        }
        // ✅ else do nothing → form will submit to RegisterServlet
    });


        function togglePassword(inputId) {
            var passwordInput = document.getElementById(inputId);
            var toggleIcon = document.getElementById('toggleIcon' + (inputId === 'password' ? 'Password' : 'CPassword'));
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

        function showMessage(message, type) {
            var messageDiv = document.getElementById('message');
            messageDiv.textContent = message;
            messageDiv.className = 'message ' + type + ' show';

            setTimeout(() => {
                messageDiv.classList.remove('show');
            }, 3000);
        }
    </script>
</body>
</html>
