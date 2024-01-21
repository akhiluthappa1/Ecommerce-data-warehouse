-- PROCEDURE: public.create_daily_sales_agg_fact()

-- DROP PROCEDURE IF EXISTS public.create_daily_sales_agg_fact();

CREATE OR REPLACE PROCEDURE public.create_daily_sales_agg_fact(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO warehouse.daily_sales_agg_fact (dateid, totalsalesamount, totaltransactions)
    SELECT 
        t.dateid,
        COALESCE(SUM(s.purchaseamountusd), 0) AS totalsalesamount, -- Handle cases with no sales
        COUNT(s.date) AS totaltransactions -- Count only rows with sales
    FROM 
        warehouse.time t
    LEFT JOIN 
        staging.sales s ON t.date = s.date -- Correct join condition
    GROUP BY 
        t.dateid
    ON CONFLICT (dateid)
    DO UPDATE SET
        totalsalesamount = EXCLUDED.totalsalesamount,
        totaltransactions = EXCLUDED.totaltransactions;
END;
$BODY$;
ALTER PROCEDURE public.create_daily_sales_agg_fact()
    OWNER TO postgres;
