# Power BI Build Guide — Phone Resale & Inventory Analytics

## 1. Load the data
Use **Get data → Text/CSV** and select `checkout_transactions_sample.csv`. The dataset contains 48 synthetic inventory/resale records across several iPhone models, storage capacities, and colors. Alternatively, load it into SQL Server using `checkout_analytics.sql` and connect Power BI to `dbo.PhoneInventoryTransactions`.

## 2. Set data types
- `checkout_datetime`: Date/Time
- `storage_gb`, `units`: Whole number
- `purchase_cost_usd`, `resale_price_usd`, `gross_profit_usd`: Fixed decimal number / Currency
- Other descriptive fields: Text

Create a date-only column:
```DAX
Transaction Date = DATE(
    YEAR('PhoneInventoryTransactions'[checkout_datetime]),
    MONTH('PhoneInventoryTransactions'[checkout_datetime]),
    DAY('PhoneInventoryTransactions'[checkout_datetime])
)
```

## 3. Create measures
```DAX
Acquisition Cost = SUM('PhoneInventoryTransactions'[purchase_cost_usd])

Estimated Resale Revenue = SUM('PhoneInventoryTransactions'[resale_price_usd])

Gross Profit Potential = SUM('PhoneInventoryTransactions'[gross_profit_usd])

Units = SUM('PhoneInventoryTransactions'[units])

Average Gross Profit per Unit = DIVIDE([Gross Profit Potential], [Units], 0)

Gross Margin % = DIVIDE([Gross Profit Potential], [Estimated Resale Revenue], 0)
```

## 4. Recommended visuals
- Four cards: `[Acquisition Cost]`, `[Estimated Resale Revenue]`, `[Gross Profit Potential]`, `[Units]`
- Line chart: Axis = `Transaction Date`; Values = acquisition cost and estimated resale revenue
- Bar chart: Axis = `product_model`; Values = `[Gross Profit Potential]`
- Table: `product_name`, `product_color`, `status`, `purchase_cost_usd`, `resale_price_usd`, `gross_profit_usd`
- Slicers: `Transaction Date`, `product_model`, `storage_gb`, `product_color`, `status`

## 5. Formatting
Use a black / charcoal background, white labels, electric blue and green chart series, and subtle borders to match the portfolio theme. Format all financial measures as USD.

## 6. Data note
All inventory rows, sourcing discounts, resale prices, and margins are synthetic portfolio examples, not actual sales or guaranteed market prices. Gross profit excludes fees, taxes, shipping, returns, and other operating expenses. Check current purchase costs and actual resale demand before making business decisions.
