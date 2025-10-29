<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<%@ page import="com.tap.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Machu Picchu - Wonderland Travels</title>
    <!-- Modern CSS Framework -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <!-- Custom Styles -->
    <style>
        :root {
            --primary-color: #2ecc71;
            --accent-color: #f39c12;
            --text-light: #ecf0f1;
            --text-dark: #34495e;
        }
        
        .hero-section {
            height: 100vh;
            position: relative;
            overflow: hidden;
        }

        .hero-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1;
        }

        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: var(--text-light);
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow-x: hidden;
        }

        .hero-section {
            height: 100vh;
            position: relative;
            overflow: hidden;
        }

        .hero-video {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            z-index: -1;
        }

        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            text-align: center;
            color: var(--text-light);
        }

        .navbar {
            background: transparent !important;
            transition: 0.3s;
            padding: 1rem 2rem;
        }

        .navbar.scrolled {
            background: var(--primary-color) !important;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .nav-link {
            color: var(--text-light) !important;
            font-weight: 500;
            margin: 0 1rem;
            position: relative;
        }

        .nav-link::after {
            content: '';
            position: absolute;
            bottom: -5px;
            left: 0;
            width: 0;
            height: 2px;
            background: var(--accent-color);
            transition: 0.3s;
        }

        .nav-link:hover::after {
            width: 100%;
        }

        .section-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 2rem;
            position: relative;
            padding-bottom: 1rem;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100px;
            height: 3px;
            background: var(--accent-color);
        }

        .feature-card {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            transition: 0.3s;
            margin-bottom: 2rem;
        }

        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }

        .gallery-img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: 15px;
            cursor: pointer;
            transition: 0.3s;
        }

        .gallery-img:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }

        .timeline {
            position: relative;
            padding: 2rem 0;
        }

        .timeline::before {
            content: '';
            position: absolute;
            top: 0;
            left: 50%;
            width: 2px;
            height: 100%;
            background: var(--accent-color);
            transform: translateX(-50%);
        }

        .timeline-item {
            margin-bottom: 3rem;
            position: relative;
        }

        .timeline-content {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }

        .booking-section {
            background: linear-gradient(135deg, #2ecc71, #27ae60);
            padding: 5rem 0;
            color: var(--text-light);
            text-align: center;
        }

        .btn-custom {
            background: var(--accent-color);
            color: var(--text-light);
            padding: 1rem 2rem;
            border-radius: 30px;
            border: none;
            font-weight: 600;
            transition: 0.3s;
        }

        .btn-custom:hover {
            background: #e67e22;
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }

        .testimonial-card {
            background: white;
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
            margin: 2rem 0;
        }

        .testimonial-img {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 1rem;
        }

        footer {
            background: var(--primary-color);
            color: var(--text-light);
            padding: 4rem 0 2rem;
        }

        .social-links a {
            color: var(--text-light);
            margin: 0 1rem;
            font-size: 1.5rem;
            transition: 0.3s;
        }

        .social-links a:hover {
            color: var(--accent-color);
            transform: translateY(-3px);
        }

        .modal-content {
            border-radius: 15px;
            overflow: hidden;
        }

        .modal-header {
            background: var(--primary-color);
            color: var(--text-light);
            border: none;
        }

        .modal-body {
            padding: 2rem;
        }

        .fade-up {
            opacity: 0;
            transform: translateY(20px);
            transition: 0.6s;
        }

        .fade-up.active {
            opacity: 1;
            transform: translateY(0);
        }
    </style>
</head>
<body>

<%
    User user = (User) session.getAttribute("user");
    boolean isLoggedIn = (user != null);
%>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container">
        <a class="navbar-brand" href="home.jsp">
            <i class="fas fa-globe-americas"></i>
            <span class="ms-2">Wonderland Travels</span>
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="#overview">Overview</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#gallery">Gallery</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#history">History</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#booking">Book Now</a>
                </li>
                <% if (isLoggedIn) { %>
                    <li class="nav-item">
                        <span class="nav-link">Welcome, <%= user.getName() %>!</span>
                    </li>
                    <li class="nav-item">
                        <a href="LogoutServlet" class="btn btn-custom">Logout</a>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <button class="btn btn-custom" data-bs-toggle="modal" data-bs-target="#loginModal">Login</button>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-section">
    <img src="https://images.unsplash.com/photo-1526392060635-9d6019884377?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80" alt="Machu Picchu" class="hero-image">
    <div class="hero-overlay">
        <div class="container">
            <h1 class="display-2 mb-4" data-aos="fade-up">Machu Picchu</h1>
            <p class="lead mb-4" data-aos="fade-up" data-aos-delay="200">
                Discover the mystical beauty of the Incan citadel
            </p>
            <a href="#booking" class="btn btn-custom btn-lg" data-aos="fade-up" data-aos-delay="400">
                Plan Your Expedition
            </a>
        </div>
    </div>
</section>

<!-- Overview Section -->
<section id="overview" class="py-5">
    <div class="container">
        <h2 class="section-title" data-aos="fade-up">Overview</h2>
        <div class="row">
            <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                <div class="feature-card">
                    <i class="fas fa-map-marked-alt fa-3x mb-4 text-primary"></i>
                    <h3 class="h4 mb-3">Location</h3>
                    <p>Situated high in the Andes Mountains of Peru, Machu Picchu is a testament to Incan engineering.</p>
                </div>
            </div>
            <div class="col-md-4" data-aos="fade-up" data-aos-delay="400">
                <div class="feature-card">
                    <i class="fas fa-clock fa-3x mb-4 text-primary"></i>
                    <h3 class="h4 mb-3">Best Time to Visit</h3>
                    <p>The dry season (May to October) offers the best weather for exploring this ancient wonder.</p>
                </div>
            </div>
            <div class="col-md-4" data-aos="fade-up" data-aos-delay="600">
                <div class="feature-card">
                    <i class="fas fa-hiking fa-3x mb-4 text-primary"></i>
                    <h3 class="h4 mb-3">Activities</h3>
                    <p>Hiking the Inca Trail, guided tours, and sunrise viewings are popular experiences at Machu Picchu.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Gallery Section -->
<section id="gallery" class="py-5 bg-light">
    <div class="container">
        <h2 class="section-title" data-aos="fade-up">Gallery</h2>
        <div class="row">
            <div class="col-md-4 mb-4" data-aos="fade-up" data-aos-delay="200">
                <img src="https://images.unsplash.com/photo-1526392060635-9d6019884377?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80" 
                     class="gallery-img" alt="Machu Picchu overview"
                     data-bs-toggle="modal" data-bs-target="#imageModal1">
            </div>
            <div class="col-md-4 mb-4" data-aos="fade-up" data-aos-delay="400">
                <img src="https://images.unsplash.com/photo-1587595431973-160d0d94add1?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80" 
                     class="gallery-img" alt="Machu Picchu terraces"
                     data-bs-toggle="modal" data-bs-target="#imageModal2">
            </div>
            <div class="col-md-4 mb-4" data-aos="fade-up" data-aos-delay="600">
                <img src="https://images.unsplash.com/photo-1569383746724-6f1b882b8f46?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80" 
                     class="gallery-img" alt="Machu Picchu sunrise"
                     data-bs-toggle="modal" data-bs-target="#imageModal3">
            </div>
        </div>
    </div>
</section>

<!-- History Timeline Section -->
<section id="history" class="py-5">
    <div class="container">
        <h2 class="section-title" data-aos="fade-up">History Timeline</h2>
        <div class="timeline">
            <div class="timeline-item" data-aos="fade-right">
                <div class="timeline-content">
                    <h3>1450 AD</h3>
                    <p>Construction of Machu Picchu begins under Inca emperor Pachacuti</p>
                </div>
            </div>
            <div class="timeline-item" data-aos="fade-left">
                <div class="timeline-content">
                    <h3>1572 AD</h3>
                    <p>Machu Picchu is abandoned as the Spanish conquest reaches the region</p>
                </div>
            </div>
            <div class="timeline-item" data-aos="fade-right">
                <div class="timeline-content">
                    <h3>1911 AD</h3>
                    <p>Hiram Bingham rediscovers Machu Picchu, bringing it to global attention</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Google Maps Section -->
<section class="py-5 bg-light">
    <div class="container">
        <h2 class="section-title" data-aos="fade-up">Location</h2>
        <div class="row">
            <div class="col-md-12" data-aos="fade-up" data-aos-delay="200">
                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3886.802501815134!2d-72.54726868517994!3d-13.163068490731698!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x916d9a5f89555555%3A0x3a10370ea4a01a27!2sMachu%20Picchu!5e0!3m2!1sen!2sus!4v1625231234567!5m2!1sen!2sus" 
                        width="100%" height="450" style="border:0;" allowfullscreen="" loading="lazy"></iframe>
            </div>
        </div>
    </div>
</section>

<!-- Booking Section -->
<section id="booking" class="booking-section">
    <div class="container">
        <h2 class="section-title text-center text-white" data-aos="fade-up">Book Your Visit</h2>
        <p class="lead mb-5" data-aos="fade-up" data-aos-delay="200">
            Experience the wonder of Machu Picchu with our expert guides
        </p>
        <% if (isLoggedIn) { %>
            <a href="booking.jsp?wonderId=4" class="btn btn-custom btn-lg" data-aos="fade-up" data-aos-delay="400">
                Book Your Tour Now
            </a>
        <% } else { %>
            <button class="btn btn-custom btn-lg" data-aos="fade-up" data-aos-delay="400"
                    data-bs-toggle="modal" data-bs-target="#loginModal">
                Login to Book
            </button>
        <% } %>
    </div>
</section>

<!-- Testimonials Section -->
<section class="py-5">
    <div class="container">
        <h2 class="section-title" data-aos="fade-up">Visitor Experiences</h2>
        <div class="row">
            <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                <div class="testimonial-card">
                    <img src="https://randomuser.me/api/portraits/women/5.jpg" alt="Maria" class="testimonial-img">
                    <h4>Maria Sanchez</h4>
                    <p class="text-muted">★★★★★</p>
                    <p>"The sunrise at Machu Picchu was absolutely breathtaking. A life-changing experience!"</p>
                </div>
            </div>
            <div class="col-md-4" data-aos="fade-up" data-aos-delay="400">
                <div class="testimonial-card">
                    <img src="https://randomuser.me/api/portraits/men/3.jpg" alt="John" class="testimonial-img">
                    <h4>John Doe</h4>
                    <p class="text-muted">★★★★★</p>
                    <p>"The Inca Trail hike was challenging but so rewarding. The views were unbelievable."</p>
                </div>
            </div>
            <div class="col-md-4" data-aos="fade-up" data-aos-delay="600">
                <div class="testimonial-card">
                    <img src="https://randomuser.me/api/portraits/women/6.jpg" alt="Akiko" class="testimonial-img">
                    <h4>Akiko Yamamoto</h4>
                    <p class="text-muted">★★★★★</p>
                    <p>"Our guide's knowledge of Incan history made the tour incredibly fascinating."</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer>
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-4">
                <h4>Wonderland Travels</h4>
                <p>Exploring the world's wonders, one journey at a time.</p>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <h4>Quick Links</h4>
                <ul class="list-unstyled">
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="#overview">Overview</a></li>
                    <li><a href="#gallery">Gallery</a></li>
                    <li><a href="#booking">Book Now</a></li>
                </ul>
            </div>
            <div class="col-md-4 mb-4">
                <h4>Contact Us</h4>
                <ul class="list-unstyled">
                    <li><i class="fas fa-phone me-2"></i> +1 234 567 890</li>
                    <li><i class="fas fa-envelope me-2"></i> info@wonderland.com</li>
                    <li><i class="fas fa-map-marker-alt me-2"></i> Cusco, Peru</li>
                </ul>
            </div>
        </div>
        <hr class="mt-4 mb-4">
        <p class="text-center mb-0">&copy; 2025 Wonderland Travels. All rights reserved.</p>
    </div>
</footer>

<!-- Image Modals -->
<div class="modal fade" id="imageModal1" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body p-0">
                <img src="https://images.unsplash.com/photo-1526392060635-9d6019884377?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80" 
                     class="img-fluid" alt="Machu Picchu overview">
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="imageModal2" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body p-0">
                <img src="https://images.unsplash.com/photo-1587595431973-160d0d94add1?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80" 
                     class="img-fluid" alt="Machu Picchu terraces">
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="imageModal3" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body p-0">
                <img src="https://images.unsplash.com/photo-1569383746724-6f1b882b8f46?ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80" 
                     class="img-fluid" alt="Machu Picchu sunrise">
            </div>
        </div>
    </div>
</div>



 <!-- Login Modal -->
    <div class="modal fade" id="loginModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Login to Your Account</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form action="loginServlet">
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
	 
<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
<script>
    // Initialize AOS
    AOS.init({
        duration: 1000,
        once: true
    });

    // Navbar scroll effect
    window.addEventListener('scroll', function() {
        if (window.scrollY > 50) {
            document.querySelector('.navbar').classList.add('scrolled');
        } else {
            document.querySelector('.navbar').classList.remove('scrolled');
        }
    });

    // Smooth scroll for navigation links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });
</script>

</body>
</html>