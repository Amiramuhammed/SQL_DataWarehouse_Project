# SQL_DataWarehouse_Project

## 📖 Project Overview
This project demonstrates the design and implementation of an end-to-end Modern Data Warehouse built using Microsoft SQL Server. The project follows the Medallion Architecture pattern to process raw data into business-ready analytics assets, covering everything from ETL design and data modeling to reporting.

## 🏗️ Data Architecture
The data architecture for this project follows Medallion Architecture (Bronze, Silver, and Gold layers):

1-Bronze Layer: Stores raw data as-is from the source systems. Data is ingested from CSV files into the SQL Server database.

2-Silver Layer: Includes data cleansing, standardization, and normalization processes to prepare data for analysis.

3-Gold Layer: Houses business-ready data modeled into a star schema required for reporting and analytics.
