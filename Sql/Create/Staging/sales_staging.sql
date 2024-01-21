-- Table: staging.sales

-- DROP TABLE IF EXISTS staging.sales;

CREATE TABLE IF NOT EXISTS staging.sales
(
    customerid integer,
    itempurchased text COLLATE pg_catalog."default",
    date date,
    category text COLLATE pg_catalog."default",
    purchaseamountusd numeric,
    location text COLLATE pg_catalog."default",
    size text COLLATE pg_catalog."default",
    color text COLLATE pg_catalog."default",
    season text COLLATE pg_catalog."default",
    subscriptionstatus boolean,
    paymentmethodid integer,
    paymentmethod text COLLATE pg_catalog."default",
    shippingtype text COLLATE pg_catalog."default",
    discountapplied boolean,
    promocodeused boolean,
    previouspurchases integer,
    preferredpaymentmethod text COLLATE pg_catalog."default",
    frequencyofpurchases text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS staging.sales
    OWNER to postgres;