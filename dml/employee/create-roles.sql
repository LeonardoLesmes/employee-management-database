INSERT INTO roles (name, description) VALUES
    -- Admin roles
    ('ADMIN', 'Administrador del sistema con acceso total'),    
    ('IT', 'Personal de TI - gestiona accesos y equipos'),
    
    -- Leadership roles
    ('LEADER_DEV', 'Líder del equipo de desarrollo - gestión de desarrolladores'),
    ('LEADER_QA', 'Líder del equipo de calidad - gestión de QAs'),
    ('LEADER_PRODUCT', 'Líder del equipo de producto - gestión de POs y BAs'),
    ('LEADER_AGILE', 'Líder de transformación ágil - gestión de SMs y coaches'),
    ('LEADER_UX', 'Líder del equipo de diseño - gestión de UX/UI'),
    ('LEADER_DEVOPS', 'Líder del equipo de DevOps - gestión de infraestructura'),

    -- Development roles
    ('DEV_JUNIOR', 'Desarrollador Junior - menos de 2 años de experiencia'),
    ('DEV_SEMI', 'Desarrollador Semi Senior - 2 a 4 años de experiencia'),
    ('DEV_SENIOR', 'Desarrollador Senior - más de 4 años de experiencia'),
    ('TECH_LEAD', 'Líder técnico del equipo de desarrollo'),
    
    -- QA roles
    ('QA_ANALYST', 'Analista de Quality Assurance'),
    ('QA_AUTOMATION', 'Ingeniero de Automatización QA'),
    
    -- DevOps roles
    ('DEVOPS_ENGINEER', 'Ingeniero DevOps - CI/CD y Cloud'),
    ('SRE', 'Site Reliability Engineer'),
    
    -- Design roles
    ('UX_DESIGNER', 'Diseñador de Experiencia de Usuario'),
    ('UI_DESIGNER', 'Diseñador de Interfaces de Usuario'),
    
    -- Project Management roles
    ('PROJECT_MANAGER', 'Gerente de Proyecto'),
    ('SCRUM_MASTER', 'Scrum Master - Facilitador Ágil'),
    ('AGILE_COACH', 'Coach Ágil - Transformación y Mejora Continua'),
    ('PRODUCT_OWNER', 'Product Owner - Gestión de Producto');

-- Verify insertion
SELECT * FROM roles ORDER BY id;
