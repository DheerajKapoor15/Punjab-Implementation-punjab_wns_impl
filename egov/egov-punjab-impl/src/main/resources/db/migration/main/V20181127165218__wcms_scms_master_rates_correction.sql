update egwtr_watercharge_rates set fromplotarea=0 where fromplotarea is null and ratetype='PLOT_BASED';
update egwtr_watercharge_rates set fromnooftaps=0 where fromnooftaps is null and ratetype='TAP_BASED';

update egswtax_seweragecharge_rates set fromplotarea=0 where fromplotarea is null and ratetype='PLOT_BASED';
update egswtax_seweragecharge_rates set fromnoofseats=0 where fromnoofseats is null and ratetype='SEAT_BASED';