<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.tap.model.User" %>
<%@ page session="true" %>

<% User user = (User) session.getAttribute("user"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wonderland Travels - Experience the Seven Wonders</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link rel="stylesheet" href="styles.css">
    <style>
        .wonder-section {
            padding: 100px 0;
            position: relative;
            overflow: hidden;
        }
        .wonder-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-size: cover;
            background-position: center;
            filter: blur(5px);
            opacity: 0.3;
            z-index: -1;
        }
        .wonder-content {
            background: rgba(255, 255, 255, 0.9);
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .wonder-image-container {
            height: 400px;
            overflow: hidden;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .wonder-image {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        .wonder-image:hover {
            transform: scale(1.05);
        }
        .stats-container {
            background: rgba(255, 255, 255, 0.8);
            border-radius: 10px;
            padding: 20px;
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary fixed-top">
        <div class="container">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/index.jsp">
                <i class="fas fa-globe-americas me-2"></i>Wonderland Travels
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item"><a class="nav-link" href="#home">Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="#wonders">Wonders</a></li>
                    <li class="nav-item"><a class="nav-link" href="#about">About</a></li>
                    <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>

                    <!-- admin login button -->
                    <li class="nav-item">
                        <button class="btn btn-outline-light ms-2" data-bs-toggle="modal" data-bs-target="#adminLoginModal">Admin Login</button>
                    </li>

                    <% if (user == null) { %>
                        <li class="nav-item">
                            <button class="btn btn-outline-light ms-2" data-bs-toggle="modal" data-bs-target="#loginModal">Login</button>
                        </li>
                        <li class="nav-item">
                            <button class="btn btn-light ms-2" data-bs-toggle="modal" data-bs-target="#registerModal">Register</button>
                        </li>
                    <% } else { %>
                        <li class="nav-item">
                            <span class="nav-link text-white">Welcome, <%= user.getName() %>!</span>
                        </li>
                        <li class="nav-item">
                            <a href="<%= request.getContextPath() %>/getbookingservlet" class="btn btn-outline-light ms-2">My Bookings</a>
                        </li>
                        <li class="nav-item">
                            <a href="<%= request.getContextPath() %>/LogoutServlet" class="btn btn-light ms-2">Logout</a>
                        </li>
                    <% } %>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <header id="home" class="hero-section text-white text-center" style="padding-top:80px;">
        <div class="container">
            <h1 class="display-3 mb-4">Discover the Seven Wonders</h1>
            <p class="lead mb-4">Embark on a journey of a lifetime with Wonderland Travels</p>
            <a href="#wonders" class="btn btn-primary btn-lg">Explore Now</a>
        </div>
    </header>

    <!-- Wonders Section -->
    <section id="wonders">
        <!-- Taj Mahal -->
        <div class="wonder-section" style="background-color: #f8f9fa;">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <div class="wonder-content">
                            <h2 class="mb-4">Taj Mahal</h2>
                            <p class="lead mb-4">An ivory-white marble mausoleum on the right bank of the river Yamuna in Agra, India. It was commissioned in 1632 by the Mughal emperor Shah Jahan to house the tomb of his favorite wife, Mumtaz Mahal.</p>
                            <div class="stats-container">
                                <div class="row text-center">
                                    <div class="col-4">
                                        <h4 class="text-primary">8M+</h4>
                                        <small>Annual Visitors</small>
                                    </div>
                                    <div class="col-4">
                                        <h4 class="text-primary">1632</h4>
                                        <small>Year Built</small>
                                    </div>
                                    <div class="col-4">
                                        <h4 class="text-primary">42</h4>
                                        <small>Acres</small>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-4">
                                <a href="<%= request.getContextPath() %>/1tajmahal.jsp" class="btn btn-primary me-2">Learn More</a>
                                <% if (session.getAttribute("user") != null) { %>
                                    <a href="<%= request.getContextPath() %>/booking.jsp?wonderId=1" class="btn btn-success">Book Now</a>
                                <% } else { %>
                                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#loginModal">Book Now</button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 mt-4 mt-lg-0">
                        <div class="wonder-image-container">
                            <img src="https://images.unsplash.com/photo-1548013146-72479768bada?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80" alt="Taj Mahal" class="wonder-image">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Colosseum -->
        <div class="wonder-section" style="background-color: #ffffff;">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6 order-lg-2">
                        <div class="wonder-content">
                            <h2 class="mb-4">Colosseum</h2>
                            <p class="lead mb-4">An oval amphitheatre in the centre of the city of Rome, Italy. Built of travertine limestone, tuff, and brick-faced concrete, it was the largest amphitheatre ever built at the time and held 50,000 to 80,000 spectators.</p>
                            <div class="stats-container">
                                <div class="row text-center">
                                    <div class="col-4">
                                        <h4 class="text-primary">7.6M+</h4>
                                        <small>Annual Visitors</small>
                                    </div>
                                    <div class="col-4">
                                        <h4 class="text-primary">80 AD</h4>
                                        <small>Year Built</small>
                                    </div>
                                    <div class="col-4">
                                        <h4 class="text-primary">6</h4>
                                        <small>Acres</small>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-4">
                                <a href="<%= request.getContextPath() %>/2colosseum.jsp" class="btn btn-primary me-2">Learn More</a>
                                <% if (session.getAttribute("user") != null) { %>
                                    <a href="<%= request.getContextPath() %>/booking.jsp?wonderId=2" class="btn btn-success">Book Now</a>
                                <% } else { %>
                                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#loginModal">Book Now</button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 mt-4 mt-lg-0 order-lg-1">
                        <div class="wonder-image-container">
                            <img src="https://images.unsplash.com/photo-1555992828-ca4dbe41d294?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80" alt="Colosseum" class="wonder-image">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Great Wall of China -->
        <div class="wonder-section" style="background-color: #f8f9fa;">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <div class="wonder-content">
                            <h2 class="mb-4">Great Wall of China</h2>
                            <p class="lead mb-4">A series of fortifications and walls built across the historical northern borders of ancient Chinese states and Imperial China as protection against nomadic invasions from the Eurasian Steppe.</p>
                            <div class="stats-container">
                                <div class="row text-center">
                                    <div class="col-4">
                                        <h4 class="text-primary">10M+</h4>
                                        <small>Annual Visitors</small>
                                    </div>
                                    <div class="col-4">
                                        <h4 class="text-primary">700 BC</h4>
                                        <small>Year Started</small>
                                    </div>
                                    <div class="col-4">
                                        <h4 class="text-primary">13,171</h4>
                                        <small>Miles Long</small>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-4">
                                <a href="<%= request.getContextPath() %>/3greatwallofchina.jsp" class="btn btn-primary me-2">Learn More</a>
                                <% if (session.getAttribute("user") != null) { %>
                                    <a href="<%= request.getContextPath() %>/booking.jsp?wonderId=3" class="btn btn-success">Book Now</a>
                                <% } else { %>
                                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#loginModal">Book Now</button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 mt-4 mt-lg-0">
                        <div class="wonder-image-container">
                            <img src="https://images.unsplash.com/photo-1549893072-4bc678117f45?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80" alt="Great Wall of China" class="wonder-image">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Machu Picchu -->
        <div class="wonder-section" style="background-color: #ffffff;">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6 order-lg-2">
                        <div class="wonder-content">
                            <h2 class="mb-4">Machu Picchu</h2>
                            <p class="lead mb-4">An Incan citadel set high in the Andes Mountains in Peru, above the Urubamba River valley. Built in the 15th century and later abandoned, it's renowned for its sophisticated dry-stone walls that fuse huge blocks without the use of mortar.</p>
                            <div class="stats-container">
                                <div class="row text-center">
                                    <div class="col-4">
                                        <h4 class="text-primary">1.5M+</h4>
                                        <small>Annual Visitors</small>
                                    </div>
                                    <div class="col-4">
                                        <h4 class="text-primary">1450</h4>
                                        <small>Year Built</small>
                                    </div>
                                    <div class="col-4">
                                        <h4 class="text-primary">32,592</h4>
                                        <small>Acres</small>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-4">
                                <a href="<%= request.getContextPath() %>/4machupichu.jsp" class="btn btn-primary me-2">Learn More</a>
                                <% if (session.getAttribute("user") != null) { %>
                                    <a href="<%= request.getContextPath() %>/booking.jsp?wonderId=4" class="btn btn-success">Book Now</a>
                                <% } else { %>
                                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#loginModal">Book Now</button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 mt-4 mt-lg-0 order-lg-1">
                        <div class="wonder-image-container">
                            <img src="https://images.unsplash.com/photo-1526392060635-9d6019884377?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80" alt="Machu Picchu" class="wonder-image">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Christ the Redeemer -->
        <div class="wonder-section" style="background-color: #f8f9fa;">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <div class="wonder-content">
                            <h2 class="mb-4">Christ the Redeemer</h2>
                            <p class="lead mb-4">An Art Deco statue of Jesus Christ in Rio de Janeiro, Brazil. Created by French sculptor Paul Landowski and built by Brazilian engineer Heitor da Silva Costa, it is 98 feet tall, excluding its 26-foot pedestal.</p>
                            <div class="stats-container">
                                <div class="row text-center">
                                    <div class="col-4">
                                        <h4 class="text-primary">2M+</h4>
                                        <small>Annual Visitors</small>
                                    </div>
                                    <div class="col-4">
                                        <h4 class="text-primary">1931</h4>
                                        <small>Year Completed</small>
                                    </div>
                                    <div class="col-4">
                                        <h4 class="text-primary">98</h4>
                                        <small>Feet Tall</small>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-4">
                                <a href="<%= request.getContextPath() %>/5christtheredemer.jsp" class="btn btn-primary me-2">Learn More</a>
                                <% if (session.getAttribute("user") != null) { %>
                                    <a href="<%= request.getContextPath() %>/booking.jsp?wonderId=5" class="btn btn-success">Book Now</a>
                                <% } else { %>
                                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#loginModal">Book Now</button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 mt-4 mt-lg-0">
                        <div class="wonder-image-container">
                            <img src="https://images.unsplash.com/photo-1593995863951-57c27e518295?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80" alt="Christ the Redeemer" class="wonder-image">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Petra -->
        <div class="wonder-section" style="background-color: #ffffff;">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6 order-lg-2">
                        <div class="wonder-content">
                            <h2 class="mb-4">Petra</h2>
                            <p class="lead mb-4">A famous archaeological site in Jordan's southwestern desert. Dating to around 300 B.C., it was the capital of the Nabatean Kingdom. Accessed via a narrow canyon called Al Siq, it contains tombs and temples carved into pink sandstone cliffs.</p>
                            <div class="stats-container">
                                <div class="row text-center">
                                    <div class="col-4">
                                        <h4 class="text-primary">1M+</h4>
                                        <small>Annual Visitors</small>
                                    </div>
                                    <div class="col-4">
                                        <h4 class="text-primary">312 BC</h4>
                                        <small>Year Founded</small>
                                    </div>
                                    <div class="col-4">
                                        <h4 class="text-primary">264</h4>
                                        <small>Square km</small>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-4">
                                <a href="<%= request.getContextPath() %>/6petra.jsp" class="btn btn-primary me-2">Learn More</a>
                                <% if (session.getAttribute("user") != null) { %>
                                    <a href="<%= request.getContextPath() %>/booking.jsp?wonderId=6" class="btn btn-success">Book Now</a>
                                <% } else { %>
                                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#loginModal">Book Now</button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 mt-4 mt-lg-0 order-lg-1">
                        <div class="wonder-image-container">
                            <img src="https://images.unsplash.com/photo-1579606032821-4e6161c81bd3?ixlib=rb-4.0.3&auto=format&fit=crop&w=1600&q=80" alt="Petra" class="wonder-image">
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Chichen Itza -->
        <div class="wonder-section" style="background-color: #f8f9fa;">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6">
                        <div class="wonder-content">
                            <h2 class="mb-4">Chichen Itza</h2>
                            <p class="lead mb-4">A large pre-Columbian city built by the Maya people of the Terminal Classic period. The archaeological site is located in Tinúm Municipality, Yucatán State, Mexico. It's known for its stepped pyramids, temples, columned arcades, and other stone structures.</p>
                            <div class="stats-container">
                                <div class="row text-center">
                                    <div class="col-4">
                                        <h4 class="text-primary">2.6M+</h4>
                                        <small>Annual Visitors</small>
                                    </div>
                                    <div class="col-4">
                                        <h4 class="text-primary">600 AD</h4>
                                        <small>Year Founded</small>
                                    </div>
                                    <div class="col-4">
                                        <h4 class="text-primary">6.5</h4>
                                        <small>Square km</small>
                                    </div>
                                </div>
                            </div>
                            <div class="mt-4">
                                <a href="<%= request.getContextPath() %>/7chichen.jsp" class="btn btn-primary me-2">Learn More</a>
                                <% if (session.getAttribute("user") != null) { %>
                                    <a href="<%= request.getContextPath() %>/booking.jsp?wonderId=7" class="btn btn-success">Book Now</a>
                                <% } else { %>
                                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#loginModal">Book Now</button>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 mt-4 mt-lg-0">
                        <div class="wonder-image-container">
                           <img src="https://images.unsplash.com/photo-1518638150340-f706e86654de?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80" alt="Chichen Itza" class="hero-image">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="py-5 bg-light">
        <div class="container">
            <h2 class="text-center mb-4">About Wonderland Travels</h2>
            <p class="lead text-center">We specialize in creating unforgettable experiences at the world's most iconic landmarks.</p>
            <div class="row mt-4">
                <div class="col-md-4">
                    <div class="text-center">
                        <i class="fas fa-map-marked-alt fa-3x mb-3 text-primary"></i>
                        <h4>Expert Guides</h4>
                        <p>Our knowledgeable guides ensure you get the most out of your visit.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="text-center">
                        <i class="fas fa-hotel fa-3x mb-3 text-primary"></i>
                        <h4>Luxury Accommodations</h4>
                        <p>Stay in comfort with our carefully selected accommodations.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="text-center">
                        <i class="fas fa-users fa-3x mb-3 text-primary"></i>
                        <h4>Small Groups</h4>
                        <p>Enjoy a more personalized experience with our small group tours.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="py-5">
        <div class="container">
            <h2 class="text-center mb-4">Contact Us</h2>
            <div class="row">
                <div class="col-md-6 mb-4">
                    <h4>Get in Touch</h4>
                    <p><i class="fas fa-map-marker-alt me-2"></i>123 Travel Street, Wonderland City</p>
                    <p><i class="fas fa-phone me-2"></i>+1 (234) 567-8900</p>
                    <p><i class="fas fa-envelope me-2"></i>info@wonderlandtravels.com</p>
                    <div class="mt-4">
                        <a href="#" class="text-primary me-3"><i class="fab fa-facebook-f fa-2x"></i></a>
                        <a href="#" class="text-primary me-3"><i class="fab fa-twitter fa-2x"></i></a>
                        <a href="#" class="text-primary me-3"><i class="fab fa-instagram fa-2x"></i></a>
                    </div>
                </div>
                <div class="col-md-6">
                    <h4>Leave us a Message</h4>
                    <form action="<%= request.getContextPath() %>/SubmitFeedbackServlet" method="POST">
                        <div class="mb-3">
                            <input type="text" name="fname" class="form-control" placeholder="Your Name" required>
                        </div>
                        <div class="mb-3">
                            <input type="email" name="fmail" class="form-control" placeholder="Your Email" required>
                        </div>
                        <div class="mb-3">
                            <textarea name="fmsg" class="form-control" rows="4" placeholder="Your Message" required></textarea>
                        </div>
                        <div class="mb-3">
                            <select name="rating" class="form-select" required>
                                <option value="">Rate your experience</option>
                                <option value="5">5 - Excellent</option>
                                <option value="4">4 - Very Good</option>
                                <option value="3">3 - Good</option>
                                <option value="2">2 - Fair</option>
                                <option value="1">1 - Poor</option>
                            </select>
                        </div>
                        <button type="submit" class="btn btn-primary">Send Message</button>
                    </form>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="bg-dark text-white py-4">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h5>Wonderland Travels</h5>
                    <p>Exploring the world's wonders, one journey at a time.</p>
                </div>
                <div class="col-md-3">
                    <h5>Quick Links</h5>
                    <ul class="list-unstyled">
                        <li><a href="#home" class="text-white">Home</a></li>
                        <li><a href="#wonders" class="text-white">Wonders</a></li>
                        <li><a href="#about" class="text-white">About</a></li>
                        <li><a href="#contact" class="text-white">Contact</a></li>
                    </ul>
                </div>
                <div class="col-md-3">
                    <h5>Legal</h5>
                    <ul class="list-unstyled">
                        <li><a href="#" class="text-white">Terms of Service</a></li>
                        <li><a href="#" class="text-white">Privacy Policy</a></li>
                    </ul>
                </div>
            </div>
            <hr class="bg-light">
            <p class="text-center mb-0">&copy; 2025 Wonderland Travels. All rights reserved.</p>
            <p class="text-center mb-0">Developed and maintained by Suresh M</p>
        </div>
    </footer>


<!-- Login Modal -->
<div class="modal fade" id="loginModal" tabindex="-1">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content rounded-4 shadow">
            <div class="modal-header bg-primary text-white border-0">
                <h5 class="modal-title">Login to Your Account</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body p-4">

                <% String loginError = (String) request.getAttribute("error"); %>
                <% if (loginError != null) { %>
                    <div class="alert alert-danger"><%= loginError %></div>
                    <script>
                        // Auto-open modal when there's an error
                        window.onload = function () {
                            var myModal = new bootstrap.Modal(document.getElementById('loginModal'));
                            myModal.show();
                        }
                    </script>
                <% } %>

                <form action="<%= request.getContextPath() %>/loginServlet" method="POST">
                    <!-- Keep track of which page to return to -->
                    <input type="hidden" name="redirect" value="<%= request.getRequestURI() %>">

                    <div class="mb-3">
                        <label for="loginEmail" class="form-label">Email Address</label>
                        <input type="email" class="form-control" id="loginEmail" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="loginPassword" class="form-label">Password</label>
                        <input type="password" class="form-control" id="loginPassword" name="password" required>
                    </div>

                    <button type="submit" class="btn btn-primary w-100">Login</button>
                </form>

                <p class="text-center mt-3">
                    Don't have an account?
                    <a href="#" data-bs-dismiss="modal" data-bs-toggle="modal" data-bs-target="#registerModal">
                        Register here
                    </a>
                </p>
            </div>
        </div>
    </div>
</div>

    <!-- Admin Login Modal -->
    <div class="modal fade" id="adminLoginModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Admin Login</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form action="<%= request.getContextPath() %>/AdminLoginServlet" method="POST">
                        <div class="mb-3">
                            <label for="adminUsername" class="form-label">Username</label>
                            <input type="text" class="form-control" id="adminUsername" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="adminPassword" class="form-label">Password</label>
                            <input type="password" class="form-control" id="adminPassword" name="password" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Login</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Register Modal (fixed) -->
    <div class="modal fade" id="registerModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Create New Account</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form action="<%= request.getContextPath() %>/RegisterServlet" method="POST" onsubmit="return validatePasswords()">
                        <div class="mb-3">
                            <label for="registerName" class="form-label">Full Name</label>
                            <input type="text" class="form-control" id="registerName" name="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="registerEmail" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="registerEmail" name="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="registerPassword" class="form-label">Password</label>
                            <input type="password" class="form-control" id="registerPassword" name="password" required>
                        </div>
                        <div class="mb-3">
                            <label for="registerConfirmPassword" class="form-label">Confirm Password</label>
                            <input type="password" class="form-control" id="registerConfirmPassword" name="cpassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="registerPhone" class="form-label">Phone Number</label>
                            <input type="tel" class="form-control" id="registerPhone" name="phonenumber" required
                                   pattern="[0-9]{10}" minlength="10" maxlength="10" title="Please enter a valid 10-digit phone number">
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Register</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="script.js"></script>

    <script>
        function validatePasswords() {
            var password = document.getElementById("registerPassword").value;
            var confirmPassword = document.getElementById("registerConfirmPassword").value;
            if (password !== confirmPassword) {
                alert("Passwords do not match!");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
