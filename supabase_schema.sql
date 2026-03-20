-- Supabase (PostgreSQL) Schema for BorrowBuddy

-- 1. Users Table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    role VARCHAR(50),
    is_verified BOOLEAN DEFAULT FALSE,
    trust_score INT DEFAULT 100
);

-- 2. Items Table
CREATE TABLE IF NOT EXISTS items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DOUBLE PRECISION NOT NULL,
    image VARCHAR(255),
    owner_email VARCHAR(255) REFERENCES users(email),
    category VARCHAR(100)
);

-- 3. Bookings Table
CREATE TABLE IF NOT EXISTS bookings (
    id SERIAL PRIMARY KEY,
    item_id INT REFERENCES items(id),
    borrower_id INT REFERENCES users(id),
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    status VARCHAR(50) DEFAULT 'Pending',
    payment_status VARCHAR(50) DEFAULT 'Unpaid',
    agreement_accepted INT DEFAULT 0,
    condition_note TEXT,
    rating_id INT,
    late_fee DOUBLE PRECISION DEFAULT 0.0
);

-- 4. Notifications Table
CREATE TABLE IF NOT EXISTS notifications (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    message TEXT NOT NULL,
    type VARCHAR(50),
    is_read INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. Reviews Table
CREATE TABLE IF NOT EXISTS reviews (
    id SERIAL PRIMARY KEY,
    item_id INT REFERENCES items(id),
    reviewer_id INT REFERENCES users(id),
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
