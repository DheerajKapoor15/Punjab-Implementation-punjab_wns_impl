insert into eg_citypreferences ( id, municipalitylogo, createdby, createddate, lastmodifiedby, lastmodifieddate, version, municipalityname, municipalitycontactno ,municipalityaddress, municipalitycontactemail, municipalitygislocation, municipalitycallcenterno, municipalityfacebooklink ,municipalitytwitterlink, googleapikey, recaptchapk, recaptchapub ) values (nextval('seq_eg_citypreferences'), null, 1, now(), 1, now(), 0, 'Garhdiwala Municipal Council', '01886-260339', 'Garhdiwala Municipal Council', 'eomcgarhdiwala@yahoo.co.in', 'https://www.google.com/maps/@31.7412,75.7560,17z', null, null, null, 'AIzaSyCzRLAPShKqs7rj2yctW0zTVTidlVt1t9I', '6LeeCGMUAAAAAOlhzAooYv1YO2nc2a60WIqNBvIu', '6LeeCGMUAAAAAGJbI4bQbndrX_6jys9bbiBkfDFf');

INSERT INTO eg_city (domainurl, name, localname, id, active, version, createdby, lastmodifiedby, createddate, lastmodifieddate, code,  districtcode, districtname, longitude, latitude, preferences, regionname, grade) VALUES ('garhdiwala-uat.egovernments.org', 'Garhdiwala', 'Garhdiwala', nextval('seq_eg_city'), true, 0, 1, 1, now(), now(), '902',  '9', 'Hoshiarpur', null,null, (select id from eg_citypreferences), 'Jalandhar Region', 'MC Class III');
