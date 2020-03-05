
 /*============================================================*/
/* DBMS NAME: MYSQL AND ANSI LEVEL 2						  */
/*         SEE PAGE 239 AND 249			  */
/*============================================================*/

DROP DATABASE IF EXISTS RIDE_ON_BY_KEVIN_BELL;          
		/* GENERATES AN ERROR ON FIRST RUN AS THERE IS NO DB TO DROP, BUT PREVENTS ERRORS IF RE-INSTALLING */

CREATE DATABASE RIDE_ON_BY_KEVIN_BELL;       	
		/* CREATES DATABASE */
USE RIDE_ON_BY_KEVIN_BELL;					
		/* MAKES THIS THE ONE WE ARE USING */
				
/*============================================================*/
/* TABLE: CUSTOMER
/*============================================================*/

CREATE TABLE CUSTOMER
	(CUSTOMER_NUMBER VARCHAR(10) NOT NULL,
	FIRST_NAME VARCHAR(25) NOT NULL,
	LAST_NAME VARCHAR(25) NOT NULL);

/*CREATE PRIMARY KEY CONSTRAINT*/	
ALTER TABLE CUSTOMER
	ADD CONSTRAINT  PK_CUSTOMER
	PRIMARY KEY (CUSTOMER_NUMBER);

 /*============================================================*/
/* TABLE: PRODUCT
/*============================================================*/

 CREATE TABLE PRODUCT
 (PRODUCT_NUMBER VARCHAR(10) NOT NULL, 
 PRODUCT_NAME VARCHAR(50) NOT NULL,
 UNIT_PRICE NUMERIC(13,4) NOT NULL); 
 
 /*CREATE PRIMARY KEY CONSTRAINT*/
  ALTER TABLE PRODUCT
	ADD CONSTRAINT  PK_PRODUCT_NUMBER
	PRIMARY KEY (PRODUCT_NUMBER);
	
/*============================================================*/
/* TABLE: SALES_PERSON
/*============================================================*/

CREATE TABLE SALES_PERSON 
    (SALES_PERSON_ID NUMERIC(25) NOT NULL,
    FIRST_NAME VARCHAR(25) NOT NULL,
    LAST_NAME VARCHAR(25) NOT NULL);
	
	/*CREATE PRIMARY KEY CONSTRAINT*/	
ALTER TABLE SALES_PERSON
	ADD CONSTRAINT  PK_SALES_PERSON_ID
	PRIMARY KEY (SALES_PERSON_ID);

/*============================================================*/
/* TABLE: INVOICE
/*============================================================*/

/*CREATE INVOICE TABLE*/	
CREATE TABLE INVOICE
	(SALES_ORDER_ID NUMERIC(25) NOT NULL,
	ORDER_DATE DATE NOT NULL,
	SALES_PERSON_ID NUMERIC(25) NOT NULL,
	CUSTOMER_NUMBER VARCHAR(10) NOT NULL);

/*CREATE PRIMARY KEY CONSTRAINT*/
ALTER TABLE INVOICE
	ADD CONSTRAINT PK_INVOICE
		PRIMARY KEY (SALES_ORDER_ID);

/*CREATE REFERENTIAL CONSTRAINT*/
ALTER TABLE INVOICE
	ADD CONSTRAINT FK_INVOICE_SALES_PERSON_ID
		FOREIGN KEY (SALES_PERSON_ID)
		REFERENCES SALES_PERSON (SALES_PERSON_ID);
		
/*CREATE REFERENTIAL CONSTRAINT*/
ALTER TABLE INVOICE
	ADD CONSTRAINT FK_INVOICE_CUSTOMER_NUMBER
		FOREIGN KEY (CUSTOMER_NUMBER)
		REFERENCES CUSTOMER (CUSTOMER_NUMBER);
		
/*============================================================*/
/* TABLE: INVOICE_LINE_ITEM
/*============================================================*/

CREATE TABLE INVOICE_LINE_ITEM
	(SALES_ORDER_ID NUMERIC(25) NOT NULL,
	PRODUCT_NUMBER VARCHAR(10) NOT NULL,
	PRODUCT_QUANTITY_SOLD NUMERIC(25) NOT NULL);
	
ALTER TABLE INVOICE_LINE_ITEM
	ADD CONSTRAINT PK_INVOICE_LINE_ITEM
		PRIMARY KEY (SALES_ORDER_ID, PRODUCT_NUMBER);
		
/*ALTER TABLE INVOICE_LINE_ITEM
	ADD CONSTRAINT CK_PRODUCT_UNIT_PRICE
		CHECK (UNIT_PRICE >=0); */
		
ALTER TABLE INVOICE_LINE_ITEM
	ADD CONSTRAINT FK_INVOICE_LINE_ITEM_INVOICE
		FOREIGN KEY (SALES_ORDER_ID)
		REFERENCES INVOICE (SALES_ORDER_ID);
		
ALTER TABLE INVOICE_LINE_ITEM
	ADD CONSTRAINT FK_INVOICE_LINE_ITEM_PRODUCT
		FOREIGN KEY (PRODUCT_NUMBER)
		REFERENCES PRODUCT (PRODUCT_NUMBER);
		
/*============================================================*/
/* TABLE: SALES_REASONS_ID
/*============================================================*/

CREATE TABLE SALES_REASONS_ID 
    (SALES_REASONS_ID NUMERIC(25) NOT NULL,
    DESCRIPTION VARCHAR(255) NOT NULL);
	
	/*CREATE PRIMARY KEY CONSTRAINT*/	
ALTER TABLE SALES_REASONS_ID
	ADD CONSTRAINT  PK_SALES_REASONS_ID
	PRIMARY KEY (SALES_REASONS_ID);

/*============================================================*/
/* TABLE: INVOICE_SALES_REASONS
/*============================================================*/

CREATE TABLE INVOICE_SALES_REASONS 
    (SALES_ORDER_ID NUMERIC(25) NOT NULL,
    SALES_REASONS_ID NUMERIC(25) NOT NULL);
	
/*CREATE PRIMARY KEY CONSTRAINT*/	
ALTER TABLE INVOICE_SALES_REASONS
	ADD CONSTRAINT  PK_SALES_REASONS
	PRIMARY KEY (SALES_ORDER_ID, SALES_REASONS_ID);
	
/*CREATE REFERENTIAL CONSTRAINT*/
ALTER TABLE INVOICE_SALES_REASONS
	ADD CONSTRAINT FK_SALES_ORDER_ID
		FOREIGN KEY (SALES_ORDER_ID)
		REFERENCES INVOICE (SALES_ORDER_ID);	
		
/*CREATE REFERENTIAL CONSTRAINT*/
ALTER TABLE INVOICE_SALES_REASONS
	ADD CONSTRAINT FK_SALES_REASONS_ID
		FOREIGN KEY (SALES_REASONS_ID)
		REFERENCES SALES_REASONS_ID (SALES_REASONS_ID);
	
/*============================================================*/
/* TABLE: SALES_QUOTA
/*============================================================*/

CREATE TABLE SALES_QUOTA 
    (SALES_PERSON_ID  NUMERIC(25) NOT NULL,
    FISCAL_YEAR NUMERIC(25) NOT NULL,
    SALES_QUOTA NUMERIC(25) NOT NULL,
    PRIOR_YEAR_SALES NUMERIC (13,4) NOT NULL );
	
/*CREATE PRIMARY KEY CONSTRAINT*/	
ALTER TABLE SALES_QUOTA
	ADD CONSTRAINT  PK_SALES_PERSON_ID
	PRIMARY KEY (SALES_PERSON_ID, FISCAL_YEAR);	

	
/*CREATE REFERENTIAL CONSTRAINT*/
ALTER TABLE SALES_QUOTA
	ADD CONSTRAINT FK_SALES_PERSON_ID
		FOREIGN KEY (SALES_PERSON_ID)
		REFERENCES SALES_PERSON (SALES_PERSON_ID);
		
/* INSERT STATEMENTS GO ANYWHERE BELOW THIS LINE */

INSERT INTO CUSTOMER 
(CUSTOMER_NUMBER, FIRST_NAME, LAST_NAME)
VALUES
('AW00029953', 'JOSEPH', 'LIQUE'),
('AW00030112', 'PATRICIA', 'VASQUEZ'),
('AW00029614', 'RYAN', 'CALAFATO'),
('AW00030048', 'MARCIA', 'SULTAN'),
('AW00030092', 'GRACIA', 'TUELL'),
('AW00015021', 'MICHAEL', 'JONES');

INSERT INTO PRODUCT
(PRODUCT_NUMBER, PRODUCT_NAME, UNIT_PRICE)
VALUES
('FR-M94B-38', 'HL Mountain Frame - Black, 38', 736.1455),
('FR-M63B-38', 'ML Mountain Frame - Black, 38', 209.256),
('HL-U509', 'Sport-100 Helmet, Black', 20.1865),
('HL-U509-B', 'Sport-100 Helmet, Blue', 20.1865),
('HL-U509-R', 'Sport-100 Helmet, Red', 20.1865);

INSERT INTO SALES_PERSON
(SALES_PERSON_ID, FIRST_NAME, LAST_NAME)
VALUES
(1, 'TETE', 'MENSA-ANNAN'),
(2, 'JAE', 'PAK'), 
(3, 'LYNN', 'TSOFLIAS');

INSERT INTO INVOICE
(SALES_ORDER_ID, ORDER_DATE, SALES_PERSON_ID, CUSTOMER_NUMBER)
VALUES
(48001, '2016-11-01', 1, 'AW00029953'),
(48057, '2016-11-01', 1, 'AW00030112'),
(48750, '2016-01-01', 2, 'AW00029614'),
(47708, '2016-10-01', 2, 'AW00030048'),
(53565, '2016-09-01', 3, 'AW00030092'),
(35091, '2015-12-01', 3, 'AW00015021');

INSERT INTO INVOICE_LINE_ITEM
(SALES_ORDER_ID, PRODUCT_NUMBER, PRODUCT_QUANTITY_SOLD)
VALUES
(48001, 'FR-M94B-38', 1),
(48001, 'FR-M63B-38', 1),
(48001, 'HL-U509', 8),
(48001, 'HL-U509-B', 8),
(48001, 'HL-U509-R', 9),
(48057, 'HL-U509', 4),
(48057, 'HL-U509-B', 4),
(48057, 'HL-U509-R', 6),
(48750, 'HL-U509', 5),
(48750, 'HL-U509-B', 6),
(48750, 'HL-U509-R', 3),
(47708, 'FR-M94B-38', 3),
(47708, 'FR-M63B-38', 3),
(47708, 'HL-U509', 9),
(47708, 'HL-U509-B', 11),
(47708, 'HL-U509-R', 5),
(53565, 'HL-U509', 5),
(53565, 'HL-U509-B', 6),
(53565, 'HL-U509-R', 8),
(35091, 'HL-U509-B', 1),
(35091, 'FR-M63B-38', 1);

INSERT INTO SALES_REASONS_ID
(SALES_REASONS_ID, DESCRIPTION)
VALUES
(1, 'PRICE'),
(2, 'ON PROMOTION'),
(3, 'SPONSORSHIP');

INSERT INTO INVOICE_SALES_REASONS
(SALES_ORDER_ID, SALES_REASONS_ID)
VALUES
(47708, 1),
(47708, 2),
(53565, 3),
(35091, 1);

INSERT INTO SALES_QUOTA
(SALES_PERSON_ID, FISCAL_YEAR, SALES_QUOTA, PRIOR_YEAR_SALES)
VALUES
(1, 2016, 300000, 0),
(2, 2016, 250000, 1635823.3967),
(3, 2015, 250000, 0);

SELECT
   TABLE_NAME,
   CONSTRAINT_NAME,
   COLUMN_NAME,
   REFERENCED_COLUMN_NAME,
   REFERENCED_TABLE_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'ride_on_by_kevin_bell'
ORDER BY TABLE_NAME,CONSTRAINT_NAME;

/* query 1 How many customers?*/
select count(*) as number_of_customers
	from customer;
	
/* query 2 Earliest sale*/
select min(order_date) as earliest_sale
	from invoice;
	
/* query 3 Latest sale*/
select max(order_date) as latest_sale
	from invoice;
	
/* query 4 last sale by sales person*/
select first_name, last_name, max(order_date) as last_sale
    from sales_person join invoice
	on invoice.sales_person_id = sales_person.sales_person_id
	group by first_name;
	
/* query 5 sales total by Customer ordered Ascending on sales total*/
select first_name, last_name, sum(unit_price * product_quantity_sold) as sales_total
	from customer join invoice 
	on customer.customer_number = invoice.customer_number 
	join invoice_line_item 
	on invoice.sales_order_id = invoice_line_item.sales_order_id 
	join product 
	on invoice_line_item.product_number = product.product_number
	group by first_name
	order by sum(unit_price * product_quantity_sold);

/* query 6 count of sales reasons*/
select invoice.sales_order_id, count(sales_reasons_id) as count_of_sales_reasons from invoice
left join invoice_sales_reasons on invoice.sales_order_id = invoice_sales_reasons.sales_order_id
group by sales_order_id;