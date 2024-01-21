-- PROCEDURE: public.update_create_paymentmethod_dimension()

-- DROP PROCEDURE IF EXISTS public.update_create_paymentmethod_dimension();

CREATE OR REPLACE PROCEDURE public.update_create_paymentmethod_dimension(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    -- Insert new payment methods or update existing ones
    INSERT INTO warehouse.paymentmethod (paymentmethodid, paymentmethod)
    SELECT DISTINCT s.paymentmethodid, s.paymentmethod
    FROM staging.sales s
    ON CONFLICT (paymentmethodid) DO UPDATE 
    SET paymentmethod = EXCLUDED.paymentmethod;

    -- If an error occurs, the transaction will be rolled back
    EXCEPTION WHEN OTHERS THEN
        RAISE;
END;
$BODY$;
ALTER PROCEDURE public.update_create_paymentmethod_dimension()
    OWNER TO postgres;
