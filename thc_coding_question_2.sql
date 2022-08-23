WITH double_entry_book AS (
SELECT
array_to_string(inputs.addresses, ",") as address
, inputs.type
, -inputs.value AS value
, is_coinbase
FROM `bigquery-public-data.crypto_bitcoin_cASh.transactions`,UNNEST(inputs) AS inputs
UNION ALL
SELECT
array_to_string(outputs.addresses, ",") AS address
, outputs.type
, outputs.value AS value
, is_coinbase
FROM `bigquery-public-data.crypto_bitcoin_cASh.transactions`,UNNEST(outputs) AS outputs
)
SELECT
address
, type
, SUM(value) AS balance
FROM double_entry_book
WHERE
NOT is_coinbase
GROUP BY 1,2
ORDER BY balance DESC