update chartofaccounts set name='Axis Bank Banur branch-918010104010302' where name='Axis Bank Banur branch-916010079336997' and glcode='4502101';

update bankaccount set accountnumber = '918010104010302' where glcodeid = (select glcodeid from egf_instrumentaccountcodes where typeid =(select id from egf_instrumenttype where type='online'));
