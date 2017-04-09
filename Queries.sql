
--Creating non partitioned table

CREATE TABLE IF NOT EXISTS real_estate(street string,city string,zip bigint,state string,beds int,baths int, sq_ft int,type string,sale_date string,price bigint,latitude float,longitude float)                         
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;


--Loading Data

LOAD DATA LOCAL INPATH '/home/acadgild/Downloads/real_estate.csv' OVERWRITE INTO TABLE real_estate;

--Setting property

SET hive.exec.dynamic.partition.mode = nonstrict;

--Creating partitioned table

CREATE TABLE IF NOT EXISTS partition_real(city string,baths int,sq_ft int,price bigint,type string)
    PARTITIONED BY (beds int)
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    STORED AS TEXTFILE;
    
--Inserting into partitioned Table

INSERT OVERWRITE TABLE partition_real PARTITION(beds) SELECT city,baths,sq_ft,price,type,beds FROM real_estate where beds>2;

--Displaying From Partitioned Table

SELECT * FROM partition_real;
