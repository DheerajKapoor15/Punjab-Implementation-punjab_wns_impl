--csc user

insert into eg_user(id, locale, username, password, createddate, lastmodifieddate, createdby, lastmodifiedby, active, name, type, pwdexpirydate) values(nextval('seq_eg_user'), 'en_IN', 'cscuser', '$2a$10$uheIOutTnD33x7CDqac1zOL8DMiuz7mWplToPgcf7oxAI9OzRKxmK', now(), now(), 1, 1, true, 'CSC User', 'SYSTEM', '2099-01-01 00:00:00');

--csc user maaping with CSC Operator role

insert into eg_userrole(roleid, userid) VALUES ((select id from eg_role where name='CSC Operator'), (select id from eg_user where username = 'cscuser'));

--missing actions for CSC operator

insert into eg_roleaction values ((select id from eg_role where name='CSC Operator'),(select id from eg_action where name='Official Home Page'));
insert into eg_roleaction values ((select id from eg_role where name='CSC Operator'),(select id from eg_action where name='OfficialChangePassword'));
insert into eg_roleaction values ((select id from eg_role where name='CSC Operator'),(select id from eg_action where name='OfficialSentFeedBack'));
insert into eg_roleaction values ((select id from eg_role where name='CSC Operator'),(select id from eg_action where name='OfficialsProfileEdit'));
insert into eg_roleaction values ((select id from eg_role where name='CSC Operator'),(select id from eg_action where name='AddFavourite'));
insert into eg_roleaction values ((select id from eg_role where name='CSC Operator'),(select id from eg_action where name='RemoveFavourite'));      




--delete from eg_roleaction where actionid = (select id from eg_action where name='Official Home Page') and roleid = (select id from eg_role where name='CSC Operator');
--delete from eg_roleaction where actionid = (select id from eg_action where name='OfficialChangePassword') and roleid = (select id from eg_role where name='CSC Operator');
--delete from eg_roleaction where actionid = (select id from eg_action where name='OfficialSentFeedBack') and roleid = (select id from eg_role where name='CSC Operator');
--delete from eg_roleaction where actionid = (select id from eg_action where name='OfficialsProfileEdit') and roleid = (select id from eg_role where name='CSC Operator');
--delete from eg_roleaction where actionid = (select id from eg_action where name='Official Home Page') and roleid = (select id from eg_role where name='CSC Operator');
--delete from eg_roleaction where actionid = (select id from eg_action where name='AddFavourite') and roleid = (select id from eg_role where name='CSC Operator');
--delete from eg_roleaction where actionid = (select id from eg_action where name='RemoveFavourite') and roleid = (select id from eg_role where name='CSC Operator');

--delete from eg_userrole where userid= (select id from eg_user where name = 'CSC User');

--delete from eg_user where name= 'CSC User';

