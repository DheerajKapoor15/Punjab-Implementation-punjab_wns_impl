

update eg_boundary set parent = (select id from eg_boundary where code='B10' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE' and name='Block'))) where code = 'SUN178';