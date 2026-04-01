--- Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria DimProduct, DimProductSubcategory
SELECT
    p.ProductKey AS CodiceProdotto,
    p.EnglishProductName AS NomeProdotto,
    sc.ProductSubcategoryKey AS CodiceSottocategoria,
    sc.EnglishProductSubcategoryName AS NomeSottocategoria
FROM DimProduct p
JOIN DimProductSubcategory sc
    ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey;
--- Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto la sua sottocategoria e la sua categoria DimProduct, DimProductSubcategory, DimProductCategory
SELECT
    p.ProductKey AS CodiceProdotto,
    p.EnglishProductName AS NomeProdotto,
    sc.EnglishProductSubcategoryName AS NomeSottocategoria,
    c.EnglishProductCategoryName AS NomeCategoria
FROM DimProduct p
JOIN DimProductSubcategory sc
    ON p.ProductSubcategoryKey = sc.ProductSubcategoryKey
JOIN DimProductCategory c
    ON sc.ProductCategoryKey = c.ProductCategoryKey;
--- Esponi lʼelenco dei soli prodotti venduti DimProduct, FactResellerSales
SELECT DISTINCT
    p.ProductKey,
    p.EnglishProductName AS NomeProdotto
FROM DimProduct p
JOIN FactResellerSales frs
    ON p.ProductKey = frs.ProductKey;
--- Esponi lʼelenco dei prodotti non venduti (considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1)
/*LEFT JOIN Prende tutti i prodotti, anche se non hanno vendite.Dove non c’è vendita, i campi di frs sono NULL.
WHERE frs.ProductKey IS NULL Filtra proprio i prodotti che non compaiono in nessuna vendita.
AND p.FinishedGoodsFlag = 1 Considera solo i prodotti finiti.*/
SELECT
    p.ProductKey,
    p.EnglishProductName AS NomeProdotto
FROM DimProduct p
LEFT JOIN FactResellerSales frs
    ON p.ProductKey = frs.ProductKey
WHERE frs.ProductKey IS NULL
  AND p.FinishedGoodsFlag = 1;
--- Esponi lʼelenco delle transazioni di vendita FactResellerSales indicando anche il nome del prodotto venduto DimProduct
SELECT
    frs.SalesOrderNumber AS NumeroOrdine,
    frs.SalesOrderLineNumber AS RigaOrdine,
    frs.OrderDate AS DataOrdine,
    p.ProductKey AS CodiceProdotto,
    p.EnglishProductName AS NomeProdotto,
    frs.SalesAmount AS ImportoVendita,
    frs.TotalProductCost AS CostoTotaleProdotto,
    (frs.SalesAmount - frs.TotalProductCost) AS Profitto
FROM FactResellerSales frs
JOIN DimProduct p
    ON frs.ProductKey = p.ProductKey;
