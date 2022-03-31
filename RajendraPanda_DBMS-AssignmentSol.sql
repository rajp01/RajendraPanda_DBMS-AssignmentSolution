Create Database if not exists `TravelOnTheGo-directory` ;
use `TravelOnTheGo-directory`;

drop table if exists `passenger`;

create table if not exists `PASSENGER`(
`PASSENGER_NAME` varchar(30) not null,
`CATEGORY` varchar(30),
`GENDER` varchar(30),
`BOARDING_CITY` varchar(30),
`DESTINATION_CITY` varchar(30),
`DISTANCE` int,
`BUS_TYPE` varchar(10) NOT NULL
);


insert into `PASSENGER` values("Sejal","AC",'F',"Bengaluru","Chennai",'350', "Sleeper");
insert into `PASSENGER` values("Anmol","Non-AC",'M',"Mumbai","Hyderabad",'700', "Sitting");
insert into `PASSENGER` values("Pallavi","AC",'F',"Panaji","Bengaluru",'600', "Sleeper");
insert into `PASSENGER` values("Khusboo","AC",'F',"Chennai","Mumbai",'1500', "Sleeper");
insert into `PASSENGER` values("Udit","Non-AC",'M',"Trivandrum","Panaji",'1000', "Sleeper");
insert into `PASSENGER` values("Ankur","AC",'M',"Nagpur","Hyderabad",'500', "Sitting");
insert into `PASSENGER` values("Hemant","Non-AC",'M',"Panaji","Mumbai",'700', "Sleeper");
insert into `PASSENGER` values("Manish","Non-AC",'M',"Hyderabad","Bengaluru",'500', "Sitting");
insert into `PASSENGER` values("Piyush","AC",'M',"Pune","Nagpur",'700', "Sitting");

SELECT * from PASSENGER;
drop table if exists `price`;
CREATE TABLE IF NOT EXISTS `PRICE` (
  `BUS_TYPE` varchar(10) NOT NULL,
  `DISTANCE` int  NOT NULL,
  `PRICE` int  );

INSERT INTO `PRICE` VALUES("Sleeper",'350',"770");
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

SELECT * from PRICE;
/*Q.3 How many females and how many male passengers travelled for a minimum distance of 
600 KM s?*/

Select gender, count(gender)
as count from passenger
where distance >= 600
group by gender;


/*Q.4 Find the minimum ticket price for Sleeper Bus.*/

select min(price) from PRICE
where bus_type = 'Sleeper';



/* Q.5 Select passenger names whose names start with character 'S' */

select passenger_name from `passenger` where (passenger_name like 'S%')
order by passenger_name;


/*Q.6  Calculate price charged for each passenger displaying Passenger name, Boarding City, 
Destination City, Bus_Type, Price in the output */

Select passenger.passenger_name, passenger.boarding_city, passenger.destination_city,passenger.bus_type,price.price
from passenger,price
where (passenger.bus_type = price.bus_type
and passenger.distance =price.distance);



/*Q.7 What are the passenger name/s and his/her ticket price who travelled in the Sitting bus 
for a distance of 1000 KM s */

select a.passenger_name, b.price
from passenger a, price b
where (a.bus_type = "sitting" and b.bus_type = "sitting"
and a.distance =700 and b.distance = 700);


/*Q.8 What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to 
Panaji?*/
select price from price where distance =(select distance from passenger
where (passenger_name = "Pallavi" and boarding_city ="Bengaluru" AND destination_city = "Panaji"));

/*Q.9 WList the distances from the "Passenger" table which are 
unique (non-repeated distances) in descending order.*/

select distinct(Distance) FROM passenger order by distance desc;

/*Q.10 Display the passenger name and percentage of distance travelled by that passenger from the total distance travelled by 
all passengers without using user variables*/

with total as ( select sum(distance) as total from passenger)
    select passenger_Name,(distance / total.total)*100 as percentage_travel from Passenger,total ;

/*Q.11 Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise */

DELIMITER &&
CREATE PROCEDURE proc4()
BEGIN
select distance, price,
case 
    when price.price > '1000' THEN 'Expensive'
    when price < '1000' AND price > '500' THEN 'Average Cost'
    ELSE 'Cheap'
END AS verdict from price ;
END &&
DELIMITER ; 

call proc4();




