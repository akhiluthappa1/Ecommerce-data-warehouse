-- Table: staging.customers

-- DROP TABLE IF EXISTS staging.customers;

CREATE TABLE IF NOT EXISTS staging.customers
(
    customerid integer,
    fullname text COLLATE pg_catalog."default",
    gender text COLLATE pg_catalog."default",
    emailaddress text COLLATE pg_catalog."default",
    phonenumber text COLLATE pg_catalog."default",
    address text COLLATE pg_catalog."default",
    membershiplevel text COLLATE pg_catalog."default",
    dateofbirth date,
    age integer,
    occupation text COLLATE pg_catalog."default",
    maritalstatus text COLLATE pg_catalog."default",
    CONSTRAINT customerid_unique2 UNIQUE (customerid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS staging.customers
    OWNER to postgres;