# 🥉 Bronze Layer – Raw Data Ingestion

## Overview
The Bronze Layer serves as the raw landing zone for all incoming data from operational systems (CRM and ERP).
Data is ingested as-is into BigQuery for further refinement in the Silver layer.

This layer consists of two main components:

- DDL Scripts – Initialize datasets and tables.
- Stored Procedures – Load raw CSV files into the Bronze tables.

---

## 📁 DDL Scripts – Table Initialization

File: bronze/ddl/create_bronze_tables.sql

Purpose:

- Creates the dataset DW_bronze if it does not exist.
- Creates all raw tables for CRM and ERP data.

Tables Created:
```markdown
System	Table Name	Description
CRM	crm_cust_info	Customer master details
CRM	crm_prd_info	Product master details
CRM	crm_sales_details	Sales transactions
ERP	erp_cust_az12	ERP customer reference
ERP	erp_loc_a101	Location/branch metadata
ERP	erp_px_cat_g1v2	Product category catalog
```
Execution:

-- Initialize Bronze Layer tables
RUN `bronze/ddl/create_bronze_tables.sql`

---

## ⚙️ Procedure: `sp_load_bronze_data`

**Purpose:**  
Automates ingestion of raw CSV files from GCS into BigQuery bronze tables.

**Execution:**
```sql
CALL `sql-warehouse-nov25.DW_bronze.sp_load_bronze_data`();
```
## Dependencies:

- Bucket: gs://bronze_layer_data/

- Service Account roles:

  - roles/storage.objectViewer

  - roles/bigquery.dataEditor

## 🧩 Integration

This stored procedure is designed to be triggered by:

- Airflow DAGs (for daily batch loads)

- BigQuery Scheduled Queries (for hourly/daily updates)

Example Airflow task snippet:
```
bq_operator = BigQueryInsertJobOperator(
    task_id="load_bronze_data",
    configuration={
        "query": {
            "query": "CALL `sql-warehouse-nov25.DW_bronze.sp_load_bronze_data`()",
            "useLegacySql": False,
        }
    },
)
```
## 🪄 Next Steps

-  Silver Layer: Data cleansing, normalization, and deduplication

- Gold Layer: Business-ready reporting marts and aggregates

## 🧑‍💻 Author

Sachin Kaushik
Toronto, ON
📧 sachinkaushikca@gmail.com

🔗 LinkedIn - https://www.linkedin.com/in/sachinkaushik7707/
