--Role for Connection Action /Deactivation and Dues Adjustment
INSERT INTO eg_role(id, name, description, createddate, createdby, lastmodifiedby, lastmodifieddate, version) VALUES (nextval('seq_eg_role'), 'Tax Waiver', 'Tax Waiver', now(), 1, 1, now(), 0);
INSERT INTO eg_role(id, name, description, createddate, createdby, lastmodifiedby, lastmodifieddate, version) VALUES (nextval('seq_eg_role'), 'Connection Active/Deactive', 'Connection Active/Deactive', now(), 1, 1, now(), 0);

Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Tax Waiver'),(select id from eg_action where name='SewerageConnectionSearchForAdjustmentfeature'));
Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Tax Waiver'),(select id from eg_action where name='WaterReportResultForAdjustmentfeature'));
Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Tax Waiver'),(select id from eg_action where name='WaterReportForAdjustmentfeature'));
Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Tax Waiver'),(select id from eg_action where name='SewerageReportForAdjustmentfeature'));
Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Tax Waiver'),(select id from eg_action where name='SewerageReportResultForAdjustmentfeature'));

Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Connection Active/Deactive'),(select id from eg_action where name='WaterTaxActivateDeactivate'));
Insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Connection Active/Deactive'),(select id from eg_action where name='SearchWaterTaxActivateDeactivate'));
