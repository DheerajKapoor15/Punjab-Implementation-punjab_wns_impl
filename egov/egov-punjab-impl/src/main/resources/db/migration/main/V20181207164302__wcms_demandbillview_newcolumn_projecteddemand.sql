DO $$ 
BEGIN
BEGIN
ALTER TABLE egwtr_demandbill_view ADD COLUMN projecteddemand double precision;
EXCEPTION
WHEN duplicate_column THEN RAISE NOTICE 'column projecteddemand already exists in egwtr_demandbill_view.';
END;
END;
$$
