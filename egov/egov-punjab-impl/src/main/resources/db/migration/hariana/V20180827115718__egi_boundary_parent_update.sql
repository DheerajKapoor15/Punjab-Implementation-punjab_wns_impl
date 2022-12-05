update eg_boundary set parent=(select id from eg_boundary where name='Zone 1') where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block');

update egwtr_connection set zone = (select id from eg_boundary where name='Zone 1');

update egswtax_connection set zone = (select id from eg_boundary where name='Zone 1');

update eg_boundary set name='Block 1', localname='Block 1' where code='B1';
update eg_boundary set name='Block 2', localname='Block 2' where code='B2';
update eg_boundary set name='Block 3', localname='Block 3' where code='B3';
update eg_boundary set name='Block 4', localname='Block 4' where code='B4';
update eg_boundary set name='Block 5', localname='Block 5' where code='B5';
update eg_boundary set name='Block 6', localname='Block 6' where code='B6';
update eg_boundary set name='Block 7', localname='Block 7' where code='B7';
update eg_boundary set name='Block 8', localname='Block 8' where code='B8';
update eg_boundary set name='Block 9', localname='Block 9' where code='B9';
update eg_boundary set name='Block 10', localname='Block 10' where code='B10';
update eg_boundary set name='Block 11', localname='Block 11' where code='B11';
