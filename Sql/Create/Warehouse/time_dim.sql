-- Table: warehouse.time

-- DROP TABLE IF EXISTS warehouse."time";

CREATE TABLE IF NOT EXISTS warehouse."time"
(
    dateid integer NOT NULL DEFAULT nextval('warehouse.time_dateid_seq'::regclass),
    date date,
    day integer,
    month integer,
    quarter integer,
    year integer,
    CONSTRAINT time_pkey PRIMARY KEY (dateid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS warehouse."time"
    OWNER to postgres;