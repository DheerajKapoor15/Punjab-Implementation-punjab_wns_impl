

update eg_boundary set parent = (select id from eg_boundary where code='B4A' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE' and name='Block'))) where code = 'TWS15';
update eg_boundary set parent = (select id from eg_boundary where code='B4B' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE' and name='Block'))) where code = 'TWS16';
update eg_boundary set parent = (select id from eg_boundary where code='B5B' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE' and name='Block'))) where code = 'TWS18';