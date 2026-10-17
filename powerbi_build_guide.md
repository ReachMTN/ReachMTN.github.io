# Power BI Build Guide

## 1. Load the data
For a quick start, use **Get data → Text/CSV** and select `checkout_transactions_sample.csv`.
For the SQL workflow, load the CSV into SQL Server, run `checkout_analytics.sql`, then connect Power BI to `dbo.CheckoutTransactions`.

## 2. Set data types
- `checkout_datetime`: Date/Time
- `price_usd`, `saved_usd`: Fixed decimal number / Currency
- `failure_flag`: Whole number
- Other fields: Text

Create a date-only column:
```DAX
Checkout Date = DATE(
    YEAR('CheckoutTransactions'[checkout_datetime]),
    MONTH('CheckoutTransactions'[checkout_datetime]),
    DAY('CheckoutTransactions'[checkout_datetime])
)
```

## 3. Create measures
```DAX
Total Spent = SUM('CheckoutTransactions'[price_usd])

Total Saved = SUM('CheckoutTransactions'[saved_usd])

Total Checkouts = DISTINCTCOUNT('CheckoutTransactions'[checkout_id])

Failed Checkouts =
CALCULATE(
    DISTINCTCOUNT('CheckoutTransactions'[checkout_id]),
    'CheckoutTransactions'[failure_flag] = 1
)

Failure Rate =
DIVIDE([Failed Checkouts], [Total Checkouts], 0)

Average Checkout Value =
DIVIDE([Total Spent], [Total Checkouts], 0)
```

## 4. Recommended visuals
- Four cards: `[Total Spent]`, `[Total Saved]`, `[Total Checkouts]`, `[Failed Checkouts]`
- Line chart: Axis = `Checkout Date`; Values = `[Total Spent]`
- Bar chart: Axis = `product_color`; Values = `[Total Spent]`
- Table: `checkout_datetime`, `product_name`, `price_usd`, `retailer`, `status`
- Slicers: `Checkout Date`, `product_color`, `retailer`, `status`

## 5. Formatting
Use a black / charcoal background, white labels, electric blue line, and subtle borders to match the reference dashboard. Use consistent currency formatting (USD) and display dates in a readable format.

## 6. Public portfolio privacy
The screenshot contains blurred profile, account, and order fields. Do not publish those real identifiers. Use the supplied synthetic CSV or anonymize all transaction-level information before publishing.
