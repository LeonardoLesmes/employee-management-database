# 🏢 Sistema de Gestión de Colaboradores - Database

## 📋 Descripción General

Este proyecto implementa un sistema de gestión de colaboradores con tres módulos principales automatizados: 
- **Creación de empleados**: Registro y aprobación de nuevos colaboradores
- **Solicitud de accesos**: Gestión de permisos a sistemas corporativos
- **Asignación de equipos**: Control de inventario y asignación de computadores

La base de datos está diseñada para **PostgreSQL** utilizando arquitectura hexagonal con separación clara de responsabilidades.

## 🗄️ Base de Datos

### Motor de Base de Datos
- **PostgreSQL** 12 o superior
- Utiliza características específicas como `SERIAL`, `CHECK` constraints y `UNIQUE` constraints
- Puerto por defecto: `5432`

## 🔗 Relaciones Detalladas

### 1. **Roles → Empleados** (One-to-Many)
```sql
employees.role_id → roles.id
```
- Un rol puede ser asignado a múltiples empleados
- Cada empleado tiene exactamente un rol

### 2. **Empleados → Credenciales** (One-to-One)
```sql
employee_credentials.employee_id → employees.id (UNIQUE)
```
- Cada empleado tiene exactamente una entrada de credenciales
- Relación obligatoria para autenticación

### 3. **Empleados → Solicitudes de Acceso** (One-to-Many)
```sql
access_requests.employee_id → employees.id
```
- Un empleado puede tener múltiples solicitudes de acceso
- Cada solicitud pertenece a un solo empleado

### 4. **Sistemas → Solicitudes de Acceso** (One-to-Many)
```sql
access_requests.system_id → systems.id
```
- Un sistema puede tener múltiples solicitudes
- Cada solicitud es para un sistema específico

### 5. **Empleados → Asignaciones de Computadores** (One-to-Many)
```sql
computer_assignments.employee_id → employees.id
```
- Un empleado puede tener múltiples asignaciones (histórico)
- Permite tracking completo de equipos asignados

## 🔑 Estados del Sistema

### Estados de Empleados
- `PENDING`: Esperando aprobación
- `APPROVED`: Empleado aprobado y activo
- `REJECTED`: Solicitud de empleado rechazada
- `CANCELED`: Solicitud cancelada

### Estados de Solicitudes/Asignaciones
- `PENDING`: En espera de aprobación
- `APPROVED`: Aprobado y activo
- `REJECTED`: Rechazado
- `CANCELED`: Cancelado

### Estados de Computadores
- `AVAILABLE`: Disponible para asignación
- `ASSIGNED`: Actualmente asignado

## 🛠️ Instalación y Configuración

### Prerrequisitos
```bash
# PostgreSQL 12+
# pgAdmin 4 (opcional para gestión visual)
```

### Creación de Base de Datos
```sql
-- Ejecutar en PostgreSQL
CREATE DATABASE employee_management;
```

### Ejecutar Scripts DDL
```bash
# En orden:
psql -d employee_management -f ddl/create-database.sql
psql -d employee_management -f ddl/create-all-tables.sql
```

### Datos Iniciales
```bash
# Roles
psql -d employee_management -f dml/employee/create-roles.sql

# Sistemas
psql -d employee_management -f dml/access-request/create-systems.sql

# Computadores
psql -d employee_management -f dml/computer/create-computers.sql
```

## 👤 Creación de Usuario Administrador

### Query para Insertar Empleado Tipo Admin

```sql
-- 1. Verificar que existe el rol ADMIN
INSERT INTO roles (name, description) VALUES
('ADMIN', 'Administrador del sistema con acceso total')
ON CONFLICT (name) DO NOTHING;

-- 2. Insertar empleado administrador
INSERT INTO employees (
    name, 
    email, 
    department, 
    role_id, 
    status,
    assigned_by,
    role_assigned_at,
    created_at
) VALUES (
    'Administrador Sistema',
    'admin@empresa.com',
    'IT',
    (SELECT id FROM roles WHERE name = 'ADMIN'),
    'APPROVED',
    NULL, -- Auto-asignado
    CURRENT_TIMESTAMP,
    CURRENT_TIMESTAMP
);

-- 4. Verificar la inserción
SELECT 
    e.id, 
    e.name, 
    e.email, 
    r.name as role_name, 
    e.status,
    ec.is_active as credentials_active
FROM employees e
JOIN roles r ON e.role_id = r.id
LEFT JOIN employee_credentials ec ON e.id = ec.employee_id
WHERE e.email = 'admin@empresa.com';
```

## 📁 Estructura del Proyecto

```
employee-management-database/
├── README.md                    # Este archivo
├── schema.dbml                  # Schema para dbdiagram.io
├── ddl/                        # Data Definition Language
│   ├── create-all-tables.sql   # Script completo de creación
│   ├── create-database.sql     # Creación de BD
│   ├── employee/              # Tablas de empleados
│   ├── access-request/        # Tablas de solicitudes
│   ├── computer/             # Tablas de computadores
│   └── index/                # Índices de optimización
└── dml/                       # Data Manipulation Language
    ├── employee/             # Datos iniciales empleados
    ├── access-request/       # Datos iniciales sistemas
    └── computer/            # Datos iniciales computadores
```

## 🔧 Características Técnicas

- **Integridad Referencial**: Foreign keys garantizan consistencia
- **Constraints**: Validaciones a nivel de BD para estados únicos
- **Auditoría**: Timestamps automáticos para tracking completo
- **Seguridad**: Hash de contraseñas con bcrypt
- **Flexibilidad**: Reasignaciones y cambios de estado controlados
- **Escalabilidad**: Índices optimizados para consultas frecuentes
