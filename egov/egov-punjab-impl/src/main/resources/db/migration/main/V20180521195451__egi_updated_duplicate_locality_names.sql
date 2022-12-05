 update eg_boundary set name='Locality 7',localname='Locality 7' where parent=(select id from eg_boundary where name='Block 4') and name='Locality 1';
 update eg_boundary set name='Locality 8',localname='Locality 8' where parent=(select id from eg_boundary where name='Block 4') and name='Locality 2';
