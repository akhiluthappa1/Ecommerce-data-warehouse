-- PROCEDURE: public.insert_update_cust_eng_fact()

-- DROP PROCEDURE IF EXISTS public.insert_update_cust_eng_fact();

CREATE OR REPLACE PROCEDURE public.insert_update_cust_eng_fact(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO warehouse.customerengagement_fact (customerid, subscriptionstatusid, frequencyofpurchase, numberpreviouspurchase)
    SELECT 
        s.customerid, 
        CASE 
            WHEN s.subscriptionstatus = true THEN 
                (SELECT subscriptionstatusid FROM warehouse.subscriptionstatus WHERE subscriptionstatus = 'Subscribed')
            ELSE 
                (SELECT subscriptionstatusid FROM warehouse.subscriptionstatus WHERE subscriptionstatus = 'Unsubscribed')
        END AS subscriptionstatusid,
        s.frequencyofpurchases,
        s.previouspurchases
    FROM 
        staging.sales s
    JOIN (
        SELECT customerid, MAX(date) AS latest
        FROM staging.sales
        GROUP BY customerid
    ) AS latest_records ON s.customerid = latest_records.customerid AND s.date = latest_records.latest
    ON CONFLICT (subscriptionstatusid, customerid) 
    DO UPDATE SET
        frequencyofpurchase = EXCLUDED.frequencyofpurchase,
        numberpreviouspurchase = EXCLUDED.numberpreviouspurchase;
END;
$BODY$;
ALTER PROCEDURE public.insert_update_cust_eng_fact()
    OWNER TO postgres;
