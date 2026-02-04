create database royal_store;
use royal_store;

/* user table*/
CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  password VARCHAR(255),
  role ENUM('customer','retailer','admin'),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

desc users;

/* retailers table*/
CREATE TABLE retailers (
  retailer_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT,
  shop_name VARCHAR(150),
  latitude DECIMAL(10,8),
  longitude DECIMAL(11,8),
  license_doc VARCHAR(255),
  approval_status ENUM('pending','approved','rejected') DEFAULT 'pending',
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

/*products table*/
create table products(
	product_id INT AUTO_INCREMENT primary key,
    retailer_id INT,
    name varchar(150),
	price decimal(10,2),
    stock INT,
    foreign key (retailer_id) REFERENCES retailers(retailer_id)
);

desc products;

/*orders table*/
create table orders(
	order_id INT AUTO_INCREMENT primary key,
    customer_id INT,
    retailer_id INT,
    status ENUM('pending','accepted','packed','delivered') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

desc orders;

/*ordering items table*/
create table order_items(
	item_id INT auto_increment primary key,
    order_id INT,
    item_name varchar(150),
    quantity INT,
    price decimal(10,2),
    foreign key (order_id) REFERENCES orders(order_id)
);

desc order_items;

create table bill(
	bill_id INT AUTO_INCREMENT primary key,
    order_id INT,
    subtotal decimal(10,2),
    discount decimal(10,2),
    final_amount decimal(10,2),
    foreign key (order_id) references orders(order_id)
);

desc bill;