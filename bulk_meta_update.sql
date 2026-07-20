-- ============================================================
-- bulk_meta_update.sql
-- OpenCart 3.x — Bulk update meta titles and descriptions
-- Table prefix: oc_ (change if different)
-- Language: 1 = default (Russian/English depending on your install)
-- ============================================================

-- ── STEP 1: Check products with empty or missing meta fields ──

SELECT p.product_id,
       pd.name,
       pd.meta_title,
       pd.meta_description
FROM oc_product p
JOIN oc_product_description pd ON pd.product_id = p.product_id
WHERE pd.language_id = 1
  AND (pd.meta_title = '' OR pd.meta_description = '')
LIMIT 50;

-- ── STEP 2: Fill empty meta_title from product name ──
-- Sets meta_title = product name where it is blank

UPDATE oc_product_description
SET meta_title = name
WHERE language_id = 1
  AND (meta_title IS NULL OR meta_title = '');

-- ── STEP 3: Fill empty meta_description from product description ──
-- Strips HTML tags and truncates to 160 characters

UPDATE oc_product_description
SET meta_description = LEFT(
    REGEXP_REPLACE(description, '<[^>]+>', ''),
    160
)
WHERE language_id = 1
  AND (meta_description IS NULL OR meta_description = '')
  AND description IS NOT NULL
  AND description != '';

-- ── STEP 4: Check categories with empty meta fields ──

SELECT c.category_id,
       cd.name,
       cd.meta_title,
       cd.meta_description
FROM oc_category c
JOIN oc_category_description cd ON cd.category_id = c.category_id
WHERE cd.language_id = 1
  AND (cd.meta_title = '' OR cd.meta_description = '')
ORDER BY c.sort_order;

-- ── STEP 5: Fill empty category meta_title from category name ──

UPDATE oc_category_description
SET meta_title = name
WHERE language_id = 1
  AND (meta_title IS NULL OR meta_title = '');

-- ── STEP 6: Fill empty category meta_description from description ──

UPDATE oc_category_description
SET meta_description = LEFT(
    REGEXP_REPLACE(description, '<[^>]+>', ''),
    160
)
WHERE language_id = 1
  AND (meta_description IS NULL OR meta_description = '')
  AND description IS NOT NULL
  AND description != '';

-- ── STEP 7: Verify results ──

SELECT 'products' AS entity,
       COUNT(*) AS total,
       SUM(meta_title = '') AS empty_title,
       SUM(meta_description = '') AS empty_desc
FROM oc_product_description
WHERE language_id = 1
UNION ALL
SELECT 'categories',
       COUNT(*),
       SUM(meta_title = ''),
       SUM(meta_description = '')
FROM oc_category_description
WHERE language_id = 1;
