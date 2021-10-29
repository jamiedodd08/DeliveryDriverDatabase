SELECT * FROM Drivers ORDER BY LastName;



SELECT Shifts.ShiftID, Drivers.DriverID, Drivers.FirstName, Drivers.LastName, GPS.GPSID, Vehicles.Registration, GPS.Latitude, GPS.Longitude, GPS.TimeDate
From GPS 
	INNER JOIN Vehicles ON GPS.Registration = Vehicles.Registration
	INNER JOIN Shifts ON Vehicles.Registration = Shifts.Registration
	INNER JOIN Drivers ON Shifts.DriverID = Drivers.DriverID
WHERE Vehicles.Registration = 'EX20 HXR'
AND GPS.TimeDate BETWEEN '2021-02-05 14:00:00' AND '2021-02-05 15:00:00'
AND IF (GPS.TimeDate BETWEEN '00:00:00' AND '11:55:00',Shifts.ShiftType = 'Morning', Shifts.ShiftType = 'Afternoon')
AND Shifts.ShiftDate = DATE(GPS.TimeDate);

	

SELECT d.FirstName, d.LastName, p.ShiftID, s.ShiftDate,COUNT(*) as ParcelCount
FROM Parcels p
	INNER JOIN Shifts s ON p.ShiftID = s.ShiftID
	INNER JOIN Drivers d ON s.DriverID = d.DriverID
WHERE d.DriverID = '1' AND s.ShiftID = '1';



SELECT FirstName, LastName, ShiftType, ShiftDate, ShiftID 
FROM Drivers
INNER JOIN Shifts ON Drivers.DriverID = Shifts.DriverID
WHERE Shifts.ShiftType = 'Morning';



DELIMITER //
CREATE PROCEDURE DriverLocation
(IN reg varchar(8), startt datetime(6), endt datetime(6))
BEGIN
	SELECT Shifts.ShiftID, Drivers.DriverID, Drivers.FirstName, Drivers.LastName, GPS.GPSID, Vehicles.Registration, GPS.Latitude, GPS.Longitude, GPS.TimeDate
	From GPS
		INNER JOIN Vehicles ON GPS.Registration = Vehicles .Registration
		INNER JOIN Shifts ON Vehicles .Registration = Shifts.Registration
		INNER JOIN Drivers ON Shifts.DriverID = Drivers.DriverID
	WHERE Vehicles .Registration = reg
	AND GPS.TimeDate BETWEEN startt AND endt
	AND IF (GPS.TimeDate BETWEEN '00:00:00' AND '11:55:00',Shifts.ShiftType = 'Morning', Shifts.ShiftType = 'Afternoon')
	AND Shifts.ShiftDate = DATE(GPS.TimeDate);
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE parcelcount
(IN driverid int(11), shiftid int(11))
BEGIN
	SELECT d.FirstName, d.LastName, p.ShiftID, s.ShiftDate,COUNT(*) as ParcelCount 
	FROM Parcels p
		INNER JOIN Shifts s ON p.ShiftID = s.ShiftID
		INNER JOIN Drivers d ON s.DriverID = d.DriverID
	WHERE d.DriverID = driverid AND s.ShiftID = shiftid;
END //
DELIMITER ;
