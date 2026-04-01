--- Esponi lʼelenco delle transazioni di vendita indicando la categoria di appartenenza di ciascun prodotto venduto.
SELECT
    frs.SalesOrderNumber,
    frs.SalesOrderLineNumber,
    frs.OrderDate,
    p.EnglishProductName AS NomeProdotto,
    c.EnglishProductCategoryName AS CategoriaProdotto
FROM FactResellerSales frs
JOIN DimProduct p
    ON frs.ProductKey = p.ProductKey
JOIN DimProductSubcategory sc
    ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey
JOIN DimProductCategory c
    ON sc.ProductCategoryKey = c.ProductCategoryKey;
--- Esplora la tabella DimReseller.
SELECT *FROM DimReseller;
--- Esponi in output lʼelenco dei reseller indicando, per ciascun reseller, anche la sua area geografica. 
SELECT
    r.ResellerKey,
    r.ResellerName,
    g.City AS Città,
    g.StateProvinceName AS Provincia,
    g.CountryRegionCode AS Paese
FROM DimReseller r
JOIN DimGeography g
    ON r.GeographyKey = g.GeographyKey;
    
--- Esponi lʼelenco delle transazioni di vendita. 
--- Il result set deve esporre i campi: SalesOrderNumber, SalesOrderLineNumber, OrderDate, UnitPrice, Quantity, TotalProductCost.
--- Il result set deve anche indicare il nome del prodotto, il nome della categoria del prodotto, il nome del reseller e lʼarea geografica.
SELECT
    frs.SalesOrderNumber,
    frs.SalesOrderLineNumber,
    frs.OrderDate,
    frs.UnitPrice,
    frs.OrderQuantity AS Quantity,
    frs.TotalProductCost,

    p.EnglishProductName AS NomeProdotto,
    c.EnglishProductCategoryName AS CategoriaProdotto,

    r.ResellerName AS NomeRivenditore,

    g.City AS Città,
    g.StateProvinceName AS Provincia,
    g.CountryRegionCode AS Paese

FROM FactResellerSales frs

JOIN DimProduct p
    ON frs.ProductKey = p.ProductKey 
--- Collega la vendita al prodotto venduto.

JOIN DimProductSubcategory sc
    ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey  
--- Serve per risalire alla categoria.

JOIN DimProductCategory c
    ON sc.ProductCategoryKey = c.ProductCategoryKey
--- Otteniamo la categoria del prodotto.

JOIN DimReseller r
    ON frs.ResellerKey = r.ResellerKey
--- Collega la vendita al rivenditore.

JOIN DimGeography g
    ON r.GeographyKey = g.GeographyKey;
--- Otteniamo città, provincia e paese del rivenditore.
