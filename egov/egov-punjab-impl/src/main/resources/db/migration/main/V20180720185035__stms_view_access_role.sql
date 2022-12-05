----------------------STMS_VIEW_ACCESS_ROLE
-- Basic
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'Inbox' and contextroot='egi'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'InboxDraft' and contextroot='egi'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'InboxHistory' and contextroot='egi'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'OfficialsProfileEdit' and contextroot='egi'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'OfficialSentFeedBack' and contextroot='egi'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'OfficialChangePassword' and contextroot='egi'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'AddFavourite' and contextroot='egi'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'RemoveFavourite' and contextroot='egi'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'Official Home Page' and contextroot='egi'));

--Master Data
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'SearchSewerageChargeRatesMaster' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'SewerageChargeRatesAjaxSearch' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'SewerageChargeRatesView' and contextroot='stms'));

--transactions
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'Scheduled Job Details For Sewerage' and contextroot='stms'));
insert into eg_roleaction (roleid,actionid) values ((select id from eg_role where name='STMS_VIEW_ACCESS_ROLE'), (select id from eg_action where name = 'Scheduled Job Detail Logs For Sewerage' and contextroot='stms'));