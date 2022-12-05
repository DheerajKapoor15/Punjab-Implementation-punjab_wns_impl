insert into bankbranch (id,branchcode,branchname, branchaddress1,branchcity,bankid,isactive,createddate,lastmodifieddate,lastmodifiedby,version,createdby)
values(nextval('seq_bankbranch'),'001','Sangrur Branch','SDO, PWSSB, Longowal','Sangrur',(select id from bank where code='UTIB'),true,now(),now(),1,0,1);


delete from chartofaccounts where glcode like '45021%';

INSERT INTO chartofaccounts (id,glcode,name,isactiveforposting,parentid,createddate,type,classification,functionreqd, budgetcheckreq, majorcode,
 createdby) VALUES (nextval('seq_chartofaccounts'), '4502101','Axis Bank Sangarur branch-917010054559439',true, (select id from chartofaccounts where glcode='45021'), current_date,'A',4, false, false, '450', 1);


insert into bankaccount (id,branchid,accountnumber,isactive,glcodeid,fundid,type,createdby,lastmodifiedby,createddate,lastmodifieddate,version)
values(nextval('seq_bankaccount'),(select id from bankbranch where branchcode='001'),'917010054559439',true,
(select id from chartofaccounts where glcode='4502101'),(select id from fund where code='01'),'RECEIPTS',1,1,now(),now(),0);

UPDATE EGF_INSTRUMENTACCOUNTCODES SET GLCODEID = (SELECT ID FROM CHARTOFACCOUNTS WHERE GLCODE='4502101') WHERE TYPEID =(SELECT ID FROM EGF_INSTRUMENTTYPE WHERE TYPE='online');



