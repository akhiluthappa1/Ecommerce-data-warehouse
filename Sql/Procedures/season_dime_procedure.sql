-- PROCEDURE: public.update_season_dimension()

-- DROP PROCEDURE IF EXISTS public.update_season_dimension();

CREATE OR REPLACE PROCEDURE public.update_season_dimension(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    -- Insert new unique seasons from the staging.sales table into the warehouse.season table if they don't exist
    INSERT INTO warehouse.season (season)
    SELECT DISTINCT s.season
    FROM staging.sales s
    WHERE NOT EXISTS (
        SELECT 1 FROM warehouse.season w WHERE LOWER(w.season) = LOWER(s.season)
    );

    -- If an error occurs, the transaction will be rolled back
    EXCEPTION WHEN OTHERS THEN
        RAISE;
END;
$BODY$;
ALTER PROCEDURE public.update_season_dimension()
    OWNER TO postgres;
