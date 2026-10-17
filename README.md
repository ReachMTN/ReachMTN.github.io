# iPhone Checkout Analytics — Portfolio Project

## Project goal
Build an analytics dashboard inspired by a checkout analytics screenshot. The goal is to monitor spending, checkout volume, savings, failures, product mix, and daily trends.

## Important data note
The supplied CSV contains **synthetic demonstration records**, not the private records shown in the screenshot. The screenshot visibly showed aggregate values of approximately $43.98K spent, $0 saved, 21 checkouts, and 0 failures. The CSV is a practice dataset with 21 demo rows at $2,000 each, so its totals will not exactly reproduce every screenshot metric. Do not present the synthetic detail rows as actual purchase history.

## Files
- `checkout_transactions_sample.csv` — synthetic data for importing into Power BI or SQL Server.
- `checkout_analytics.sql` — SQL Server table definition, KPI queries, trend queries, and data-quality checks.
- `dashboard_mockup.html` — standalone interactive dashboard mockup that runs in a browser without a server.
- `powerbi_build_guide.md` — step-by-step Power BI build notes and DAX measures.

## Suggested Power BI report layout
1. KPI cards: Total Spend, Total Saved, Checkouts, Failed Checkouts.
2. Line chart: daily spend by checkout date.
3. Bar chart: spend by product / color.
4. Table: recent checkouts (keep personal/account identifiers out of a public portfolio).
5. Slicers: date, product color, retailer, status.

## Suggested portfolio description
**iPhone Checkout Analytics Dashboard | Power BI, SQL, Excel**
Created a checkout analytics project to monitor spend, transaction volume, savings, failures, and product-level trends. Designed a SQL Server data model and validation queries, then defined Power BI KPIs and trend visuals to make purchase activity easier to review. Used synthetic data for the public demonstration to protect private transaction information.

## How to use
1. Open the CSV in Excel to review the sample rows.
2. Import the CSV into SQL Server and run the SQL script (adjust the import method to your environment).
3. In Power BI Desktop, select **Get data → Text/CSV** and load the CSV, or connect to the SQL Server table after importing.
4. Follow `powerbi_build_guide.md` to create the report.
5. Open `dashboard_mockup.html` in a browser for the standalone visual concept.
