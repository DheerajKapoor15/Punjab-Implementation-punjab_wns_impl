--demand reason masters for estimation charges

INSERT INTO eg_demand_reason_master(id, reasonmaster, category, isdebit, module,code,"order", create_date, modified_date,isdemand) VALUES (nextval('seq_eg_demand_reason_master'), 'Water Road Cutting Charges', (select id from eg_reason_category where code='TAX'),'N',(select id from eg_module where name = 'Water Tax Management'),'WTAXROADCUTTING', 2, now(), now(),true);

INSERT INTO eg_demand_reason_master(id, reasonmaster, category, isdebit, module,code,"order", create_date, modified_date,isdemand) VALUES (nextval('seq_eg_demand_reason_master'), 'Water SuperVision Charges', (select id from eg_reason_category where code='TAX'),'N',(select id from eg_module where name = 'Water Tax Management'),'WTAXSUPERVISION', 3, now(), now(),true);

INSERT INTO eg_demand_reason_master(id, reasonmaster, category, isdebit, module,code,"order", create_date, modified_date,isdemand) VALUES (nextval('seq_eg_demand_reason_master'), 'Water Security Deposit', (select id from eg_reason_category where code='TAX'),'N',(select id from eg_module where name = 'Water Tax Management'),'WTAXSECURITY', 1, now(), now(),true);

INSERT INTO eg_demand_reason_master(id, reasonmaster, category, isdebit, module,code,"order", create_date, modified_date,isdemand) VALUES (nextval('seq_eg_demand_reason_master'), 'Water Application Charges', (select id from eg_reason_category where code='TAX'),'N',(select id from eg_module where name = 'Water Tax Management'),'WTAXAPPLICATION', 4, now(), now(),true);

INSERT INTO eg_demand_reason_master(id, reasonmaster, category, isdebit, module,code,"order", create_date, modified_date,isdemand) VALUES (nextval('seq_eg_demand_reason_master'), 'Water Other Charges', (select id from eg_reason_category where code='TAX'),'N',(select id from eg_module where name = 'Water Tax Management'),'WTAXOTHERS', 5, now(), now(),true);

--demand reasons for estimation charges


Insert into EG_DEMAND_REASON (ID,ID_DEMAND_REASON_MASTER,ID_INSTALLMENT,PERCENTAGE_BASIS,ID_BASE_REASON,create_date,modified_date,GLCODEID) select nextval('seq_eg_demand_reason'), (select id from eg_demand_reason_master where reasonmaster in ('Water Road Cutting Charges') and module=(select id from eg_module where name='Water Tax Management')), inst.id, null, null, current_timestamp, current_timestamp, (select id from chartofaccounts where glcode = '1407011') from eg_installment_master inst where inst.id_module=(select id from eg_module where name='Water Tax Management') and start_date in (select start_date from eg_installment_master where id_module=(select id from eg_module where name='Water Tax Management') and inst.installment_type='Quarterly');


Insert into EG_DEMAND_REASON (ID,ID_DEMAND_REASON_MASTER,ID_INSTALLMENT,PERCENTAGE_BASIS,ID_BASE_REASON,create_date,modified_date,GLCODEID) select nextval('seq_eg_demand_reason'), (select id from eg_demand_reason_master where reasonmaster in ('Water SuperVision Charges') and module=(select id from eg_module where name='Water Tax Management')), inst.id, null, null, current_timestamp, current_timestamp, (select id from chartofaccounts where glcode = '1407011') from eg_installment_master inst where inst.id_module=(select id from eg_module where name='Water Tax Management') and start_date in (select start_date from eg_installment_master where id_module=(select id from eg_module where name='Water Tax Management') and inst.installment_type='Quarterly');


Insert into EG_DEMAND_REASON (ID,ID_DEMAND_REASON_MASTER,ID_INSTALLMENT,PERCENTAGE_BASIS,ID_BASE_REASON,create_date,modified_date,GLCODEID) select nextval('seq_eg_demand_reason'), (select id from eg_demand_reason_master where reasonmaster in ('Water Security Deposit') and module=(select id from eg_module where name='Water Tax Management')), inst.id, null, null, current_timestamp, current_timestamp, (select id from chartofaccounts where glcode = '1407011') from eg_installment_master inst where inst.id_module=(select id from eg_module where name='Water Tax Management') and start_date in (select start_date from eg_installment_master where id_module=(select id from eg_module where name='Water Tax Management') and inst.installment_type='Quarterly');


Insert into EG_DEMAND_REASON (ID,ID_DEMAND_REASON_MASTER,ID_INSTALLMENT,PERCENTAGE_BASIS,ID_BASE_REASON,create_date,modified_date,GLCODEID) select nextval('seq_eg_demand_reason'), (select id from eg_demand_reason_master where reasonmaster in ('Water Application Charges') and module=(select id from eg_module where name='Water Tax Management')), inst.id, null, null, current_timestamp, current_timestamp, (select id from chartofaccounts where glcode = '1407011') from eg_installment_master inst where inst.id_module=(select id from eg_module where name='Water Tax Management') and start_date in (select start_date from eg_installment_master where id_module=(select id from eg_module where name='Water Tax Management') and inst.installment_type='Quarterly');


Insert into EG_DEMAND_REASON (ID,ID_DEMAND_REASON_MASTER,ID_INSTALLMENT,PERCENTAGE_BASIS,ID_BASE_REASON,create_date,modified_date,GLCODEID) select nextval('seq_eg_demand_reason'), (select id from eg_demand_reason_master where reasonmaster in ('Water Other Charges') and module=(select id from eg_module where name='Water Tax Management')), inst.id, null, null, current_timestamp, current_timestamp, (select id from chartofaccounts where glcode = '1407011') from eg_installment_master inst where inst.id_module=(select id from eg_module where name='Water Tax Management') and start_date in (select start_date from eg_installment_master where id_module=(select id from eg_module where name='Water Tax Management') and inst.installment_type='Quarterly');