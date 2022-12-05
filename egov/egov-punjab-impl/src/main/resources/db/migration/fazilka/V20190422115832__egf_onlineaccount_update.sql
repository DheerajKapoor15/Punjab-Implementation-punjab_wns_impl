update chartofaccounts set name='Axis Bank Fazilka branch-919010025281358' where name='Axis Bank Fazilka branch-918010103200540' and glcode='4502001';

update bankaccount set accountnumber = '919010025281358' where glcodeid = (select glcodeid from egf_instrumentaccountcodes where typeid =(select id from egf_instrumenttype where type='online'));

