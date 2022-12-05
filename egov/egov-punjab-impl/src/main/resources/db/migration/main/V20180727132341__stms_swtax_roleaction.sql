delete from eg_roleaction 
where roleid = (select id from eg_role where name  = 'CSC Operator' ) and
actionid in (
select id from eg_action where name in (
'New Sewerage Connection',
'AjaxSewerageClosetsCheck',
'AjaxCheckConnection',
'AjaxCheckWaterTaxDue',
'Create Sewerage Connection',
'Sewerage Acknowledgement',
'Print Sewerage Acknowledgement',
'SearchSewerageChargeRatesMaster',
'SewerageChargeRatesView',
'SearchNotice',
'EditDemand-stms',
'EditDemand',
'viewSewerageConnection'
) 
);


delete from eg_roleaction 
where roleid = (select id from eg_role where name = 'Sewerage Tax Administrator') and
actionid in (
select id from eg_action where name in (
'New Sewerage Connection',
'AjaxSewerageClosetsCheck',
'AjaxCheckConnection',
'AjaxCheckWaterTaxDue',
'Create Sewerage Connection',
'Sewerage Acknowledgement',
'Print Sewerage Acknowledgement',
'SearchSewerageChargeRatesMaster',
'SewerageChargeRatesView',
'SearchNotice',
'EditDemand-stms',
'EditDemand',
'viewSewerageConnection'
) 
);



insert into eg_roleaction(roleid, actionid) values ((select id from eg_role where name = 'Sewerage Tax Administrator'),(select id from eg_action where name = 'New Sewerage Connection'));
insert into eg_roleaction(roleid, actionid) values ((select id from eg_role where name = 'Sewerage Tax Administrator'),(select id from eg_action where name = 'AjaxSewerageClosetsCheck'));
insert into eg_roleaction(roleid, actionid) values ((select id from eg_role where name = 'Sewerage Tax Administrator'),(select id from eg_action where name = 'AjaxCheckConnection'));
insert into eg_roleaction(roleid, actionid) values ((select id from eg_role where name = 'Sewerage Tax Administrator'),(select id from eg_action where name = 'AjaxCheckWaterTaxDue'));
insert into eg_roleaction(roleid, actionid) values ((select id from eg_role where name = 'Sewerage Tax Administrator'),(select id from eg_action where name = 'Create Sewerage Connection'));
insert into eg_roleaction(roleid, actionid) values ((select id from eg_role where name = 'Sewerage Tax Administrator'),(select id from eg_action where name = 'Sewerage Acknowledgement'));
insert into eg_roleaction(roleid, actionid) values ((select id from eg_role where name = 'Sewerage Tax Administrator'),(select id from eg_action where name = 'Print Sewerage Acknowledgement'));
insert into eg_roleaction(roleid, actionid) values ((select id from eg_role where name = 'Sewerage Tax Administrator'),(select id from eg_action where name = 'SearchSewerageChargeRatesMaster'));
insert into eg_roleaction(roleid, actionid) values ((select id from eg_role where name = 'Sewerage Tax Administrator'),(select id from eg_action where name = 'SewerageChargeRatesView'));
insert into eg_roleaction(roleid, actionid) values ((select id from eg_role where name = 'Sewerage Tax Administrator'),(select id from eg_action where name = 'SearchNotice'));
insert into eg_roleaction(roleid, actionid) values ((select id from eg_role where name = 'Sewerage Tax Administrator'),(select id from eg_action where name = 'EditDemand-stms'));
insert into eg_roleaction(roleid, actionid) values ((select id from eg_role where name = 'Sewerage Tax Administrator'),(select id from eg_action where name = 'EditDemand'));
insert into eg_roleaction(roleid, actionid) values ((select id from eg_role where name = 'Sewerage Tax Administrator'),(select id from eg_action where name = 'viewSewerageConnection'));



