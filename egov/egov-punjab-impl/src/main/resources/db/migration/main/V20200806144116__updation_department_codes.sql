alter table eg_department ADD COLUMN active boolean;

--Renaming Department names as per Rainmaker
update eg_department set name='Health & Sanitation',code='H&S',active='t' where name='Birth and Death Branch';
update eg_department set name='Town planning',code='TP',active='t' where name='Building Branch';
update eg_department set name='Operation & Maintenance',code='O&M',active='t' where name='Engineering Branch -Electrical';
update eg_department set name='CIVIL',code='CIVIL',active='t' where name='Engineering Branch(Civil) - for Buildings and Roads';
update eg_department set name='Engineering Branch (O&M - W&S)',code='ENGG',active='t' where name='Engineering Branch(O&M) -for Water and Sewerage';
update eg_department set name='Secretary/General Administration Branch',code='ADMIN',active='t' where name='Executive Branch';


update eg_department set code='ACCT',active='t' where name='Accounts Branch';
update eg_department set code='TAX',active='t' where name='Tax Branch';
update eg_department set code='PWSSB',active='t' where name='PWSSB';
update eg_department set code='DWSS',active='t' where name='DWSS';
update eg_department set code='WORKS',active='t' where name='Works Branch';


--New Departments which are used in Rainmaker
insert into eg_department (id, name, createddate, code, createdby, lastmodifiedby, lastmodifieddate, version, active)
values (nextval('seq_eg_department'), 'Fire Services Department', now(), 'FIRE', 1, 1, now(), 0, 't');
insert into eg_department (id, name, createddate, code, createdby, lastmodifiedby, lastmodifieddate, version, active)
values (nextval('seq_eg_department'), 'Hotriculture', now(), 'HORTI', 1, 1, now(), 0, 't');
insert into eg_department (id, name, createddate, code, createdby, lastmodifiedby, lastmodifieddate, version, active)
values (nextval('seq_eg_department'), 'Land Branch', now(), 'LAND', 1, 1, now(), 0, 't');
insert into eg_department (id, name, createddate, code, createdby, lastmodifiedby, lastmodifieddate, version, active)
values (nextval('seq_eg_department'), 'Legal Branch', now(), 'LEGAL', 1, 1, now(), 0, 't');
insert into eg_department (id, name, createddate, code, createdby, lastmodifiedby, lastmodifieddate, version, active)
values (nextval('seq_eg_department'), 'Sewa Kendra (DGR)', now(), 'SEWA', 1, 1, now(), 0, 't');