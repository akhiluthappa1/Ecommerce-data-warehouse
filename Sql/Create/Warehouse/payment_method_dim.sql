-- Table: warehouse.paymentmethod

-- DROP TABLE IF EXISTS warehouse.paymentmethod;

CREATE TABLE IF NOT EXISTS warehouse.paymentmethod
(
    paymentmethodid integer NOT NULL,
    paymentmethod character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT paymentmethod_pkey PRIMARY KEY (paymentmethodid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS warehouse.paymentmethod
    OWNER to postgres;