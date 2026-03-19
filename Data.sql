create database SWD_2

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100),
    Email NVARCHAR(100) UNIQUE,
    Phone NVARCHAR(20) UNIQUE,
    Password NVARCHAR(255),
    Role VARCHAR(20) CHECK (Role IN ('Admin', 'Driver', 'Customer')),
    Status NVARCHAR(20) DEFAULT 'Active',
    CreatedAt DATETIME DEFAULT GETDATE()
);


CREATE TABLE DriverProfiles (
    DriverID INT PRIMARY KEY,
    LicenseNumber NVARCHAR(50),
    IDCard NVARCHAR(50),
    HealthCertificate NVARCHAR(255),
    ExperienceYears INT,
    IntroductionVideo NVARCHAR(255),
    ProfilePhoto NVARCHAR(255),
    VerificationStatus NVARCHAR(20) DEFAULT 'Pending',
    WorkingStatus NVARCHAR(20) DEFAULT 'Offline',
    FOREIGN KEY (DriverID) REFERENCES Users(UserID)
);


CREATE TABLE Bookings (
    BookingID INT IDENTITY PRIMARY KEY,
    CustomerID INT NOT NULL,
    DriverID INT NULL,
    PickupAddress NVARCHAR(255),
    DestinationAddress NVARCHAR(255),
    PickupLatitude DECIMAL(9,6),
    PickupLongitude DECIMAL(9,6),
    DestinationLatitude FLOAT,
    DestinationLongitude FLOAT,
    BookingTime DATETIME,
    ScheduleTime DATETIME NULL,
	Status NVARCHAR(30),
    CHECK (Status IN ('Pending', 'Completed', 'Cancelled')),
    EstimatedPrice DECIMAL(10,2),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID),
    FOREIGN KEY (DriverID) REFERENCES Users(UserID)
);

CREATE TABLE Trips (
    TripID INT IDENTITY PRIMARY KEY,
    BookingID INT,
    StartTime DATETIME,
    EndTime DATETIME,
    DistanceKm FLOAT,
    FinalPrice DECIMAL(10,2),
    Status NVARCHAR(20),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

CREATE TABLE Payments (
    PaymentID INT IDENTITY PRIMARY KEY,
    BookingID INT,
    Amount DECIMAL(10,2),
    PaymentMethod NVARCHAR(50),
    PaymentStatus NVARCHAR(20),
    TransactionCode NVARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);


CREATE TABLE DriverIncome (
    IncomeID INT IDENTITY PRIMARY KEY,
    DriverID INT,
    TripID INT,
    Amount DECIMAL(10,2),
    CommissionRate DECIMAL(5,2),
	CHECK (CommissionRate BETWEEN 0 AND 100),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (DriverID) REFERENCES Users(UserID),
    FOREIGN KEY (TripID) REFERENCES Trips(TripID)
);

CREATE TABLE Reviews (
    ReviewID INT IDENTITY PRIMARY KEY,
    BookingID INT,
    CustomerID INT,
    DriverID INT,
    Rating INT,
    Comment NVARCHAR(500),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID),
    FOREIGN KEY (DriverID) REFERENCES Users(UserID)
);



CREATE TABLE Complaints (
    ComplaintID INT IDENTITY PRIMARY KEY,
    BookingID INT,
    UserID INT,
    Description NVARCHAR(1000),
    Status NVARCHAR(20) DEFAULT 'Pending',
    ResolvedBy INT NULL,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ResolvedBy) REFERENCES Users(UserID)
);


CREATE TABLE Notifications (
    NotificationID INT IDENTITY PRIMARY KEY,
    UserID INT,
    Title NVARCHAR(200),
    Message NVARCHAR(1000),
    IsRead BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);


CREATE TABLE Coupons (
    CouponID INT IDENTITY PRIMARY KEY,
    Code NVARCHAR(50) UNIQUE,
    DiscountPercent INT,
	CHECK (DiscountPercent BETWEEN 0 AND 100),
    ExpiryDate DATETIME,
    MaxUsage INT,
    CreatedAt DATETIME DEFAULT GETDATE()
);


CREATE TABLE BookingCoupons (
    ID INT IDENTITY PRIMARY KEY,
    BookingID INT,
    CouponID INT,
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
    FOREIGN KEY (CouponID) REFERENCES Coupons(CouponID)
);

INSERT INTO Users (FullName, Email, Phone, Password, Role, Status)
VALUES
(N'Nguyễn Văn A','a@gmail.com','0901111111','hash123','Customer','Active'),
(N'Trần Văn B','b@gmail.com','0902222222','hash456','Customer','Active'),
(N'Lê Văn C','c@gmail.com','0903333333','hash789','Driver','Active'),
(N'Phạm Văn D','d@gmail.com','0904444444','hash000','Driver','Pending'),
(N'Admin','admin@gmail.com','0909999999','adminhash','Admin','Active');

INSERT INTO DriverProfiles
(DriverID, LicenseNumber, IDCard, HealthCertificate, ExperienceYears, IntroductionVideo, ProfilePhoto, VerificationStatus, WorkingStatus)
VALUES
(3,'DL123456','123456789','health1.pdf',5,'video1.mp4','driver1.jpg','Verified','Offline'),
(4,'DL987654','987654321','health2.pdf',2,'video2.mp4','driver2.jpg','Pending','Offline');

INSERT INTO Bookings
(CustomerID, DriverID, PickupAddress, DestinationAddress,
PickupLatitude, PickupLongitude,
DestinationLatitude, DestinationLongitude,
BookingTime, Status, EstimatedPrice)
VALUES
(1,3,N'Hồ Gươm, Hà Nội',N'Sân bay Nội Bài',
21.0285,105.8542,
21.2212,105.8072,
GETDATE(),'Completed',300000),

(2,3,N'Cầu Giấy',N'Hà Đông',
21.0362,105.7900,
20.9710,105.7788,
GETDATE(),'Completed',150000),

(1,NULL,N'Ba Đình',N'Long Biên',
21.0333,105.8142,
21.0450,105.8890,
GETDATE(),'Pending',120000);


INSERT INTO Trips
(BookingID, StartTime, EndTime, DistanceKm, FinalPrice, Status)
VALUES
(1,GETDATE(),DATEADD(MINUTE,40,GETDATE()),30,300000,'Completed'),
(2,GETDATE(),DATEADD(MINUTE,25,GETDATE()),12,150000,'Completed');

INSERT INTO Payments
(BookingID, Amount, PaymentMethod, PaymentStatus, TransactionCode)
VALUES
(1,300000,'Credit Card','Success','TXN001'),
(2,150000,'Cash','Success','TXN002');


INSERT INTO DriverIncome
(DriverID, TripID, Amount, CommissionRate)
VALUES
(3,1,240000,20),
(3,2,120000,20);


INSERT INTO Reviews
(BookingID, CustomerID, DriverID, Rating, Comment)
VALUES
(1,1,3,5,N'Tài xế rất thân thiện'),
(2,2,3,4,N'Chuyến đi ổn');


INSERT INTO Complaints
(BookingID, UserID, Description, Status)
VALUES
(2,2,N'Tài xế đến hơi muộn','Pending');


INSERT INTO Notifications
(UserID, Title, Message)
VALUES
(1,N'Đặt xe thành công',N'Tài xế đang đến đón bạn'),
(3,N'Bạn có chuyến mới',N'Có khách đặt chuyến gần bạn');


INSERT INTO Coupons
(Code, DiscountPercent, ExpiryDate, MaxUsage)
VALUES
('NEWUSER10',10,'2026-12-31',1000),
('SALE20',20,'2026-06-01',500);

INSERT INTO BookingCoupons
(BookingID, CouponID)
VALUES
(1,1),
(2,2);









