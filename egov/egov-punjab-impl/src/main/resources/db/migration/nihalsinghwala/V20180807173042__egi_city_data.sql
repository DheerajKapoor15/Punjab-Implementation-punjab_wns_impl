insert into eg_citypreferences ( id, municipalitylogo, createdby, createddate, lastmodifiedby, lastmodifieddate, version, municipalityname, municipalitycontactno ,municipalityaddress, municipalitycontactemail, municipalitygislocation, municipalitycallcenterno, municipalityfacebooklink ,municipalitytwitterlink, googleapikey, recaptchapk, recaptchapub ) values (nextval('seq_eg_citypreferences'), null, 1, now(), 1, now(), 0, 'Nihal Singh Wala Nagara Panchayat', '01636-254221', 'Nihal Singh Wala Nagara Panchayat', 'eonpnsw@gmail.com', 'https://www.google.com/maps/@30.5927,75.2800,17z', null, null, null, 'AIzaSyCzRLAPShKqs7rj2yctW0zTVTidlVt1t9I', '6LeeCGMUAAAAAOlhzAooYv1YO2nc2a60WIqNBvIu', '6LeeCGMUAAAAAGJbI4bQbndrX_6jys9bbiBkfDFf');

INSERT INTO eg_city (domainurl, name, localname, id, active, version, createdby, lastmodifiedby, createddate, lastmodifieddate, code,  districtcode, districtname, longitude, latitude, preferences, regionname, grade) VALUES ('nihalsinghwala-uat.egovernments.org', 'Nihal Singh Wala', 'Nihal Singh Wala', nextval('seq_eg_city'), true, 0, 1, 1, now(), now(), '1406',  '14', 'Moga', null,null, (select id from eg_citypreferences), 'Ferozepur Region', 'NP');