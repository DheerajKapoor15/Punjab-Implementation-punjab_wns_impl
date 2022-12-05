insert into eg_userrole (roleid,userid) values((select id from eg_role where name='Coll_Cancel Access'),(select id from eg_user where username='pmidchelpdesk'));
