-- PROCEDURE: public.insert_time_dimension()

-- DROP PROCEDURE IF EXISTS public.insert_time_dimension();

CREATE OR REPLACE PROCEDURE public.insert_time_dimension(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    -- Insert new dates into the warehouse.time table only if they don't exist
    INSERT INTO warehouse.time (date, day, month, quarter, year)
    SELECT
        unique_dates.date,
        EXTRACT(DAY FROM unique_dates.date) AS day,
        EXTRACT(MONTH FROM unique_dates.date) AS month,
        EXTRACT(QUARTER FROM unique_dates.date) AS quarter,
        EXTRACT(YEAR FROM unique_dates.date) AS year
    FROM (
        SELECT DISTINCT date FROM staging.sales
        UNION
        SELECT DISTINCT reviewdate FROM staging.reviews
        UNION
        SELECT DISTINCT dateofbirth FROM staging.customers_transformed
    ) AS unique_dates
    WHERE NOT EXISTS (
        SELECT 1 FROM warehouse.time t WHERE t.date = unique_dates.date
    );

    -- If an error occurs, the transaction will be rolled back
    EXCEPTION WHEN OTHERS THEN
        RAISE;
END;
$BODY$;
ALTER PROCEDURE public.insert_time_dimension()
    OWNER TO postgres;
