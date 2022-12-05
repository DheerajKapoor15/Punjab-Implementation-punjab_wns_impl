alter table eg_designation ADD COLUMN active boolean;
alter table eg_designation ALTER COLUMN code type character varying(15);

--Renaming Existing Designations as per Rainmaker
update eg_designation set name='Building Inspector',description='Building Inspector',code='BI',active='t' where name='Building inspector(Technical)/Draftsman';
update eg_designation set name='District controller (Finance & Accounts)',description='District controller (Finance & Accounts)',code='DCFA',active='t' where name='District controller( Finance & Accounts)';
update eg_designation set name='Inspector',description='Inspector',code='INS',active='t' where name='Inspector/Senior Assistant';
update eg_designation set name='Executive Engineer',description='Executive Engineer',code='XEN',active='t' where name='Executive Engineer/Municipal Engineer/Corporation Engineer';
update eg_designation set name='Municipal Town Planner',description='Municipal Town Planner',code='MTP',active='t' where name='Municipal Town Planner/Town Planner';
update eg_designation set name='Sub-Divisional Engineer',description='Sub-Divisional Engineer',code='SDE',active='t' where name='Sub-Divisional Engineer/Sub-Divisional Officer';
update eg_designation set name='Junior Assistant',description='Junior Assistant',code='JA',active='t' where name='JUNIOR ASSISTANT';
update eg_designation set name='Pump Operator',description='Pump Operator',code='PUMPOP',active='t' where name='Pump operator';
update eg_designation set name='Secretary',description='Secretary',code='SEC',active='t' where name='Additional Chief Secretary/Principal Secretary/Secretary';
update eg_designation set name='Commissioner',description='Commissioner',code='COMM',active='t' where name='Commissioner Municipal Coorporations';
update eg_designation set name='Computer Operator',description='Computer Operator',code='CO',active='t' where name='Computer Opertor';


update eg_designation set code='ACC',active='t' where name='Accountant';
update eg_designation set code='ACE',active='t' where name='Assistant Corporation Engineer';
update eg_designation set code='AME',active='t' where name='Assistant Municipal Engineer';
update eg_designation set code='ATP',active='t' where name='Assistant Town Planner';
update eg_designation set code='CE',active='t' where name='Chief Engineer';
update eg_designation set code='CLERK',active='t' where name='Clerk';
update eg_designation set code='CORPE',active='t' where name='Corporation Engineer';
update eg_designation set code='DEO',active='t' where name='Data Entry Operator';
update eg_designation set code='EO',active='t' where name='Executive Officer';
update eg_designation set code='HD',active='t' where name='Head Draftsman';
update eg_designation set code='JE',active='t' where name='Junior Engineer';
update eg_designation set code='LA',active='t' where name='Legal Assistant';
update eg_designation set code='ME',active='t' where name='Municipal Engineer';
update eg_designation set code='SI',active='t' where name='Sanitary Inspector';
update eg_designation set code='SO',active='t' where name='Sectional Officer';
update eg_designation set code='STP',active='t' where name='Senior Town Planner';
update eg_designation set code='SUPT',active='t' where name='Superintendent';
update eg_designation set code='SUPERVISOR',active='t' where name='Supervisor';
update eg_designation set code='JA',active='t' where name='Junior Assistant';
update eg_designation set code='AE',active='t' where name='Assistant Engineer';
update eg_designation set code='PUMPOP',active='t' where name='Pump Operator';
update eg_designation set code='SFO',active='t' where name='Sub Fire Officer';
update eg_designation set code='FIREMAN',active='t' where name='Fireman';
update eg_designation set code='BAILDAR',active='t' where name='Baildar';
update eg_designation set code='FSO',active='t' where name='Fire Station Officer';
update eg_designation set code='CP',active='t' where name='Computer Programmer';
update eg_designation set code='AC',active='t' where name='Assistant Commissioner';
update eg_designation set code='CSI',active='t' where name='Chief Sanitary Inspector';


--Adding New Designations
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'Additional Local Registrar', 'ALR', 'Additional Local Registrar', null, 0, now(), now(), 1, 1, 't');
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'Assistant Line Man', 'ALM', 'Assistant Line Man', null, 0, now(), now(), 1, 1, 't');
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'Citizen service representative', 'CSR', 'Citizen service representative', null, 0, now(), now(), 1, 1, 't');
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'Electrician', 'ELECTRICIAN', 'Electrician', null, 0, now(), now(), 1, 1, 't');
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'Health Officer', 'HO', 'Health Officer', null, 0, now(), now(), 1, 1, 't');
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'Junior Draftsman', 'JD', 'Junior Draftsman', null, 0, now(), now(), 1, 1, 't');
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'Land Scape Officer', 'LSO', 'Land Scape Officer', null, 0, now(), now(), 1, 1, 't');
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'Local Registrar', 'LR', 'Local Registrar', null, 0, now(), now(), 1, 1, 't');
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'Medical Officer', 'MO', 'Medical Officer', null, 0, now(), now(), 1, 1, 't');
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'Sanitary Supervisor', 'SS', 'Sanitary Supervisor', null, 0, now(), now(), 1, 1, 't');
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'Senior Assistant', 'SA', 'Senior Assistant', null, 0, now(), now(), 1, 1, 't');
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'Sub Division Officer', 'SDO', 'Sub Division Officer', null, 0, now(), now(), 1, 1, 't');
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'Sub Registrar', 'SR', 'Sub Registrar', null, 0, now(), now(), 1, 1, 't');
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'Superintending Engineer', 'SE', 'Superintending Engineer', null, 0, now(), now(), 1, 1, 't');
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'Surveyor', 'SURVEYOR', 'Surveyor', null, 0, now(), now(), 1, 1, 't');
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'Tax Collector', 'TC', 'Tax Collector', null, 0, now(), now(), 1, 1, 't');
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'In charge/DBA', 'DBA', 'In charge/DBA', null, 0, now(), now(), 1, 1, 't');
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'GIS Expert', 'GISEXPERT', 'GIS Expert', null, 0, now(), now(), 1, 1, 't');
insert into eg_designation(id, name, code, description, chartofaccounts, version, createddate, lastmodifieddate, createdby, lastmodifiedby, active) values (nextval('seq_eg_designation'), 'Sewa Kendra Operator', 'SK_OPR', 'Sewa Kendra Operator', null, 0, now(), now(), 1, 1, 't'); 
