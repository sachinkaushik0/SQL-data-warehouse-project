-- =============================================================================
-- Procedure Name   : sp_load_bronze_data
-- Dataset          : DW_bronze
-- Project          : sql-warehouse-nov25
-- Layer            : Bronze (Raw Data Ingestion)
-- Author           : Sachin Kaushik
-- Created On       : 2025-11-05
-- Last Modified On : 2025-11-05
-- =============================================================================
-- Description:
--     This stored procedure ingests raw CSV files from Google Cloud Storage (GCS)
--     into the Bronze layer tables of the Data Warehouse. It handles both CRM and
--     ERP datasets, serving as the first stage of the Medallion Architecture.
--
-- Workflow:
--     1. Load CSV files from GCS into BigQuery bronze tables.
--     2. Each LOAD DATA statement corresponds to one data source (CRM or ERP).
--     3. Skips header rows (skip_leading_rows = 1).
--     4. Designed for daily batch ingestion jobs (can be triggered via Airflow or Scheduler).
--
-- Dependencies:
--     - Cloud Storage bucket: gs://bronze_layer_data/
--     - BigQuery Datasets: DW_bronze, DW_silver, DW_gold
--     - Service Account: must have `roles/storage.objectViewer` and `roles/bigquery.dataEditor`
--
-- Example Execution:
--     CALL `sql-warehouse-nov25.DW_bronze.sp_load_bronze_data`();
--
-- =============================================================================

CREATE OR REPLACE PROCEDURE `sql-warehouse-nov25.DW_bronze.sp_load_bronze_data`()
BEGIN

  -- ======================
  -- CRM Data Ingestion
  -- ======================

  -- Load Customer Info
  LOAD DATA INTO `sql-warehouse-nov25.DW_bronze.crm_cust_info`
  FROM FILES (
    format = 'CSV',
    uris = ['gs://bronze_layer_data/crm_cust_info.csv'],
    skip_leading_rows = 1
  );

  -- Load Product Info
  LOAD DATA INTO `sql-warehouse-nov25.DW_bronze.crm_prd_info`
  FROM FILES (
    format = 'CSV',
    uris = ['gs://bronze_layer_data/crm_prd_info.csv'],
    skip_leading_rows = 1
  );

  -- Load Sales Details
  LOAD DATA INTO `sql-warehouse-nov25.DW_bronze.crm_sales_details`
  FROM FILES (
    format = 'CSV',
    uris = ['gs://bronze_layer_data/crm_sales_details.csv'],
    skip_leading_rows = 1
  );

  -- ======================
  -- ERP Data Ingestion
  -- ======================

  -- Load Customer Master
  LOAD DATA INTO `sql-warehouse-nov25.DW_bronze.erp_cust_az12`
  FROM FILES (
    format = 'CSV',
    uris = ['gs://bronze_layer_data/erp_CUST_AZ12.csv'],
    skip_leading_rows = 1
  );

  -- Load Location Info
  LOAD DATA INTO `sql-warehouse-nov25.DW_bronze.erp_loc_a101`
  FROM FILES (
    format = 'CSV',
    uris = ['gs://bronze_layer_data/erp_LOC_A101.csv'],
    skip_leading_rows = 1
  );

  -- Load Product Catalog
  LOAD DATA INTO `sql-warehouse-nov25.DW_bronze.erp_px_cat_g1v2`
  FROM FILES (
    format = 'CSV',
    uris = ['gs://bronze_layer_data/erp_PX_CAT_G1V2.csv'],
    skip_leading_rows = 1
  );

END;
