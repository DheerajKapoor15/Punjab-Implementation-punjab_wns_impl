INSERT INTO eg_appconfig_values(id, key_id, effective_from, value, version) VALUES (nextval('seq_eg_appconfig_values'), (select id from eg_appconfig where key_name='THIRDPARTY_RECEIPTVOUCHER_DEPT_MAPPING'), now(), 'DEPT_13,DEPT_13', 0);
INSERT INTO eg_appconfig_values(id, key_id, effective_from, value, version) VALUES (nextval('seq_eg_appconfig_values'), (select id from eg_appconfig where key_name='THIRDPARTY_REMITTANCEVOUCHER_DEPT_MAPPING'), now(), 'DEPT_01,DEPT_25', 0);