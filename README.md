# opencart-bulk-seo-sql

SQL scripts for bulk SEO operations in OpenCart 3.x — ready to run via phpMyAdmin or any MySQL client.

## Scripts

| File | Description |
|------|-------------|
| `bulk_seo_settings.sql` | Enable SEO URLs, set meta robots, configure canonical settings |
| `bulk_meta_update.sql` | Bulk-generate meta titles and descriptions for products and categories |

## Usage

1. Back up your database first
2. Replace `oc_` with your actual table prefix if different
3. Run via phpMyAdmin → SQL tab, or `mysql -u user -p dbname < script.sql`

## Compatibility

- OpenCart 3.x
- MySQL 5.7+ / MariaDB 10.3+
- Table prefix: `oc_` (default)

## Notes

All scripts use `INSERT ... ON DUPLICATE KEY UPDATE` or `UPDATE ... WHERE` patterns to be safe for repeated runs. No data is deleted.
