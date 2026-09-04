CREATE or ALTER PROCEDURE bronze.load_bronze as
BEGIN
	DECLARE @start_time datetime,@end_time datetime,@batch_stime datetime,@batch_etime datetime
    BEGIN TRY
	    set @batch_stime=GETDATE();
		print'========================================';
		print 'Loading Bronze Layer';
		print'========================================';

		print'----------------------------------------';
		print 'Loading CRM Tables';
		print'----------------------------------------';
		
		set @start_time=GETDATE();
		print'>> Truncating Table:bronze.crm_cst_info';
		truncate table bronze.crm_cst_info
		print'>> Inserting Data Into:bronze.crm_cst_info';
		bulk insert bronze.crm_cst_info
		from "D:\projects\sql-data-warehouse-project\datasets\source_crm\cust_info.csv"
		with(
			firstrow=2,
			fieldterminator=',',
			Tablock
		);
		set @end_time=GETDATE();
		print'>> Load Duration:' + cast(datediff(second,@start_time,@end_time)as nvarchar) + 'seconds';
		print'---------------------------';
		set @start_time=GETDATE();
		print'>> Truncating Table:bronze.crm_prd_info';
		truncate table bronze.crm_prd_info
		print'>> Inserting Data Into:bronze.crm_prd_info';
		bulk insert bronze.crm_prd_info
		from "D:\projects\sql-data-warehouse-project\datasets\source_crm\prd_info.csv"
		with(
			firstrow=2,
			fieldterminator=',',
			Tablock
		);
		set @end_time=GETDATE();
		print'>> Load Duration:' + cast(datediff(second,@start_time,@end_time)as nvarchar) + 'seconds';
		print'-------------';
		set @start_time=GETDATE();
		print'>> Truncating Table:bronze.crm_sales_details';
		truncate table bronze.crm_sales_details
		print'>> Inserting Data Into:bronze.crm_sales_details';
		bulk insert bronze.crm_sales_details
		from "D:\projects\sql-data-warehouse-project\datasets\source_crm\sales_details.csv"
		with(
			firstrow=2,
			fieldterminator=',',
			Tablock
		);
		set @end_time=GETDATE();
		print'>> Load Duration:' + cast(datediff(second,@start_time,@end_time)as nvarchar) + 'seconds';
		print'-------------';

		print'----------------------------------------';
		print 'Loading ERP Tables';
		print'----------------------------------------';
		set @start_time=GETDATE();
		print'>> Truncating Table:bronze.erp_cst_az12';
		truncate table bronze.erp_cst_az12
		print'>> Inserting Data Into:bronze.erp_cst_az12';
		bulk insert bronze.erp_cst_az12
		from "D:\projects\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv"
		with(
			firstrow=2,
			fieldterminator=',',
			Tablock
		);
		set @end_time=GETDATE();
		print'>> Load Duration:' + cast(datediff(second,@start_time,@end_time)as nvarchar) + 'seconds';
		print'-------------------'
		set @start_time=GETDATE();
		print'>> Truncating Table:bronze.erp_loc_a101';
		truncate table bronze.erp_loc_a101
		print'>> Inserting Data Into:bronze.erp_loc_a101';
		bulk insert bronze.erp_loc_a101
		from "D:\projects\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv"
		with(
			firstrow=2,
			fieldterminator=',',
			Tablock
		);
		set @end_time=GETDATE();
		print'>> Load Duration:' + cast(datediff(second,@start_time,@end_time)as nvarchar) + 'seconds';
		print'-------------';
		set @start_time=GETDATE();
		print'>> Truncating Table:bronze.erp_px_cat_g1v2';
		truncate table bronze.erp_px_cat_g1v2
		print'>> Inserting Data Into:bronze.erp_px_cat_g1v2';
		bulk insert bronze.erp_px_cat_g1v2
		from "D:\projects\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv"
		with(
			firstrow=2,
			fieldterminator=',',
			Tablock
		);
		set @end_time=GETDATE();

		print'>> Load Duration:' + cast(datediff(second,@start_time,@end_time)as nvarchar) + 'seconds';
		print'-------------';
		set @batch_etime=GETDATE();
	    print'================================================='
		print 'Loading Bronze Layer is Completed';
		print'>> Total Load Duration: ' + cast(datediff(second,@batch_stime,@batch_etime)as nvarchar) + 'seconds';
		print'================================================='
	END TRY
	BEGIN CATCH
	print'------------------------------------------'
	print'EEROR OCCURED DURING LOADING BRONZE LAYER'
	PRINT'EEROR Message' +  Error_message();
	print'ERROR Message' + cast(Error_number() as nvarchar);
	print'ERROR Message' + cast(Error_state() as nvarchar);
	print'------------------------------------------'
	END CATCH
END