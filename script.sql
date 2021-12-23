--Group Memebers:
-- Bhuvana Iyer - bci190000
-- Riya Bhargava - rxb190058
-- Mariam Aafreen - mxm210042
-- Hasika Nune - hxn210010


CREATE Database DB6360_Project

USE DB6360_Project

--Creating Table for Users
CREATE TABLE Users(
user_id INTEGER PRIMARY KEY NOT NULL,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(20) NOT NULL,
user_name VARCHAR(50) NOT NULL UNIQUE,
phone_number VARCHAR(12),
cell_number VARCHAR(12),
user_type VARCHAR(2), --User Type 0: Client, 1: Trader, 2: Manager
email VARCHAR(100) NOT NULL,
street VARCHAR(200),
city VARCHAR(200) NOT NULL,
state VARCHAR(200),
zip_code VARCHAR(10) NOT NULL,
btc_balance DECIMAL(30,4),
usd_balance DECIMAL(30,4),
customer_type VARCHAR(20) ---Classifying customer as Gold/Silver 
);

--Creating Table for Transaction
CREATE TABLE Transactions(
transc_id INTEGER PRIMARY KEY,
btc_amount DECIMAL(30,4) NOT NULL,
exchange_rate DECIMAL(10,4),
commission_type VARCHAR(20) NOT NULL,
commission_amount DECIMAL(30,4) NOT NULL,
client_id INTEGER,
trader_id INTEGER,
timestamp DATETIME NOT NULL,
status VARCHAR(20) NOT NULL,
sell_flag INTEGER NOT NULL, ----Incase of Sell the value would be 0, otherwise 1
CONSTRAINT FK_ClientID FOREIGN KEY (client_id) REFERENCES Users (user_id),
CONSTRAINT FK_TraderID FOREIGN KEY (trader_id) REFERENCES Users (user_id)
);


---Creating Table Payments
CREATE TABLE Payments(
payment_id INTEGER PRIMARY KEY,
usd_amount DECIMAL(30,4) NOT NULL,
client_id INTEGER,
trader_id INTEGER,
timestamp DATETIME NOT NULL,
status VARCHAR(20) NOT NULL,
CONSTRAINT FK_clientid1 FOREIGN KEY (client_id) REFERENCES Users (user_id),
CONSTRAINT FK_traderid1 FOREIGN KEY (trader_id) REFERENCES Users (user_id)
);

insert into Users values( 101, 'James', 'Flosi', 'jf_07', '504-621-8927', '504-845-1427', '0', 'jflosi@gmail.com', '6649 N Blue Gum St', 'New Orleans', 'LA', '70116', 45678.897, 5678.783, 'Silver');
insert into Users values( 102, 'Josphine', 'Darak', 'jos12', '810-292-9388', '810-374-9840', '0', 'josephine_darak@yahoo.com', '4 B Blue Ridge Blvd', 'Brighton', 'MI', '48116', 67345.389, 237856.00925, 'Silver');
insert into Users values( 103, 'Art', 'Venere', 'artv15', '856-636-8749', '856-264-4130', '0', 'art@venere.org', '8 W Cerritos Ave #54', 'Bridgeport', 'NJ', '8014', 746656.578, 87536.292, 'Gold');
insert into Users values( 104, 'Lenna', 'Paprocki', 'pap099', '907-385-4412', '907-921-2010', '0', 'lpaprocki@hotmail.com', '639 Main St', 'Anchorage', 'AK', '99501', 3546799, 524367.78, 'Gold');
insert into Users values( 105, 'Donette', 'Foller', 'dfon_11', '513-570-1893', '513-549-4561', '0', 'donette.foller@cox.net', '34 Center St', 'Hamilton', 'OH', '45011', 123455.876, 7365.234, 'Gold');
insert into Users values( 106, 'Simona', 'Morasca', 'simca_007', '419-503-2484', '419-800-6759', '0', 'simona@morasca.com', '3 Mcauley Dr', 'Ashland', 'OH', '44805', 678853.385, 128745.9724, 'Gold');
insert into Users values( 107, 'Mitsue', 'Tollner', 'MToll34', '773-573-6914', '773-924-8565', '0', 'mitsue_tollner@yahoo.com', '7 Eads St', 'Chicago', 'IL', '60632', 164765.88356, 657.8636, 'Gold');
insert into Users values( 108, 'Leota', 'Dilliard', 'LeoD67', '408-752-3500', '408-813-1105', '0', 'leota@hotmail.com', '7 W Jackson Blvd', 'San Jose', 'CA', '95111', 76579.5859,577785.4672, 'Silver');
insert into Users values( 109, 'Sage', 'Wieser', 'sageER8', '605-414-2147', '605-794-4895', '0', 'sage_wieser@cox.net', '5 Boston Ave #88', 'Sioux Falls', 'SD', '57105', 642756.586, 37568.793, 'Gold');
insert into Users values( 110, 'Kris', 'Marrier', 'kriss_901', '410-655-8723', '410-804-4694', '0', 'kris@gmail.com', '228 Runamuck Pl #2808', 'Baltimore', 'MD', '21224', 85689.4687, 2475869.673, 'Silver');
insert into Users values( 111, 'Minna', 'Amigon', 'MAmigo23', '215-874-1229', '215-422-8694', '1', 'minna_amigon@yahoo.com', '2371 Jerrold Ave', 'Kulpsville', 'PA', '19443', 386389.583, 56244.578, '');
insert into Users values( 112, 'Abel', 'Maclead', 'abel756', '631-335-3414', '631-677-3675', '1', 'amaclead@gmail.com', '37275 St Rt 17m M', 'Middle Island', 'NY', '11953', 856385.476, 29759.78, '');
insert into Users values( 113, 'Kiley', 'Caldarera', 'kilera56', '310-498-5651', '310-254-3084', '1', 'kiley.caldarera@aol.com', '25 E 75th St #69', 'Los Angeles', 'CA', '90034', 247790.57, 345358.67, '');
insert into Users values( 114, 'Graciela', 'Ruta', 'grr79', '440-780-8425', '440-579-7763', '1', 'gruta@cox.net', '98 Connecticut Ave Nw', 'Chagrin Falls', 'OH', '44023', 246478.67, 457354.678, '');
insert into Users values( 115, 'Cammy', 'Albares', 'albasre89', '956-537-6195', '956-841-7216', '1', 'calbares@gmail.com', '56 E Morehead St', 'Laredo', 'TX', '78045', 67538.57, 12665.67, '');
insert into Users values( 116, 'Mattie', 'Poquette', 'mapoqq45', '602-277-4385', '602-953-6360', '1', 'mattie@aol.com', '73 State Road 434 E', 'Phoenix', 'AZ', '85013', 869600.4637, 3466.572, '');
insert into Users values( 117, 'Meaghan', 'Garufi', 'meaghan657', '931-313-9635', '931-235-7959', '1', 'meaghan@hotmail.com', '69734 E Carrillo St', 'Mc Minnville', 'TN', '37110', 298495.677, 265479.789, '');
insert into Users values( 118, 'Gladys', 'Rim', 'grim47', '414-661-9598', '414-377-2880', '1', 'gladys.rim@rim.org', '322 New Horizon Blvd', 'Milwaukee', 'WI', '53207', 463588.682, 2643859.738, '');
insert into Users values( 119, 'Yuki', 'Whobrey', 'yukii78', '313-288-7937', '313-341-4470', '1', 'yuki_whobrey@aol.com', '1 State Route 27', 'Taylor', 'MI', '48180', 7356358.678, 46868.24, '');
insert into Users values( 120, 'Bette', 'Nicka', 'nikkk635', '610-545-3615', '610-492-4643', '1', 'bette_nicka@cox.net', '6 S 33rd St', 'Aston', 'PA', '19014', 428590.68, 2056897.478, '');
insert into Users values( 121, 'Veronika', 'Inouye', 'Vino468', '408-540-1785', '408-813-4592', '2', 'vinouye@aol.com', '6 Greenleaf Ave', 'San Jose', 'CA', '95111', 38689.57, 3756486.467, '');
insert into Users values( 122, 'Willard', 'Kolmetz', 'willmet23', '972-303-9197', '972-896-4882', '2', 'willard@hotmail.com', '618 W Yakima Ave', 'Irving', 'TX', '75062', 475588.678, 12364.843, '');
insert into Users values( 123, 'Maryann', 'Royster', 'mroy546', '518-966-7987', '518-448-8982', '2', 'mroyster@royster.com', '74 S Westgate St', 'Albany', 'NY', '12204', 568956.467, 2637589.567, '');
insert into Users values( 124, 'Alia sha', 'Slusarski', 'alislu764', '732-658-3154', '732-635-3453', '2', 'alisha@slusarski.com', '3273 State St', 'Middlesex', 'NJ', '8846', 68600.367, 134937.789, '');
insert into Users values( 125, 'Allene', 'Iturbide', 'allen67', '715-530-9863', '715-662-6764', '2', 'allene_iturbide@cox.net', '1 Central Ave', 'Stevens Point', 'WI', '54481', 275967.48, 795780.478, '');


insert into Transactions values(1111, 345723.56, 47839.788, 'bitcoin', 4758.577, 103, 115,'2021-03-12 03:34:25', 'completed', 0);
insert into Transactions values(1112, 476547.579, 56793.34, 'fiat', 6800.67, 105, 117, '2021-03-12 23:56:23', 'completed', 0);
insert into Transactions values(1113, 679794.239, 54728.27, 'bitcoin', 70973.68, 110, 118, '2021-04-19 01:15:01', 'cancelled', 0);
insert into Transactions values(1114, 49860.789, 56828.378, 'fiat', 3868.23, 101, 120, '2021-04-15 13:53:11', 'completed', 1);
insert into Transactions values(1115, 27580.67, 56725.67, 'bitcoin', 6987.67, 105, 113, '2021-06-12 04:37:24', 'completed', 0);
insert into Transactions values(1116, 95790.36, 46789.92, 'fiat', 3567.367, 107, 118, '2021-09-15 18:57:34', 'completed', 1);
insert into Transactions values(1117, 229057.56, 56389.34, 'fiat', 2548.89, 106, 114, '2021-09-21 03:36:59', 'cancelled', 1);
insert into Transactions values(1118, 85637.567, 45837.78, 'bitcoin', 95735.67, 104, 113, '2021-10-02 16:33:25', 'completed', 0);
insert into Transactions values(1119, 2546375.67, 57856.23, 'bitcoin', 89947.56, 102, 116, '2021-11-25 15:56:45', 'pending', 0);
insert into Transactions values(1120, 2865377.55, 45678.56, 'fiat', 3248.678, 109, 119, '2021-12-01 17:45:12', 'pending', 1);


insert into Payments values(201, 23857.36, 103, 115, '2021-03-12 03:35:25', 'completed');
insert into Payments values(202, 53875.788, 105, 117, '2021-03-12 23:58:23', 'completed');
insert into Payments values(203, 936794.67, 110, 118, '2021-04-19 01:16:01', 'completed');
insert into Payments values(204, 67940.39, 101, 120, '2021-04-15 13:56:11', 'completed');
insert into Payments values(205, 78689.24, 105, 113, '2021-03-12 03:40:25', 'completed');
insert into Payments values(206, 224575.67, 107, 118, '2021-09-15 18:00:34', 'completed');
insert into Payments values(207, 678679.35, 106, 114, '2021-09-21 03:38:59', 'completed');
insert into Payments values(208, 476390.27, 104, 113, '2021-10-02 16:40:25', 'completed');
insert into Payments values(209, 86936.688, 102, 116, '2021-11-25 15:59:45', 'completed');
insert into Payments values(210, 567359.577, 109, 119, '2021-12-01 17:47:12', 'completed');

select * from Users
select * from Payments
select * from Transactions

DROP TABLE Users
DROP TABLE Transactions
DROP TABLE Payments
