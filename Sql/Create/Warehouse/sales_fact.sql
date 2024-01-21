-- Table: warehouse.sales_fact

-- DROP TABLE IF EXISTS warehouse.sales_fact;

CREATE TABLE IF NOT EXISTS warehouse.sales_fact
(
    dateid integer NOT NULL,
    shippingtypeid integer NOT NULL,
    customerid integer NOT NULL,
    seasonid integer NOT NULL,
    productid integer NOT NULL,
    paymentmethodid integer NOT NULL,
    locationid integer NOT NULL,
    purchaseamount numeric(10,2),
    discountapplied boolean,
    reviewrating numeric(2,1),
    reviewhelpfulvotes integer,
    CONSTRAINT sales_fact_pkey PRIMARY KEY (dateid, shippingtypeid, customerid, seasonid, productid, paymentmethodid, locationid),
    CONSTRAINT sales_fact_dateid_fkey FOREIGN KEY (dateid)
        REFERENCES warehouse."time" (dateid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sales_fact_locationid_fkey FOREIGN KEY (locationid)
        REFERENCES warehouse.location (locationid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sales_fact_paymentmethodid_fkey FOREIGN KEY (paymentmethodid)
        REFERENCES warehouse.paymentmethod (paymentmethodid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sales_fact_productid_fkey FOREIGN KEY (productid)
        REFERENCES warehouse.product (productid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sales_fact_seasonid_fkey FOREIGN KEY (seasonid)
        REFERENCES warehouse.season (seasonid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT sales_fact_shippingtypeid_fkey FOREIGN KEY (shippingtypeid)
        REFERENCES warehouse.shippingtype (shippingtypeid) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS warehouse.sales_fact
    OWNER to postgres;