<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.tap.model.Booking" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Bookings - Wonderland Travels</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .booking-card {
            transition: transform 0.3s, box-shadow 0.3s;
            border: none;
            border-radius: 15px;
            overflow: hidden;
        }
        .booking-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        .card-header {
            background: linear-gradient(45deg, #007bff, #00bcd4);
            color: white;
            font-weight: bold;
            border-bottom: none;
        }
        .badge-custom {
            background-color: #17a2b8;
            color: white;
            font-size: 0.9em;
            padding: 0.5em 0.7em;
        }
        .icon-container {
            display: flex;
            justify-content: center;
            align-items: center;
            width: 50px;
            height: 50px;
            background-color: #f8f9fa;
            border-radius: 50%;
            margin-bottom: 15px;
        }
        .icon-container i {
            font-size: 1.5em;
            color: #007bff;
        }
    </style>
</head>
<body>
    <%! String appName = "Wonderland Travels"; %>
    
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="home.jsp">
                <i class="fas fa-globe-americas mr-2"></i>
                <%= appName %>
            </a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a class="nav-link" href="home.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link active" href="#">All Bookings</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <h2 class="text-center mb-4">All Bookings</h2>
        <div class="row">
            <% 
                java.util.List<Booking> allBookings = (java.util.List<Booking>) request.getAttribute("allBookings");
                if (allBookings == null || allBookings.isEmpty()) { 
            %>
                <p class="text-center text-danger">No bookings available.</p>
            <% 
                } else { 
                    for (Booking booking : allBookings) { 
            %>
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card booking-card">
                            <div class="card-header text-center">
                                Booking #<%= booking.getBookingId() %>
                            </div>
                            <div class="card-body">
                                <div class="icon-container mx-auto">
                                    <i class="fas fa-suitcase-rolling"></i>
                                </div>
                                <h5 class="card-title text-center">Wonder ID: <%= booking.getWonderId() %></h5>
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item"><i class="far fa-calendar-alt mr-2"></i> Date: <%= booking.getBookingDate() %></li>
                                    <li class="list-group-item"><i class="far fa-clock mr-2"></i> Time: <%= booking.getTimeSlot() %></li>
                                    <li class="list-group-item"><i class="fas fa-language mr-2"></i> Language: <%= booking.getLanguage() %></li>
                                    <li class="list-group-item"><i class="fas fa-users mr-2"></i> Guests: <%= booking.getGuests() %></li>
                                    <li class="list-group-item"><i class="fas fa-dollar-sign mr-2"></i> Total: $<%= booking.getTotalAmount() %></li>
                                </ul>
                            </div>
                            <div class="card-footer text-center">
                                <span class="badge badge-custom"><%= booking.getStatus() %></span>
                            </div>
                        </div>
                    </div>
            <% 
                    } 
                } 
            %>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>