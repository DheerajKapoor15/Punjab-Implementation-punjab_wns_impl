delete from egwtr_meter_rent;

INSERT INTO egwtr_meter_rent(id, usagetype, rate, fromdate, todate, fromconsumption, toconsumption) VALUES (nextval('seq_egwtr_meter_rent'), (select id from egwtr_usage_type where name='DOMESTIC'), 2, '2019-01-01', '2019-06-30', 0, 0);
INSERT INTO egwtr_meter_rent(id, usagetype, rate, fromdate, todate, fromconsumption, toconsumption) VALUES (nextval('seq_egwtr_meter_rent'), (select id from egwtr_usage_type where name='COMMERCIAL'),6, '2019-01-01', '2019-06-30', 0, 0);
INSERT INTO egwtr_meter_rent(id, usagetype, rate, fromdate, todate, fromconsumption, toconsumption) VALUES (nextval('seq_egwtr_meter_rent'), (select id from egwtr_usage_type where name='DOMESTIC_EXEMPTED'), 0, '2019-01-01', '2019-06-30', 0, 0);
INSERT INTO egwtr_meter_rent(id, usagetype, rate, fromdate, todate, fromconsumption, toconsumption) VALUES (nextval('seq_egwtr_meter_rent'), (select id from egwtr_usage_type where name='INSTITUTIONAL'),6, '2019-01-01', '2019-06-30', 0, 0);

INSERT INTO egwtr_meter_rent(id, usagetype, rate, fromdate, todate, fromconsumption, toconsumption) VALUES (nextval('seq_egwtr_meter_rent'), (select id from egwtr_usage_type where name='DOMESTIC'), 2, '2019-07-01', '2025-06-30', 0, 0);
INSERT INTO egwtr_meter_rent(id, usagetype, rate, fromdate, todate, fromconsumption, toconsumption) VALUES (nextval('seq_egwtr_meter_rent'), (select id from egwtr_usage_type where name='COMMERCIAL'),6, '2019-07-01', '2025-06-30', 0, 0);
INSERT INTO egwtr_meter_rent(id, usagetype, rate, fromdate, todate, fromconsumption, toconsumption) VALUES (nextval('seq_egwtr_meter_rent'), (select id from egwtr_usage_type where name='DOMESTIC_EXEMPTED'), 0, '2019-07-01', '2025-06-30', 0, 0);
INSERT INTO egwtr_meter_rent(id, usagetype, rate, fromdate, todate, fromconsumption, toconsumption) VALUES (nextval('seq_egwtr_meter_rent'), (select id from egwtr_usage_type where name='INSTITUTIONAL'),6, '2019-07-01', '2025-06-30', 0, 0);