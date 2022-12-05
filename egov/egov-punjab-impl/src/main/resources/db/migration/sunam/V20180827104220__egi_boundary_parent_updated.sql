update eg_boundary set parent=(select id from eg_boundary where name='Block 7') where name='Mohalla Chhahrian Wala';

update egwtr_connection set block = (select id from eg_boundary where name='Block 7') where locality= (select id from eg_boundary where name='Mohalla Chhahrian Wala');

update egswtax_connection set block = (select id from eg_boundary where name='Block 7') where locality= (select id from eg_boundary where name='Mohalla Chhahrian Wala');
