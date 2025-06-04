CREATE TABLE computers (
    id SERIAL PRIMARY KEY,
    model VARCHAR(100) NOT NULL,
    serial_number VARCHAR(50) UNIQUE NOT NULL,
    status VARCHAR(20) DEFAULT 'AVAILABLE'
        CHECK (status IN ('AVAILABLE', 'ASSIGNED')),
    specs TEXT
);
