SELECT * --select all columns 
FROM `bigquery-public-data.crypto_bitcoin_cash.transactions` --set dataset source
WHERE DATE(block_timestamp) BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 3 MONTH) AND CURRENT_DATE() 
--set 3 months interval between the current time at the moment and the past
ORDER BY block_timestamp ASC
--sort by timestamp from the past
