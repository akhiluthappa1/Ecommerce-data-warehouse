-- Table: staging.reviews

-- DROP TABLE IF EXISTS staging.reviews;

CREATE TABLE IF NOT EXISTS staging.reviews
(
    reviewid integer,
    customerid integer,
    itempurchased text COLLATE pg_catalog."default",
    reviewdate date,
    reviewtext text COLLATE pg_catalog."default",
    reviewrating numeric,
    reviewhelpfulvotes integer
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS staging.reviews
    OWNER to postgres;