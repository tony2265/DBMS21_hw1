-- patient_info
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

-- search_trend
DROP TABLE IF EXISTS search_trend;

create table search_trend(
    date date not NULL,
    cold float,
    flu float,
    pneumonia float,
    coronavirus float,
    primary key (date)
);

load data local infile './search_trend.csv'
into table search_trend
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- time
DROP TABLE IF EXISTS time;

create table time(
    date date not NULL,
    test int,
    negative int,
    confirmed int,
    released int,
    deceased int,
    primary key (date)
);

load data local infile './time.csv'
into table time
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- time_age
DROP TABLE IF EXISTS time_age;

create table time_age(
    date date not NULL,
    age int not NULL,
    confirmed int,
    deceased int,
    primary key (date,age)
);

load data local infile './time_age.csv'
into table time_age
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- time_gender
DROP TABLE IF EXISTS time_gender;

create table time_gender(
    date date not NULL,
    sex varchar(10) not NULL,
    confirmed int,
    deceased int,
    primary key (date,sex)
);

load data local infile './time_gender.csv'
into table time_gender
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- time_province
DROP TABLE IF EXISTS time_province;

create table time_province(
    date date not NULL,
    province varchar(10) not NULL,
    confirmed int,
    released int,
    deceased int,
    primary key (date,province)
);

load data local infile './time_province.csv'
into table time_province
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- region
DROP TABLE IF EXISTS region;

create table region(
    code int not NULL,
    province varchar(20),
    city varchar(20),
    elementary_school_count int,
    kindergarten_count int,
    university_count int,
    elderly_population_ratio float,
    elderly_alone_ratio float,
    nursing_home_count int,
    primary key (code)
);

load data local infile './region.csv'
into table region
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;

-- weather
DROP TABLE IF EXISTS weather;

create table weather(
    code int not NULL,
    date date not NULL,
    avg_temp float,
    most_wind_direction int,
    avg_relative_humidity float,
    primary key (code,date),
    FOREIGN KEY (code) REFERENCES region(code) 
);

load data local infile './weather.csv'
into table weather
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines;