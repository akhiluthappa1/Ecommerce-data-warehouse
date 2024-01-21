-- Table: warehouse.product

-- DROP TABLE IF EXISTS warehouse.product;

CREATE TABLE IF NOT EXISTS warehouse.product
(
    productid integer NOT NULL DEFAULT nextval('warehouse.product_productid_seq'::regclass),
    itempurchased character varying(255) COLLATE pg_catalog."default",
    category character varying(255) COLLATE pg_catalog."default",
    size character varying(50) COLLATE pg_catalog."default",
    color character varying(50) COLLATE pg_catalog."default",
    previous_category character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT product_pkey PRIMARY KEY (productid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS warehouse.product
    OWNER to postgres;