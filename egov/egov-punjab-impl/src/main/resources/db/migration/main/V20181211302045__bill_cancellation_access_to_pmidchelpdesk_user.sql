insert into eg_userrole (roleid,userid) select (select id from eg_role where name='Water Bill Cancel Access'),(select id from eg_user where username='pmidchelpdesk') 
where not exists (select * from eg_userrole where roleid=(select id from eg_role where name='Water Bill Cancel Access') and userid=(select id from eg_user where username='pmidchelpdesk'));

insert into eg_userrole (roleid,userid) select (select id from eg_role where name='Sewerage Bill Cancel Access'),(select id from eg_user where username='pmidchelpdesk') 
where not exists (select * from eg_userrole where roleid=(select id from eg_role where name='Sewerage Bill Cancel Access') and userid=(select id from eg_user where username='pmidchelpdesk'));