-- Check and create tablespaces (must be outside DO blocks)
SELECT 'CREATE TABLESPACE chimera_space LOCATION ''/var/lib/postgresql/tablespaces/chimera_db'''
WHERE NOT EXISTS (SELECT FROM pg_tablespace WHERE spcname = 'chimera_space')\gexec

SELECT 'CREATE TABLESPACE keycloak_space LOCATION ''/var/lib/postgresql/tablespaces/keycloak'''
WHERE NOT EXISTS (SELECT FROM pg_tablespace WHERE spcname = 'keycloak_space')\gexec

SELECT 'CREATE TABLESPACE vault_space LOCATION ''/var/lib/postgresql/tablespaces/vault'''
WHERE NOT EXISTS (SELECT FROM pg_tablespace WHERE spcname = 'vault_space')\gexec

SELECT 'CREATE TABLESPACE datahub_space LOCATION ''/var/lib/postgresql/tablespaces/datahub'''
WHERE NOT EXISTS (SELECT FROM pg_tablespace WHERE spcname = 'datahub_space')\gexec

SELECT 'CREATE TABLESPACE superset_space LOCATION ''/var/lib/postgresql/tablespaces/superset'''
WHERE NOT EXISTS (SELECT FROM pg_tablespace WHERE spcname = 'superset_space')\gexec

SELECT 'CREATE TABLESPACE temporal_space LOCATION ''/var/lib/postgresql/tablespaces/temporal'''
WHERE NOT EXISTS (SELECT FROM pg_tablespace WHERE spcname = 'temporal_space')\gexec

-- Check and create databases (must be outside DO blocks)
SELECT 'CREATE DATABASE chimera_db WITH TABLESPACE chimera_space'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'chimera_db')\gexec

SELECT 'CREATE DATABASE keycloak_db WITH TABLESPACE keycloak_space'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'keycloak_db')\gexec

SELECT 'CREATE DATABASE vault_db WITH TABLESPACE vault_space'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'vault_db')\gexec

SELECT 'CREATE DATABASE datahub_db WITH TABLESPACE datahub_space'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'datahub_db')\gexec

SELECT 'CREATE DATABASE superset_db WITH TABLESPACE superset_space'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'superset_db')\gexec

SELECT 'CREATE DATABASE temporal_db WITH TABLESPACE temporal_space'
WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'temporal_db')\gexec

-- Users can be created in DO blocks
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'chimera_user') THEN
        CREATE USER chimera_user WITH ENCRYPTED PASSWORD 'chimera_pass';
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'keycloak_user') THEN
        CREATE USER keycloak_user WITH ENCRYPTED PASSWORD 'keycloak_pass';
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'vault_user') THEN
        CREATE USER vault_user WITH ENCRYPTED PASSWORD 'vault_pass';
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'datahub_user') THEN
        CREATE USER datahub_user WITH ENCRYPTED PASSWORD 'datahub_pass';
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'superset_user') THEN
        CREATE USER superset_user WITH ENCRYPTED PASSWORD 'superset_pass';
    END IF;
END $$;

DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'temporal_user') THEN
        CREATE USER temporal_user WITH ENCRYPTED PASSWORD 'temporal_pass';
    END IF;
END $$;

-- Grant privileges
GRANT ALL PRIVILEGES ON DATABASE chimera_db TO chimera_user;
GRANT ALL PRIVILEGES ON DATABASE keycloak_db TO keycloak_user;
GRANT ALL PRIVILEGES ON DATABASE vault_db TO vault_user;
GRANT ALL PRIVILEGES ON DATABASE datahub_db TO datahub_user;
GRANT ALL PRIVILEGES ON DATABASE superset_db TO superset_user;
GRANT ALL PRIVILEGES ON DATABASE temporal_db TO temporal_user;