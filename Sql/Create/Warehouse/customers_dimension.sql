-- Table: warehouse.customers

-- DROP TABLE IF EXISTS warehouse.customers;

CREATE TABLE IF NOT EXISTS warehouse.customers
(
    customer_sk integer NOT NULL DEFAULT nextval('warehouse.customers_customer_sk_seq'::regclass),
    customerid integer,
    firstname character varying(255) COLLATE pg_catalog."default",
    lastname character varying(255) COLLATE pg_catalog."default",
    gender character varying(10) COLLATE pg_catalog."default",
    email character varying(255) COLLATE pg_catalog."default",
    phone character varying(50) COLLATE pg_catalog."default",
    address character varying(255) COLLATE pg_catalog."default",
    membershiplevel character varying(50) COLLATE pg_catalog."default",
    dob date,
    age integer,
    occupation character varying(255) COLLATE pg_catalog."default",
    maritalstatus character varying(50) COLLATE pg_catalog."default",
    valid_from date,
    valid_to date,
    is_current boolean DEFAULT true,
    CONSTRAINT customers_pkey PRIMARY KEY (customer_sk)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS warehouse.customers
    OWNER to postgres;