CREATE TABLE egswtax_stg_usagetype (
    code character varying(25),
    name character varying(50),
    orderid integer,
	ismigrated boolean default false
);

CREATE TABLE egswtax_stg_seweragecharge_rates (
	ratetype varchar(50),
	usagetype character varying(25),
	fromplotsize bigint,
	toplotsize bigint,
	fromnoofseats integer,
	tonoofseats integer,
	effectivefromdate timestamp without time zone,
	effectivetodate timestamp without time zone,
	billamount double precision,
	fixedbillamount double precision,
	ismigrated boolean default false
);

CREATE TABLE egswtax_stg_connection (
	ownername character varying(100),
	aadharno character varying(12),
	mobileno character varying(10),
	emailid character varying(128),
	dob timestamp without time zone,
	guardianrelation character varying(32),
	guardian character varying(100),
	corraddress character varying(256),
	gender character varying(12),
	houseno character varying(32),
	buildingname character varying(100),
	landmark character varying(256),
	locality character varying(25),
	street character varying(256),
	pincode character varying(6),
	billingtype character varying(32),
	custombillamount double precision,
	plotsize double precision,
	resdseats bigint,
	nonresdseats bigint,
	propertyidentifier character varying(50),
	oldconsumernumber character varying(50),
	waterconnectionnumber character varying(50),
	ledgerid character varying(50),
	billgroupid character varying(50),
	connectiondate timestamp without time zone,
	usagetype character varying(25),
	securitydeposit double precision,
	status character varying(10),
	diconnectiondate timestamp without time zone,
	currentbillingcycle character varying(10),
	lastbilldate timestamp without time zone,
	ismigrated boolean default false,
	error character varying(4000)
);

CREATE TABLE egswtax_stg_connection_dcb (
	oldconsumernumber character varying(50),
	billingcycle character varying(16),
	chargeamount double precision,
	chargecollection double precision,
	penaltyamount double precision,
	penaltycollection double precision,
	interestamount double precision,
	interestcollection double precision,
	ismigrated boolean default false
);

