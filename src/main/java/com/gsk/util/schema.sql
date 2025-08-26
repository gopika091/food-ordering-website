-- Food Delivery System Database Schema
-- Database: food_delivery_system

-- Create database
CREATE DATABASE IF NOT EXISTS food_delivery_system;
USE food_delivery_system;

-- Users table
CREATE TABLE users (
    userId INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    fullName VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    userType ENUM('customer', 'admin', 'restaurant_owner') DEFAULT 'customer',
    isActive BOOLEAN DEFAULT TRUE,
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Restaurants table
CREATE TABLE restaurants (
    restaurantId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    address VARCHAR(500) NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    rating DECIMAL(3,2) DEFAULT 0.00,
    cuisineType VARCHAR(100) NOT NULL,
    isActive BOOLEAN DEFAULT TRUE,
    deliveryTime VARCHAR(50) DEFAULT '30-40 mins',
    adminUserId INT DEFAULT 1,
    imagePath VARCHAR(500) DEFAULT '/images/default-restaurant.jpg',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (adminUserId) REFERENCES users(userId) ON DELETE SET NULL
);

-- Menu table
CREATE TABLE menu (
    menuId INT PRIMARY KEY AUTO_INCREMENT,
    restaurantId INT NOT NULL,
    itemName VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(100) NOT NULL,
    isAvailable BOOLEAN DEFAULT TRUE,
    imagePath VARCHAR(500) DEFAULT '/images/default-menu.jpg',
    createdAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (restaurantId) REFERENCES restaurants(restaurantId) ON DELETE CASCADE
);

-- Orders table
CREATE TABLE orders (
    orderId INT PRIMARY KEY AUTO_INCREMENT,
    userId INT NOT NULL,
    restaurantId INT NOT NULL,
    totalAmount DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'confirmed', 'preparing', 'out_for_delivery', 'delivered', 'cancelled') DEFAULT 'pending',
    deliveryAddress TEXT NOT NULL,
    deliveryInstructions TEXT,
    orderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deliveryDate TIMESTAMP NULL,
    FOREIGN KEY (userId) REFERENCES users(userId) ON DELETE CASCADE,
    FOREIGN KEY (restaurantId) REFERENCES restaurants(restaurantId) ON DELETE CASCADE
);

-- Order items table
CREATE TABLE order_items (
    orderItemId INT PRIMARY KEY AUTO_INCREMENT,
    orderId INT NOT NULL,
    menuId INT NOT NULL,
    quantity INT NOT NULL,
    unitPrice DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    specialInstructions TEXT,
    FOREIGN KEY (orderId) REFERENCES orders(orderId) ON DELETE CASCADE,
    FOREIGN KEY (menuId) REFERENCES menu(menuId) ON DELETE CASCADE
);

-- Cart table
CREATE TABLE cart (
    cartId INT PRIMARY KEY AUTO_INCREMENT,
    userId INT NOT NULL,
    restaurantId INT NOT NULL,
    menuId INT NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    addedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (userId) REFERENCES users(userId) ON DELETE CASCADE,
    FOREIGN KEY (restaurantId) REFERENCES restaurants(restaurantId) ON DELETE CASCADE,
    FOREIGN KEY (menuId) REFERENCES menu(menuId) ON DELETE CASCADE,
    UNIQUE KEY unique_cart_item (userId, restaurantId, menuId)
);

-- Insert sample admin user
INSERT INTO users (username, email, password, fullName, userType) VALUES 
('admin', 'admin@fooddelivery.com', 'admin123', 'System Administrator', 'admin');

-- Insert sample restaurants
INSERT INTO restaurants (name, description, address, phone, email, rating, cuisineType, deliveryTime, adminUserId) VALUES 
('Spice Garden', 'Authentic North Indian cuisine with rich flavors and traditional recipes', 'Brigade Road, Bengaluru', '+91-9876543210', 'spicegarden@email.com', 4.5, 'North Indian', '30-40 mins', 1),
('Dosa Corner', 'South Indian specialties with crispy dosas and authentic chutneys', 'Indiranagar, Bengaluru', '+91-9876543211', 'dosacorner@email.com', 4.3, 'South Indian', '25-35 mins', 1),
('Pizza Palace', 'Italian pizzas with fresh ingredients and wood-fired ovens', 'Koramangala, Bengaluru', '+91-9876543212', 'pizzapalace@email.com', 4.4, 'Italian', '35-45 mins', 1),
('Chinese Wok', 'Authentic Chinese cuisine with spicy and flavorful dishes', 'HSR Layout, Bengaluru', '+91-9876543213', 'chinesewok@email.com', 4.2, 'Chinese', '40-50 mins', 1),
('Burger House', 'Juicy burgers with fresh buns and premium ingredients', 'Whitefield, Bengaluru', '+91-9876543214', 'burgerhouse@email.com', 4.1, 'American', '20-30 mins', 1),
('Kebab Junction', 'Mouth-watering kebabs and grilled delicacies', 'Electronic City, Bengaluru', '+91-9876543215', 'kebabjunction@email.com', 4.6, 'Mughlai', '45-55 mins', 1),
('Sushi Bar', 'Fresh sushi and Japanese delicacies', 'Marathahalli, Bengaluru', '+91-9876543216', 'sushibar@email.com', 4.4, 'Japanese', '50-60 mins', 1),
('Mexican Fiesta', 'Spicy Mexican dishes with authentic flavors', 'Bellandur, Bengaluru', '+91-9876543217', 'mexicanfiesta@email.com', 4.3, 'Mexican', '40-50 mins', 1),
('Thai Spice', 'Aromatic Thai cuisine with perfect balance of flavors', 'Sarjapur, Bengaluru', '+91-9876543218', 'thaispice@email.com', 4.5, 'Thai', '45-55 mins', 1),
('Kerala Kitchen', 'Traditional Kerala dishes with coconut and spices', 'Yelahanka, Bengaluru', '+91-9876543219', 'keralakitchen@email.com', 4.2, 'Kerala', '35-45 mins', 1);

-- Insert sample menu items for Spice Garden (restaurantId = 1)
INSERT INTO menu (restaurantId, itemName, description, price, category, imagePath) VALUES 
(1, 'Paneer Tikka', 'Grilled cottage cheese with aromatic spices', 180.00, 'Starters', '/images/paneer-tikka.jpg'),
(1, 'Butter Chicken', 'Rich tomato-based curry with tender chicken', 280.00, 'Main Course', '/images/butter-chicken.jpg'),
(1, 'Dal Makhani', 'Slow-cooked black lentils in creamy gravy', 160.00, 'Main Course', '/images/dal-makhani.jpg'),
(1, 'Jeera Rice', 'Fragrant rice cooked with cumin seeds', 120.00, 'Rice & Breads', '/images/jeera-rice.jpg'),
(1, 'Gulab Jamun', 'Sweet milk dumplings in sugar syrup', 80.00, 'Desserts', '/images/gulab-jamun.jpg');

-- Insert sample menu items for Dosa Corner (restaurantId = 2)
INSERT INTO menu (restaurantId, itemName, description, price, category, imagePath) VALUES 
(2, 'Masala Dosa', 'Crispy dosa with spiced potato filling', 120.00, 'Dosas', '/images/masala-dosa.jpg'),
(2, 'Idli Sambar', 'Soft idlis with hot sambar and chutney', 80.00, 'Breakfast', '/images/idli-sambar.jpg'),
(2, 'Vada', 'Crispy lentil fritters with coconut chutney', 60.00, 'Snacks', '/images/vada.jpg'),
(2, 'Filter Coffee', 'Traditional South Indian filter coffee', 40.00, 'Beverages', '/images/filter-coffee.jpg');

-- Insert sample menu items for Pizza Palace (restaurantId = 3)
INSERT INTO menu (restaurantId, itemName, description, price, category, imagePath) VALUES 
(3, 'Margherita Pizza', 'Classic pizza with tomato and mozzarella', 350.00, 'Pizzas', '/images/margherita-pizza.jpg'),
(3, 'Pepperoni Pizza', 'Spicy pepperoni with melted cheese', 450.00, 'Pizzas', '/images/pepperoni-pizza.jpg'),
(3, 'Garlic Bread', 'Crispy bread with garlic butter', 120.00, 'Sides', '/images/garlic-bread.jpg'),
(3, 'Tiramisu', 'Classic Italian dessert with coffee flavor', 180.00, 'Desserts', '/images/tiramisu.jpg');

-- Insert sample menu items for Chinese Wok (restaurantId = 4)
INSERT INTO menu (restaurantId, itemName, description, price, category, imagePath) VALUES 
(4, 'Chicken Fried Rice', 'Stir-fried rice with chicken and vegetables', 200.00, 'Rice & Noodles', '/images/chicken-fried-rice.jpg'),
(4, 'Chilli Chicken', 'Spicy chicken with green chillies', 280.00, 'Main Course', '/images/chilli-chicken.jpg'),
(4, 'Veg Spring Roll', 'Crispy rolls with vegetable filling', 120.00, 'Starters', '/images/veg-spring-roll.jpg'),
(4, 'Hot & Sour Soup', 'Spicy and tangy soup with vegetables', 100.00, 'Soups', '/images/hot-sour-soup.jpg');

-- Insert sample menu items for Burger House (restaurantId = 5)
INSERT INTO menu (restaurantId, itemName, description, price, category, imagePath) VALUES 
(5, 'Classic Burger', 'Juicy beef patty with fresh vegetables', 250.00, 'Burgers', '/images/classic-burger.jpg'),
(5, 'Chicken Burger', 'Grilled chicken with special sauce', 220.00, 'Burgers', '/images/chicken-burger.jpg'),
(5, 'French Fries', 'Crispy golden fries with seasoning', 100.00, 'Sides', '/images/french-fries.jpg'),
(5, 'Chocolate Shake', 'Rich chocolate milkshake', 120.00, 'Beverages', '/images/chocolate-shake.jpg');

-- Insert sample menu items for Kebab Junction (restaurantId = 6)
INSERT INTO menu (restaurantId, itemName, description, price, category, imagePath) VALUES 
(6, 'Chicken Kebab', 'Grilled chicken kebab with spices', 300.00, 'Kebabs', '/images/chicken-kebab.jpg'),
(6, 'Seekh Kebab', 'Minced meat kebab with herbs', 280.00, 'Kebabs', '/images/seekh-kebab.jpg'),
(6, 'Roti', 'Soft whole wheat bread', 30.00, 'Breads', '/images/roti.jpg'),
(6, 'Mint Chutney', 'Fresh mint and coriander chutney', 40.00, 'Sauces', '/images/mint-chutney.jpg');

-- Insert sample menu items for Sushi Bar (restaurantId = 7)
INSERT INTO menu (restaurantId, itemName, description, price, category, imagePath) VALUES 
(7, 'California Roll', 'Avocado, cucumber and crab stick roll', 400.00, 'Sushi Rolls', '/images/california-roll.jpg'),
(7, 'Salmon Nigiri', 'Fresh salmon over seasoned rice', 180.00, 'Nigiri', '/images/salmon-nigiri.jpg'),
(7, 'Miso Soup', 'Traditional Japanese soup with tofu', 120.00, 'Soups', '/images/miso-soup.jpg'),
(7, 'Green Tea', 'Authentic Japanese green tea', 60.00, 'Beverages', '/images/green-tea.jpg');

-- Insert sample menu items for Mexican Fiesta (restaurantId = 8)
INSERT INTO menu (restaurantId, itemName, description, price, category, imagePath) VALUES 
(8, 'Tacos', 'Soft corn tortillas with spicy filling', 180.00, 'Tacos', '/images/tacos.jpg'),
(8, 'Quesadilla', 'Cheese and chicken filled tortilla', 220.00, 'Main Course', '/images/quesadilla.jpg'),
(8, 'Guacamole', 'Fresh avocado dip with chips', 120.00, 'Starters', '/images/guacamole.jpg'),
(8, 'Churros', 'Sweet fried dough with cinnamon sugar', 100.00, 'Desserts', '/images/churros.jpg');

-- Insert sample menu items for Thai Spice (restaurantId = 9)
INSERT INTO menu (restaurantId, itemName, description, price, category, imagePath) VALUES 
(9, 'Pad Thai', 'Stir-fried rice noodles with vegetables', 280.00, 'Noodles', '/images/pad-thai.jpg'),
(9, 'Green Curry', 'Spicy green curry with coconut milk', 320.00, 'Curries', '/images/green-curry.jpg'),
(9, 'Tom Yum Soup', 'Hot and sour soup with shrimp', 180.00, 'Soups', '/images/tom-yum-soup.jpg'),
(9, 'Mango Sticky Rice', 'Sweet sticky rice with fresh mango', 140.00, 'Desserts', '/images/mango-sticky-rice.jpg');

-- Insert sample menu items for Kerala Kitchen (restaurantId = 10)
INSERT INTO menu (restaurantId, itemName, description, price, category, imagePath) VALUES 
(10, 'Kerala Fish Curry', 'Traditional fish curry with coconut', 350.00, 'Main Course', '/images/kerala-fish-curry.jpg'),
(10, 'Appam', 'Soft rice pancakes with coconut milk', 80.00, 'Breakfast', '/images/appam.jpg'),
(10, 'Malabar Parotta', 'Layered flatbread with curry', 60.00, 'Breads', '/images/malabar-parotta.jpg'),
(10, 'Payasam', 'Sweet rice pudding with nuts', 100.00, 'Desserts', '/images/payasam.jpg');

-- Create indexes for better performance
CREATE INDEX idx_restaurants_cuisine ON restaurants(cuisineType);
CREATE INDEX idx_restaurants_rating ON restaurants(rating);
CREATE INDEX idx_menu_restaurant ON menu(restaurantId);
CREATE INDEX idx_menu_category ON menu(category);
CREATE INDEX idx_orders_user ON orders(userId);
CREATE INDEX idx_orders_restaurant ON orders(restaurantId);
CREATE INDEX idx_cart_user ON cart(userId);
CREATE INDEX idx_cart_restaurant ON cart(restaurantId);
