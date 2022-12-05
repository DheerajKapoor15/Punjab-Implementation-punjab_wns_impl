------Meter Reading Entry View

INSERT INTO eg_roleaction(roleid, actionid) VALUES ((select id from eg_role where name = 'PWSSB User'), (select id from eg_action where name = 'Meter Reading Entry View'));