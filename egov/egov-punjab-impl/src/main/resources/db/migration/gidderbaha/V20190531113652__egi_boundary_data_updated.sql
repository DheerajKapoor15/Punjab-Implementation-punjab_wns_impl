

update eg_boundary set name='Sahibzada Ajit Singh  Nagar',localname='Sahibzada Ajit Singh  Nagar' where code='GD10';
update eg_boundary set name='Shaheed Bhagat Singh Nagar',localname='Shaheed Bhagat Singh Nagar' where code='GD11';


update egwtr_connection set block=(select parent from eg_boundary where id=locality);
update egwtr_connection set	zone=(select parent from eg_boundary where id=block);
update egswtax_connection set block=(select parent from eg_boundary where id=locality);
update egswtax_connection set zone=(select parent from eg_boundary where id=block);