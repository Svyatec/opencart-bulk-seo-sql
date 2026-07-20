-- ============================================================
-- bulk_seo_settings.sql
-- OpenCart 3.x — Enable SEO URLs and configure global SEO settings
-- Table prefix: oc_ (change if different)
-- Safe to run multiple times (INSERT ... ON DUPLICATE KEY UPDATE)
-- ============================================================

-- 1. Enable SEO URLs
INSERT INTO oc_setting (store_id, code, `key`, value, serialized)
VALUES (0, 'config', 'config_seo_url', '1', 0)
ON DUPLICATE KEY UPDATE value = '1';

-- 2. Enable canonical self-referencing URLs
INSERT INTO oc_setting (store_id, code, `key`, value, serialized)
VALUES (0, 'config', 'config_canonical_self', '1', 0)
ON DUPLICATE KEY UPDATE value = '1';

-- 3. Set robots meta for all pages (index,follow)
INSERT INTO oc_setting (store_id, code, `key`, value, serialized)
VALUES (0, 'config', 'config_robots', 'index,follow', 0)
ON DUPLICATE KEY UPDATE value = 'index,follow';

-- 4. Enable output compression
INSERT INTO oc_setting (store_id, code, `key`, value, serialized)
VALUES (0, 'config', 'config_compression', '6', 0)
ON DUPLICATE KEY UPDATE value = '6';

-- 5. Set default product limit (good for SEO: avoid thin paginated pages)
INSERT INTO oc_setting (store_id, code, `key`, value, serialized)
VALUES (0, 'config', 'config_product_limit', '24', 0)
ON DUPLICATE KEY UPDATE value = '24';

-- ============================================================
-- Check current SEO-related settings
-- ============================================================
SELECT `key`, value
FROM oc_setting
WHERE store_id = 0
  AND `key` IN (
    'config_seo_url',
    'config_canonical_self',
    'config_robots',
    'config_compression',
    'config_product_limit'
  )
ORDER BY `key`;
