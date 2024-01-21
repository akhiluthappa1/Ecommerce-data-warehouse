-- PROCEDURE: public.update_insert_shippingtype_dimension()

-- DROP PROCEDURE IF EXISTS public.update_insert_shippingtype_dimension();

CREATE OR REPLACE PROCEDURE public.update_insert_shippingtype_dimension(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    -- Insert new shipping types from the staging.sales table into the warehouse if they don't exist
    INSERT INTO warehouse.shippingtype (shippingtype)
    SELECT DISTINCT s.shippingtype
    FROM staging.sales s
    LEFT JOIN warehouse.shippingtype w ON w.shippingtype = s.shippingtype
    WHERE w.shippingtypeid IS NULL;

    -- Optionally update existing shipping types if there are any changes
    -- This step might not be necessary unless there's a need to standardize or correct shipping type names
    UPDATE warehouse.shippingtype w
    SET shippingtype = s.shippingtype
    FROM staging.sales s
    WHERE w.shippingtype = s.shippingtype
    AND w.shippingtype != s.shippingtype;

    -- If an error occurs, the transaction will be rolled back
    EXCEPTION WHEN OTHERS THEN
        RAISE;
END;
$BODY$;
ALTER PROCEDURE public.update_insert_shippingtype_dimension()
    OWNER TO postgres;
