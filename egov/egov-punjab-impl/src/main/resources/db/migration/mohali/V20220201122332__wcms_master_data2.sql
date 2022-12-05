INSERT INTO egwtr_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) 
VALUES (nextval('seq_egwtr_usage_type'), 'DOMESTIC_FIXED', 'USAGE_DOM_FIXED', true, now(), now(), 1, 1, 0);
