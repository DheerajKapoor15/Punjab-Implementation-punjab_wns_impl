INSERT INTO eg_role(id, name, description, createddate, createdby, lastmodifiedby, lastmodifieddate, version) VALUES (nextval('seq_eg_role'), 'Collection Agency', 'One who can collect the Water and Sewerage charges', now(), 1, 1, now(), 0);

insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Collection Agency'), (select id from eg_action where name='GetAllBankName' and url='/voucher/common-ajaxGetAllBankName.action' and contextroot='EGF'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Collection Agency'), (select id from eg_action where url='/receipts/receipt-newform.action' and contextroot='collection' and displayname='CreateReceipt'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Collection Agency'), (select id from eg_action where url='/receipts/receipt-save.action' and contextroot='collection'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='Collection Agency'), (select id from eg_action where name='PrintReceipts' and contextroot='collection'));

