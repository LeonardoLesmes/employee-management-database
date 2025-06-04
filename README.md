# 🏢 Sistema de Gestión de Colaboradores - Database

## 📋 Descripción General

Este proyecto implementa un sistema de gestión de colaboradores con tres módulos principales automatizados: 
- **Creación de empleados**: Registro y aprobación de nuevos colaboradores
- **Solicitud de accesos**: Gestión de permisos a sistemas corporativos
- **Asignación de equipos**: Control de inventario y asignación de computadores

Además implementa un sistema de autenticación de managers los cuales se encargan de la gestion, modificacion, rechazo y aprobacion de las solicitudes de los colaboradores.

La base de datos está diseñada para **PostgreSQL**.

## 🗄️ Base de Datos

### Motor de Base de Datos
- **PostgreSQL** 12 o superior
- Utiliza características específicas como `SERIAL`, `CHECK` constraints y `UNIQUE` constraints
- Puerto por defecto: `5432`

## 🔗 Relaciones Detalladas

### 🔄 Relaciones Específicas

#### 1. **Sistema de Gestión de Managers**
```sql
-- Managers → Manager Roles (Many-to-One)
managers.role_id → manager_roles.id
```
- Un rol de manager puede ser asignado a múltiples managers
- Cada manager tiene exactamente un rol específico
- Roles como: LEADER, IT, etc.

```sql
-- Managers → Credentials (One-to-One)
managers_credentials.manager_id → managers.id (UNIQUE)
```
- Cada manager tiene exactamente una entrada de credenciales
- Relación obligatoria para autenticación de directivos

#### 2. **Sistema de Empleados**
```sql
-- Employees → Roles (Many-to-One)
employees.role_id → roles.id
```
- Un rol puede ser asignado a múltiples empleados
- Cada empleado tiene exactamente un rol funcional
- Roles como: DEV_JUNIOR, QA_ANALYST, PROJECT_MANAGER, etc.

#### 3. **Solicitudes de Acceso a Sistemas**
```sql
-- Employees → Access Requests (One-to-Many)
access_requests.employee_id → employees.id

-- Systems → Access Requests (One-to-Many)
access_requests.system_id → systems.id
```
- Un empleado puede tener múltiples solicitudes de acceso (historial)
- Un sistema puede tener múltiples solicitudes
- **Constraint especial**: Solo una solicitud activa por empleado-sistema

#### 4. **Asignaciones de Computadoras**
```sql
-- Employees → Computer Assignments (One-to-Many)
computer_assignments.employee_id → employees.id

-- Computers → Computer Assignments (One-to-Many)
computer_assignments.computer_id → computers.id
```
- Un empleado puede tener múltiples asignaciones (histórico)
- Una computadora puede tener múltiples asignaciones (historial)
- **Constraint especial**: Solo una asignación activa por computadora

#### 5. **Auditoría y Tracking**
- Tracking completo de quién realiza las acciones
- Separación entre quien asigna y quien aprueba
- Auditoría completa de decisiones

### 🔑 Estados del Sistema

#### Estados de Empleados
- `PENDING`: Esperando aprobación del manager
- `APPROVED`: Empleado aprobado y activo
- `REJECTED`: Solicitud de empleado rechazada
- `CANCELED`: Solicitud cancelada

#### Estados de Solicitudes/Asignaciones
- `PENDING`: En espera de aprobación
- `APPROVED`: Aprobado y activo
- `REJECTED`: Rechazado (permite nueva solicitud)
- `CANCELED`: Cancelado (permite nueva solicitud)

#### Estados de Computadoras
- `AVAILABLE`: Disponible para asignación
- `ASSIGNED`: Actualmente asignada a un empleado
- `IN_PROCESS`: En proceso de configuración/mantenimiento

### 🔒 Constraints Únicos Parciales

```sql
-- Solo una solicitud activa por empleado-sistema
CREATE UNIQUE INDEX unique_active_access_request 
ON access_requests (employee_id, system_id) 
WHERE status IN ('PENDING', 'APPROVED');

-- Solo una asignación activa por computadora
CREATE UNIQUE INDEX unique_active_computer_assignment 
ON computer_assignments (computer_id) 
WHERE status IN ('PENDING', 'APPROVED');
```

Estos constraints permiten:
- ✅ Nuevas solicitudes cuando las anteriores fueron `REJECTED` o `CANCELED`
- ❌ Solicitudes duplicadas con estado `PENDING` o `APPROVED`

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

Para insertar las credenciales del usuario ADMIN o cualquier otro manager hacerlo mediante el recurso expuesto en el backend.

## 📁 Estructura del Proyecto

```
employee-management-database/
├── README.md                    # Este archivo
├── schema.dbml                  # Schema para dbdiagram.io
├── schema.png                  # Schema de la base de datos
├── ddl/                        # Data Definition Language
│   ├── create-all-tables.sql   # Script completo de creación
│   ├── create-database.sql     # Creación de BD
│   │
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
