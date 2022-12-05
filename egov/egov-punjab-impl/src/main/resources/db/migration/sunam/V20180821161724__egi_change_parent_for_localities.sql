update eg_boundary set parent=(select id from eg_boundary where name='Block 6') where name='Gali Prem FCI Di Back';

update egwtr_connection set block = (select id from eg_boundary where name='Block 6') where locality= (select id from eg_boundary where name='Gali Prem FCI Di Back');

update egswtax_connection set block = (select id from eg_boundary where name='Block 6') where locality= (select id from eg_boundary where name='Gali Prem FCI Di Back');

update eg_boundary set parent=(select id from eg_boundary where name='Block 8') where name='Mohalla manjoran Wala';

update egwtr_connection set block = (select id from eg_boundary where name='Block 8') where locality= (select id from eg_boundary where name='Mohalla manjoran Wala');

update egswtax_connection set block = (select id from eg_boundary where name='Block 8') where locality= (select id from eg_boundary where name='Mohalla manjoran Wala');




