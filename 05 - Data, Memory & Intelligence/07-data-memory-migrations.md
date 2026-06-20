# Data & Memory – Schema Versioning and Migration

## Current Schema (v1.0)
Defined in `07-data-memory-records-baseline.md`.

## Migration Strategy
- Each change to the schema is stored as a migration script in `/migrations/`.
- Scripts are numbered sequentially (e.g., `001_add_invoice_status.sql`).
- The system checks the current schema version and applies pending migrations on startup.

## Migration Example (v1.0 → v1.1)
```sql
-- 001_add_currency_to_rates.sql
ALTER TABLE load_rates ADD COLUMN currency TEXT DEFAULT 'USD';
```

## Tooling
- Python `alembic` for SQLite migrations.
- LanceDB schema evolution is managed via versioned table schemas.

## Backward Compatibility
- The system can read old schema versions.
- New features may not work with old data until migration is run.

## Automatic Migration
- On each deployment, migrations are automatically applied.
- A backup is created before any migration.

## Rollback
- If a migration fails, the previous version is restored from backup.
- Admin can manually run rollback scripts.

## Documentation
- Each migration script includes a description of the change and its impact.
- A master changelog is maintained in this document.
