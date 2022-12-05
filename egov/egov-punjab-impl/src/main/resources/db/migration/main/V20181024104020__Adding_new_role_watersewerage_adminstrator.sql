INSERT INTO eg_role(id, name, description, createddate, createdby, lastmodifiedby, lastmodifieddate, version) select nextval('seq_eg_role'), 'Water Sewerage Administrator', 'Water Sewerage Administrator', now(), 1, 1, now(), 0 where not exists (select name from eg_role where name='Water Sewerage Administrator');

