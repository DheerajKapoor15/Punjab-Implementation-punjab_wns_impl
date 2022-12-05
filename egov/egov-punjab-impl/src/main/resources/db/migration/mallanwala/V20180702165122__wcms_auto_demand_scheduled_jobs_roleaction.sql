INSERT INTO eg_roleaction(roleid, actionid) VALUES ((select id from eg_role where name = 'PWSSB User'), (select id from eg_action where name = 'Scheduled Job Details For Sewerage'));

INSERT INTO eg_roleaction(roleid, actionid) VALUES ((select id from eg_role where name = 'PWSSB User'), (select id from eg_action where name = 'Scheduled Job Detail Logs For Sewerage'));

INSERT INTO eg_roleaction(roleid, actionid) VALUES ((select id from eg_role where name = 'PWSSB User'), (select id from eg_action where name = 'Auto Generate Demand For Water'));

INSERT INTO eg_roleaction(roleid, actionid) VALUES ((select id from eg_role where name = 'PWSSB User'), (select id from eg_action where name = 'Scheduled Job Details For Water'));

INSERT INTO eg_roleaction(roleid, actionid) VALUES ((select id from eg_role where name = 'PWSSB User'), (select id from eg_action where name = 'Scheduled Job Detail Logs For Water'));
