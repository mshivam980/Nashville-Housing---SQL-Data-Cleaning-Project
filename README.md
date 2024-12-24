# Nashville-Housing---SQL-Data-Cleaning-Project

## Overview
This repository contains SQL scripts for cleaning and transforming real estate data from the Nashville Housing dataset. The scripts demonstrate practical SQL techniques for standardizing formats, handling missing values, splitting data into meaningful components, and removing duplicates to prepare the data for analysis.

---

## Features
### 1. **Standardizing Data Formats**
- Converted `SaleDate` into a consistent `DATE` format.
- Normalized text values in the `Sold as Vacant` field, converting "Y/N" to "Yes/No".

### 2. **Handling Missing Data**
- Populated missing property addresses using existing records via self-joins.

### 3. **Splitting and Structuring Data**
- Split `PropertyAddress` into distinct columns for street and city.
- Extracted components of `OwnerAddress` (e.g., state, city, address) using `PARSENAME`.

### 4. **Removing Duplicates**
- Used a Common Table Expression (CTE) with `ROW_NUMBER()` to identify and delete duplicate rows.

### 5. **Data Refinement**
- Removed unused columns (`OwnerAddress`, `TaxDistrict`, `PropertyAddress`, `SaleDate`) to streamline the dataset.

---

## Skills Demonstrated
- **Data Cleaning**: Formatting fields, handling missing values, and deduplicating.
- **Advanced SQL**: Joins, window functions, conditional logic, and CTEs.
- **Schema Management**: Adding, updating, and dropping columns.

## DataSet Source
- https://www.kaggle.com/code/bvanntruong/nashville-housing-sql-data-cleaning/input
