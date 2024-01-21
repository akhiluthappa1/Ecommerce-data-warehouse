import psycopg2
from psycopg2 import Error

def execute_stored_procedure(connection, proc_name):
    cursor = connection.cursor()
    cursor.execute(f"CALL {proc_name}();")
    connection.commit()
    cursor.close()
    print(f"Executed stored procedure: {proc_name}")

def clear_staging_tables(connection):
    cursor = connection.cursor()
    cursor.execute("DELETE FROM staging.sales;")
    cursor.execute("DELETE FROM staging.customers_transformed;")
    cursor.execute("DELETE FROM staging.reviews;")
    cursor.execute("DELETE FROM staging.customers;")
    connection.commit()
    cursor.close()
    print("Cleared staging tables")

try:
    connection = psycopg2.connect(
        dbname="ProjectStaging",
        user="postgres",
        password="akhil",
        host="localhost"
    )

    stored_procedures = [
        'update_insert_customer_dimension', 
        'update_insert_product_dimension',
        'update_insert_location_dimension',
        'update_insert_shippingtype_dimension',
        'update_season_dimension',
        'update_subscriptionstatus_dimension_scd1',
        'insert_time_dimension',
        'update_create_paymentmethod_dimension',
        'insert_update_sales_fact',
        'create_daily_sales_agg_fact',
        'insert_update_cust_eng_fact'
    ]

    for proc in stored_procedures:
        execute_stored_procedure(connection, proc)

    clear_staging_tables(connection)

except (Exception, Error) as error:
    print("Error while connecting to PostgreSQL", error)
finally:
    if connection:
        connection.close()
        print("PostgreSQL connection is closed")
