Table manager_roles {
  id integer [pk, increment]
  name varchar(50) [unique, not null]
  created_at timestamp [default: `now()`]
}

Table managers {
  id integer [pk, increment]
  name varchar(100) [not null]
  email varchar(100) [unique, not null]
  role_id integer [ref: > manager_roles.id]
  is_active boolean [default: true]
  created_at timestamp [default: `now()`]
}

Table managers_credentials {
  id integer [pk, increment]
  manager_id integer [ref: - managers.id, not null, unique]
  password_hash varchar(255) [not null]
  last_login timestamp
  created_at timestamp [default: `now()`]
  updated_at timestamp [default: `now()`]
}

Table roles {
  id integer [pk, increment]
  name varchar(50) [unique, not null]
  description text
  created_at timestamp [default: `now()`]
}

Table employees {
  id integer [pk, increment]
  name varchar(100) [not null]
  email varchar(100) [unique, not null]
  department varchar(50) [not null]
  role_id integer [ref: > roles.id]
  status varchar(20) [default: 'PENDING']
  request_date timestamp [default: `now()`]
  assigned_by integer
  approved_by integer
  resolution_date timestamp
}

Table systems {
  id integer [pk, increment]
  name varchar(100) [not null]
  description text
  active boolean [default: true]
}

Table access_requests {
  id integer [pk, increment]
  employee_id integer [ref: > employees.id]
  system_id integer [ref: > systems.id]
  status varchar(20) [default: 'PENDING']
  request_date timestamp [default: `now()`]
  assigned_by integer
  approved_by integer
  resolution_date timestamp

  indexes {
    (employee_id, system_id) [unique]
  }
}

Table computers {
  id integer [pk, increment]
  model varchar(100) [not null]
  serial_number varchar(50) [unique, not null]
  status varchar(20) [default: 'AVAILABLE']
  specs text
}

Table computer_assignments {
  id integer [pk, increment]
  employee_id integer [ref: > employees.id]
  computer_id integer [ref: > computers.id]
  status varchar(20) [default: 'PENDING']
  request_date timestamp [default: `now()`]
  assigned_by integer
  approved_by integer
  resolution_date timestamp

  indexes {
    computer_id [unique]
  }
}

Enum employee_status {
  PENDING
  APPROVED
  REJECTED
  CANCELED
}

Enum request_status {
  PENDING
  APPROVED
  REJECTED
  CANCELED
}

Enum computer_status {
  AVAILABLE
  ASSIGNED
  IN_PROCESS
}