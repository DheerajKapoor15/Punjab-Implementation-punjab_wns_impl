create table IF NOT EXISTS generic.wsweeklyemailer (
city character varying(256),
revenue_collected double precision,
revenue_collected_week5 double precision,
revenue_collected_week4 double precision,
revenue_collected_week3 double precision,
revenue_collected_week2 double precision,
revenue_collected_week1 double precision,
services_applied bigint,
services_applied_week5 bigint,
services_applied_week4 bigint,
services_applied_week3 bigint,
services_applied_week2 bigint,
services_applied_week1 bigint
);
