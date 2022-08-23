WITH double_entry_book AS ( --pre-select data from input&outputs for later calculating balance later   
SELECT
array_to_string(inputs.addresses, ",") AS address --transaction address, convert array to string for grouping
, inputs.type --types of transaction addresses
, -inputs.value AS value --set inputs value as negative to subtract from outputs value
, is_coinbase --column for identifying coinbase transactions
FROM `bigquery-public-data.crypto_bitcoin_cash.transactions`, UNNEST(inputs) AS inputs --unpack nested field inputs 
UNION ALL --combine the results from the 2 select statements
SELECT
array_to_string(outputs.addresses, ",") AS address --transaction address, convert array to string for grouping
, outputs.type --types of transaction addresses
, outputs.value AS value --outputs transaction value
, is_coinbase --column for identifying coinbase transactions
FROM `bigquery-public-data.crypto_bitcoin_cash.transactions`, UNNEST(outputs) AS outputs --unpack nested field outputs 
)
SELECT
address --predefined above
, type --predefined above
, SUM(value) AS balance -- outputs value plus native inputs value
FROM double_entry_book
WHERE
NOT is_coinbase --exclude coinbase transactions
GROUP BY 1,2 --group by address and address type column
ORDER BY balance DESC --sort by the value of balance
