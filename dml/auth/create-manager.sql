INSERT INTO managers (
    name, 
    email, 
    role_id,
    is_active,
    created_at
) VALUES (
    'Foo Bar',
    'foo.ba@empresa.com',
    (SELECT id FROM manager_roles WHERE name = 'LEADER'),
    true,
    CURRENT_TIMESTAMP
);
