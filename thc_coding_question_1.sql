SELECT *
FROM `bigquery-public-data.crypto_bitcoin_cash.transactions`
WHERE DATE(block_timestamp) BETWEEN DATE_SUB(CURRENT_DATE(), INTERVAL 3 MONTH) AND CURRENT_DATE()
ORDER BY block_timestamp ASC
