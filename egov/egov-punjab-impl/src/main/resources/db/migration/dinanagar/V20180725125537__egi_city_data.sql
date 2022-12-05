insert into eg_citypreferences ( id, municipalitylogo, createdby, createddate, lastmodifiedby, lastmodifieddate, version, municipalityname, municipalitycontactno ,municipalityaddress, municipalitycontactemail, municipalitygislocation, municipalitycallcenterno, municipalityfacebooklink ,municipalitytwitterlink, googleapikey, recaptchapk, recaptchapub ) values (nextval('seq_eg_citypreferences'), null, 1, now(), 1, now(), 0, 'Dina Nagar Municipal Council', '01875-220050', 'Dina Nagar Municipal Council', 'eomcdinanagar33@gmail.com', 'https://www.google.com/maps/@32.1266,75.4636,17z', null, null, null, 'AIzaSyCzRLAPShKqs7rj2yctW0zTVTidlVt1t9I', '6LeeCGMUAAAAAOlhzAooYv1YO2nc2a60WIqNBvIu', '6LeeCGMUAAAAAGJbI4bQbndrX_6jys9bbiBkfDFf');

INSERT INTO eg_city (domainurl, name, localname, id, active, version, createdby, lastmodifiedby, createddate, lastmodifieddate, code,  districtcode, districtname, longitude, latitude, preferences, regionname, grade) VALUES ('dinanagar-uat.egovernments.org', 'Dina Nagar', 'Dina Nagar', nextval('seq_eg_city'), true, 0, 1, 1, now(), now(), '0804', '8', 'Gurdaspur', null,null, (select id from eg_citypreferences), 'Amritsar Region', 'MC Class II');