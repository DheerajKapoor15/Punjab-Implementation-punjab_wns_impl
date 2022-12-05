--sewerage collection
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/collectfee/search' and contextroot='stms'));

--collection
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/receipts/searchReceipt.action' and contextroot='collection'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/citizen/searchOnlineReceipt-search.action' and contextroot='collection'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/cashCollectionReport-criteria.action' and contextroot='collection'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/chequeCollectionReport-criteria.action' and contextroot='collection'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/receiptRegisterReport-criteria.action' and contextroot='collection'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/onlineTransactionReport-criteria.action' and contextroot='collection'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/collectionSummary-criteria.action' and contextroot='collection'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/receipts/searchReceipt-search.action' and contextroot='collection'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/receipts/receipt-viewReceipts.action' and contextroot='collection'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/cashCollectionReport-report.action' and contextroot='collection'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/receiptRegisterReport-report.action' and contextroot='collection'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/chequeCollectionReport-report.action' and contextroot='collection'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='PWSSB User'), (select id from eg_action where url='/reports/onlineTransactionReport-report.action' and contextroot='collection'));
