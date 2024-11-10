<%@ page import="java.sql.*, java.util.*, javax.servlet.http.*, javax.servlet.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Menu</title>
    <link rel="stylesheet" href="styles.css">
    <!-- Add Font Awesome for cart icon -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>
<body>
    
    <!-- Header Section -->
    <header>
        <div class="container">
            <div class="logo">
                <img src="https://b.zmtcdn.com/web_assets/8313a97515fcb0447d2d77c276532a511583262271.png" alt="Logo">
                <h1>Discover the best food in your city</h1>
            </div>
            <div class="search">
                <form action="menu.jsp" method="GET">
                    <input type="text" name="search" placeholder="Search cuisine or food" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                    <button type="submit"><i class="fas fa-search"></i></button>
                </form>
            </div>
            <!-- Cart icon button in the upper right corner -->
            <div class="cart-button">
                <a href="cart.jsp">
                    <i class="fas fa-shopping-cart"></i> Cart
                </a>
            </div>
        </div>
    </header>

    <!-- Menu Items Section -->
    <section class="menu-items">
        <h2>Menu</h2>

        <!-- Dynamically display menu items -->
        <div class="menu-grid">
            <% 
                String searchQuery = request.getParameter("search");
                String query = "SELECT * FROM MenuItem WHERE availability = '1'"; // Default query
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    query = "SELECT * FROM MenuItem WHERE (name LIKE ? OR genre LIKE ?) AND availability = '1'";
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
                    
                    PreparedStatement stmt = conn.prepareStatement(query);
                    if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                        stmt.setString(1, "%" + searchQuery + "%");
                        stmt.setString(2, "%" + searchQuery + "%");
                    }
                    ResultSet rs = stmt.executeQuery();
                    
                    while (rs.next()) {
                        String itemId = rs.getString("menu_item_id");
                        String name = rs.getString("name");
                        String genre = rs.getString("genre");
                        String desc = rs.getString("description");
                        double price = rs.getDouble("price");
                        String portion = rs.getString("portion_size");
            %>
                <div class="menu-card">
                    <img src="images/<%= itemId %>.jpg" alt="<%= name %>">
                    <h3><%= name %></h3>
                    <p><strong>Genre:</strong> <%= genre %></p>
                    <p><%= desc %></p>
                    <p><strong>Price:</strong> $<%= price %></p>
                    <p><strong>Size:</strong> <%= portion %></p>
                    <form action="addtocart.jsp" method="get">
                        <input type="hidden" name="menu_item_id" value="<%= itemId %>">
                        <input type="hidden" name="item_name" value="<%= name %>">
                        <input type="hidden" name="item_price" value="<%= price %>">
                        <input type="hidden" name="add_to_cart" value="true">
                        <button type="submit">Add to Cart</button>
                    </form>
                </div>
            <% 
                    }
            
                } catch (Exception e) {
                    out.println("Connection failure. Error: " + e.getMessage()); // Prints the error if connection fails
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
