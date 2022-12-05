update chartofaccounts set glcode='4502001', parentid=(select id from chartofaccounts where glcode='45020'),functionreqd=true where glcode='4502101';

update eg_action set enabled=true where name='ServiceToBankMapping' and contextroot='collection';

update eg_action set enabled=true where name in('BankRemittance','ChequeRemittance') and contextroot='collection';

update egcl_servicedetails set vouchercreation=true where code in ('WT', 'STAX', 'AXIS', 'AIRTEL', 'FREECHARGE', 'PAYTM', 'SEWAKENDRA', 'PAYU'); 
