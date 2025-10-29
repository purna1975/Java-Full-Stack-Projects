<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.tap.test.Cart" %>
<%@ page import="com.tap.test.CartItem" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart - FoodHub</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <style>
        :root {
            --primary-color: #fc8019;
            --secondary-color: #e67312;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        .cart-container {
            margin: 30px auto;
            max-width: 800px;
            background-color: #ffffff;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        .cart-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #eee;
            padding: 20px 0;
            transition: all 0.3s ease;
        }
        .cart-item:hover {
            background-color: #f8f9fa;
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .item-details h3 {
            margin: 0;
            color: var(--primary-color);
        }
        .cart-summary {
            margin-top: 30px;
            text-align: right;
            padding-top: 20px;
            border-top: 2px solid #eee;
        }
        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }
        .btn-primary:hover {
            background-color: var(--secondary-color);
            border-color: var(--secondary-color);
        }
        .quantity-control {
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 10px;
        }
        .quantity-btn {
            background-color: #e9ecef;
            border: none;
            color: #495057;
            font-size: 1.2rem;
            padding: 5px 10px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .quantity-btn:hover {
            background-color: #ced4da;
        }
        .quantity-input {
            width: 50px;
            text-align: center;
            font-size: 1rem;
            border: 1px solid #ced4da;
            border-radius: 4px;
            padding: 5px;
            margin: 0 10px;
        }
        .empty-cart {
            text-align: center;
            padding: 50px 0;
        }
        .empty-cart i {
            font-size: 5rem;
            color: #dee2e6;
            margin-bottom: 20px;
        }
        .total-amount {
            font-size: 1.5rem;
            font-weight: bold;
            color: var(--primary-color);
        }
    </style>
</head>
<body>
    <div class="container cart-container">
        <h1 class="text-center mb-4">Your Cart</h1>
        <%
            Cart cart = (Cart) session.getAttribute("cart");

            if (cart == null || cart.getItems().isEmpty()) {
        %>
        <div class="empty-cart">
            <i class="bi bi-cart-x"></i>
            <h2>Your cart is empty</h2>
            <p>Looks like you haven't added anything to your cart yet.</p>
            <a href="menu?restaurantId=<%= session.getAttribute("restaurantId") %>" class="btn btn-primary mt-3">Browse Menu</a>
        </div>
        <%
            } else {
                double totalAmount = 0;
                int restaurantId = 0;
                if (!cart.getItems().isEmpty()) {
                    restaurantId = cart.getItems().values().iterator().next().getRestaurantId();
                }
        %>
        <div class="cart-items">
            <%
                for (Map.Entry<Integer, CartItem> entry : cart.getItems().entrySet()) {
                    CartItem item = entry.getValue();
                    totalAmount += item.getPrice() * item.getQuantity();
            %>
            <div class="cart-item">
                <div class="item-details">
                    <h3><%= item.getName() %></h3>
                    <p class="text-muted">Price: ₹<%= String.format("%.2f", item.getPrice()) %></p>
                    <p class="fw-bold">Total: ₹<%= String.format("%.2f", item.getTotalPrice()) %></p>
                </div>
                <div class="item-actions">
                    <form action="cart" method="post" class="quantity-control">
                        <input type="hidden" name="action" value="update">
                        <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                        <button type="button" class="quantity-btn minus-btn" data-item-id="<%= item.getItemId() %>">-</button>
                        <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" max="10" class="quantity-input" data-item-id="<%= item.getItemId() %>">
                        <button type="button" class="quantity-btn plus-btn" data-item-id="<%= item.getItemId() %>">+</button>
                    </form>
                    <form action="cart" method="post">
                        <input type="hidden" name="action" value="remove">
                        <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                        <button type="submit" class="btn btn-outline-danger btn-sm">
                            <i class="bi bi-trash"></i> Remove
                        </button>
                    </form>
                </div>
            </div>
            <% } %>
        </div>
        <div class="cart-summary">
            <h3 class="total-amount mb-4">Total Amount: ₹<%= String.format("%.2f", totalAmount) %></h3>
            <a href="menu?restaurantId=<%= restaurantId %>" class="btn btn-outline-primary">
                <i class="bi bi-plus-circle"></i> Add More Items
            </a>
            <a href="checkout.jsp" class="btn btn-primary">
                <i class="bi bi-credit-card"></i> Proceed to Checkout
            </a>
        </div>
        <%
            }
        %>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const quantityForms = document.querySelectorAll('.quantity-control');
            
            quantityForms.forEach(form => {
                const minusBtn = form.querySelector('.minus-btn');
                const plusBtn = form.querySelector('.plus-btn');
                const input = form.querySelector('.quantity-input');
                const itemId = input.dataset.itemId;

                minusBtn.addEventListener('click', () => updateQuantity(itemId, -1));
                plusBtn.addEventListener('click', () => updateQuantity(itemId, 1));
                input.addEventListener('change', () => updateQuantity(itemId, 0));

                function updateQuantity(itemId, change) {
                    let newValue = parseInt(input.value) + change;
                    newValue = Math.max(1, Math.min(newValue, 10));
                    input.value = newValue;

                    // Submit the form
                    form.submit();
                }
            });
        });
    </script>
</body>
</html>
