--Locality
delete from eg_boundary where boundarytype = (select id from eg_boundary_type where name='Locality' and hierarchytype=(select id from eg_hierarchy_type where name='REVENUE')) and parent in (select id from eg_boundary where boundarytype = (select id from eg_boundary_type where name='Block' and hierarchytype=(select id from eg_hierarchy_type where name='REVENUE')) and parent in (select id from eg_boundary where boundarytype = (select id from eg_boundary_type where name='Zone' and hierarchytype=(select id from eg_hierarchy_type where name='REVENUE')) and parent=(select id from eg_boundary where name='Punjab'and boundarytype = (select id from eg_boundary_type where name='City' and hierarchytype=(select id from eg_hierarchy_type where name='REVENUE')))));

--Block
delete from eg_boundary where boundarytype = (select id from eg_boundary_type where name='Block' and hierarchytype=(select id from eg_hierarchy_type where name='REVENUE')) and parent in (select id from eg_boundary where boundarytype = (select id from eg_boundary_type where name='Zone' and hierarchytype=(select id from eg_hierarchy_type where name='REVENUE')) and parent=(select id from eg_boundary where name='Punjab'and boundarytype = (select id from eg_boundary_type where name='City' and hierarchytype=(select id from eg_hierarchy_type where name='REVENUE'))));

--Zone
delete from eg_boundary where boundarytype = (select id from eg_boundary_type where name='Zone' and hierarchytype=(select id from eg_hierarchy_type where name='REVENUE')) and parent=(select id from eg_boundary where name='Punjab'and boundarytype = (select id from eg_boundary_type where name='City' and hierarchytype=(select id from eg_hierarchy_type where name='REVENUE')));

--Ward
delete from eg_boundary where boundarytype = (select id from eg_boundary_type where name='Ward' and hierarchytype=(select id from eg_hierarchy_type where name='ADMINISTRATION')) and parent=(select id from eg_boundary where name='Punjab'and boundarytype = (select id from eg_boundary_type where name='City' and hierarchytype=(select id from eg_hierarchy_type where name='ADMINISTRATION')));

--City
delete from eg_boundary where name='Punjab'and boundarytype = (select id from eg_boundary_type where name='City' and hierarchytype=(select id from eg_hierarchy_type where name='ADMINISTRATION'));

delete from eg_boundary where name='Punjab'and boundarytype = (select id from eg_boundary_type where name='City' and hierarchytype=(select id from eg_hierarchy_type where name='REVENUE'));
