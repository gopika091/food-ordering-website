CREATE DATABASE IF NOT EXISTS food_ordering_db 
    CHARACTER SET utf8mb4 
    COLLATE utf8mb4_unicode_ci;

USE food_ordering_db;

-- Enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- ═══════════════════════════════════════════════════════════════
-- 👤 USER TABLE - Enhanced with additional fields
-- ═══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS user (
    userId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL, -- Consider hashing in production
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    role ENUM('CUSTOMER', 'ADMIN', 'RESTAURANT_OWNER', 'DELIVERY_PARTNER') DEFAULT 'CUSTOMER',
    profileImage VARCHAR(255) DEFAULT '/images/default-profile.jpg',
    isActive BOOLEAN DEFAULT TRUE,
    isEmailVerified BOOLEAN DEFAULT FALSE,
    createdDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    lastLoginDate TIMESTAMP NULL,
    updatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Indexes for performance
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_role (role),
    INDEX idx_created_date (createdDate)
);

-- ═══════════════════════════════════════════════════════════════
-- 🏪 RESTAURANT TABLE - Enhanced with business details
-- ═══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS restaurant (
    restaurantId INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    address TEXT NOT NULL,
    phone VARCHAR(20),
    email VARCHAR(100),
    website VARCHAR(255),
    rating DECIMAL(3,2) DEFAULT 0.00 CHECK (rating >= 0 AND rating <= 5),
    reviewCount INT DEFAULT 0,
    cuisineType VARCHAR(50),
    priceRange ENUM('₹', '₹₹', '₹₹₹', '₹₹₹₹') DEFAULT '₹₹',
    isActive BOOLEAN DEFAULT TRUE,
    isOpen BOOLEAN DEFAULT TRUE,
    openingHours JSON, -- Store opening hours as JSON
    deliveryTime VARCHAR(20), -- e.g., "30-45 mins"
    minimumOrder DECIMAL(10,2) DEFAULT 0.00,
    deliveryFee DECIMAL(8,2) DEFAULT 0.00,
    serviceCharge DECIMAL(5,2) DEFAULT 0.00,
    adminUserId INT,
    imagePath VARCHAR(255) DEFAULT '/images/default-restaurant.jpg',
    bannerImage VARCHAR(255),
    latitude DECIMAL(10, 8), -- For location-based search
    longitude DECIMAL(11, 8),
    createdDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign key constraint
    FOREIGN KEY (adminUserId) REFERENCES user(userId) ON DELETE SET NULL,
    
    -- Indexes for performance
    INDEX idx_name (name),
    INDEX idx_cuisine (cuisineType),
    INDEX idx_rating (rating),
    INDEX idx_location (latitude, longitude),
    INDEX idx_active (isActive, isOpen),
    FULLTEXT INDEX idx_search (name, description, cuisineType)
);

-- ═══════════════════════════════════════════════════════════════
-- 📂 CATEGORY TABLE - For menu categorization
-- ═══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS category (
    categoryId INT PRIMARY KEY AUTO_INCREMENT,
    categoryName VARCHAR(50) NOT NULL,
    description TEXT,
    imagePath VARCHAR(255),
    isActive BOOLEAN DEFAULT TRUE,
    sortOrder INT DEFAULT 0,
    createdDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_name (categoryName),
    INDEX idx_sort (sortOrder)
);

-- ═══════════════════════════════════════════════════════════════
-- 🍽️ MENU TABLE - Enhanced with nutritional info and variants
-- ═══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS menu (
    menuId INT PRIMARY KEY AUTO_INCREMENT,
    restaurantId INT NOT NULL,
    categoryId INT DEFAULT NULL,
    itemName VARCHAR(100) NOT NULL,
    description TEXT,
    ingredients TEXT, -- List of ingredients
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    originalPrice DECIMAL(10,2), -- For discount calculations
    ratings DECIMAL(3,2) DEFAULT 0.00 CHECK (ratings >= 0 AND ratings <= 5),
    reviewCount INT DEFAULT 0,
    isAvailable BOOLEAN DEFAULT TRUE,
    isVegetarian BOOLEAN DEFAULT FALSE,
    isVegan BOOLEAN DEFAULT FALSE,
    isGlutenFree BOOLEAN DEFAULT FALSE,
    spiceLevel ENUM('MILD', 'MEDIUM', 'SPICY', 'EXTRA_SPICY') DEFAULT 'MILD',
    calories INT DEFAULT NULL,
    preparationTime INT DEFAULT NULL, -- in minutes
    imagePath VARCHAR(255) DEFAULT '/images/default-food.jpg',
    tags JSON, -- Store tags as JSON array
    createdDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    FOREIGN KEY (restaurantId) REFERENCES restaurant(restaurantId) ON DELETE CASCADE,
    FOREIGN KEY (categoryId) REFERENCES category(categoryId) ON DELETE SET NULL,
    
    -- Indexes for performance
    INDEX idx_restaurant (restaurantId),
    INDEX idx_category (categoryId),
    INDEX idx_available (isAvailable),
    INDEX idx_price (price),
    INDEX idx_rating (ratings),
    INDEX idx_dietary (isVegetarian, isVegan, isGlutenFree),
    FULLTEXT INDEX idx_search (itemName, description, ingredients)
);

-- ═══════════════════════════════════════════════════════════════
-- 📦 ORDER TABLE - Enhanced with delivery and payment details
-- ═══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS `order` (
    orderId INT PRIMARY KEY AUTO_INCREMENT,
    orderNumber VARCHAR(20) UNIQUE NOT NULL, -- Human readable order number
    userId INT NOT NULL,
    restaurantId INT NOT NULL,
    orderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estimatedDeliveryTime TIMESTAMP NULL,
    actualDeliveryTime TIMESTAMP NULL,
    
    -- Pricing breakdown
    subtotal DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    taxAmount DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    deliveryFee DECIMAL(8,2) NOT NULL DEFAULT 0.00,
    serviceCharge DECIMAL(8,2) NOT NULL DEFAULT 0.00,
    discount DECIMAL(8,2) NOT NULL DEFAULT 0.00,
    totalAmount DECIMAL(10,2) NOT NULL,
    
    -- Status tracking
    orderStatus ENUM('PENDING', 'CONFIRMED', 'PREPARING', 'READY', 'OUT_FOR_DELIVERY', 'DELIVERED', 'CANCELLED') DEFAULT 'PENDING',
    paymentMethod ENUM('CASH', 'CREDIT_CARD', 'DEBIT_CARD', 'UPI', 'WALLET', 'NET_BANKING') DEFAULT 'CASH',
    paymentStatus ENUM('PENDING', 'PAID', 'FAILED', 'REFUNDED') DEFAULT 'PENDING',
    
    -- Delivery information
    deliveryAddress TEXT NOT NULL,
    deliveryInstructions TEXT,
    contactPhone VARCHAR(20),
    
    -- Additional fields
    couponCode VARCHAR(50),
    specialInstructions TEXT,
    rating DECIMAL(2,1) DEFAULT NULL CHECK (rating >= 1 AND rating <= 5),
    feedback TEXT,
    
    createdDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updatedDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    FOREIGN KEY (userId) REFERENCES user(userId) ON DELETE CASCADE,
    FOREIGN KEY (restaurantId) REFERENCES restaurant(restaurantId) ON DELETE CASCADE,
    
    -- Indexes for performance
    INDEX idx_order_number (orderNumber),
    INDEX idx_user (userId),
    INDEX idx_restaurant (restaurantId),
    INDEX idx_status (orderStatus),
    INDEX idx_payment (paymentStatus),
    INDEX idx_date (orderDate),
    INDEX idx_total (totalAmount)
);

-- ═══════════════════════════════════════════════════════════════
-- 🛒 ORDER ITEM TABLE - Enhanced with customizations
-- ═══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS order_item (
    orderItemId INT PRIMARY KEY AUTO_INCREMENT,
    orderId INT NOT NULL,
    menuId INT NOT NULL,
    itemName VARCHAR(100) NOT NULL, -- Stored for historical purposes
    unitPrice DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
    subtotal DECIMAL(10,2) NOT NULL,
    specialRequests TEXT,
    customizations JSON, -- Store customizations as JSON
    createdDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    FOREIGN KEY (orderId) REFERENCES `order`(orderId) ON DELETE CASCADE,
    FOREIGN KEY (menuId) REFERENCES menu(menuId) ON DELETE CASCADE,
    
    -- Indexes for performance
    INDEX idx_order (orderId),
    INDEX idx_menu (menuId)
);

-- ═══════════════════════════════════════════════════════════════
-- ⭐ REVIEW TABLE - For restaurant and food reviews
-- ═══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS review (
    reviewId INT PRIMARY KEY AUTO_INCREMENT,
    userId INT NOT NULL,
    restaurantId INT NOT NULL,
    orderId INT NOT NULL,
    rating DECIMAL(2,1) NOT NULL CHECK (rating >= 1 AND rating <= 5),
    reviewText TEXT,
    foodRating DECIMAL(2,1) CHECK (foodRating >= 1 AND foodRating <= 5),
    deliveryRating DECIMAL(2,1) CHECK (deliveryRating >= 1 AND deliveryRating <= 5),
    serviceRating DECIMAL(2,1) CHECK (serviceRating >= 1 AND serviceRating <= 5),
    isAnonymous BOOLEAN DEFAULT FALSE,
    isApproved BOOLEAN DEFAULT TRUE,
    createdDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    FOREIGN KEY (userId) REFERENCES user(userId) ON DELETE CASCADE,
    FOREIGN KEY (restaurantId) REFERENCES restaurant(restaurantId) ON DELETE CASCADE,
    FOREIGN KEY (orderId) REFERENCES `order`(orderId) ON DELETE CASCADE,
    
    -- Indexes for performance
    INDEX idx_user (userId),
    INDEX idx_restaurant (restaurantId),
    INDEX idx_order (orderId),
    INDEX idx_rating (rating),
    INDEX idx_date (createdDate)
);

-- ═══════════════════════════════════════════════════════════════
-- 🎫 COUPON TABLE - For discount management
-- ═══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS coupon (
    couponId INT PRIMARY KEY AUTO_INCREMENT,
    couponCode VARCHAR(50) UNIQUE NOT NULL,
    couponName VARCHAR(100) NOT NULL,
    description TEXT,
    discountType ENUM('PERCENTAGE', 'FIXED_AMOUNT') NOT NULL,
    discountValue DECIMAL(8,2) NOT NULL,
    minimumOrderAmount DECIMAL(10,2) DEFAULT 0.00,
    maximumDiscountAmount DECIMAL(8,2) DEFAULT NULL,
    usageLimit INT DEFAULT NULL,
    usedCount INT DEFAULT 0,
    restaurantId INT DEFAULT NULL, -- NULL means applicable to all restaurants
    validFrom TIMESTAMP NOT NULL,
    validUntil TIMESTAMP NOT NULL,
    isActive BOOLEAN DEFAULT TRUE,
    createdDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    FOREIGN KEY (restaurantId) REFERENCES restaurant(restaurantId) ON DELETE CASCADE,
    
    -- Indexes for performance
    INDEX idx_code (couponCode),
    INDEX idx_restaurant (restaurantId),
    INDEX idx_validity (validFrom, validUntil),
    INDEX idx_active (isActive)
);

-- ═══════════════════════════════════════════════════════════════
-- 📱 NOTIFICATION TABLE - For user notifications
-- ═══════════════════════════════════════════════════════════════
CREATE TABLE IF NOT EXISTS notification (
    notificationId INT PRIMARY KEY AUTO_INCREMENT,
    userId INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    type ENUM('ORDER_UPDATE', 'PROMOTION', 'GENERAL', 'PAYMENT') NOT NULL,
    isRead BOOLEAN DEFAULT FALSE,
    relatedOrderId INT DEFAULT NULL,
    createdDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign key constraints
    FOREIGN KEY (userId) REFERENCES user(userId) ON DELETE CASCADE,
    FOREIGN KEY (relatedOrderId) REFERENCES `order`(orderId) ON DELETE CASCADE,
    
    -- Indexes for performance
    INDEX idx_user (userId),
    INDEX idx_read (isRead),
    INDEX idx_type (type),
    INDEX idx_date (createdDate)
);

-- ══════════════════════════════════════════════════════════════════════════════
-- 🏷️ INSERT SAMPLE CATEGORIES
-- ══════════════════════════════════════════════════════════════════════════════
INSERT INTO category (categoryName, description, imagePath, sortOrder) VALUES 
('South Indian', 'Authentic South Indian delicacies', '/images/categories/south-indian.jpg', 1),
('North Indian', 'Rich and flavorful North Indian cuisine', '/images/categories/north-indian.jpg', 2),
('Chinese', 'Indo-Chinese and traditional Chinese dishes', '/images/categories/chinese.jpg', 3),
('Pizza', 'Wood-fired and traditional pizzas', '/images/categories/pizza.jpg', 4),
('Burgers', 'Gourmet burgers and sandwiches', '/images/categories/burgers.jpg', 5),
('Beverages', 'Refreshing drinks and traditional beverages', '/images/categories/beverages.jpg', 6),
('Desserts', 'Sweet treats and traditional Indian sweets', '/images/categories/desserts.jpg', 7),
('Biryani', 'Aromatic rice dishes with spices', '/images/categories/biryani.jpg', 8);

-- ══════════════════════════════════════════════════════════════════════════════
-- 👥 INSERT INDIAN SAMPLE USERS
-- ══════════════════════════════════════════════════════════════════════════════
INSERT INTO user (name, username, password, email, phone, address, role, isActive, isEmailVerified) VALUES 
('Gopika Sharma', 'gopika', 'password123', 'gopika.sharma@gmail.com', '+91-9876543210', 'MG Road, Bengaluru, Karnataka 560001', 'ADMIN', TRUE, TRUE),
('Manu Krishna', 'manu', 'password123', 'manu.krishna@gmail.com', '+91-9876543211', 'Koramangala, Bengaluru, Karnataka 560034', 'CUSTOMER', TRUE, TRUE),
('Ganesh Patil', 'ganesh', 'password123', 'ganesh.patil@gmail.com', '+91-9876543212', 'Indiranagar, Bengaluru, Karnataka 560038', 'CUSTOMER', TRUE, TRUE),
('Priya Nair', 'priya', 'password123', 'priya.nair@gmail.com', '+91-9876543213', 'Whitefield, Bengaluru, Karnataka 560066', 'CUSTOMER', TRUE, TRUE),
('Riya Singh', 'riya', 'password123', 'riya.singh@gmail.com', '+91-9876543214', 'Electronic City, Bengaluru, Karnataka 560100', 'CUSTOMER', TRUE, TRUE),
('Arjun Reddy', 'arjun', 'password123', 'arjun.reddy@gmail.com', '+91-9876543215', 'Jayanagar, Bengaluru, Karnataka 560011', 'RESTAURANT_OWNER', TRUE, TRUE),
('Shreya Gupta', 'shreya', 'password123', 'shreya.gupta@gmail.com', '+91-9876543216', 'HSR Layout, Bengaluru, Karnataka 560102', 'RESTAURANT_OWNER', TRUE, TRUE),
('Vikash Kumar', 'vikash', 'password123', 'vikash.kumar@gmail.com', '+91-9876543217', 'BTM Layout, Bengaluru, Karnataka 560029', 'DELIVERY_PARTNER', TRUE, TRUE),
('Ananya Iyer', 'ananya', 'password123', 'ananya.iyer@gmail.com', '+91-9876543218', 'Malleshwaram, Bengaluru, Karnataka 560003', 'CUSTOMER', TRUE, TRUE),
('Rohit Mehta', 'rohit', 'password123', 'rohit.mehta@gmail.com', '+91-9876543219', 'Rajajinagar, Bengaluru, Karnataka 560010', 'CUSTOMER', TRUE, TRUE);

-- ══════════════════════════════════════════════════════════════════════════════
-- 🏪 INSERT SAMPLE RESTAURANTS
-- ══════════════════════════════════════════════════════════════════════════════
INSERT INTO restaurant (name, description, address, phone, email, rating, reviewCount, cuisineType, priceRange, deliveryTime, minimumOrder, deliveryFee, adminUserId, imagePath, latitude, longitude) VALUES 
(
    'Saravana Bhavan', 
    'Authentic South Indian vegetarian restaurant serving traditional dishes like dosa, idli, and filter coffee',
    'Brigade Road, Bengaluru, Karnataka 560001', 
    '+91-80-25584455', 
    'info@saravanabhavan.com', 
    4.5, 
    1250, 
    'South Indian', 
    '₹₹', 
    '25-35 mins', 
    150.00, 
    30.00, 
    6, 
    '/images/restaurants/saravana_bhavan.jpg',
    12.9716,
    77.5946
),
(
    'Punjabi Dhaba', 
    'Hearty North Indian cuisine with rich curries, fresh naan, and tandoor specialties',
    'Commercial Street, Bengaluru, Karnataka 560001', 
    '+91-80-25557788', 
    'info@punjabidhaba.com', 
    4.3, 
    890, 
    'North Indian', 
    '₹₹₹', 
    '30-40 mins', 
    200.00, 
    40.00, 
    7, 
    '/images/restaurants/punjabi_dhaba.jpg',
    12.9716,
    77.5946
),
(
    'Mainland China', 
    'Premium Chinese restaurant offering both traditional and Indo-Chinese delicacies',
    'UB City Mall, Bengaluru, Karnataka 560001', 
    '+91-80-41234567', 
    'info@mainlandchina.co.in', 
    4.4, 
    675, 
    'Chinese', 
    '₹₹₹', 
    '35-45 mins', 
    250.00, 
    50.00, 
    6, 
    '/images/restaurants/mainland_china.jpg',
    12.9716,
    77.5946
),
(
    'Pizza Corner', 
    'Fresh wood-fired pizzas with both international and Indian fusion toppings',
    'Koramangala, Bengaluru, Karnataka 560034', 
    '+91-80-41567890', 
    'orders@pizzacorner.com', 
    4.2, 
    432, 
    'Italian', 
    '₹₹', 
    '20-30 mins', 
    180.00, 
    25.00, 
    7, 
    '/images/restaurants/pizza_corner.jpg',
    12.9352,
    77.6245
),
(
    'Burger Street', 
    'Gourmet burgers with Indian spices and international flavors',
    'Indiranagar, Bengaluru, Karnataka 560038', 
    '+91-80-41678901', 
    'info@burgerstreet.com', 
    4.1, 
    298, 
    'American', 
    '₹₹', 
    '15-25 mins', 
    120.00, 
    20.00, 
    6, 
    '/images/restaurants/burger_street.jpg',
    12.9784,
    77.6408
),
(
    'Biryani House', 
    'Authentic Hyderabadi and Lucknowi biryanis with traditional dum cooking',
    'Frazer Town, Bengaluru, Karnataka 560005', 
    '+91-80-25567890', 
    'orders@biryanihouse.com', 
    4.6, 
    1100, 
    'Biryani', 
    '₹₹₹', 
    '40-50 mins', 
    300.00, 
    45.00, 
    7, 
    '/images/restaurants/biryani_house.jpg',
    12.9716,
    77.5946
);

-- ══════════════════════════════════════════════════════════════════════════════
-- 🍽️ INSERT DIVERSE MENU ITEMS
-- ══════════════════════════════════════════════════════════════════════════════

-- Saravana Bhavan Menu (South Indian)
INSERT INTO menu (restaurantId, categoryId, itemName, description, ingredients, price, originalPrice, ratings, reviewCount, isVegetarian, calories, preparationTime, imagePath, spiceLevel) VALUES 
(1, 1, 'Masala Dosa', 'Crispy rice crepe filled with spiced potato filling, served with sambar and chutney', 'Rice, Urad dal, Potatoes, Onions, Spices, Curry leaves', 120.00, NULL, 4.7, 450, TRUE, 280, 15, '/images/menu/masala_dosa.jpg', 'MEDIUM'),
(1, 1, 'Idli Sambar', 'Soft steamed rice cakes served with flavorful sambar and coconut chutney', 'Rice, Urad dal, Toor dal, Vegetables, Tamarind, Spices', 80.00, NULL, 4.5, 320, TRUE, 180, 10, '/images/menu/idli_sambar.jpg', 'MILD'),
(1, 1, 'Rava Upma', 'Traditional semolina breakfast dish with vegetables and aromatic tempering', 'Semolina, Mixed vegetables, Mustard seeds, Curry leaves, Cashews', 90.00, NULL, 4.3, 180, TRUE, 220, 12, '/images/menu/rava_upma.jpg', 'MILD'),
(1, 6, 'Filter Coffee', 'Traditional South Indian filter coffee made with chicory blend', 'Coffee powder, Chicory, Milk, Sugar', 40.00, NULL, 4.8, 280, TRUE, 25, 5, '/images/menu/filter_coffee.jpg', 'MILD'),
(1, 1, 'Vada Sambar', 'Crispy lentil donuts served with tangy sambar and chutneys', 'Urad dal, Curry leaves, Ginger, Green chili, Sambar', 70.00, NULL, 4.4, 200, TRUE, 250, 12, '/images/menu/vada_sambar.jpg', 'MEDIUM');

-- Punjabi Dhaba Menu (North Indian)
INSERT INTO menu (restaurantId, categoryId, itemName, description, ingredients, price, ratings, reviewCount, isVegetarian, calories, preparationTime, imagePath, spiceLevel) VALUES 
(2, 2, 'Butter Chicken', 'Tender chicken in rich tomato-cashew gravy with butter and cream', 'Chicken, Tomatoes, Cashews, Butter, Cream, Spices', 280.00, 4.6, 380, FALSE, 420, 25, '/images/menu/butter_chicken.jpg', 'MEDIUM'),
(2, 2, 'Dal Makhani', 'Creamy black lentils slow-cooked with butter and spices', 'Black lentils, Kidney beans, Butter, Cream, Tomatoes, Spices', 220.00, 4.5, 290, TRUE, 280, 30, '/images/menu/dal_makhani.jpg', 'MILD'),
(2, 2, 'Paneer Butter Masala', 'Cottage cheese cubes in rich buttery tomato gravy', 'Paneer, Tomatoes, Cashews, Butter, Cream, Spices', 240.00, 4.4, 250, TRUE, 350, 20, '/images/menu/paneer_butter_masala.jpg', 'MEDIUM'),
(2, 2, 'Garlic Naan', 'Soft leavened bread topped with fresh garlic and coriander', 'Flour, Yogurt, Garlic, Butter, Baking powder', 60.00, 4.7, 420, TRUE, 180, 8, '/images/menu/garlic_naan.jpg', 'MILD'),
(2, 6, 'Lassi', 'Traditional yogurt-based drink available in sweet and salted varieties', 'Yogurt, Sugar/Salt, Cardamom, Rose water', 80.00, 4.3, 180, TRUE, 120, 3, '/images/menu/lassi.jpg', 'MILD');

-- Mainland China Menu (Chinese)
INSERT INTO menu (restaurantId, categoryId, itemName, description, ingredients, price, ratings, reviewCount, calories, preparationTime, imagePath, spiceLevel) VALUES 
(3, 3, 'Hakka Noodles', 'Stir-fried noodles with vegetables in Indo-Chinese style', 'Noodles, Mixed vegetables, Soy sauce, Garlic, Ginger', 180.00, 4.3, 220, TRUE, 380, 15, '/images/menu/hakka_noodles.jpg', 'MEDIUM'),
(3, 3, 'Chicken Manchurian', 'Crispy chicken balls in tangy Manchurian sauce', 'Chicken, Corn flour, Soy sauce, Tomato ketchup, Garlic, Ginger', 220.00, 4.4, 190, FALSE, 420, 18, '/images/menu/chicken_manchurian.jpg', 'SPICY'),
(3, 3, 'Veg Spring Rolls', 'Crispy rolls filled with fresh vegetables and served with sauce', 'Spring roll sheets, Cabbage, Carrots, Capsicum, Sweet chili sauce', 150.00, 4.2, 160, TRUE, 200, 12, '/images/menu/veg_spring_rolls.jpg', 'MILD'),
(3, 3, 'Hot and Sour Soup', 'Traditional Chinese soup with mushrooms and tofu', 'Mushrooms, Tofu, Corn, Vinegar, White pepper, Soy sauce', 120.00, 4.1, 140, TRUE, 80, 10, '/images/menu/hot_sour_soup.jpg', 'SPICY'),
(3, 3, 'Chilli Paneer', 'Indo-Chinese cottage cheese dish with bell peppers', 'Paneer, Bell peppers, Onions, Soy sauce, Chili sauce', 200.00, 4.5, 200, TRUE, 320, 15, '/images/menu/chilli_paneer.jpg', 'SPICY');

-- Pizza Corner Menu (Italian)
INSERT INTO menu (restaurantId, categoryId, itemName, description, ingredients, price, ratings, reviewCount, isVegetarian, calories, preparationTime, imagePath, spiceLevel) VALUES 
(4, 4, 'Margherita Pizza', 'Classic pizza with fresh tomatoes, mozzarella and basil', 'Pizza base, Tomato sauce, Mozzarella cheese, Fresh basil, Olive oil', 280.00, 4.5, 320, TRUE, 300, 18, '/images/menu/margherita_pizza.jpg', 'MILD'),
(4, 4, 'Paneer Tikka Pizza', 'Indian fusion pizza with marinated paneer and spices', 'Pizza base, Paneer, Bell peppers, Onions, Tikka sauce, Cheese', 350.00, 4.3, 180, TRUE, 420, 20, '/images/menu/paneer_tikka_pizza.jpg', 'MEDIUM'),
(4, 4, 'Chicken BBQ Pizza', 'Smoky BBQ chicken pizza with onions and capsicum', 'Pizza base, Chicken, BBQ sauce, Onions, Capsicum, Mozzarella', 380.00, 4.4, 200, FALSE, 480, 22, '/images/menu/chicken_bbq_pizza.jpg', 'MEDIUM'),
(4, 4, 'Veggie Supreme', 'Loaded vegetable pizza with multiple toppings', 'Pizza base, Mixed vegetables, Olives, Corn, Mushrooms, Cheese', 320.00, 4.2, 150, TRUE, 350, 20, '/images/menu/veggie_supreme.jpg', 'MILD'),
(4, 6, 'Virgin Mojito', 'Refreshing mint and lime drink', 'Mint leaves, Lime, Soda water, Sugar', 120.00, 4.6, 180, TRUE, 45, 5, '/images/menu/virgin_mojito.jpg', 'MILD');

-- Burger Street Menu (American)
INSERT INTO menu (restaurantId, categoryId, itemName, description, ingredients, price, ratings, reviewCount, calories, preparationTime, imagePath, spiceLevel) VALUES 
(5, 5, 'Aloo Tikki Burger', 'Indian-style potato patty burger with chutneys', 'Potato patty, Bun, Mint chutney, Tamarind chutney, Onions, Tomato', 150.00, 4.2, 280, TRUE, 380, 12, '/images/menu/aloo_tikki_burger.jpg', 'MEDIUM'),
(5, 5, 'Chicken Maharaja Burger', 'Spiced chicken patty with Indian flavors', 'Chicken patty, Spices, Bun, Lettuce, Mayo, Tomato, Cheese', 220.00, 4.4, 200, FALSE, 520, 15, '/images/menu/chicken_maharaja_burger.jpg', 'SPICY'),
(5, 5, 'Paneer Makhani Burger', 'Creamy paneer burger with makhani sauce', 'Paneer patty, Makhani sauce, Bun, Lettuce, Onions', 180.00, 4.1, 150, TRUE, 420, 12, '/images/menu/paneer_makhani_burger.jpg', 'MEDIUM'),
(5, 5, 'Masala French Fries', 'Crispy fries tossed with Indian spices', 'Potatoes, Chaat masala, Red chili powder, Salt', 90.00, 4.3, 320, TRUE, 280, 8, '/images/menu/masala_fries.jpg', 'MEDIUM'),
(5, 6, 'Thumps Up', 'Popular Indian cola drink', 'Cola, Spices', 50.00, 4.0, 150, TRUE, 150, 2, '/images/menu/thumbs_up.jpg', 'MILD');

-- Biryani House Menu (Biryani)
INSERT INTO menu (restaurantId, categoryId, itemName, description, ingredients, price, ratings, reviewCount, isVegetarian, calories, preparationTime, imagePath, spiceLevel) VALUES 
(6, 8, 'Hyderabadi Chicken Biryani', 'Authentic Hyderabadi-style chicken biryani cooked in dum', 'Basmati rice, Chicken, Saffron, Yogurt, Fried onions, Spices', 320.00, 4.8, 520, FALSE, 580, 45, '/images/menu/chicken_biryani.jpg', 'SPICY'),
(6, 8, 'Mutton Biryani', 'Tender mutton pieces layered with aromatic rice', 'Basmati rice, Mutton, Saffron, Yogurt, Mint, Spices', 420.00, 4.7, 380, FALSE, 650, 50, '/images/menu/mutton_biryani.jpg', 'SPICY'),
(6, 8, 'Vegetable Biryani', 'Aromatic rice with mixed vegetables and paneer', 'Basmati rice, Mixed vegetables, Paneer, Saffron, Spices', 250.00, 4.4, 280, TRUE, 450, 35, '/images/menu/veg_biryani.jpg', 'MEDIUM'),
(6, 8, 'Egg Biryani', 'Spiced rice with boiled eggs and aromatic spices', 'Basmati rice, Eggs, Saffron, Fried onions, Mint, Spices', 180.00, 4.3, 200, FALSE, 420, 30, '/images/menu/egg_biryani.jpg', 'MEDIUM'),
(6, 7, 'Raita', 'Cooling yogurt side dish with cucumber and spices', 'Yogurt, Cucumber, Mint, Cumin powder, Salt', 60.00, 4.2, 150, TRUE, 80, 5, '/images/menu/raita.jpg', 'MILD');

-- ══════════════════════════════════════════════════════════════════════════════
-- 🎫 INSERT SAMPLE COUPONS
-- ══════════════════════════════════════════════════════════════════════════════
INSERT INTO coupon (couponCode, couponName, description, discountType, discountValue, minimumOrderAmount, maximumDiscountAmount, usageLimit, validFrom, validUntil, restaurantId) VALUES 
('WELCOME50', 'Welcome Offer', 'Flat ₹50 off on your first order', 'FIXED_AMOUNT', 50.00, 200.00, 50.00, 1000, NOW(), DATE_ADD(NOW(), INTERVAL 3 MONTH), NULL),
('SOUTH20', 'South Indian Special', '20% off on South Indian cuisine', 'PERCENTAGE', 20.00, 150.00, 100.00, 500, NOW(), DATE_ADD(NOW(), INTERVAL 1 MONTH), 1),
('BIRYANI100', 'Biryani Bonanza', '₹100 off on Biryani orders above ₹400', 'FIXED_AMOUNT', 100.00, 400.00, 100.00, 200, NOW(), DATE_ADD(NOW(), INTERVAL 2 MONTH), 6),
('PIZZA15', 'Pizza Treat', '15% off on all pizzas', 'PERCENTAGE', 15.00, 250.00, 75.00, 300, NOW(), DATE_ADD(NOW(), INTERVAL 1 MONTH), 4);

-- ══════════════════════════════════════════════════════════════════════════════
-- 📦 INSERT SAMPLE ORDERS
-- ══════════════════════════════════════════════════════════════════════════════
INSERT INTO `order` (orderNumber, userId, restaurantId, subtotal, taxAmount, deliveryFee, totalAmount, orderStatus, paymentMethod, paymentStatus, deliveryAddress, contactPhone) VALUES 
('ORD-001', 2, 1, 200.00, 18.00, 30.00, 248.00, 'DELIVERED', 'UPI', 'PAID', 'Koramangala, Bengaluru, Karnataka 560034', '+91-9876543211'),
('ORD-002', 3, 6, 500.00, 45.00, 45.00, 590.00, 'PREPARING', 'CREDIT_CARD', 'PAID', 'Indiranagar, Bengaluru, Karnataka 560038', '+91-9876543212'),
('ORD-003', 4, 4, 350.00, 31.50, 25.00, 406.50, 'OUT_FOR_DELIVERY', 'CASH', 'PENDING', 'Whitefield, Bengaluru, Karnataka 560066', '+91-9876543213');

-- ══════════════════════════════════════════════════════════════════════════════
-- 🛒 INSERT SAMPLE ORDER ITEMS
-- ══════════════════════════════════════════════════════════════════════════════
INSERT INTO order_item (orderId, menuId, itemName, unitPrice, quantity, subtotal) VALUES 
-- Order 1 items (Manu's South Indian order)
(1, 1, 'Masala Dosa', 120.00, 1, 120.00),
(1, 2, 'Idli Sambar', 80.00, 1, 80.00),

-- Order 2 items (Ganesh's Biryani order)
(2, 26, 'Hyderabadi Chicken Biryani', 320.00, 1, 320.00),
(2, 27, 'Mutton Biryani', 420.00, 1, 420.00),

-- Order 3 items (Priya's Pizza order)
(3, 21, 'Margherita Pizza', 280.00, 1, 280.00),
(3, 25, 'Virgin Mojito', 120.00, 1, 120.00);

-- ══════════════════════════════════════════════════════════════════════════════
-- ⭐ INSERT SAMPLE REVIEWS
-- ══════════════════════════════════════════════════════════════════════════════
INSERT INTO review (userId, restaurantId, orderId, rating, reviewText, foodRating, deliveryRating, serviceRating) VALUES 
(2, 1, 1, 4.5, 'Excellent dosa and idli! Tastes just like home. Fast delivery and hot food.', 4.5, 4.5, 4.5),
(3, 6, 2, 4.8, 'Best biryani in town! The mutton was perfectly cooked and rice was aromatic.', 5.0, 4.5, 4.5);

-- ══════════════════════════════════════════════════════════════════════════════
-- 📊 CREATE USEFUL VIEWS FOR REPORTING
-- ══════════════════════════════════════════════════════════════════════════════

-- Restaurant performance view
CREATE OR REPLACE VIEW restaurant_performance AS
SELECT 
    r.restaurantId,
    r.name AS restaurantName,
    r.cuisineType,
    r.rating,
    r.reviewCount,
    COUNT(o.orderId) AS totalOrders,
    COALESCE(SUM(o.totalAmount), 0) AS totalRevenue,
    COALESCE(AVG(o.totalAmount), 0) AS avgOrderValue
FROM restaurant r
LEFT JOIN `order` o ON r.restaurantId = o.restaurantId
GROUP BY r.restaurantId;

-- Popular menu items view
CREATE OR REPLACE VIEW popular_menu_items AS
SELECT 
    m.menuId,
    m.itemName,
    r.name AS restaurantName,
    m.price,
    m.ratings,
    COUNT(oi.orderItemId) AS timesOrdered,
    SUM(oi.quantity) AS totalQuantitySold
FROM menu m
JOIN restaurant r ON m.restaurantId = r.restaurantId
LEFT JOIN order_item oi ON m.menuId = oi.menuId
GROUP BY m.menuId
ORDER BY timesOrdered DESC, totalQuantitySold DESC;

-- User order history view
CREATE OR REPLACE VIEW user_order_summary AS
SELECT 
    u.userId,
    u.name AS userName,
    COUNT(o.orderId) AS totalOrders,
    COALESCE(SUM(o.totalAmount), 0) AS totalSpent,
    COALESCE(AVG(o.totalAmount), 0) AS avgOrderValue,
    MAX(o.orderDate) AS lastOrderDate
FROM user u
LEFT JOIN `order` o ON u.userId = o.userId
WHERE u.role = 'CUSTOMER'
GROUP BY u.userId;

-- ══════════════════════════════════════════════════════════════════════════════
-- ✅ VERIFICATION QUERIES
-- ══════════════════════════════════════════════════════════════════════════════

-- Show all tables created
SELECT 'Database Tables:' AS Info;
SHOW TABLES;

-- Show table counts
SELECT 'Data Summary:' AS Info;
SELECT 
    'Users' AS Table_Name, COUNT(*) AS Record_Count FROM user
UNION ALL
SELECT 'Restaurants', COUNT(*) FROM restaurant
UNION ALL
SELECT 'Categories', COUNT(*) FROM category
UNION ALL
SELECT 'Menu Items', COUNT(*) FROM menu
UNION ALL
SELECT 'Orders', COUNT(*) FROM `order`
UNION ALL
SELECT 'Order Items', COUNT(*) FROM order_item
UNION ALL
SELECT 'Reviews', COUNT(*) FROM review
UNION ALL
SELECT 'Coupons', COUNT(*) FROM coupon;

-- Display success message
SELECT 
    '🎉 Indian Food Ordering Database Created! 🎉' AS Status,
    'Complete with Indian users, restaurants, and diverse cuisine' AS Description,
    DATABASE() AS Database_Name,
    NOW() AS Setup_Time;
