Create Database if not exists TravelOnTheGo;
use TravelOnTheGo;

create table if not exists PASSENGER
(Passenger_name varchar(50),
 Category varchar(20),
 Gender varchar(2),
 Boarding_City varchar(20),
 Destination_City varchar(20),
 Distance int,
 Bus_Type varchar(20)
);

insert into PASSENGER values("Sejal","AC","F","Bengaluru","Chennai",'350',"Sleeper"),
("Anmol", "Non-AC", "M", "Mumbai", "Hyderabad", '700', "Sitting"),
("Pallavi", "AC" ,"F", "Panaji", "Bengaluru", '600', "Sleeper"),
("Khusboo", "AC", "F", "Chennai", "Mumbai", '1500', "Sleeper"),
("Udit", "Non-AC", "M", "Trivandrum", "panaji", '1000', "Sleeper"),
("Ankur", "AC", "M", "Nagpur", "Hyderabad", '500', "Sitting"),
("Hemant", "Non-AC", "M", "panaji", "Mumbai", '700', "Sleeper"),
("Manish", "Non-AC", "M", "Hyderabad", "Bengaluru", '500', "Sitting"),
("Piyush", "AC", "M", "Pune", "Nagpur", '700', "Sitting");

create table if not exists PRICE
(
 Bus_Type varchar(20),
 Distance int,
 Price int
 );

  insert into PRICE values("Sleeper", '350', '770'),
("Sleeper", '500', '1100'),
("Sleeper", '600', '1320'),
("Sleeper", '700', '1540'),
("Sleeper", '1000', '2200'),
("Sleeper", '1200', '2640'),
("Sleeper", '1500', '2700'),
("Sitting", '500', '620'),
("Sitting", '500', '620'),
("Sitting", '600', '744'),
("Sitting", '700', '868'),
("Sitting", '1000', '1240'),
("Sitting", '1200', '1488'),
("Sitting", '1500', '1860');


3) How many females and how many male passengers travelled for a minimum distance of
#600 KM s?


select Gender, count(Gender) as "Number of Customer"
from PASSENGER
where distance>=600
group by Gender;


4) Find the minimum ticket price for Sleeper Bus
select min(price) as "minimum ticket price for Sleeper Bus" from `price` where Bus_Type="Sleeper";


select min(price) as "minimum ticket price for Sleeper Bus" from 
PRICE where Bus_Type="Sleeper";



5) Select passenger names whose names start with character 'S' 

select Passenger_name from PASSENGER where Passenger_name like 'S%';



6) Calculate price charged for each passenger displaying Passenger name, Boarding City,
Destination City, Bus_Type, Price in the output


select distinct p.Passenger_name, p.Boarding_City, p.Destination_City, p.Bus_Type, c.price
from PRICE c 
right join PASSENGER p
on c.Distance=p.Distance and c.Bus_Type=p.Bus_Type;



7) What is the passenger name and his/her ticket price who travelled in Sitting bus for a
distance of 1000 KM s 

select p.Passenger_name, c.Price from PASSENGER p
inner join PRICE c on c.Bus_Type=p.Bus_Type
where p.Distance>=1000 and p.Bus_Type="Sitting";


8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji?


select c.price, c.Bus_Type from PRICE c where  c.distance in
(select distance from PASSENGER p where p.Passenger_name="Pallavi" and 
p.Boarding_City="Panaji" and p.Destination_City="Bengaluru");


9) List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order.

select distinct Distance from PASSENGER order by Distance desc; 


10) Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables 

select Passenger_name as 'Passenger Name' , distance * 100.0 /sum(distance)over() 
as '% of Total Distance'
from PASSENGER;


11) Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise


select distinct c.distance, c.price,
case
when c.price>1000 then 'Expensive'
when c.price>500 and c.price<1000 then 'Average Cost'
else 'Cheap'
end as verdict
from PRICE c;