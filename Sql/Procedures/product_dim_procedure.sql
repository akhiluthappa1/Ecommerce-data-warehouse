-- PROCEDURE: public.update_insert_product_dimension()

-- DROP PROCEDURE IF EXISTS public.update_insert_product_dimension();

CREATE OR REPLACE PROCEDURE public.update_insert_product_dimension(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    -- Update existing product records with the new category 
    -- and move the old category to previous_category if there is a change
    UPDATE warehouse.product w
    SET 
        previous_category = w.category,
        category = s.category
    FROM staging.sales s
    WHERE w.itempurchased = s.itempurchased
    AND w.size = s.size
    AND w.color = s.color
    AND w.category IS DISTINCT FROM s.category;

    -- Insert new products
    INSERT INTO warehouse.product (itempurchased, category, size, color)
    SELECT DISTINCT s.itempurchased, s.category, s.size, s.color
    FROM staging.sales s
    LEFT JOIN warehouse.product w ON 
        w.itempurchased = s.itempurchased AND 
        w.category = s.category AND 
        w.size = s.size AND 
        w.color = s.color
    WHERE w.productid IS NULL;

    -- If an error occurs, the transaction will be rolled back
    EXCEPTION WHEN OTHERS THEN
        RAISE;
END;
$BODY$;
ALTER PROCEDURE public.update_insert_product_dimension()
    OWNER TO postgres;
