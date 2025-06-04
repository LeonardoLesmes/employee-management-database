-- Herramientas de Desarrollo y DevOps
INSERT INTO systems (name, description, active) VALUES
('GitHub-devops', 'Acceso a GitHub para equipo DevOps con privilegios de administrador', true),
('GitHub-developer', 'Acceso a GitHub para desarrolladores con privilegios estándar', true),
('AWS-developer', 'Acceso a Consola AWS para desarrolladores', true),
('AWS-devops', 'Acceso a Consola AWS para equipo DevOps con privilegios extendidos', true);

-- Herramientas de Colaboración y Documentación
INSERT INTO systems (name, description, active) VALUES
('Jira', 'Sistema de gestión de proyectos y seguimiento de incidencias', true),
('Figma', 'Herramienta de diseño y prototipado', true),
('Confluence', 'Plataforma de documentación y base de conocimiento', true);

-- Herramientas de Monitoreo y Operaciones
INSERT INTO systems (name, description, active) VALUES
('Grafana-prod', 'Acceso a dashboard de monitoreo para ambiente de producción', true),
('Grafana-stg', 'Acceso a dashboard de monitoreo para ambiente de staging', true);

-- Herramientas de Negocio
INSERT INTO systems (name, description, active) VALUES
('CRM-stg', 'Sistema de Gestión de Relaciones con Clientes - Ambiente de staging', true);
