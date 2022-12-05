
update eg_action set enabled=false where name in ('CreateSewerageMonthlyRates', 'DonationMaster', 'DonationMasterView', 
'SewerageRateView')  and contextroot='stms';

update eg_action set enabled=false where name in ('New Sewerage Connection')  and contextroot='stms';
