import pandas as pd
import psycopg2
from psycopg2 import Error

def load_csv(file_path):
    return pd.read_csv(file_path)

def load_json(file_path):
    return pd.read_json(file_path)

def insert_into_db(df, table_name, connection):
    with connection.cursor() as cursor:
        for index, row in df.iterrows():
            columns = ', '.join(row.index)
            placeholders = ', '.join(['%s'] * len(row))
            sql = f"INSERT INTO {table_name} ({columns}) VALUES ({placeholders})"
            cursor.execute(sql, tuple(row))
            connection.commit()

def execute_sql(connection, query):
    with connection.cursor() as cursor:
        cursor.execute(query)
        connection.commit()


try:
    connection = psycopg2.connect(
    dbname="ProjectStaging",
    user="postgres",
    password="akhil",
    host="localhost"
)

    # Load data from files into staging tables
    customers_df = load_csv('Path/customers.csv')
    sales_df = load_csv('Path/transformed_data.csv')
    reviews_df = load_json('/Path/reviews.json')

    insert_into_db(customers_df, 'staging.customers', connection)
    insert_into_db(sales_df, 'staging.sales', connection)
    insert_into_db(reviews_df, 'staging.reviews', connection)

    # SQL transformation for staging.customers_transformed
    transformation_query = """
    INSERT INTO staging.customers_transformed (customerid, firstname, lastname, gender, emailaddress, phonenumber, address, membershiplevel, dateofbirth, age, occupation, maritalstatus)
    SELECT
        customerid,
        SPLIT_PART(fullname, ' ', 1) AS firstname,
        CASE 
            WHEN CHAR_LENGTH(fullname) - CHAR_LENGTH(REPLACE(fullname, ' ', '')) > 0 THEN
                SPLIT_PART(fullname, ' ', 2)
            ELSE
                NULL
        END AS lastname,
        gender,
        emailaddress,
        phonenumber,
        address,
        membershiplevel,
        dateofbirth,
        age,
        occupation,
        maritalstatus
    FROM staging.customers
    ON CONFLICT (customerid) DO UPDATE SET
        firstname = EXCLUDED.firstname,
        lastname = EXCLUDED.lastname,
        gender = EXCLUDED.gender,
        emailaddress = EXCLUDED.emailaddress,
        phonenumber = EXCLUDED.phonenumber,
        address = EXCLUDED.address,
        membershiplevel = EXCLUDED.membershiplevel,
        dateofbirth = EXCLUDED.dateofbirth,
        age = EXCLUDED.age,
        occupation = EXCLUDED.occupation,
        maritalstatus = EXCLUDED.maritalstatus;
    """
    
    execute_sql(connection, transformation_query)

except (Exception, Error) as error:
    print("Error while connecting to PostgreSQL", error)
finally:
    if connection:
        connection.close()
        print("PostgreSQL connection is closed")
