<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.tap.daoimpl.UserDaoImpl, com.tap.model.User" %>

<%
    String admin = (String) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("home.jsp");
        return;
    }

    String searchQuery = request.getParameter("search");
    if (searchQuery == null) {
        searchQuery = "";
    }

    UserDaoImpl userDao = new UserDaoImpl();
    List<User> users = userDao.getAllUsers(searchQuery);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wonderland Travels - Manage Users</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        .sidebar {
            min-height: 100vh;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }
        .page-header {
            background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);
            color: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        .search-box {
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            background: white;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        .table-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 1.5rem;
        }
        .table {
            margin-bottom: 0;
        }
        .table thead th {
            background-color: #f8f9fa;
            border-bottom: 2px solid #dee2e6;
        }
        .status-badge {
            padding: 0.5em 1em;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 500;
        }
        .status-active {
            background-color: #d4edda;
            color: #155724;
        }
        .status-blocked {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body class="bg-light">

<div class="container-fluid">
    <div class="row">
        <!-- Sidebar -->
        <div class="col-md-3 col-lg-2 d-md-block bg-white sidebar p-4">
            <div class="text-center mb-4">
                <i class="bi bi-airplane-engines fs-1 text-primary"></i>
                <h4 class="mt-2">Wonderland Travels</h4>
            </div>
            <hr>
            <ul class="nav flex-column">
                <li class="nav-item mb-2">
                    <a href="admindashboard.jsp" class="nav-link text-dark">
                        <i class="bi bi-speedometer2 me-2"></i> Dashboard
                    </a>
                </li>
                <li class="nav-item mb-2">
                    <a href="manageUsers.jsp" class="nav-link active text-primary">
                        <i class="bi bi-people me-2"></i> Manage Users
                    </a>
                </li>
                <li class="nav-item mb-2">
                    <a href="manageBookings.jsp" class="nav-link text-dark">
                        <i class="bi bi-calendar-check me-2"></i> Manage Bookings
                    </a>
                </li>
                <li class="nav-item mb-2">
                    <a href="adminLogoutServlet" class="nav-link text-danger">
                        <i class="bi bi-box-arrow-right me-2"></i> Logout
                    </a>
                </li>
            </ul>
        </div>

        <!-- Main Content -->
        <div class="col-md-9 col-lg-10 ms-sm-auto px-4 py-3">
            <!-- Page Header -->
            <div class="page-header">
                <div class="d-flex justify-content-between align-items-center">
                    <div>
                        <h2><i class="bi bi-people-fill me-2"></i>Manage Users</h2>
                        <p class="mb-0">View and manage all registered users</p>
                    </div>
                    <div>
                        <a href="manageBookings.jsp" class="btn btn-light">
                            <i class="bi bi-calendar-check me-2"></i>Manage Bookings
                        </a>
                    </div>
                </div>
            </div>

            <!-- Search Box -->
            <div class="search-box">
                <form method="get" action="manageUsers.jsp">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0">
                            <i class="bi bi-search"></i>
                        </span>
                        <input type="text" 
                               class="form-control border-start-0" 
                               name="search" 
                               placeholder="Search by name or email..." 
                               value="<%= searchQuery %>">
                        <button class="btn btn-primary" type="submit">Search</button>
                    </div>
                </form>
            </div>

            <!-- Users Table -->
            <div class="table-container">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th scope="col">ID</th>
                            <th scope="col">Name</th>
                            <th scope="col">Email</th>
                            <th scope="col">Phone</th>
                            <th scope="col">Status</th>
                            <th scope="col">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (User user : users) { %>
                        <tr>
                            <td><%= user.getUserId() %></td>
                            <td>
                                <i class="bi bi-person-circle me-2"></i>
                                <%= user.getName() %>
                            </td>
                            <td>
                                <i class="bi bi-envelope me-2"></i>
                                <%= user.getEmail() %>
                            </td>
                            <td>
                                <i class="bi bi-phone me-2"></i>
                                <%= user.getPhone() %>
                            </td>
                            <td>
                                <span class="status-badge <%= user.getStatus().equals("active") ? "status-active" : "status-blocked" %>">
                                    <i class="bi <%= user.getStatus().equals("active") ? "bi-check-circle" : "bi-x-circle" %> me-1"></i>
                                    <%= user.getStatus() %>
                                </span>
                            </td>
                            <td>
                                <div class="btn-group">
                                    <a href="toggleUserStatusServlet?id=<%= user.getUserId() %>" 
                                       class="btn btn-sm <%= user.getStatus().equals("active") ? "btn-warning" : "btn-success" %>">
                                        <i class="bi <%= user.getStatus().equals("active") ? "bi-slash-circle" : "bi-check-circle" %> me-1"></i>
                                        <%= user.getStatus().equals("active") ? "Block" : "Unblock" %>
                                    </a>
                                    <a href="deleteUserServlet?id=<%= user.getUserId() %>" 
                                       class="btn btn-danger btn-sm ms-1"
                                       onclick="return confirm('Are you sure you want to delete this user?')">
                                        <i class="bi bi-trash me-1"></i>
                                        Delete
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>