<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.tap.model.Restaurant, com.tap.model.User" %>
<%
    if (session.getAttribute("restaurants") == null) {
        com.tap.daoimpl.RestaurantDAOImpl rdao = new com.tap.daoimpl.RestaurantDAOImpl();
        List<com.tap.model.Restaurant> restaurantList = rdao.getAllRestaurants();
        session.setAttribute("restaurantList", restaurantList);
    }
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodHub - Restaurant Listings</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="main.css">
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light fixed-top">
        <div class="container">
            <a class="navbar-brand text-primary" href="#"><i class="bi bi-egg-fried me-2"></i>FoodHub</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#home">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#restaurants">Restaurants</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="cuisineDropdown" role="button" data-bs-toggle="dropdown">
                            Cuisines
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item cuisine-filter" href="#" data-cuisine="South Indian">South Indian</a></li>
                            <li><a class="dropdown-item cuisine-filter" href="#" data-cuisine="North Indian">North Indian</a></li>
                            <li><a class="dropdown-item cuisine-filter" href="#" data-cuisine="Chinese">Chinese</a></li>
                            <li><a class="dropdown-item cuisine-filter" href="#" data-cuisine="Italian">Italian</a></li>
                            <li><a class="dropdown-item cuisine-filter" href="#" data-cuisine="Japanese">Japanese</a></li>
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">Contact Us</a>
                    </li>
                </ul>
                <div class="d-flex align-items-center">
                    <span class="me-3"><i class="bi bi-geo-alt-fill"></i> Bangalore, India</span>
                    <% if (user != null) { %>
                        <a href="OrderHistory" class="btn btn-outline-primary me-2">
                            <i class="bi bi-clock-history"></i> Orders
                        </a>
                        <div class="dropdown">
                            <button class="btn btn-link text-dark p-0" data-bs-toggle="dropdown">
                                <div class="user-profile-icon">
                                    <i class="bi bi-person-circle fs-4"></i>
                                    <span class="ms-2"><%= user.getName() %></span>
                                </div>
                            </button>
                            <ul class="dropdown-menu dropdown-menu-end">
                                <li><a class="dropdown-item" href="#"><i class="bi bi-person me-2"></i>Profile</a></li>
                                <li><a class="dropdown-item" href="LogoutServlet"><i class="bi bi-box-arrow-right me-2"></i>Logout</a></li>
                            </ul>
                        </div>
                    <% } else { %>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#loginModal">
                            <i class="bi bi-person"></i> Login
                        </button>
                    <% } %>
                </div>
            </div>
        </div>
    </nav>

<!-- Login Modal -->
<div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="loginModalLabel">Login to FoodHub</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                
                <!-- ✅ Updated form -->
                <form id="loginForm" action="<%= request.getContextPath() %>/CallLoginServlet" method="post">
                    <div class="mb-3">
                        <label for="loginUsername" class="form-label">Username</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-person"></i></span>
                            <input type="text" class="form-control" id="loginUsername" name="username" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="loginPassword" class="form-label">Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-lock"></i></span>
                            <input type="password" class="form-control" id="loginPassword" name="password" required>
                            <span class="input-group-text password-toggle" onclick="togglePassword('loginPassword')">
                                <i class="bi bi-eye" id="toggleIconLoginPassword"></i>
                            </span>
                        </div>
                    </div>
                    
                    <!-- ✅ Submit button -->
                    <button type="submit" class="btn btn-primary w-100">Login</button>
                </form>
                
                <p class="mt-3 text-center">Don't have an account? 
                    <a href="#" data-bs-toggle="modal" data-bs-target="#registerModal">Register here</a>
                </p>
            </div>
        </div>
    </div>
</div>




    <!-- Register Modal -->
    <div class="modal fade" id="registerModal" tabindex="-1" aria-labelledby="registerModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="registerModalLabel">Register for FoodHub</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="RegisterServlet" method="post" id="registerForm">
                        <div class="alert alert-danger" id="errorMessage" style="display: none;"></div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="name" class="form-label">Full Name</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-person"></i></span>
                                    <input type="text" class="form-control" id="name" name="name" required>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label">Email address</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                                    <input type="email" class="form-control" id="email" name="email" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="phonenumber" class="form-label">Phone Number</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-phone"></i></span>
                                    <input type="tel" class="form-control" id="phonenumber" name="phone" required>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="username" class="form-label">Username</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-person-badge"></i></span>
                                    <input type="text" class="form-control" id="username" name="username" required>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-geo-alt"></i></span>
                                <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="password" class="form-label">Password</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                    <input type="password" class="form-control" id="password" name="password" required>
                                    <span class="input-group-text password-toggle" onclick="togglePassword('password')">
                                        <i class="bi bi-eye" id="toggleIconPassword"></i>
                                    </span>
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="cpassword" class="form-label">Confirm Password</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-lock"></i></span>
                                    <input type="password" class="form-control" id="cpassword" name="cpassword" required>
                                    <span class="input-group-text password-toggle" onclick="togglePassword('cpassword')">
                                        <i class="bi bi-eye" id="toggleIconCPassword"></i>
                                    </span>
                                </div>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label for="role" class="form-label">Role</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="bi bi-person-gear"></i></span>
                                <select class="form-select" id="role" name="role" required>
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
                </div>
            </div>
        </div>
    </div>

    <!-- Carousel -->
    <div id="foodCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#foodCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#foodCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#foodCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
            <button type="button" data-bs-target="#foodCarousel" data-bs-slide-to="3" aria-label="Slide 4"></button>
            <button type="button" data-bs-target="#foodCarousel" data-bs-slide-to="4" aria-label="Slide 5"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=1600&h=400&q=80" class="d-block w-100" alt="Delicious Food">
                <div class="carousel-caption">
                    <h3>Discover Culinary Delights</h3>
                    <p>Explore a world of flavors right at your doorstep</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="https://images.unsplash.com/photo-1414235077428-338989a2e8c0?auto=format&fit=crop&w=1600&h=400&q=80" class="d-block w-100" alt="Restaurant Ambiance">
                <div class="carousel-caption">
                    <h3>Dine in Style</h3>
                    <p>Experience the best restaurants in town</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="https://images.unsplash.com/photo-1498837167922-ddd27525d352?auto=format&fit=crop&w=1600&h=400&q=80" class="d-block w-100" alt="Variety of Cuisines">
                <div class="carousel-caption">
                    <h3>Explore Global Cuisines</h3>
                    <p>From local favorites to international delicacies</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="https://images.unsplash.com/photo-1476224203421-9ac39bcb3327?auto=format&fit=crop&w=1600&h=400&q=80" class="d-block w-100" alt="Food Delivery">
                <div class="carousel-caption">
                    <h3>Swift Delivery</h3>
                    <p>Hot and fresh food delivered to your doorstep</p>
                </div>
            </div>
            <div class="carousel-item">
                <img src="https://images.unsplash.com/photo-1515003197210-e0cd71810b5f?auto=format&fit=crop&w=1600&h=400&q=80" class="d-block w-100" alt="Cooking">
                <div class="carousel-caption">
                    <h3>Culinary Excellence</h3>
                    <p>Prepared by the finest chefs in the city</p>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#foodCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#foodCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>

    <!-- Features Section -->
    <section class="features-section py-5 bg-light">
        <div class="container">
            <h2 class="text-center mb-5">Why Choose FoodHub?</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body text-center">
                            <i class="bi bi-clock-history display-4 text-primary mb-3"></i>
                            <h5 class="card-title">Lightning-Fast Delivery</h5>
                            <p class="card-text">Experience the quickest food delivery in town. Your favorite meals, delivered hot and fresh in no time!</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body text-center">
                            <i class="bi bi-hand-thumbs-up display-4 text-primary mb-3"></i>
                            <h5 class="card-title">Top-Rated Restaurants</h5>
                            <p class="card-text">We partner with only the best restaurants to ensure you get nothing but excellence on your plate.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-body text-center">
                            <i class="bi bi-gift display-4 text-primary mb-3"></i>
                            <h5 class="card-title">Exclusive Offers</h5>
                            <p class="card-text">Enjoy amazing discounts and deals on your favorite cuisines. Saving money never tasted so good!</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Search Section with Cuisine Filter -->
    <section class="search-section py-5">
        <div class="container">
            <h2 class="text-center mb-4">Find Your Favorite Food</h2>
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="input-group mb-3">
                        <input type="text" class="form-control" id="searchInput" placeholder="Search for restaurants or cuisines">
                        <button class="btn btn-primary" type="button"><i class="bi bi-search"></i> Search</button>
                    </div>
                </div>
            </div>
            <div class="text-center mt-4">
                <h4 class="mb-3">Popular Cuisines</h4>
                <div class="d-flex flex-wrap justify-content-center gap-2">
                    <button class="btn btn-outline-primary cuisine-filter active" data-cuisine="all">All</button>
                    <button class="btn btn-outline-primary cuisine-filter" data-cuisine="South Indian">South Indian</button>
                    <button class="btn btn-outline-primary cuisine-filter" data-cuisine="North Indian">North Indian</button>
                    <button class="btn btn-outline-primary cuisine-filter" data-cuisine="Chinese">Chinese</button>
                    <button class="btn btn-outline-primary cuisine-filter" data-cuisine="Italian">Italian</button>
                    <button class="btn btn-outline-primary cuisine-filter" data-cuisine="Japanese">Japanese</button>
                </div>
            </div>
        </div>
    </section>

    <!-- Restaurants Section -->
    <section id="restaurants" class="py-5">
        <div class="container">
            <h2 class="mb-4">Top Restaurants</h2>
            <div class="row g-4" id="restaurantContainer">
                <% 
                    List<Restaurant> restaurantList = (List<Restaurant>) session.getAttribute("restaurantList");
                    if (restaurantList != null) {
                        for (Restaurant restaurant : restaurantList) {
                %>
                <div class="col-12 col-md-6 col-lg-4 restaurant-item" data-cuisine="<%= restaurant.getCuisineType() %>">
                    <div class="card restaurant-card">
                        <img src="data:image/jpeg;base64,<%= restaurant.getBase64Image() %>" class="card-img-top" alt="<%= restaurant.getName() %>">
                        <div class="card-body">
                            <h5 class="card-title"><%= restaurant.getName() %></h5>
                            <p class="cuisine-type text-muted mb-2"><%= restaurant.getCuisineType() %></p>
                            <p class="text-muted small mb-2"><i class="bi bi-geo-alt"></i> <%= restaurant.getAddress() %></p>
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="badge bg-success"><i class="bi bi-star-fill"></i> <%= restaurant.getRating() %></span>
                                <span class="text-muted small"><i class="bi bi-clock"></i> <%= restaurant.getDeliveryTime() %> mins</span>
                            </div>
                            <a href="menu?restaurantId=<%= restaurant.getRestaurantId() %>" class="btn btn-outline-primary w-100">
                                <i class="bi bi-arrow-right-circle me-2"></i>View Menu
                            </a>
                        </div>
                    </div>
                </div>
                <% 
                        }
                    } else {
                %>
                <div class="col-12 text-center">
                    <p>No restaurants available.</p>
                </div>
                <% } %>
            </div>
        </div>
    </section>

    <!-- Contact & Feedback Section -->
    <section id="contact" class="contact-section py-5">
        <div class="container">
            <div class="row g-0">
                <!-- Contact Us -->
                <div class="col-md-6">
                    <div class="contact-left h-100 p-5 text-center">
                        <div class="contact-icon mb-4">
                            <i class="bi bi-envelope display-4 text-primary"></i>
                        </div>
                        <h2 class="mb-4 text-primary">Contact us</h2>
                        <p class="mb-5 text-dark">if you have any queries, you can contact us at the following:</p>
                        <div class="social-icons d-flex gap-4 mb-5 justify-content-center gap-4 mb-5">
                             <a href="#" class="text-primary fs-3"><i class="bi bi-twitter"></i></a>
                             <a href="#" class="text-primary fs-3"><i class="bi bi-instagram"></i></a>
                             <a href="#" class="text-primary fs-3"><i class="bi bi-github"></i></a>
                        </div>
                        <div class="location-info">
                            <h3 class="h5 mb-4 text-primary" >Location</h3>
                            <p class="mb-0 text-dark">FoodHub Headquarters<br>
                            Koramangala<br>
                            Bangalore, India</p>
                        </div>
                    </div>
                </div>
                <!-- Feedback Form -->
                <div class="col-md-6">
                    <div class="feedback-right h-100 p-5">
                        <h2 class="mb-4" style="color: #00D290;">FeedBack</h2>
                        <form class="feedback-form">
                            <div class="mb-4">
                                <input type="text" class="form-control form-control-lg border-0 shadow-sm" 
                                       placeholder="Name" required>
                            </div>
                            <div class="mb-4">
                                <input type="email" class="form-control form-control-lg border-0 shadow-sm" 
                                       placeholder="Email" required>
                            </div>
                            <div class="mb-4">
                                <input type="tel" class="form-control form-control-lg border-0 shadow-sm" 
                                       placeholder="Mobile Number" required>
                            </div>
                            <div class="mb-4">
                                <textarea class="form-control form-control-lg border-0 shadow-sm" 
                                          rows="4" placeholder="Your Description" required></textarea>
                            </div>
                            <button type="submit" class="btn btn-lg w-100 text-white" 
                                    style="background-color: #00D290;">SUBMIT</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer py-4" style="background-color: #02060C;">
        <div class="container">
            <div class="row">
                <div class="col-12 text-center">
                    <div class="d-flex align-items-center justify-content-center mb-2">
                       
                        <p class="mb-0 copyright-text">
                            Copyright © 2025 , <i class="bi bi-egg-fried"></i> FoodHub
                        </p>
                    </div>
                    <p class="mb-2 text-white">All Rights Reserved</p>
                    <p class="mb-3 text-white">Developed & Maintained by Purna Chandra</p>
        
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="main.js"></script>
</body>
</html>
