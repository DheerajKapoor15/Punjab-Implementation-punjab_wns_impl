ALTER TABLE egwtr_road_category
ADD RoadCuttingCharges Decimal(6,2);

update egwtr_road_category set roadcuttingcharges =180 where name='Premix Carpet';
update egwtr_road_category set roadcuttingcharges =240 where name='BM and Premix Road';
update egwtr_road_category set roadcuttingcharges =9  where name='Berm Cutting (Katcha)';
update egwtr_road_category set roadcuttingcharges =45  where name='Brick Paving';
update egwtr_road_category set roadcuttingcharges =180  where name='CC Road';
update egwtr_road_category set roadcuttingcharges =270  where name='Interlocking Paver Block';
update egwtr_road_category set roadcuttingcharges =0  where name='Under Scheme';
update egwtr_road_category set roadcuttingcharges =0  where name='Open Pipe';
