
--Revenue Locality
update eg_boundary set name = 'Polo Ram Sarai', localname= 'Polo Ram Sarai',parent =(select id from eg_boundary where code='B1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')) where code = 'LC12';

update eg_boundary set name = 'Preet Nagar', localname= 'Preet Nagar',parent =(select id from eg_boundary where code='B1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')) where code = 'LC13';
update eg_boundary set name = 'Purana Gurudwara', localname= 'Purana Gurudwara',parent =(select id from eg_boundary where code='B1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')) where code = 'LC14';
update eg_boundary set name = 'Railway Road', localname= 'Railway Road',parent =(select id from eg_boundary where code='B4' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')) where code = 'LC15';
update eg_boundary set name = 'Raj Nagar', localname= 'Raj Nagar',parent =(select id from eg_boundary where code='B3' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')) where code = 'LC16';
update eg_boundary set name = 'Ram Nagar', localname= 'Ram Nagar',parent =(select id from eg_boundary where code='B1' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')) where code = 'LC17';
update eg_boundary set name = 'Sharma Store', localname= 'Sharma Store',parent =(select id from eg_boundary where code='B2' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')) where code = 'LC18';
update eg_boundary set name = 'Shiwalik Avenue Ph- 1 A', localname= 'Shiwalik Avenue Ph- 1 A',parent =(select id from eg_boundary where code='B8' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')) where code = 'LC19';
update eg_boundary set name = 'Shiwalik Avenue Ph- 1 B', localname= 'Shiwalik Avenue Ph- 1 B',parent =(select id from eg_boundary where code='B8' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')) where code = 'LC20';
update eg_boundary set name = 'Shiwalik Avenue Ph- 2', localname= 'Shiwalik Avenue Ph- 2',parent =(select id from eg_boundary where code='B8' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')) where code = 'LC21';

