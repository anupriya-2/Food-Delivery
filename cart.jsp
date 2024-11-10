<%@ page import="java.sql.*, java.util.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <link rel="stylesheet" href="styles.css">
    <!-- Add Font Awesome for cart icon -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>
<body>

    <!-- Header Section -->
    <header>
        <div class="container">
            <h1>Your Cart</h1>
        </div>
    </header>

    <!-- Cart Items Section -->
    <section class="cart-items">
        <div class="cart-grid">
            <% 
                //HttpSession session = request.getSession();
                String custId = "1"; //(String) session.getAttribute("cust_id"); // Customer ID from session

                if (custId == null) {
                    out.println("<p>Please log in to view your cart.</p>");
                    return;
                }

                try {
                    String host = "food-db-ghoshsupratim7-b879.k.aivencloud.com";
                    String port = "23858";
                    String databaseName = "defaultdb";
                    String userName = "avnadmin";
                    String password = "AVNS_iboxmMGlaTPggv0OOAy";
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String dbUrl = "jdbc:mysql://" + host + ":" + port + "/" + databaseName + "?sslmode=require";
                    Connection conn = DriverManager.getConnection(dbUrl, userName, password);

                    // Query to fetch cart items and their details
                    String query = "SELECT c.cart_item_id, c.qty, m.name, m.price, m.menu_item_id " +
                                   "FROM CartItem c " +
                                   "JOIN MenuItem m ON c.menu_item_id = m.menu_item_id " +
                                   "WHERE c.cust_id = ?";
                    
                    PreparedStatement stmt = conn.prepareStatement(query);
                    stmt.setString(1, custId);
                    ResultSet rs = stmt.executeQuery();

                    double totalPrice = 0.0;
                    boolean hasItems = false;
                    
                    while (rs.next()) {
                        hasItems = true;
                        String cartItemId = rs.getString("cart_item_id");
                        String itemName = rs.getString("name");
                        double itemPrice = rs.getDouble("price");
                        int quantity = rs.getInt("qty");
                        String menuItemId = rs.getString("menu_item_id");

                        double itemTotal = itemPrice * quantity;
                        totalPrice += itemTotal;
            %>
                <div class="cart-item">
                    <h3><%= itemName %></h3>
                    <p><strong>Price:</strong> $<%= itemPrice %></p>
                    <p><strong>Quantity:</strong> 
                        <form action="updateCart.jsp" method="POST" style="display: inline;">
                            <input type="hidden" name="cart_item_id" value="<%= cartItemId %>">
                            <input type="number" name="quantity" value="<%= quantity %>" min="1" style="width: 50px;">
                            <button type="submit">Update</button>
                        </form>
                    </p>
                    <p><strong>Total:</strong> $<%= itemTotal %></p>
                    <form action="removeFromCart.jsp" method="POST" style="display: inline;">
                        <input type="hidden" name="cart_item_id" value="<%= cartItemId %>">
                        <button type="submit" class="remove-button">Remove</button>
                    </form>
                </div>
            <% 
                    }

                    if (!hasItems) {
                        out.println("<p>Your cart is empty.</p>");
                    } else {
            %>
                <div class="cart-summary">
                    <h3>Total Price: $<%= totalPrice %></h3>
                    <form action="checkout.jsp" method="POST">
                        <button type="submit" class="checkout-button">Proceed to Checkout</button>
                    </form>
                </div>
            <% 
                    }
                } catch (Exception e) {
                    out.println("<p>Unable to load cart items. Error: " + e.getMessage() + "</p>");
                }
            %>
        </div>
    </section>

    <!-- Footer Section -->
    <footer>
        <p>© 2024 Food Delivery Website</p>
    </footer>

    <script src="script.js"></script>
</body>
</html>
