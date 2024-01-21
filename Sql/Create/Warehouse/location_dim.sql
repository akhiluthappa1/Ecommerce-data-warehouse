-- Table: warehouse.location

-- DROP TABLE IF EXISTS warehouse.location;

CREATE TABLE IF NOT EXISTS warehouse.location
(
    locationid integer NOT NULL DEFAULT nextval('warehouse.location_locationid_seq'::regclass),
    location character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT location_pkey PRIMARY KEY (locationid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS warehouse.location
    OWNER to postgres;