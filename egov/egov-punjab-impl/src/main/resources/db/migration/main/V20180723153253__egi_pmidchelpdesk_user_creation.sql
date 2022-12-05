insert into eg_user(id, locale, username, password, createddate, lastmodifieddate, createdby, lastmodifiedby, active, name, type, pwdexpirydate) values(nextval('seq_eg_user'), 'en_IN', 'pmidchelpdesk', '$2a$10$uheIOutTnD33x7CDqac1zOL8DMiuz7mWplToPgcf7oxAI9OzRKxmK', now(), now(), 1, 1, true, 'PMIDC HELP DESK', 'SYSTEM', '2099-01-01 00:00:00');

insert into eg_userrole(roleid, userid) VALUES ((select id from eg_role where name='WC_VIEW_ACCESS_ROLE'), (select id from eg_user where username = 'pmidchelpdesk'));
insert into eg_userrole(roleid, userid) VALUES ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'), (select id from eg_user where username = 'pmidchelpdesk'));
