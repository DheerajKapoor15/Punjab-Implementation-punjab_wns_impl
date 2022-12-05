insert into chartofaccounts(id,glcode,name,description,isactiveforposting,parentid,createddate,createdby,lastmodifieddate,purposeid,operation,type,class,classification,functionreqd,budgetcheckreq,scheduleid,receiptscheduleid,receiptoperation,paymentscheduleid,paymentoperation,majorcode,lastmodifiedby,fiescheduleid,fieoperation)
values(nextval('seq_chartofaccounts'),'1402012','Late Payment Penalty - Water Charges','Late Payment Penalty - Water Charges',true,(select id from chartofaccounts where glcode='14020'),now(),1,now(),null,null,'I',null,4,true,false,null,null,null,null,null,140,1,null,null);

insert into chartofaccounts(id,glcode,name,description,isactiveforposting,parentid,createddate,createdby,lastmodifieddate,purposeid,operation,type,class,classification,functionreqd,budgetcheckreq,scheduleid,receiptscheduleid,receiptoperation,paymentscheduleid,paymentoperation,majorcode,lastmodifiedby,fiescheduleid,fieoperation)
values(nextval('seq_chartofaccounts'),'1402011','Late Payment Penalty - Sewerage Charges','Late Payment Penalty - Sewerage Charges',true,(select id from chartofaccounts where glcode='14020'),now(),1,now(),null,null,'I',null,4,true,false,null,null,null,null,null,140,1,null,null);

insert into chartofaccounts(id,glcode,name,description,isactiveforposting,parentid,createddate,createdby,lastmodifieddate,purposeid,operation,type,class,classification,functionreqd,budgetcheckreq,scheduleid,receiptscheduleid,receiptoperation,paymentscheduleid,paymentoperation,majorcode,lastmodifiedby,fiescheduleid,fieoperation)
values(nextval('seq_chartofaccounts'),'1501107','Sewerage Connection Form','Sewerage Connection Form',true,(select id from chartofaccounts where glcode='15011'),now(),1,now(),null,null,'I',null,4,true,false,null,null,null,null,null,150,1,null,null);

insert into chartofaccounts(id,glcode,name,description,isactiveforposting,parentid,createddate,createdby,lastmodifieddate,purposeid,operation,type,class,classification,functionreqd,budgetcheckreq,scheduleid,receiptscheduleid,receiptoperation,paymentscheduleid,paymentoperation,majorcode,lastmodifiedby,fiescheduleid,fieoperation)
values(nextval('seq_chartofaccounts'),'3402004','Deposits – Revenues Related- Sewerage','Deposits – Revenues Related- Sewerage',true,(select id from chartofaccounts where glcode='34020'),now(),1,now(),null,null,'L',null,4,true,false,null,null,null,null,null,340,1,null,null);

insert into chartofaccounts(id,glcode,name,description,isactiveforposting,parentid,createddate,createdby,lastmodifieddate,purposeid,operation,type,class,classification,functionreqd,budgetcheckreq,scheduleid,receiptscheduleid,receiptoperation,paymentscheduleid,paymentoperation,majorcode,lastmodifiedby,fiescheduleid,fieoperation)
values(nextval('seq_chartofaccounts'),'4501003','Cheque in hand','Cheque in hand',true,(select id from chartofaccounts where glcode='45010'),now(),1,now(),5,null,'A',null,4,true,false,null,null,null,null,null,450,1,null,null);

insert into chartofaccounts(id,glcode,name,description,isactiveforposting,parentid,createddate,createdby,lastmodifieddate,purposeid,operation,type,class,classification,functionreqd,budgetcheckreq,scheduleid,receiptscheduleid,receiptoperation,paymentscheduleid,paymentoperation,majorcode,lastmodifiedby,fiescheduleid,fieoperation)
values(nextval('seq_chartofaccounts'),'4501004','Online AXIS Payment Gatway','Online AXIS Payment Gatway',true,(select id from chartofaccounts where glcode='45010'),now(),1,now(),121,null,'A',null,4,true,false,null,null,null,null,null,450,1,null,null);

insert into chartofaccounts(id,glcode,name,description,isactiveforposting,parentid,createddate,createdby,lastmodifieddate,purposeid,operation,type,class,classification,functionreqd,budgetcheckreq,scheduleid,receiptscheduleid,receiptoperation,paymentscheduleid,paymentoperation,majorcode,lastmodifiedby,fiescheduleid,fieoperation)
values(nextval('seq_chartofaccounts'),'1100303','Penal Interest on Sewerage tax','Penal Interest on Sewerage tax',true,(select id from chartofaccounts where glcode='11003'),now(),1,now(),null,null,'I',null,4,true,false,null,null,null,null,null,110,1,null,null);


update chartofaccounts set name='Water Tax/User Charges', description='Water Tax/User Charges' where glcode='1100201';

update chartofaccounts set name='Others Fees', description='Others Fees' where glcode='1404009';

update chartofaccounts set name='Road Cutting Charge', description='Road Cutting Charge' where glcode='1405009';

update chartofaccounts set name='New Connection Charges', description='New Connection Charges' where glcode='1404003';

update chartofaccounts set name='Water Connection Form', description='Water Connection Form' where glcode='1501102';

update chartofaccounts set name='Penal Interest on Water Tax', description='Penal Interest on Water Tax' where glcode='1100202';

update chartofaccounts set name='Deposits – Revenues Related - Water', description='Deposits – Revenues Related - Water' where glcode='3402001';

update chartofaccounts set name='Advance Collected - Water supply', description='Advance Collected - Water supply' where glcode='3504102';

update chartofaccounts set name='Sewerage Tax/User Charges', description='Sewerage Tax/User Charges' where glcode='1100301';

update chartofaccounts set name='Advance Collected- Sewerage', description='Advance Collected- Sewerage' where glcode='3504103';

-- Update old glcodes for cheque in hand and Cash in transit as inactive since new glcodes are added
update chartofaccounts set purposeid=null, isactiveforposting=false where glcode='4501051';
update chartofaccounts set purposeid=null, isactiveforposting=false where glcode='4318002';
