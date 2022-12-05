update chartofaccounts set name='Axis Bank Fazilka branch-918010103200540' where name='Axis Bank Fazilka branch-912010031911378' and glcode='4502001';

update bankaccount set accountnumber = '918010103200540' where glcodeid = (select glcodeid from egf_instrumentaccountcodes where typeid =(select id from egf_instrumenttype where type='online'));
