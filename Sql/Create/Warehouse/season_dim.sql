-- Table: warehouse.season

-- DROP TABLE IF EXISTS warehouse.season;

CREATE TABLE IF NOT EXISTS warehouse.season
(
    seasonid integer NOT NULL DEFAULT nextval('warehouse.season_seasonid_seq'::regclass),
    season character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT season_pkey PRIMARY KEY (seasonid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS warehouse.season
    OWNER to postgres;