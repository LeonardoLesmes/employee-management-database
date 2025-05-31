CREATE TABLE computers (
    id SERIAL PRIMARY KEY,
    model VARCHAR(100) NOT NULL,
    serial_number VARCHAR(50) UNIQUE NOT NULL,
    status VARCHAR(20) DEFAULT 'available'
        CHECK (status IN ('available', 'assigned', 'maintenance')),
    specs TEXT
);
