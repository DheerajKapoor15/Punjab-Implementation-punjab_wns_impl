
update eg_boundary set name=trim(localname) where boundarytype in (select id from eg_boundary_type where name='Locality');