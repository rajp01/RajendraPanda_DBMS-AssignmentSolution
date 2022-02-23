Create Database if not exists `TravelOnTheGo-directory` ;
use `TravelOnTheGo-directory`;

drop table if exists `passenger`, `price`;

create table if not exists `PASSENGER`(
`PASSENGER_NAME` varchar(50) primary key,
`CATEGORY` varchar(50),
`GENDER` varchar(50),
`BOARDING_CITY` varchar(50),
`DESTINATION_CITY` varchar(50),
`DISTANCE` int NOT NULL,
`BUS_TYPE` varchar(10) NOT NULL
);


insert into `PASSENGER` values("Sejal","AC",'F',"Bengaluru","Chennai",'350', "Sleeper");
insert into `PASSENGER` values("Anmol","Non-AC",'M',"Mumbai","Hyderabad",'700', "Sitting");
insert into `PASSENGER` values("Pallavi","AC",'F',"Panaji","Bengaluru",'600', "Sleeper");
insert into `PASSENGER` values("Khusboo","AC",'F',"Chennai","Mumbai",'1500', "Sleeper");
insert into `PASSENGER` values("Udit","Non-AC",'M',"Trivandrum","Panaji",'1000', "Sleeper");
insert into `PASSENGER` values("Ankur","AC",'M',"Nagpur","Hyderabad",'500', "Sitting");
insert into `PASSENGER` values("Hemant","Non-AC",'M',"Mumbai","Chennai",'700', "Sleeper");
insert into `PASSENGER` values("Manish","Non-AC",'M',"Bengaluru","Chennai",'500', "Sitting");
insert into `PASSENGER` values("Piyush","AC",'M',"Pune","Nagpur",'700', "Sitting");


CREATE TABLE IF NOT EXISTS `PRICE` (
  `BUS_TYPE` varchar(10) NOT NULL,
  `DISTANCE` int  NOT NULL,
  `PRICE` int primary key,
   FOREIGN KEY (`BUS_TYPE`) REFERENCES PASSENGER(`BUS_TYPE`)
);

INSERT INTO `PRICE` VALUES("Sleeper",'350',"750");
INSERT INTO `PRICE` VALUES("Sleeper",'500',"1100");
INSERT INTO `PRICE` VALUES("Sleeper",'600',"1320");
INSERT INTO `PRICE` VALUES("Sleeper",'700',"1540");
INSERT INTO `PRICE` VALUES("Sleeper",'1000',"2200");
INSERT INTO `PRICE` VALUES("Sleeper",'1200',"2640");
INSERT INTO `PRICE` VALUES("Sleeper",'1500',"2700");
INSERT INTO `PRICE` VALUES("Sitting",'500',"620");
INSERT INTO `PRICE` VALUES("Sitting",'600',"744");
INSERT INTO `PRICE` VALUES("Sitting",'700',"868");
INSERT INTO `PRICE` VALUES("Sitting",'1000',"1240");
INSERT INTO `PRICE` VALUES("Sitting",'1200',"1488");
INSERT INTO `PRICE` VALUES("Sitting",'1500',"1860");


/*Q.3 How many females and how many male passengers travelled for a minimum distance of 
600 KM s?*/

Select passenger.gender, count(passenger.gender)
as count from passenger
inner join `price`
on passenger.distance =`price`.distance
where `price`.distance >= 600
group by passenger.gender;


/*Q.4 Find the minimum ticket price for Sleeper Bus.*/

select price.*, passenger.bus_type
from `price`
inner join `price`
on `passenger`.bus_type = price.bus_type
having min(`price`.price);


/* Q.5 Select passenger names whose names start with character 'S' */

select passenger_name from `passenger` where (passenger_name like 'S%');


/*Q.6  Calculate price charged for each passenger displaying Passenger name, Boarding City, 
Destination City, Bus_Type, Price in the output */

Select passenger.passenger_name, passenger.boarding_city, passenger.destination_city,passenger.bus_type,price.price
from passenger,price
inner join `price`
on passenger.distance =`price`.distance
group by passenger.bus_type;


/*Q.7 What are the passenger name/s and his/her ticket price who travelled in the Sitting bus 
for a distance of 1000 KM s */

select passenger_name, gender, price.price 
from `passenger`,`price` 
inner join `price`
on passenger.distance =`price`.distance
where (bus_type like 'Sitting' AND distance like '1000');


/*Q.8 What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to 
Panaji?*/
select price.price, passenger.bus_type
from `price`,`passenger`
inner join `bus_type`
on `passenger`.bus_type = price.bus_type
where (`passenger`.passenger_name = 'Pallavi' AND boarding_city = 'Bangalore' AND destination_city = 'Panaji') ;

/*Q.11 Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise */

DELIMITER &&
CREATE PROCEDURE proc1()
BEGIN
select passenger.distance, price.price,
case 
    when price.price > '1000' THEN 'Expensive'
    when price.price < '1000' AND price.price > '500' THEN 'Average Cost'
    ELSE 'Cheap'
END AS verdict from `price` inner join `passenger` on passenger.distance=price.distance;
END &&
DELIMITER ; 

call proc1();




