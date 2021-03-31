
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