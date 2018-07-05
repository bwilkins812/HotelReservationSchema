USE HotelReservation;


#Rooms have assigned numbers, floors, and occupancy limits
SELECT * FROM RoomInformation;

#Rooms have rates
SELECT * FROM RoomType;

#To see the standard rate for a specific room type
SELECT * FROM RoomType
WHERE RoomTypeID = 3;

#To see a specific room
SELECT * FROM RoomInformation
WHERE RoomID = 29;

#Rooms have types
SELECT * FROM RoomType;

#To see a specific rooms type
SELECT RoomID, rt.RoomTypeID, RoomType, StandardRate
FROM RoomType rt
INNER JOIN RoomInformationRoomType rirt
WHERE rirt.RoomID = 18 AND rt.RoomTypeID = 2;

#Rooms have amenities
SELECT * FROM RoomAmenities;

#See a list of Customers with their reservation id and customer id
SELECT r.ReservationID, r.CustomerID, c.FirstName, c.LastName 
FROM Reservations r INNER JOIN Customers c
WHERE r.CustomerID = c.CustomerID;

#Get a count of total customers
SELECT COUNT(CustomerID) AS Total_Customers FROM Customers;

#A customer can make many reservations
SELECT * FROM Reservations
WHERE CustomerID = 18;

#Basic customer contact information is being tracked
SELECT * FROM Customers;

#A customer can book multiple rooms on the same reservation
SELECT * FROM ReservationsRoomInformation;

#Reservations have date ranges
SELECT * FROM DateRange;

#Reservations list names and ages of guests
SELECT ReservationID, FirstName, MiddleInitial, AgeIfUnder18
FROM ReservationsRoomOccupants INNER JOIN RoomOccupants
WHERE ReservationsRoomOccupants.OccupantID = RoomOccupants.OccupantID;

#Room prices can vary depending on season or other events
SELECT * FROM RoomTypeSeasonalAndEventRates;

#AddOns can be tracked and prices can be changed
SELECT * FROM AddOns;

#AddOns can be tracked
SELECT ReservationID, AddOnName, AddOnPrice, AddOnDate
FROM ReservationsAddOns INNER JOIN AddOns
WHERE ReservationsAddOns.AddOnID = AddOns.AddOnID;

#Other room charges can be tracked and general charges can be itemized
SELECT ReservationID, RoomChargeName, RoomChargeItem, RoomChargePrice, ChargeDate
FROM ReservationsRoomCharges INNER JOIN RoomCharges
WHERE ReservationsRoomCharges.RoomChargeID = RoomCharges.RoomChargeID;

#The system allows for promo codes which have date ranges and dollar or percentage amounts off (ex. .85  = 15% off)
SELECT * FROM PromotionCode;

#Promotion codes are attached to the reservation
SELECT * FROM ReservationsPromotionCode;

#Invoice contains header and rows with taxes and total and details table
SELECT * FROM Invoice;

#To see a specific customer number from the invoice
SELECT * FROM Invoice
WHERE CustomerID = 18;

#To see the total number of invoices
SELECT Count(ReservationID)
FROM Invoice;

#To see a specific customers room charges from the invoice, concatenating the customer name and using 'Name' as an alias
SELECT CustomerID, CONCAT(FirstName,' ', LastName) AS Name, RoomChargeName, RoomChargePrice
FROM Invoice
WHERE CustomerID = 18;

#To see a list of all customer names
SELECT CONCAT(FirstName,' ', LastName) AS Name
FROM Customers 
ORDER BY LastName ASC;




