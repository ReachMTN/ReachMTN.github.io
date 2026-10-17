-- Phone resale analytics; synthetic sample rows only.
-- iPhone 18 Pro Max: preorder Sep 12, 2026; retail availability Sep 18, 2026.
-- MSRP: 256GB $1,299; 512GB $1,499; 1TB $1,899; 2TB $2,499.
-- iPhone Duo: preorder Oct 16, 2026; retail availability Oct 23, 2026.
-- MSRP: 256GB $1,999; 512GB $2,199; 1TB $2,599; 2TB $3,199.

SELECT model, storage, status, COUNT(*) AS units, SUM(cost) AS purchase_cost,
       SUM(resale) AS target_resale_value, SUM(profit) AS target_gross_profit,
       AVG(profit) AS avg_target_profit_per_unit
FROM phone_transactions GROUP BY model, storage, status ORDER BY model, storage, status;

SELECT date, product, color, status, cost, resale, profit
FROM phone_transactions WHERE model IN ('iPhone 18 Pro Max','iPhone Duo')
ORDER BY date DESC, model, storage;
