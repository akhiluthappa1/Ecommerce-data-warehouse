-- Table: staging.location_standardization

-- DROP TABLE IF EXISTS staging.location_standardization;

CREATE TABLE IF NOT EXISTS staging.location_standardization
(
    original_name character varying(255) COLLATE pg_catalog."default",
    standardized_name character varying(255) COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS staging.location_standardization
    OWNER to postgres;