CREATE TABLE computer_assignments (
    id SERIAL PRIMARY KEY,
    employee_id INTEGER REFERENCES employees(id),
    computer_id INTEGER REFERENCES computers(id),
    status VARCHAR(20) DEFAULT 'pending'
        CHECK (status IN ('pending', 'approved', 'rejected')),
    request_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolution_date TIMESTAMP,
    assignment_date TIMESTAMP,
    return_date TIMESTAMP,
    UNIQUE(computer_id, return_date)
);
