Insert into EG_ACTION (ID,NAME,URL,QUERYPARAMS,PARENTMODULE,ORDERNUMBER,DISPLAYNAME,ENABLED,CONTEXTROOT,VERSION,
CREATEDBY,CREATEDDATE,LASTMODIFIEDBY,LASTMODIFIEDDATE,APPLICATION) 
values (NEXTVAL('SEQ_EG_ACTION'),'ConnectionSearchModule','/search/connectionsearchmodule', null,(select id from eg_module where name='Commons'),2,'Connection Search Module',true,'wtms',0,1,now(),1,now(),582);


insert into eg_roleaction (roleid,actionid) values((select id from eg_role where name='SYSTEM'),(select id from eg_action where DISPLAYNAME='Connection Search Module'));
insert into eg_roleaction (roleid,actionid) values((select id from eg_role where name='ULB Operator'),(select id from eg_action where DISPLAYNAME='Connection Search Module'));
insert into eg_roleaction (roleid,actionid) values((select id from eg_role where name='CITIZEN'),(select id from eg_action where DISPLAYNAME='Connection Search Module'));
