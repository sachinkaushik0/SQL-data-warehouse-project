# 🥉 Bronze Layer – Raw Data Ingestion

## Overview
The Bronze Layer serves as the raw landing zone for all incoming data from operational systems (CRM, ERP, and external sources).  
Data is ingested **as-is** from Google Cloud Storage (GCS) into BigQuery for further refinement.

---

## 📁 Data Sources

| System | File Name | Target Table | Description |
|---------|------------|---------------|-------------|
| CRM | crm_cust_info.csv | crm_cust_info | Customer master details |
| CRM | crm_prd_info.csv | crm_prd_info | Product master details |
| CRM | crm_sales_details.csv | crm_sales_details | Sales transactions |
| ERP | erp_CUST_AZ12.csv | erp_cust_az12 | ERP customer reference |
| ERP | erp_LOC_A101.csv | erp_loc_a101 | Location/branch metadata |
| ERP | erp_PX_CAT_G1V2.csv | erp_px_cat_g1v2 | Product category catalog |

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
