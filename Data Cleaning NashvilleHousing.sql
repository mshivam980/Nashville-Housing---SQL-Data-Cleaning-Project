/*
Cleaning Data in SQL Queries
*/

SELECT *
FROM 
	PortfolioProject.dbo.[Nashville Housing]

------------------------------------------------------------------------------------------

-- Standardize Data Format

SELECT 
	SaleDate, CONVERT(date,SaleDate)
FROM 
	PortfolioProject.dbo.[Nashville Housing]

UPDATE [Nashville Housing]
SET SaleDate=CONVERT(date,SaleDate)

Select *
From PortfolioProject.dbo.[Nashville Housing]

------------------------------------------------------------------------------------------

-- Populate Property Address Data

SELECT A.ParcelID,A.PropertyAddress,B.ParcelID,B.PropertyAddress, ISNULL(A.PropertyAddress,B.PropertyAddress)
FROM PortfolioProject.dbo.[Nashville Housing] A 
JOIN 
	PortfolioProject.dbo.[Nashville Housing] B
	ON 
	A.ParcelID=B.ParcelID AND A.[UniqueID ]!=B.[UniqueID ]
	WHERE A.PropertyAddress IS NULL 

UPDATE a 
SET PropertyAddress= ISNULL(A.PropertyAddress,B.PropertyAddress)
FROM PortfolioProject.dbo.[Nashville Housing] A 
JOIN 
	PortfolioProject.dbo.[Nashville Housing] B
	ON 
	A.ParcelID=B.ParcelID AND A.[UniqueID ]!=B.[UniqueID ]
	WHERE A.PropertyAddress IS NULL 

Select *
From PortfolioProject.dbo.[Nashville Housing]

------------------------------------------------------------------------------------------

--  Breaking Address into Individual Columns (Address, City, State)

SELECT PropertyAddress, SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+2,LEN(PropertyAddress)),SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)
FROM PortfolioProject.dbo.[Nashville Housing]

ALTER TABLE PortfolioProject.dbo.[Nashville Housing]
ADD PropertySplitCity Nvarchar(255)

UPDATE [Nashville Housing]
SET PropertySplitCity=SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+2,LEN(PropertyAddress))

ALTER TABLE PortfolioProject.dbo.[Nashville Housing]
ADD PropertySplitAddress Nvarchar(255)

UPDATE [Nashville Housing]
SET PropertySplitAddress=SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1)

Select *
From PortfolioProject.dbo.[Nashville Housing]


SELECT OwnerAddress,PARSENAME(REPLACE(OwnerAddress,',','.'),3),PARSENAME(REPLACE(OwnerAddress,',','.'),2),PARSENAME(REPLACE(OwnerAddress,',','.'),1)
FROM PortfolioProject.dbo.[Nashville Housing]

ALTER TABLE PortfolioProject.dbo.[Nashville Housing]
ADD OwnerSplitSate Nvarchar(255)

ALTER TABLE PortfolioProject.dbo.[Nashville Housing]
ADD OwnerSplitCity Nvarchar(255)

ALTER TABLE PortfolioProject.dbo.[Nashville Housing]
ADD OwnerSplitAddress Nvarchar(255)

UPDATE [Nashville Housing]
SET OwnerSplitAddress=PARSENAME(REPLACE(OwnerAddress,',','.'),3)

UPDATE [Nashville Housing]
SET OwnerSplitCity=PARSENAME(REPLACE(OwnerAddress,',','.'),2)

UPDATE [Nashville Housing]
SET OwnerSplitSate=PARSENAME(REPLACE(OwnerAddress,',','.'),1)

Select *
From PortfolioProject.dbo.[Nashville Housing]


------------------------------------------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant" field

Select DISTINCT SoldAsVacant
From PortfolioProject.dbo.[Nashville Housing]

Select SoldAsVacant
, CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
From PortfolioProject.dbo.[Nashville Housing]

Update [Nashville Housing]
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END


Select *
From PortfolioProject.dbo.[Nashville Housing]

------------------------------------------------------------------------------------------

-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From PortfolioProject.dbo.[Nashville Housing]
--order by ParcelID
)
Select *
From RowNumCTE
Where row_num > 1
Order by PropertyAddress


WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From PortfolioProject.dbo.[Nashville Housing]
--order by ParcelID
)
DELETE
From RowNumCTE
Where row_num > 1


Select *
From PortfolioProject.dbo.[Nashville Housing]

---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns

Select *
From PortfolioProject.dbo.[Nashville Housing]

ALTER TABLE PortfolioProject.dbo.[Nashville Housing]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

