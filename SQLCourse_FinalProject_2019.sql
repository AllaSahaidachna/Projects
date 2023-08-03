/*Финальный проект

Цель: создать модель таблиц для онлайн продажи пиццы.

Примечание: чтобы получить уникальные имена таблиц для каждого студента
просьба для всех таблиц в начале имени хранить первую букву имени и фамилию (пример mbelko_table_name)

Напишите DDL/DML операторы
Минимальные требования к хранению данных:*/
	DROP TABLE IF EXIST db_laba.dbo.asahaidachna_menu_delivery;

	CREATE TABLE db_laba.dbo.asahaidachna_menu_delivery (
	dish_id int  identity  PRIMARY KEY NOT NULL,
	name varchar(255) NOT NULL,
	price decimal(8,2) NOT NULL
	--CONSTRAINT FK_asahaidachna_menu_delivery_dish FOREIGN KEY (dish_id)
	--REFERENCES db_laba.dbo.asahaidachna_menu_delivery(dish_id)
	);
	SELECT * FROM db_laba.dbo.asahaidachna_menu_delivery 

	INSERT 
	INTO db_laba.dbo.asahaidachna_menu_delivery VALUES
	('MARGARITA', '139.99')
	,('CEZARII', '145.99')
	,('BBQ', '145.99') 
	,('FOUR CHEESE', '190.99')
	,('FOCKACHA', '99.99')
	
	

--2. 	--2.     Таблица с клиентами. В ней должна быть возможность хранить ФИО, телефон.
    --Эта таблица должна быть заполнена данными (минимум 10 клиентов).

	DROP TABLE db_laba.dbo.asahaidachna_customers

	CREATE TABLE db_laba.dbo.asahaidachna_customers(
	customer_id int identity NOT NULL PRIMARY KEY,
	first_name varchar(255) NOT NULL,
	last_name varchar(255) NOT NULL,
	phone varchar (50) NOT NULL
		)

	INSERT 
	INTO  db_laba.dbo.asahaidachna_customers VALUES('Kevin', 'Mcera', '222-555-999'), ('Ivan', 'Strogin', '222-658-585'), 
	('Katia', 'Razymkova', ' 222-655-965'), ('Roman', 'Keyis', '222-965-873'),
	('Sara', 'Tomkina', '222-584-681'), ('Robert', 'Kiosaki', '222-965-025'), 
	('Sasha', 'Shapovaliuk', '222-985-588'), ('Kim', 'Ropder', '222-965-002'),
	('Nata', 'Brain', '222-900-320'), ('Georg', 'Frankin', '222-685-259')

	SELECT* from db_laba.dbo.asahaidachna_customers

--3.     Таблица с адресами для клиентов (у клиента есть возможность заказывать пиццу на разные адреса).
    --Эта таблица должна быть заполнена данными (минимум 15 адресов).
	

	CREATE TABLE db_laba.dbo.asahaidachna_adress_customers(
	adress_id int identity NOT NULL PRIMARY KEY,
	customer_id int NOT NULL,	
	street varchar(255) NOT NULL

	CONSTRAINT FKk_asahaidachna_customers FOREIGN KEY (customer_id)
	REFERENCES db_laba.dbo.asahaidachna_customers (customer_id)
	)


	INSERT INTO db_laba.dbo.asahaidachna_adress_customers
	VALUES
	(2,'Bazhenova 58'), (1,'Soborna 30'), (5,'Stiletska 65'), (10,'Teatralna 24'), 
	(8,'Vashchuka 10'), (6,'Pl. Mury 5'), (7,'Chehova 50'), (3,'Kyivska 51'),
	(1,'Kosmonavtiv 14'), (4,'1-st May 25'), (9,'D.Nechia 87'), (3,'Teatralna 21'),
	(1,'Soborna 8'), (4,'Soborna 25'), (7,'Kyivska 48'), (5,'Pl.Mury 3')

	SELECT * FROM db_laba.dbo.asahaidachna_adress_customers

--4.     Таблица с продавцами. В ней должна быть возможность хранить ФИО, телефон (минимум 10 продавцов)

		DROP TABLE db_laba.dbo.asahaidachna_salesman
		CREATE TABLE db_laba.dbo.asahaidachna_salesman(
		salesman_id int PRIMARY KEY NOT NULL identity,
		first_name varchar(255),
		last_name varchar (255),
		phone varchar(15)
		)

		INSERT INTO db_laba.dbo.asahaidachna_salesman
		VALUES ('Nina', 'Dobrev', '222-001-001'), ('Ekaterina', 'Lusko', '222-993-000'), 
		('Tom', 'Tailor', '222-951-900'), ('Ron', 'Visli', '222-652-004'),
		('Yurii', 'Glushenko', '222-650-877'), ('Marta', 'Torentino', '222-777-999'), 
		('Olia', 'Kutz', '222-987-200'), ('Veronika', 'Sivak', '222-930-123'),
		('Diana', 'Sikora', '222-740-045'), ('Vitalii', 'Koshoviy', '222-066-776')

		SELECT * FROM db_laba.dbo.asahaidachna_salesman

--5.     Таблица заказов. Заполнить для 10 заказов
	

	CREATE TABLE db_laba.dbo.asahaidachna_orders(
	order_id int identity NOT NULL PRIMARY KEY,
	customer_id int NOT NULL,
	adress_id int NOT NULL,
	status varchar(20),
	salesman_id int NOT NULL,
	order_date date NOT NULL
	CONSTRAINT f_k_asahaidachna_adress_customers FOREIGN KEY (adress_id)
	REFERENCES db_laba.dbo.asahaidachna_adress_customers (adress_id),
	CONSTRAINT FK_asahaidachna_customers FOREIGN KEY (customer_id)
	REFERENCES db_laba.dbo.asahaidachna_customers (customer_id),
	CONSTRAINT FK_asahaidachna_salesman FOREIGN KEY (salesman_id)
	REFERENCES db_laba.dbo.asahaidachna_salesman (salesman_id)
	);

	SELECT * FROM db_laba.dbo.asahaidachna_orders;

	INSERT INTO db_laba.dbo.asahaidachna_orders
	VALUES(5, 3,'Delivered', 8, '02.20.2019'), (6,6, 'Delivered', 5, '01.17.2019'),
	(4,10, 'Canceled', 8, '03-19-2019'), (3, 12,'Delivered', 2, '01-03-2019'),
	(3,12, 'Delivered', 10, '07-02-2019'), (10, 4,'Delivered', 7, '09-04-2019'),
	(10,4, 'Canceled', 9, '06-03-2019'), (1, 13,'Delivered', 1, '01-15-2019'),
	(7,15, 'Delivered', 4, '09-04-2019'), (2, 1,'Deliverd', 9, '06-21-2019')

	/*(2,'Bazhenova 58'), 2(1,'Soborna 30'), 3(5,'Stiletska 65'), 4(10,'Teatralna 24'), 
	5(8,'Vashchuka 10'), 6(6,'Pl. Mury 5'), 7(7,'Chehova 50'), 8(3,'Kyivska 51'),
	9(1,'Kosmonavtiv 14'), 10(4,'1-st May 25'), 11(9,'D.Nechia 87'), 12(3,'Teatralna 21'),
	13(1,'Soborna 8'), 14(4,'Soborna 25'), 15(7,'Kyivska 48'), 16(5,'Pl.Mury 3')*/


--6.     Таблица деталей заказов. Заполнить для 10 заказов, некоторые заказы должны включать более одной пиццы
DROP TABLE db_laba.dbo.asahaidachna_details_orders
CREATE TABLE db_laba.dbo.asahaidachna_details_orders(
details_id int NOT NULL identity PRIMARY KEY,
order_id int NOT NULL,
customer_id int NOT NULL, 
dish_id int NOT NULL, 
quantity decimal(8,2)
CONSTRAINT FK0_asahaidachna_customers FOREIGN KEY (customer_id)
	REFERENCES db_laba.dbo.asahaidachna_customers (customer_id),
	CONSTRAINT FK1_asahaidachna_orders FOREIGN KEY(order_id)
	REFERENCES db_laba.dbo.asahaidachna_orders (order_id),
	CONSTRAINT FK2_asahaidachna_menu_delivery_dish FOREIGN KEY (dish_id)
	REFERENCES db_laba.dbo.asahaidachna_menu_delivery(dish_id)
	);

	SELECT * FROM db_laba.dbo.asahaidachna_details_orders

	INSERT INTO db_laba.dbo.asahaidachna_details_orders
	VALUES (1,5, 1,1),
	(2,6, 4, 1),
	(2,6,  5, 1),
	(3,4,  4, 1),
	(4,3,  3,1),
	(5,3, 2, 1),
	(6,10,  1,1),
	(6,10, 4, 1),
	(7,10,  1,1),
	(8, 1,  3,  2),
	(9,7,  2,1),
	(10,1, 3, 1),
	(10,1, 4,2)
	

	/*VALUES 1(5, 'Delivered', 8, '02.20.2019'), 2(6, 'Delivered', 5, '01.17.2019'),
	3(4, 'Canceled', 8, '03-19-2019'), 4(3, 'Delivered', 2, '01-03-2019'),
	5(3, 'Delivered', 10, '07-02-2019'), 6(10, 'Delivered', 7, '09-04-2019'),
	7(10, 'Canceled', 9, '06-03-2019'), 8(1, 'Delivered', 1, '01-15-2019'),
	9(7, 'Delivered', 4, '09-04-2019'), 10(2, 'Deliverd', 9, '06-21-2019')

	(2,'Bazhenova 58'), (1,'Soborna 30'), (5,'Stiletska 65'), (10,'Teatralna 24'), 
	(8,'Vashchuka 10'), (6,'Pl. Mury 5'), (7,'Chehova 50'), (3,'Kyivska 51'),
	(1,'Kosmonavtiv 14'), (4,'1-st May 25'), (9,'D.Nechia 87'), (3,'Teatralna 21'),
	(1,'Soborna 8'), (4,'Soborna 25'), (7,'Kyivska 48'), (5,'Pl.Mury 3')*/


--7.     По желанию, добавить свои таблицы и их содержание в этом пункте.
--8.     Самая популярная пицца

 SELECT x.name, x.row_id from 
 (select y.name, ROW_NUMBER() OVER (ORDER BY y.count_dish desc)  as row_id FROM 
 (SELECT d.name, count(od.dish_id)  as count_dish FROM db_laba.dbo.asahaidachna_details_orders od JOIN db_laba.dbo.asahaidachna_menu_delivery d 
 on d.dish_id= od.dish_id group by od.dish_id, d.name )y)x
 where x.row_id = 1

--9.     Самая не популярная пицца
SELECT x.name, x.row_id from 
 (select y.name, ROW_NUMBER() OVER (ORDER BY y.count_dish )  as row_id FROM 
 (SELECT d.name, count(od.dish_id)  as count_dish FROM db_laba.dbo.asahaidachna_details_orders od JOIN db_laba.dbo.asahaidachna_menu_delivery d 
 on d.dish_id= od.dish_id group by od.dish_id, d.name )y)x
 where x.row_id = 1

/*10. Выведите имя пиццы, количество проданных пиццы, на какую сумму было продано,
    имя продавца и его телефон за последние 30 дней (подсказка getdate() - 30)
    Отсортируйте на ваше усмотрение*/

	SELECT d.name, sum(o.quantity) as amount, sum(d.price*o.quantity) as sum_sold, s.first_name,s.phone
	FROM db_laba.dbo.asahaidachna_details_orders o
	INNER JOIN db_laba.dbo.asahaidachna_orders ord
	ON o.order_id = ord.order_id
	INNER JOIN db_laba.dbo.asahaidachna_salesman s
	ON s.salesman_id =  ord.salesman_id
	JOIN db_laba.dbo.asahaidachna_menu_delivery d 
	on d.dish_id= o.dish_id
	where ord.order_date > (getdate() - 30)
	GROUP BY d.name, s.first_name,s.phone
	ORDER BY getdate();
	
/*11. Выведите дату заказа, номер заказа, количество позиций в заказе, имя клиента,
    телефон клиента и адрес доставки, имя и телефон продавца для отмененных заказов
    Отсортируйте на ваше усмотрение*/

	SELECT o.order_date, o.order_id, sum(d.quantity), c.first_name,  c.phone, ac.street
	FROM db_laba.dbo.asahaidachna_orders o
	INNER JOIN db_laba.dbo.asahaidachna_details_orders d
	ON o.order_id = d.order_id
	INNER JOIN db_laba.dbo.asahaidachna_adress_customers ac
	ON ac.adress_id = o.adress_id
	JOIN db_laba.dbo.asahaidachna_customers c
	ON ac.customer_id = c.customer_id
	WHERE o.status = 'Canceled'
	GROUP BY o.order_date, o.order_id, c.first_name,  c.phone, ac.street, c.customer_id


