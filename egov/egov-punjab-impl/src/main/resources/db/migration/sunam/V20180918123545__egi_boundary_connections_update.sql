update egwtr_connection set block = (select id from eg_boundary where code='B10' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')) where locality= (select id from eg_boundary where code = 'SUN178');

update egswtax_connection set block = (select id from eg_boundary where code='B10' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')) where locality= (select id from eg_boundary where code = 'SUN178');