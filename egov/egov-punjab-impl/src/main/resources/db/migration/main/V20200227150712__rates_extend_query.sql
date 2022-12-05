update egwtr_watermeteredcharge_rates set effectivetodate='2021-03-31' where effectivetodate=(select max(effectivetodate) from egwtr_watermeteredcharge_rates);

update egwtr_watercharge_rates set effectivetodate='2021-03-31' where effectivetodate=(select max(effectivetodate) from egwtr_watercharge_rates);

update egswtax_seweragecharge_rates set effectivetodate='2021-03-31' where effectivetodate=(select max(effectivetodate) from egswtax_seweragecharge_rates);