# Ecommerce-data-warehouse
An end-to-end automated Ecommerce Data Warehouse, encompassing data processing from raw sources to staging, and ultimately to the warehouse, with the implementation of Slowly Changing Dimensions, all powered by a stack that includes PostgreSQL, NoSQL databases, and Python.

This repository contains an end-to-end Ecommerce Data Warehouse solution that automates the process of ingesting, processing, and storing data from raw sources to a fully structured data warehouse. The solution is designed to handle data transformations, implement Slowly Changing Dimensions (SCD), and provide a foundation for business intelligence and analysis. The primary technologies used in this project include PostgreSQL, NoSQL databases, and Python scripts.

## Project Structure

The project is organized into several key components, each responsible for a specific stage in the data processing pipeline:

### 1. Staging Tables

- Staging tables are the first point of entry for raw data.
- Staging tables are created to temporarily store raw data before it undergoes transformation and moves to the data warehouse.
- Raw data is ingested into these staging tables using Python scripts.

### 2. Data Transformation

- Data transformation processes are applied to the data stored in the staging tables.
- These transformations include data cleaning, validation, and formatting.
- The goal is to prepare the data for insertion into the data warehouse and ensure data quality.

### 3. Dimension Tables and Fact Tables

- Dimension tables and fact tables are created in the data warehouse.
- Dimension tables store reference data, providing context for the facts.
- Fact tables store the core transactional data.
- Data from the staging tables is ingested into the appropriate dimension and fact tables.

### 4. Slowly Changing Dimensions (SCD)

- Slowly Changing Dimensions (SCD) are implemented to handle changes in dimension data over time.
- Four types of SCD (0, 1, 2, 3) are implemented, allowing for different strategies to manage historical data.

### 5. Business Intelligence Integration

- A Business Intelligence (BI) tool is integrated with the data warehouse.
- The BI tool enables data analysts and stakeholders to perform data analysis, generate reports, and gain insights from the structured data.

## Installation and Setup

To set up and run this project, follow these steps:

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/ecommerce-data-warehouse.git
cd ecommerce-data-warehouse


Use your BI tool to analyze data, create reports, and gain insights.
Contributing
Contributions to this project are welcome! If you have any improvements or new features to propose, please open an issue or create a pull request.
