-- PROCEDURE: public.insert_update_sales_fact()

-- DROP PROCEDURE IF EXISTS public.insert_update_sales_fact();

CREATE OR REPLACE PROCEDURE public.insert_update_sales_fact(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO warehouse.sales_fact (
        dateid, shippingtypeid, customerid, seasonid, productid, paymentmethodid, 
        locationid, purchaseamount, discountapplied, reviewrating, reviewhelpfulvotes
    )
    SELECT 
        t.dateid, 
        st.shippingtypeid,
        s.customerid, 
        se.seasonid, 
        p.productid, 
        pm.paymentmethodid, 
        l.locationid,
        s.purchaseamountusd,
        s.discountapplied,
        r.reviewrating,
        r.reviewhelpfulvotes
    FROM 
        staging.sales s
    JOIN 
        warehouse.time t ON s.date = t.date
    JOIN 
        warehouse.product p ON s.itempurchased = p.itempurchased AND s.size = p.size AND s.color = p.color
    JOIN 
        warehouse.location l ON s.location = l.location
    JOIN 
        warehouse.season se ON s.season = se.season
    JOIN 
        warehouse.paymentmethod pm ON s.paymentmethodid = pm.paymentmethodid
    JOIN 
        warehouse.shippingtype st ON s.shippingtype = st.shippingtype
    LEFT JOIN 
        staging.reviews r ON s.customerid = r.customerid AND s.itempurchased = r.itempurchased
    ON CONFLICT (dateid, shippingtypeid, customerid, seasonid, productid, paymentmethodid, locationid)
    DO UPDATE SET
        purchaseamount = EXCLUDED.purchaseamount,
        discountapplied = EXCLUDED.discountapplied,
        reviewrating = EXCLUDED.reviewrating,
        reviewhelpfulvotes = EXCLUDED.reviewhelpfulvotes;
END;
$BODY$;
ALTER PROCEDURE public.insert_update_sales_fact()
    OWNER TO postgres;
