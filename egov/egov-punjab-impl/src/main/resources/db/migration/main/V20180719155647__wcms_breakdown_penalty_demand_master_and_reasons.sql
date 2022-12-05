--demand reason masters

INSERT INTO eg_demand_reason_master(id, reasonmaster, category, isdebit, module,code,"order", create_date, modified_date,isdemand) VALUES (nextval('seq_eg_demand_reason_master'), 'Breakdown Penalty', (select id from eg_reason_category where code='PENALTY'),'N',(select id from eg_module where name = 'Water Tax Management'),'BREAKDOWN_PENALTY', 4, now(), now(),true);

--demand reasons


Insert into EG_DEMAND_REASON (ID,ID_DEMAND_REASON_MASTER,ID_INSTALLMENT,PERCENTAGE_BASIS,ID_BASE_REASON,create_date,modified_date,GLCODEID) select nextval('seq_eg_demand_reason'), (select id from eg_demand_reason_master where reasonmaster='Breakdown Penalty' and module=(select id from eg_module where name='Water Tax Management')), inst.id, null, null, current_timestamp, current_timestamp, (select id from chartofaccounts where glcode = '1718001') from eg_installment_master inst where inst.id_module=(select id from eg_module where name='Water Tax Management') and start_date in (select start_date from eg_installment_master where id_module=(select id from eg_module where name='Water Tax Management') and inst.installment_type='Quarterly');