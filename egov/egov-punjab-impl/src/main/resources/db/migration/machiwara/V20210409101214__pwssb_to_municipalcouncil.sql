insert into bankaccount (id, branchid, accountnumber, isactive, glcodeid, fundid, type, createdby, lastmodifiedby, createddate, lastmodifieddate, version) values(nextval('seq_bankaccount'), (select id from bankbranch where branchcode='001'), '918010041248271', true, (select id from chartofaccounts where glcode='4502101'), (select id from fund where code='01'),'RECEIPTS', 1, 1, now(), now(), 0);
  
update eg_appconfig_values set value='TAX' where key_id = (select id from eg_appconfig where key_name='DEPTCODEFORGENERATEBILL' and module=(select id from eg_module where name='Water Tax Management'));

update eg_appconfig_values set value='TAX' where key_id = (select id from eg_appconfig where key_name='DEPT_CODE_FOR_GENERATE_BILL' and module=(select id from eg_module where name='Sewerage Tax Management'));

update eg_appconfig_values set value='Tax Branch' where key_id = (select id from eg_appconfig where key_name='COLLECTIONDEPARTMENTFORWORKFLOW' and module=(select id from eg_module where name='Collection'));

update eg_appconfig_values set value='TAX' where key_id = (select id from eg_appconfig where key_name='COLLECTIONDEPARTMENTCOLLMODES' and module=(select id from eg_module where name='Collection'));

update eg_appconfig_values set value='Clerk' where key_id = (select id from eg_appconfig where key_name='COLLECTIONDESIGNATIONFORCSCOPERATORASCLERK' and module=(select id from eg_module where name='Collection'));

update eg_appconfig_values set value='TAX' where value='PWSSB';

update eg_appconfig_values set value='NO' where KEY_ID = (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='IS_PWSSB_ULB' and module=(select id from eg_module where name='Administration'));

update bankaccount set isactive='f' where accountnumber = '918010041865928';

update chartofaccounts set name='RAZORPAY Bank Machiwara branch-918010041248271' where name ='RAZORPAY Bank Machiwara branch-918010041865928';