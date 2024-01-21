-- Table: warehouse.subscriptionstatus

-- DROP TABLE IF EXISTS warehouse.subscriptionstatus;

CREATE TABLE IF NOT EXISTS warehouse.subscriptionstatus
(
    subscriptionstatusid integer NOT NULL DEFAULT nextval('warehouse.subscriptionstatus_subscriptionstatusid_seq'::regclass),
    subscriptionstatus character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT subscriptionstatus_pkey PRIMARY KEY (subscriptionstatusid)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS warehouse.subscriptionstatus
    OWNER to postgres;