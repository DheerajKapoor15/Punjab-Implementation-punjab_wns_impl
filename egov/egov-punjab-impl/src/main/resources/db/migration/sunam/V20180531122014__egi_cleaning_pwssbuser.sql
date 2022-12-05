delete from eg_roleaction where roleid=(select id from eg_role where name='PWSSB User');
delete from eg_userrole where roleid=(select id from eg_role where name='PWSSB User');
delete from eg_role where name='PWSSB User';
