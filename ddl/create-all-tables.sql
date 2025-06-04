CREATE TABLE manager_roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE managers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    role_id INTEGER REFERENCES manager_roles(id),
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE managers_credentials (
    id SERIAL PRIMARY KEY,
    manager_id INTEGER NOT NULL REFERENCES managers(id) UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    last_login TIMESTAMP,    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    department VARCHAR(50) NOT NULL,
    role_id INTEGER REFERENCES roles(id),
    status VARCHAR(20) DEFAULT 'PENDING' 
        CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED', 'CANCELED')),
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    assigned_by INTEGER NOT NULL,
    approved_by INTEGER,
    resolution_date TIMESTAMP,
);

CREATE TABLE systems (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    active BOOLEAN DEFAULT true
);

CREATE TABLE access_requests (
    id SERIAL PRIMARY KEY,
    employee_id INTEGER REFERENCES employees(id),
    system_id INTEGER REFERENCES systems(id),
    status VARCHAR(20) DEFAULT 'PENDING'
       CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED', 'CANCELED')),
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    assigned_by INTEGER,
    approved_by INTEGER,
    resolution_date TIMESTAMP
);

CREATE TABLE computers (
    id SERIAL PRIMARY KEY,
    model VARCHAR(100) NOT NULL,
    serial_number VARCHAR(50) UNIQUE NOT NULL,
    status VARCHAR(20) DEFAULT 'AVAILABLE'
        CHECK (status IN ('AVAILABLE', 'ASSIGNED', 'IN_PROCESS')),
    specs TEXT
);

CREATE TABLE computer_assignments (
    id SERIAL PRIMARY KEY,
    employee_id INTEGER REFERENCES employees(id),
    computer_id INTEGER REFERENCES computers(id),
    status VARCHAR(20) DEFAULT 'PENDING'
        CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED', 'CANCELED')),
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    assigned_by INTEGER,
    approved_by INTEGER,
    resolution_date TIMESTAMP
);

CREATE UNIQUE INDEX unique_active_access_request 
ON access_requests (employee_id, system_id) 
WHERE status IN ('PENDING', 'APPROVED');

CREATE UNIQUE INDEX unique_active_computer_assignment 
ON computer_assignments (computer_id) 
WHERE status IN ('PENDING', 'APPROVED');