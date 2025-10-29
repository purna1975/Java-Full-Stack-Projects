<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Menu" %>
<%@ page import="com.tap.model.Restaurant" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Restaurant Menu - FoodHub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        .navbar {
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .menu-card {
            transition: transform 0.3s, box-shadow 0.3s;
            height: 100%;
        }
        .menu-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        .card-img-container {
            position: relative;
            overflow: hidden;
            height: 200px;
        }
        .card-img-top {
            object-fit: cover;
            height: 100%;
            width: 100%;
            transition: transform 0.3s;
        }
        .menu-card:hover .card-img-top {
            transform: scale(1.05);
        }
        .unavailable-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0,0,0,0.6);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
        }
        .price-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #fc8019;
            color: white;
            padding: 5px 10px;
            border-radius: 20px;
            font-weight: bold;
        }
        .add-to-cart-form {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .quantity-input {
            width: 60px;
            text-align: center;
        }
        .add-to-cart-btn {
            background-color: #fc8019;
            border: none;
            color: white;
            padding: 8px 15px;
            border-radius: 5px;
            transition: background-color 0.3s;
        }
        .add-to-cart-btn:hover {
            background-color: #e67312;
        }
        .add-to-cart-btn:disabled {
            background-color: #ffd4b8;
            cursor: not-allowed;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top">
        <div class="container">
            <a class="navbar-brand fw-bold text-danger" href="#">FoodHub</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarContent">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="home.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="cart.jsp">Cart</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container py-5">
        <%
            Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
            if (restaurant != null) {
        %>
        <h1 class="mb-4"><%= restaurant.getName() %> Menu</h1>
        <%
            } else {
        %>
        <h1 class="mb-4">Restaurant Menu</h1>
        <%
            }
        %>

        <div class="row g-4">
            <%
                List<Menu> menus = (List<Menu>) request.getAttribute("menus");
                if (menus != null && !menus.isEmpty()) {
                    for (Menu m : menus) {
            %>
            <div class="col-md-4 mb-4">
                <div class="card menu-card shadow-sm h-100">
                    <div class="card-img-container">
                        <% if (m.getBase64Image() != null) { %>
                        <img src="data:image/jpeg;base64,<%= m.getBase64Image() %>" class="card-img-top" alt="<%= m.getItemName() %>">
                        <% } else { %>
                        <img src="https://via.placeholder.com/300x200?text=<%= m.getItemName() %>" class="card-img-top" alt="No Image">
                        <% } %>
                        <span class="price-badge">₹<%= m.getPrice() %></span>
                        <% if (!m.isAvailable()) { %>
                        <div class="unavailable-overlay">Currently Unavailable</div>
                        <% } %>
                    </div>
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title mb-3"><%= m.getItemName() %></h5>
                        <p class="card-text mb-3"><%= m.getDescription() %></p>
                        <p class="text-warning"><i class="bi bi-star-fill"></i> <%= m.getRatings() %></p>
                        
                        <form action="cart" class="mt-auto add-to-cart-form">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="itemId" value="<%= m.getMenuId() %>">
                            <input type="hidden" name="restaurantId" value="<%= m.getRestaurantId() %>">
                            <div class="input-group">
                                <input type="number" name="quantity" class="form-control quantity-input" value="1" min="1" max="10" <%= m.isAvailable() ? "" : "disabled" %>>
                                <button type="submit" class="add-to-cart-btn" <%= m.isAvailable() ? "" : "disabled" %>>
                                    <i class="bi bi-cart-plus"></i> Add to Cart
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="col-12">
                <p class="text-center text-muted">No menu items available.</p>
            </div>
            <%
                }
            %>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const quantityInputs = document.querySelectorAll('.quantity-input');
            quantityInputs.forEach(input => {
                input.addEventListener('change', function() {
                    if (this.value < 1) this.value = 1;
                    if (this.value > 10) this.value = 10;
                });
            });
        });
    </script>
</body>
</html>
