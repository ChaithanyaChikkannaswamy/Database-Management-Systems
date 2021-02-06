USE MDUrgentCare;
BEGIN TRAN
UPDATE MedicationInventory
SET StockDescription = 'Stock Low'
WHERE InStockQuantity < 200; Select * from MedicationInventory