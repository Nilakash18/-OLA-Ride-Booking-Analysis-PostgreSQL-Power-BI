CREATE TABLE olabookings (
    Date DATE,
    Time TIME,
    Booking_ID VARCHAR(20) PRIMARY KEY,
    Booking_Status VARCHAR(30),
    Customer_ID VARCHAR(20),
    Vehicle_Type VARCHAR(50),
    Pickup_Location VARCHAR(100),
    Drop_Location VARCHAR(100),
    V_TAT INT,
    C_TAT INT,
    Canceled_Rides_by_Customer VARCHAR(100),
    Canceled_Rides_by_Driver VARCHAR(100),
    Incomplete_Rides VARCHAR(10),
    Incomplete_Rides_Reason VARCHAR(255),
    Booking_Value NUMERIC(10,2),
    Payment_Method VARCHAR(30),
    Ride_Distance NUMERIC(6,2),
    Driver_Ratings NUMERIC(2,1),
    Customer_Rating NUMERIC(2,1),
    Vehicle_Images TEXT
);
SELECT * FROM olabookings;


-- 1. How many total bookings were received?
SELECT COUNT(*) AS total_booking FROM olabookings;


-- 2. How many total bookings were received sucess?
SELECT * FROM olabookings
WHERE booking_status='Success';


-- 3. What percentage of bookings were successful?


SELECT ROUND((COUNT(CASE WHEN booking_status='Success'THEN 1 END))*100/COUNT(*),2) AS persent_success
FROM olabookings;

--4. Which vehicle type generates the highest revenue?



SELECT SUM(booking_value) AS revenue,vehicle_type
FROM olabookings
WHERE booking_status='Success'
GROUP BY vehicle_type -- sum (booking_value) in the base of vehicale
ORDER BY revenue desc;

-- 5 Which city/location receives the highest number of pickups?


SELECT pickup_location ,COUNT(*) AS total_booking FROM olabookings
GROUP BY pickup_location
ORDER BY total_booking desc;



--6. Which drop location is most popular?
SELECT drop_location ,COUNT(*) AS  popular_drop  FROM olabookings
GROUP BY drop_location
ORDER BY popular_drop desc
LIMIT 1




--7 What is the cancellation rate?

--Cancellation Rate =(Cancelled Bookings/Total Bookings)*100

SELECT 
ROUND (COUNT(CASE WHEN booking_status LIKE 'Canceled%' THEN 1 END )*100/COUNT(*),2) AS cancellation_rate
FROM olabookings;

--8. Why do customers cancel rides?

SELECT Canceled_rides_by_Customer,COUNT(*) AS customer_cancel_rides
FROM olabookings
GROUP BY Canceled_rides_by_Customer;

-- 8. Why do drivers cancel rides?


SELECT Canceled_rides_by_driver,COUNT(*) AS customer_cancel_driver
FROM olabookings
GROUP BY Canceled_rides_by_driver;


--9. Which payment method is used the most?

SELECT payment_method,COUNT(*) AS payment_option
FROM olabookings
WHERE payment_method <> 'null' -- null bada 
GROUP BY payment_method
ORDER BY payment_option DESC
LIMIT 3
;
-- 10. Which payment method generates the highest revenue?
SELECT payment_method,SUM(booking_value) AS revnue
FROM olabookings
WHERE booking_status='Success'
AND payment_method <> 'null' 
GROUP BY payment_method
ORDER BY revnue DESC
;
-- 11. What is the average booking value?

SELECT AVG(booking_value) AS avg_booking_value FROM olabookings
WHERE booking_status='Success';


--12  Which customers book rides most frequently?
SELECT  customer_id , count(*) AS  total_booking 
FROM olabookings
WHERE booking_status='Success'
GROUP BY customer_id 
ORDER BY total_booking DESC;

--13. Which vehicle type is booked the most?
SELECT vehicle_type, COUNT (*)  AS most_use_vehicle
FROM olabookings
GROUP BY vehicle_type;


--14. What is the average ride distance by vehicle type?

SELECT AVG(ride_distance) AS avg_ride_distance,vehicle_type
FROM olabookings
GROUP BY vehicle_type;


--15. Which bookings have the highest value?

SELECT booking_value ,customer_id ,booking_id
FROM olabookings
ORDER BY booking_value DESC
LIMIT 1;



--16. What are the busiest booking hours?


SELECT EXTRACT (HOUR FROM Time::Time) AS Booking_hours,count(*) AS total_booking_hours
FROM olabookings
GROUP BY Booking_hours
ORDER BY total_booking_hours DESC;

-- 17 which day has the highest bookings?


SELECT date,COUNT(*) AS  high_booking_day
FROM olabookings
WHERE booking_status='Success'
GROUP BY date
order by high_booking_day DESC;


--18 WHICH Vehicle type is the highest cncellation rate?


SELECT vehicle_type,
ROUND (COUNT(CASE WHEN booking_status LIKE 'Canceled%' THEN 1 END )*100/COUNT(*),2) AS cancellation_rate
FROM olabookings
GROUP BY vehicle_type
ORDER BY cancellation_rate DESC
;


--19 what is the average driver rating by vehicle type?
SELECT ROUND(AVG(driver_ratings),2) AS avg_driver_rating, vehicle_type
FROM olabookings
GROUP BY vehicle_type
ORDER BY avg_driver_rating DESC

--20 what is the average CUSTOMER rating by vehicle TYPE?
SELECT ROUND(AVG(customer_rating),2) AS avg_customer_rating, vehicle_type
FROM olabookings
GROUP BY vehicle_type
ORDER BY avg_customer_rating DESC


















