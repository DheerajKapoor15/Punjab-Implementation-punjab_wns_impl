
update eg_boundary set parent=(select id from eg_boundary where code='B4A' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')) where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='TWS15';
update eg_boundary set parent=(select id from eg_boundary where code='B4B' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')) where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='TWS16';
update eg_boundary set parent=(select id from eg_boundary where code='B5B' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')) where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='TWS18';

update egwtr_connection set block=(select parent from eg_boundary where id=locality);
update egswtax_connection set block=(select parent from eg_boundary where id=locality);
