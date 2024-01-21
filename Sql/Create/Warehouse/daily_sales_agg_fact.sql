-- Table: warehouse.daily_sales_agg_fact

-- DROP TABLE IF EXISTS warehouse.daily_sales_agg_fact;

CREATE TABLE IF NOT EXISTS warehouse.daily_sales_agg_fact
(
    dateid integer NOT NULL,
    totalsalesamount numeric(10,2),
    totaltransactions integer,
    CONSTRAINT daily_sales_agg_fact_pkey PRIMARY KEY (dateid),
    CONSTRAINT daily_sales_agg_fact_dateid_fkey FOREIGN KEY (dateid)
        REFERENCES warehouse."time" (dateid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS warehouse.daily_sales_agg_fact
    OWNER to postgres;