-- DROP TABLE ReservaVoos_Seat;
-- GO
-- DROP TABLE ReservaVoos_LegInstance;
-- GO
-- DROP TABLE ReservaVoos_Fare;
-- GO
-- DROP TABLE ReservaVoos_FlightLeg;
-- GO
-- DROP TABLE ReservaVoos_Flight;
-- GO
-- DROP TABLE ReservaVoos_Airplane;
-- GO
-- DROP TABLE ReservaVoos_CanLand;
-- GO
-- DROP TABLE ReservaVoos_AirplaneType;
-- GO
-- DROP TABLE ReservaVoos_Airport;
-- GO

CREATE TABLE [ReservaVoos_Airport](
	[AirportCode] [varchar](128) NOT NULL,
	[Name] [varchar](256) NOT NULL,
	[City] [varchar](128) NOT NULL,
	[State] [bit] NOT NULL,
 PRIMARY KEY ([AirportCode]))
GO

CREATE TABLE [ReservaVoos_AirplaneType](
	[TypeName] [varchar](64) NOT NULL,
	[Company] [varchar](128) NOT NULL,
	[MaxSeats] [int] NOT NULL,
 PRIMARY KEY ([TypeName]))
GO

CREATE TABLE [ReservaVoos_CanLand](
	[Airport_AirportCode] [varchar](128) REFERENCES [ReservaVoos_Airport] ([AirportCode]) NOT NULL,
	[AirplaneType_TypeName] [varchar](64) REFERENCES [ReservaVoos_AirplaneType] ([TypeName]) NOT NULL,
 PRIMARY KEY ([Airport_AirportCode],[AirplaneType_TypeName]))
GO

CREATE TABLE [ReservaVoos_Airplane](
	[AirplaneId] [varchar](128) NOT NULL,
	[TotalNum_Seats] [int] NOT NULL,
	[AirplaneType_TypeName] [varchar](64) NOT NULL,
 PRIMARY KEY ([AirplaneId]),
 FOREIGN KEY ([AirplaneType_TypeName]) REFERENCES [ReservaVoos_AirplaneType] ([TypeName]))
GO

CREATE TABLE [ReservaVoos_Flight](
	[Number] [varchar] (128) NOT NULL,
	[Weekdays] [varchar] (64) NOT NULL,
	[Airline] [varchar] (128) NOT NULL,
 PRIMARY KEY ([Number]))
GO

CREATE TABLE [ReservaVoos_FlightLeg](
	[LegNum] [int] NOT NULL,
	[Flight_Number] [varchar] (128) REFERENCES [ReservaVoos_Flight] ([Number]) NOT NULL,
	[SchDepTime] [varchar] (64) NOT NULL,
	[SchArrTime] [varchar] (64) NOT NULL,
	[DepAirportCode] [varchar] (128) REFERENCES [ReservaVoos_Airport] ([AirportCode]) NOT NULL,
	[ArrAirportCode] [varchar] (128) REFERENCES [ReservaVoos_Airport] ([AirportCode]) NOT NULL,
 PRIMARY KEY ([LegNum],[Flight_Number]))
GO

CREATE TABLE [ReservaVoos_Fare](
	[Flight_Number] [varchar] (128) REFERENCES [ReservaVoos_Flight] ([Number]) NOT NULL,
	[Code] [varchar] (64) NOT NULL,
	[Amount] [int] NOT NULL,
	[Restriction] [varchar] (128) NOT NULL,
 PRIMARY KEY ([Flight_Number],[Code]))
GO

CREATE TABLE [ReservaVoos_LegInstance](
	[FlightLeg_Flight_Number] [varchar] (128) NOT NULL,
	[FlightLeg_LegNum] [int] NOT NULL,
	[Date] [varchar] (128) NOT NULL,
	[Airplane_AirplaneId] [varchar] (128) REFERENCES [ReservaVoos_Airplane] ([AirplaneId]) NOT NULL,
	[NoOfAvailableSeats] [int] NOT NULL,
	[Airport_DepCode] [varchar] (128) REFERENCES [ReservaVoos_Airport] ([AirportCode]) NOT NULL,
	[Airport_ArrCode] [varchar] (128) REFERENCES [ReservaVoos_Airport] ([AirportCode]) NOT NULL,
	[DepTime] [varchar] (64) NOT NULL,
	[ArrTime] [varchar] (64) NOT NULL,
 PRIMARY KEY ([FlightLeg_Flight_Number],[FlightLeg_LegNum],[Date]),
 FOREIGN KEY ([FlightLeg_LegNum], [FlightLeg_Flight_Number]) REFERENCES [ReservaVoos_FlightLeg] ([LegNum], [Flight_Number]))
GO

CREATE TABLE [ReservaVoos_Seat](
   [LegInstance_FlightLeg_Flight_Number] [varchar] (128) NOT NULL,
   [LegInstance_FlightLeg_LegNum] [int] NOT NULL,
   [LegInstance_Date] [varchar] (128) NOT NULL,
   [SeatNum] [int] NOT NULL,
   [CustomerName] [varchar] (128) NOT NULL,
   [CPhone] [varchar] (16) NOT NULL,
   PRIMARY KEY ([LegInstance_FlightLeg_Flight_Number], [LegInstance_FlightLeg_LegNum], [LegInstance_Date], [SeatNum]),
   FOREIGN KEY ([LegInstance_FlightLeg_Flight_Number], [LegInstance_FlightLeg_LegNum], [LegInstance_Date]) REFERENCES [ReservaVoos_LegInstance] ([FlightLeg_Flight_Number], [FlightLeg_LegNum], [Date]))
GO
