
update eg_action set enabled=true where name='ServiceToBankMapping' and contextroot='collection';

update eg_action set enabled=true where name in('BankRemittance','ChequeRemittance') and contextroot='collection';

