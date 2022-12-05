
update eg_action set enabled=false where name='ServiceToBankMapping' and contextroot='collection';

update eg_action set enabled=false where name in('BankRemittance','ChequeRemittance') and contextroot='collection';

update eg_action set enabled=false where name='DishonoredCheque' and contextroot='collection';

update eg_action set enabled=false where name='DishonoredChequeReport' and contextroot='collection';

