INSERT INTO egswtax_usage_type(id, name, code, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES (nextval('seq_egswtax_usage_type'), 'INSTITUTIONAL', 'USAGE_INST', true, now(), now(), 1, 1, 0);

update egswtax_seweragecharge_rates set usagetype=(select id from egswtax_usage_type where name='INSTITUTIONAL') where usagetype is null;
