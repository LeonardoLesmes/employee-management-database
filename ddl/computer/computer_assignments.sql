CREATE TABLE computer_assignments (
    id SERIAL PRIMARY KEY,
    employee_id INTEGER REFERENCES employees(id),
    computer_id INTEGER REFERENCES computers(id),
    status VARCHAR(20) DEFAULT 'PENDING'
        CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED', 'CANCELED')),
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolution_date TIMESTAMP,
    assignment_date TIMESTAMP,
    return_date TIMESTAMP,
    assigned_by INTEGER REFERENCES employees(id),
    UNIQUE(computer_id, return_date)
);
