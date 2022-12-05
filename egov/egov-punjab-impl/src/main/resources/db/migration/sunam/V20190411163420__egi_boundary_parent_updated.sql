update eg_boundary set parent=(select id from eg_boundary where code='B11' and boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Block')) where boundarytype=(select id from eg_boundary_type where hierarchytype = (select id from eg_hierarchy_type where name = 'REVENUE') and name='Locality') and code='SUN345';

update egwtr_connection set block=(select parent from eg_boundary where id=locality);
update egswtax_connection set block=(select parent from eg_boundary where id=locality);