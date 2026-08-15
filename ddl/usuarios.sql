USE gimnasio_db;

-- Administrador de la base de datos
CREATE USER IF NOT EXISTS 'admin_gym'@'localhost' IDENTIFIED BY 'AdminGym_2026';
GRANT ALL PRIVILEGES ON gimnasio_db.* TO 'admin_gym'@'localhost';

-- Operador con privilegios de lectura y escritura
CREATE USER IF NOT EXISTS 'operador_gym'@'localhost' IDENTIFIED BY 'OperadorGym_2026';
GRANT SELECT, INSERT, UPDATE ON gimnasio_db.* TO 'operador_gym'@'localhost';

-- Privilegio restringido a nivel de columna
GRANT SELECT (numero_telefono_socio) ON gimnasio_db.socios TO 'operador_gym'@'localhost';

SHOW GRANTS FOR 'admin_gym'@'localhost';
SHOW GRANTS FOR 'operador_gym'@'localhost';