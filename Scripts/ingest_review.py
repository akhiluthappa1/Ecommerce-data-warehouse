import json
import psycopg2

# Connection parameters - replace these with your actual parameters
conn = psycopg2.connect(
    dbname="ProjectStaging",
    user="postgres",
    password="akhil",
    host="localhost"
)
cur = conn.cursor()

# Load the JSON data from the file
# Note: Ensure the file path is correct for your operating system and environment
with open('/Users/akhil/Desktop/BOSTON UNIVERSITY/ASSIGNMENTS/CS 779/Project/Final_stuff/review.json', 'r') as file:
    reviews = json.load(file)

# Insert data into the table
for review in reviews:
    cur.execute("""
        INSERT INTO staging.reviews (reviewid, customerid, itempurchased, reviewdate, reviewtext, reviewrating, reviewhelpfulvotes)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    """, (
        review["reviewid"],
        review["customerid"],
        review["itempurchased"],
        review["reviewdate"],
        review["reviewtext"],
        review["reviewrating"],
        review["reviewhelpfulvotes"]
    ))

# Commit changes and close the connection
conn.commit()
cur.close()
conn.close()
