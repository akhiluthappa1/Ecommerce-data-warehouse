-- PROCEDURE: public.update_insert_location_dimension()

-- DROP PROCEDURE IF EXISTS public.update_insert_location_dimension();

CREATE OR REPLACE PROCEDURE public.update_insert_location_dimension(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    INSERT INTO warehouse.location (location)
    SELECT DISTINCT INITCAP(ss.standardized_name)
    FROM staging.sales s
    JOIN staging.location_standardization ss ON LOWER(ss.original_name) = LOWER(s.location) -- Updated column name
    LEFT JOIN warehouse.location w ON w.location = INITCAP(ss.standardized_name)
    WHERE w.location IS NULL;

    UPDATE warehouse.location w
    SET location = INITCAP(ss.standardized_name)
    FROM staging.sales s
    JOIN staging.location_standardization ss ON LOWER(ss.original_name) = LOWER(s.location) -- Updated column name
    WHERE LOWER(w.location) = LOWER(ss.original_name)
    AND w.location != INITCAP(ss.standardized_name);

    EXCEPTION WHEN OTHERS THEN
        RAISE;
END;
$BODY$;
ALTER PROCEDURE public.update_insert_location_dimension()
    OWNER TO postgres;
