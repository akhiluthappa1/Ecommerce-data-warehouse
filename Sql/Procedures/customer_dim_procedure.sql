-- PROCEDURE: public.update_insert_customer_dimension()

-- DROP PROCEDURE IF EXISTS public.update_insert_customer_dimension();

CREATE OR REPLACE PROCEDURE public.update_insert_customer_dimension(
	)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    -- Update existing records in the warehouse that have changes in the staging table.
    -- This sets 'valid_to' to the current date and 'is_current' to false.
    UPDATE warehouse.customers w
    SET 
        valid_to = CURRENT_DATE,
        is_current = false
    FROM staging.customers_transformed s
    WHERE w.customerid = s.customerid
    AND w.is_current = true
    AND (
        w.firstname != s.firstname OR
        w.lastname != s.lastname OR
        w.gender != s.gender OR
        w.email != s.emailaddress OR
        w.phone != s.phonenumber OR
        w.address != s.address OR
        w.membershiplevel != s.membershiplevel OR
        w.dob != s.dateofbirth OR
        w.occupation != s.occupation OR
        w.maritalstatus != s.maritalstatus
    );

    -- Insert new current records for those changes.
    INSERT INTO warehouse.customers (
        customerid,
        firstname,
        lastname,
        gender,
        email,
        phone,
        address,
        membershiplevel,
        dob,
        age,
        occupation,
        maritalstatus,
        valid_from,
        is_current
    )
    SELECT
        s.customerid,
        s.firstname,
        s.lastname,
        s.gender,
        s.emailaddress,
        s.phonenumber,
        s.address,
        s.membershiplevel,
        s.dateofbirth,
        s.age,
        s.occupation,
        s.maritalstatus,
        CURRENT_DATE AS valid_from,
        true AS is_current
    FROM staging.customers_transformed s
    LEFT JOIN warehouse.customers w ON s.customerid = w.customerid AND w.is_current = true
    WHERE w.customerid IS NULL OR (
        w.is_current = true AND (
            w.firstname != s.firstname OR
            w.lastname != s.lastname OR
            w.gender != s.gender OR
            w.email != s.emailaddress OR
            w.phone != s.phonenumber OR
            w.address != s.address OR
            w.membershiplevel != s.membershiplevel OR
            w.dob != s.dateofbirth OR
            w.occupation != s.occupation OR
            w.maritalstatus != s.maritalstatus
        )
    );

    -- If an error occurs, the transaction will be rolled back
    EXCEPTION WHEN OTHERS THEN
        RAISE;
END;
$BODY$;
ALTER PROCEDURE public.update_insert_customer_dimension()
    OWNER TO postgres;
