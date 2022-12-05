--Property Type Category
--INSERT INTO egwtr_property_category(id, propertytype, categorytype, active, createddate, lastmodifieddate, createdby, lastmodifiedby, version) VALUES 
--(nextval('seq_egwtr_property_category'), (select id from egwtr_property_type where name='Residential'), (select id from egwtr_category where name='Regularisation of Illegal Connection'), true, now(), now(), 1, 1, 0);

