UPDATE EGF_INSTRUMENTACCOUNTCODES SET GLCODEID = (SELECT ID FROM CHARTOFACCOUNTS WHERE GLCODE='4501001') WHERE TYPEID =(SELECT ID FROM EGF_INSTRUMENTTYPE WHERE TYPE='cash');

UPDATE EGF_INSTRUMENTACCOUNTCODES SET GLCODEID = (SELECT ID FROM CHARTOFACCOUNTS WHERE GLCODE='4501051') WHERE TYPEID =(SELECT ID FROM EGF_INSTRUMENTTYPE WHERE TYPE='cheque');

UPDATE EGF_INSTRUMENTACCOUNTCODES SET GLCODEID = (SELECT ID FROM CHARTOFACCOUNTS WHERE GLCODE='4501051') WHERE TYPEID =(SELECT ID FROM EGF_INSTRUMENTTYPE WHERE TYPE='dd');

UPDATE EGF_INSTRUMENTACCOUNTCODES SET GLCODEID = (SELECT ID FROM CHARTOFACCOUNTS WHERE GLCODE='4501002') WHERE TYPEID =(SELECT ID FROM EGF_INSTRUMENTTYPE WHERE TYPE='online');

update chartofaccounts set name='Water Charges' where glcode='1806006';
