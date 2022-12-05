update chartofaccounts set name='Axis Bank Phagwara branch-919010041317688' where name='Axis Bank Phagwara branch-918010034709978' and glcode='4502101';

update bankaccount set accountnumber = '919010041317688' where glcodeid = (select glcodeid from egf_instrumentaccountcodes where typeid =(select id from egf_instrumenttype where type='online'));
