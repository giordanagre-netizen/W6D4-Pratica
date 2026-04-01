--- Esponi lʼanagrafica dei prodotti indicando per ciascun prodotto anche la sua sottocategoria DimProduct, DimProductSubcategory
/*SELECT Inizio della lista delle colonne. p.ProductKey AS CodiceProdotto,  p.EnglishProductName AS NomeProdotto,  
(SELECT sc.EnglishProductSubcategoryName Stiamo chiedendo: “dammi il nome della sottocategoria”.
FROM DimProductSubcategory sc La subquery legge dalla tabella delle sottocategorie.
WHERE sc.ProductSubcategoryKey = p.ProductSubcategoryKey Collega la sottocategoria al prodotto corrente (p).
Per ogni riga di DimProduct, la subquery cerca la sottocategoria corrispondente.
AS NomeSottocategoria Il valore restituito dalla subquery viene esposto come colonna NomeSottocategoria.
FROM DimProduct p; Tabella principale: DimProduct.Per ogni riga di DimProduct, viene eseguita la subquery.*/
SELECT
    p.ProductKey AS CodiceProdotto,
    p.EnglishProductName AS NomeProdotto,
    (SELECT sc.EnglishProductSubcategoryName
     FROM DimProductSubcategory sc
     WHERE sc.ProductSubcategoryKey = p.ProductSubcategoryKey
    ) AS NomeSottocategoria
FROM DimProduct p;
--- Esponi lʼelenco dei soli prodotti venduti DimProduct, FactResellerSales
/*WHERE p.ProductKey IN (...)La subquery restituisce tutti i ProductKey presenti nelle vendite.
IN filtra i prodotti, tenendo solo quelli che compaiono almeno una volta in FactResellerSales*/
SELECT
    p.ProductKey,
    p.EnglishProductName AS NomeProdotto
FROM DimProduct p
WHERE p.ProductKey IN (
    SELECT ProductKey
    FROM FactResellerSales
);
--- Esponi lʼelenco dei prodotti non venduti considera i soli prodotti finiti cioè quelli per i quali il campo FinishedGoodsFlag è uguale a 1
/*NOT IN (SELECT ProductKey FROM FactResellerSales)Esclude tutti i prodotti che compaiono nelle vendite.Restano solo quelli mai venduti.
FinishedGoodsFlag = 1 Stesso vincolo: solo prodotti finiti.*/
SELECT
    p.ProductKey,
    p.EnglishProductName AS NomeProdotto
FROM DimProduct p
WHERE p.FinishedGoodsFlag = 1
  AND p.ProductKey NOT IN (
        SELECT ProductKey
        FROM FactResellerSales
    );
