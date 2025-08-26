# Database Structure for Food Ordering Website

## Restaurants Table Structure
Your `restaurants` table should have these columns:

```sql
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
    adminUserId INT,
    imagePath VARCHAR(500) DEFAULT '/images/default-restaurant.jpg'
);
```

## Menu Table Structure
Your `menu` table should have these columns:

```sql
CREATE TABLE menu (
    menuId INT PRIMARY KEY AUTO_INCREMENT,
    restaurantId INT NOT NULL,
    itemName VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(100),
    isAvailable BOOLEAN DEFAULT TRUE,
    imagePath VARCHAR(500),
    FOREIGN KEY (restaurantId) REFERENCES restaurants(restaurantId)
);
```

## Expected Data Format
Make sure your existing data follows this format:

### Restaurants Example:
- **restaurantId**: Auto-increment (1, 2, 3...)
- **name**: "Spice Garden", "Mario's Pizza", etc.
- **description**: Brief description of the restaurant
- **address**: Full address or location
- **phone**: Contact number
- **rating**: Decimal number (4.5, 3.8, etc.)
- **cuisineType**: "Italian", "Indian", "Chinese", "Mexican", "American", "Thai", "Japanese", "Mediterranean"
- **isActive**: TRUE/FALSE (1/0)
- **deliveryTime**: "25-30 mins", "30-40 mins", etc.
- **adminUserId**: Owner ID (can be 1 for now)

### Menu Example:
- **menuId**: Auto-increment
- **restaurantId**: References the restaurant ID
- **itemName**: "Margherita Pizza", "Chicken Biryani", etc.
- **price**: Decimal number (299.99, 450.00, etc.)
- **category**: "Appetizer", "Main Course", "Dessert", etc.

## Important Notes:
1. Make sure `cuisineType` values match exactly: "Italian", "Indian", "Chinese", "Mexican", "American", "Thai", "Japanese", "Mediterranean"
2. The `rating` should be a decimal number between 0.00 and 5.00
3. `isActive` should be TRUE (1) for restaurants you want to display
4. `deliveryTime` should be in format like "25-30 mins" or "30-40 mins"
