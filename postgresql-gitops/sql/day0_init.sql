CREATE DATABASE chimera_db TABLESPACE ts_chimera_meta;
CREATE USER chimera_user WITH ENCRYPTED PASSWORD 'chimera_pass';
GRANT ALL PRIVILEGES ON DATABASE chimera_db TO chimera_user;

CREATE DATABASE keycloak_db TABLESPACE ts_chimera_meta;
CREATE USER keycloak_user WITH ENCRYPTED PASSWORD 'keycloak_pass';
GRANT ALL PRIVILEGES ON DATABASE keycloak_db TO keycloak_user;

CREATE DATABASE vault_db TABLESPACE ts_chimera_meta;
CREATE USER vault_user WITH ENCRYPTED PASSWORD 'vault_pass';
GRANT ALL PRIVILEGES ON DATABASE vault_db TO vault_user;

CREATE DATABASE datahub_db TABLESPACE ts_chimera_dh;
CREATE USER datahub_user WITH ENCRYPTED PASSWORD 'datahub_pass';
GRANT ALL PRIVILEGES ON DATABASE datahub_db TO datahub_user;

CREATE DATABASE superset_db TABLESPACE ts_chimera_meta;
CREATE USER superset_user WITH ENCRYPTED PASSWORD 'superset_pass';
GRANT ALL PRIVILEGES ON DATABASE superset_db TO superset_user;

CREATE DATABASE temporal_db TABLESPACE ts_chimera_meta;
CREATE USER temporal_user WITH ENCRYPTED PASSWORD 'temporal_pass';
GRANT ALL PRIVILEGES ON DATABASE temporal_db TO temporal_user;
