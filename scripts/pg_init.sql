
-- Create application user
DO
$$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'jaffle') THEN
        CREATE ROLE jaffle LOGIN INHERIT PASSWORD 'jaffle';
    END IF;
END
$$;

DO
$$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'lecteur') THEN
        CREATE ROLE lecteur LOGIN INHERIT PASSWORD 'lecteur';
    END IF;
END
$$;


-- Create jaffle_shop database if not exists
DO
$$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'jaffle_shop') THEN
        CREATE DATABASE jaffle_shop 
        WITH
            ENCODING = 'UTF8';
    END IF;
END
$$;

GRANT CONNECT ON DATABASE jaffle_shop TO lecteur;
GRANT  ALL ON DATABASE jaffle_shop TO jaffle;
REVOKE ALL ON DATABASE jaffle_shop FROM public;

