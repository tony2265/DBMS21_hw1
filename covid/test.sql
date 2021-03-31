DROP TABLE IF EXISTS patient_info;

create table patient_info(
    patient_id varchar(10) not NULL,
    sex varchar(10),
    age int,
    province varchar(20),
    city varchar(20),
    infection_case varchar(100),
    primary key (patient_id)
);

load data local infile './patient_info.csv'
into table patient_info
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;


DROP TABLE IF EXISTS search_trend;

create table search_trend(
    date date not NULL,
    cold float,
    flu float,
    pneumonia float,
    coronavirus float,
    primary key (date)
);

load data local infile './patient_info.csv'
into table patient_info
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;