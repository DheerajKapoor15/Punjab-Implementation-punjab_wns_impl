update eg_demand_reason_master set category =(select id from eg_reason_category where code='Fee') where code in ('WTAXSECURITY','WTAXOTHERS','WTAXROADCUTTING','WTAXAPPLICATION','WTAXSUPERVISION')
and module = (select id from eg_module where name='Water Tax Management');