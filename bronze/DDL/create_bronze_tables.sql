-- =============================================================================
-- File: create_bronze_tables.sql
-- Purpose: Initialize Bronze Layer Tables in BigQuery
-- Project: sql-warehouse-nov25
-- Dataset: DW_bronze
-- Author: Sachin Kaushik
-- Created: 2025-11-05
-- Notes: This script can be run once to create tables before loading CSVs
-- =============================================================================

-- Create dataset if not exists
CREATE SCHEMA IF NOT EXISTS `sql-warehouse-nov25.DW_bronze`;

-- =========================
-- CRM Tables
-- =========================

CREATE TABLE IF NOT EXISTS `sql-warehouse-nov25.DW_bronze.crm_cust_info` (
    cst_id STRING,
    cst_key STRING,
    cst_firstname STRING,
    cst_lastname STRING,
    cst_marital_status STRING,
    cst_gndr STRING,
    cst_create_date DATE
);

CREATE TABLE IF NOT EXISTS `sql-warehouse-nov25.DW_bronze.crm_prd_info` (
    prd_id STRING,
    prd_name STRING,
    prd_category STRING,
    prd_create_date DATE
);

CREATE TABLE IF NOT EXISTS `sql-warehouse-nov25.DW_bronze.crm_sales_details` (
    sales_id STRING,
    cst_id STRING,
    prd_id STRING,
    sales_amount NUMERIC,
    sales_date DATE
);

-- =========================
-- ERP Tables
-- =========================

CREATE TABLE IF NOT EXISTS `sql-warehouse-nov25.DW_bronze.erp_cust_az12` (
    cust_id STRING,
    cust_name STRING,
    cust_type STRING,
    region STRING
);

CREATE TABLE IF NOT EXISTS `sql-warehouse-nov25.DW_bronze.erp_loc_a101` (
    loc_id STRING,
    loc_name STRING,
    loc_region STRING
);

CREATE TABLE IF NOT EXISTS `sql-warehouse-nov25.DW_bronze.erp_px_cat_g1v2` (
    prod_id STRING,
    prod_name STRING,
    prod_category STRING
);
