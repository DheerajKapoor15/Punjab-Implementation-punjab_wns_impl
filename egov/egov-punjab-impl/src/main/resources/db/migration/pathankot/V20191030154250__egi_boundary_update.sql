update egwtr_connection set block =(select parent from eg_boundary where code=(select code from eg_boundary where id=locality));

update egswtax_connection set block =(select parent from eg_boundary where code=(select code from eg_boundary where id=locality));