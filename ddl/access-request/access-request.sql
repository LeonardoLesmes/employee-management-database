CREATE TABLE access_requests (
    id SERIAL PRIMARY KEY,
    employee_id INTEGER REFERENCES employees(id),
    system_id INTEGER REFERENCES systems(id),
    status VARCHAR(20) DEFAULT 'PENDING'
        CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED', 'CANCELED')),
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolution_date TIMESTAMP,
    assigned_by INTEGER REFERENCES employees(id),
    UNIQUE(employee_id, system_id)
);
