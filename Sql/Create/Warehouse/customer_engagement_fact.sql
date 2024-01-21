-- Table: warehouse.customerengagement_fact

-- DROP TABLE IF EXISTS warehouse.customerengagement_fact;

CREATE TABLE IF NOT EXISTS warehouse.customerengagement_fact
(
    subscriptionstatusid integer NOT NULL,
    customerid integer NOT NULL,
    frequencyofpurchase character varying(255) COLLATE pg_catalog."default",
    numberpreviouspurchase integer,
    CONSTRAINT customerengagement_fact_pkey PRIMARY KEY (subscriptionstatusid, customerid),
    CONSTRAINT customerengagement_fact_subscriptionstatusid_fkey FOREIGN KEY (subscriptionstatusid)
        REFERENCES warehouse.subscriptionstatus (subscriptionstatusid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS warehouse.customerengagement_fact
    OWNER to postgres;