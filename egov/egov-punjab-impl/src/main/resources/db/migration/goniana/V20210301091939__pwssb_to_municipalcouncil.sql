update chartofaccounts set name='RAZORPAY Bank Goniana branch-918010071292015' where name ='RAZORPAY Bank Goniana branch-918010064572665';
update bankaccount set isactive='f' where accountnumber = '918010064572665';

insert into bankaccount (id, branchid, accountnumber, isactive, glcodeid, fundid, type, createdby, lastmodifiedby,
 createddate, lastmodifieddate, version) values(nextval('seq_bankaccount'), (select id from bankbranch where branchcode='001'), 
 '918010071292015', true, (select id from chartofaccounts where glcode='4502101'), (select id from fund where code='01'),
  'RECEIPTS', 1, 1, now(), now(), 0);

update eg_appconfig_values set value='NO' where KEY_ID = (SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='IS_PWSSB_ULB' and module=(select id from eg_module where name='Administration'));
delete from eg_appconfig_values where key_id=(SELECT id FROM EG_APPCONFIG WHERE KEY_NAME='PWSSB_CONFIGURATION' and module=(select id from eg_module where name='Administration'));
update eg_appconfig_values set value='TAX' where value='PWSSB';
update eg_appconfig_values set value='Tax Branch' where key_id = (select id from eg_appconfig where key_name='COLLECTIONDEPARTMENTFORWORKFLOW' and module=(select id from eg_module where name='Collection')); 
update eg_appconfig_values set value='Clerk' where key_id = (select id from eg_appconfig where key_name='COLLECTIONDESIGNATIONFORCSCOPERATORASCLERK' and module=(select id from eg_module where name='Collection'));
update eg_appconfig_values set value = 'Executive Officer' where key_id =(select id from eg_appconfig where key_name = 'WATER_APPROVE_DESIGNATION');
update eg_appconfig_values set value = 'Executive Officer' where key_id =(select id from eg_appconfig where key_name = 'SEWERAGE_APPROVE_DESIGNATION'); 


update bankaccount set narration ='acc_GiWtQYLAcT3ZRP' where accountnumber='918010071292015';
