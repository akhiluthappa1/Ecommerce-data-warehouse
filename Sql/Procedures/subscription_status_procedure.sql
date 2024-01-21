-- PROCEDURE: public.update_subscriptionstatus_dimension_scd1()

-- DROP PROCEDURE IF EXISTS public.update_subscriptionstatus_dimension_scd1();

CREATE OR REPLACE PROCEDURE public.update_subscriptionstatus_dimension_scd1(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    -- Insert new subscription status descriptions from staging to warehouse if they don't exist
    INSERT INTO warehouse.subscriptionstatus (subscriptionstatus)
    SELECT DISTINCT 
        CASE 
            WHEN s.subscriptionstatus = true THEN 'Subscribed'
            ELSE 'Unsubscribed'
        END AS subscriptionstatus_text
    FROM staging.sales s
    LEFT JOIN warehouse.subscriptionstatus w 
        ON w.subscriptionstatus = CASE 
                                    WHEN s.subscriptionstatus = true THEN 'Subscribed'
                                    ELSE 'Unsubscribed'
                                 END
    WHERE w.subscriptionstatus IS NULL;

    -- If an error occurs, the transaction will be rolled back
    EXCEPTION WHEN OTHERS THEN
        RAISE;
END;
$BODY$;
ALTER PROCEDURE public.update_subscriptionstatus_dimension_scd1()
    OWNER TO postgres;
