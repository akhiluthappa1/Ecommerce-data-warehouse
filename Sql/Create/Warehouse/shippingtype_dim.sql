-- Table: warehouse.shippingtype

-- DROP TABLE IF EXISTS warehouse.shippingtype;

CREATE TABLE IF NOT EXISTS warehouse.shippingtype
(
    shippingtypeid integer NOT NULL DEFAULT nextval('warehouse.shippingtype_shippingtypeid_seq'::regclass),
    shippingtype character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT shippingtype_pkey PRIMARY KEY (shippingtypeid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS warehouse.shippingtype
    OWNER to postgres;