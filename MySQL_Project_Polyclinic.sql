/*База данных поликлиники. Содержит информацию по всем отделениям поликлиники, информацию о пациентах, врачах, услугах, 
есть таблица диагнозов, расписание врачей и работы отделений. Информация об участках и прикрепленным к ним врачах.
БД позволяет получать статистическую информацию например о посещении, распространненых болезнях.
Так же есть таблица с платными услугами, представление о работе врачей которые можно размместить на сайте поликлиники.
Специальный триггер не позволяет удалить данные о пациенте, если он имеет запись о посещении.*/




CREATE DATABASE IF NOT EXISTS polyclinic;
USE polyclinic;

CREATE TABLE IF NOT EXISTS outpatient_department (
	id SERIAL PRIMARY KEY,
	department_name VARCHAR(255) COMMENT 'Название отделения',
	INDEX department_idx(department_name)
) COMMENT 'Отделения поликлиники'; 


INSERT INTO outpatient_department (department_name) VALUES
	('1-е Терапевтическое'),
	('2-е Терапевтическое'),
	('3-е Терапевтическое'),
	('Лучевая диагностика'),
	('Хирургическое'),
	('Гастроэнтерологическое'),
	('Физиотерапевтическое'),
	('Кардиология'),
	('Инфекционное'),
	('Дневной стационар'),
	('Колопроктология'),
	('ЛОР'),
	('Неврология'),
	('Офтальмология'),
	('Администрация');

CREATE TABLE IF NOT EXISTS policlinic_schedule (
	id SERIAL PRIMARY KEY,
	department_id BIGINT UNSIGNED NOT NULL,
	`Monday` VARCHAR(17) DEFAULT NULL,
	`Tuesday` VARCHAR(17) DEFAULT NULL,
	`Wednesday` VARCHAR(17) DEFAULT NULL,
	`Thursday` VARCHAR(17) DEFAULT NULL,
	`Friday` VARCHAR(17) DEFAULT NULL,
	`Saturday` VARCHAR(17) DEFAULT NULL,
	`Sunday` VARCHAR(17) DEFAULT NULL,
	`uneven` VARCHAR(17) DEFAULT NULL,
	`even` VARCHAR(17) DEFAULT NULL
) COMMENT 'график работы отделений';

ALTER TABLE policlinic_schedule ADD FOREIGN KEY (department_id) REFERENCES outpatient_department(id);

INSERT INTO policlinic_schedule (id, department_id, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday`, `Saturday`, `Sunday`, `uneven`, `even`) VALUES
	(1, 1, '12:30 - 16:30', '08:00 - 12:00', '17:00 - 21:00', '12:30 - 16:30', '08:00 - 12:00', 'выходной', 'выходной', NULL, NULL),
	(2, 2, '12:30 - 16:30', '08:00 - 12:00', '17:00 - 21:00', '12:30 - 16:30', '08:00 - 12:00', 'выходной', 'выходной', NULL, NULL),
	(3, 3, '12:30 - 16:30', '08:00 - 12:00', '17:00 - 21:00', '12:30 - 16:30', '08:00 - 12:00', 'выходной', 'выходной', NULL, NULL),
	(4, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '08:00 - 21:00', '08:00 - 21:00'),
	(5, 5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '08:00 - 21:00', '08:00 - 21:00'),
	(6, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '08:00 - 21:00', '08:00 - 21:00'),
	(7, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '08:00 - 21:00', '08:00 - 21:00'),
	(8, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '08:00 - 21:00', '08:00 - 21:00'),
	(9, 9, '13:30 - 20:00', '08:30 - 14:00', '08:30 - 15:00', '08:30 - 15:00', '08:00 - 15:00', 'выходной', 'выходной', NULL, NULL),
	(10, 10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '08:00 - 21:00', '08:00 - 21:00'),
	(11, 11, '19:00 - 20:00', 'выходной', '19:00 - 20:00', 'выходной', 'выходной', 'выходной', 'выходной', NULL, NULL),
	(12, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '08:00 - 21:00', '08:00 - 21:00'),
	(13, 13, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '08:00 - 21:00', '08:00 - 21:00'),
	(14, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '08:00 - 21:00', '08:00 - 21:00'),
	(15, 15, '09:00 - 17:00', '09:00 - 17:00', '09:00 - 17:00', '09:00 - 17:00', '09:00 - 17:00', 'выходной', 'выходной', NULL, NULL);

CREATE TABLE IF NOT EXISTS prof_position (
	id SERIAL PRIMARY KEY,
	position_name VARCHAR(255) COMMENT 'Название должности',
	department_id BIGINT UNSIGNED NOT NULL, 
	INDEX position_idx(position_name),
	FOREIGN KEY (department_id) REFERENCES outpatient_department(id)
) COMMENT 'Должности';

INSERT INTO prof_position (position_name, department_id) VALUES
	('Терапевт', 1),
	('Терапевт', 2),
	('Терапевт', 3),
	('Общая врачебная практика', 1),
	('Общая врачебная практика', 2),
	('Общая врачебная практика', 3),
	('Заведующий отделением', 1),
	('Заведующий отделением', 2),
	('Заведующий отделением', 3),
	('Главный врач', 15),
	('Заместитель главного врача по медицинской части', 15),
	('Заместитель главного врача по ЭВН', 15),
	('Гастроэнтеролог', 6),
	('Врач-инфекционист', 9),
	('Кардиолог', 8),
	('Колопроктолог', 11),
	('ЛОР', 12),
	('Рентгенолог', 4),
	('Невролог', 13),
	('Окулист', 14),
	('Хирург', 5),
	('Физиотерапевт', 7),
	('Дневной стационар', 10);
	

CREATE TABLE IF NOT EXISTS doctors_schedule (
	id SERIAL PRIMARY KEY,
	`Monday` VARCHAR(17) DEFAULT NULL,
	`Tuesday` VARCHAR(17) DEFAULT NULL,
	`Wednesday` VARCHAR(17) DEFAULT NULL,
	`Thursday` VARCHAR(17) DEFAULT NULL,
	`Friday` VARCHAR(17) DEFAULT NULL,
	`Saturday` VARCHAR(17) DEFAULT NULL,
	`Sunday` VARCHAR(17) DEFAULT NULL,
	`uneven` VARCHAR(17) DEFAULT NULL,
	`even` VARCHAR(17) DEFAULT NULL
) COMMENT 'график работы врачей';

INSERT INTO doctors_schedule (id, `Monday`, `Tuesday`, `Wednesday`, `Thursday`, `Friday`, `Saturday`, `Sunday`, `uneven`, `even`) VALUES
	(1, '12:30 - 16:30', '08:00 - 12:00', '17:00 - 21:00', '12:30 - 16:30', '08:00 - 12:00', NULL, NULL, NULL, NULL),
	(2, '09:00 - 17:00', '09:00 - 17:00', '09:00 - 17:00', '09:00 - 17:00', '09:00 - 17:00', NULL, NULL, NULL, NULL),
	(3, '09:00 - 13:00', '09:00 - 13:00', '09:00 - 13:00', '09:00 - 13:00', '09:00 - 13:00', NULL, NULL, NULL, NULL),
	(4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '14:30 - 21:00', '08:00 - 14:30'),
	(5, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '08:00 - 14:30', '14:30 - 21:00'),
	(6, '13:30 - 20:00', '08:30 - 14:00', '08:30 - 15:00', '08:30 - 15:00', '08:00 - 15:00', NULL, NULL, NULL, NULL),
	(7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '10:00 - 14:30', '14:30 - 19:00'),
	(8, '19:00 - 20:00', NULL, '19:00 - 20:00', NULL, NULL, NULL, NULL, NULL, NULL),
	(9, '10:30 - 15:30', '10:30 - 15:30', '10:30 - 15:30', '11:30 - 16:30', '11:30 - 16:30', NULL, NULL, NULL, NULL),
	(10, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '08:00 - 21:00', '08:00 - 21:00');
	

CREATE TABLE IF NOT EXISTS district (
	district_id INT(10) UNSIGNED NOT NULL,
	adress VARCHAR(255),
	PRIMARY KEY (district_id, adress)
) COMMENT 'Участки';

INSERT INTO district (district_id, adress) VALUES
	(1, 'ул.Огнева д.6 к.1'),
	(1, 'Пр.Дальневосточный д.34 к.1'),
	(1, 'Пр.Дальневосточный д.36'),
	(1, 'Пр.Дальневосточный д.38'),
	(2, 'Ул.Дыбенко д.9 к.1'),
	(2, 'Ул.Дыбенко д.11 к.1'),
	(2, 'Пр.Дальневосточный д.30'),
	(3, 'Ул.Е.Огнева д.6 к.3'),
	(3, 'Ул.Е.Огнева д.8 к.2'),
	(3, 'Ул.Дыбенко д.11 к.2'),
	(4, 'Ул.Дыбенко д.15 к.1'),
	(5, 'Ул.Е.Огнева д.12 к.1'),
	(6, 'Ул.Шотмана д.3'),
	(7, ' Пр.Искровский д.28');
	

CREATE TABLE IF NOT EXISTS doctors (
	id SERIAL PRIMARY KEY,
	full_name VARCHAR(255),
	doctor_position BIGINT UNSIGNED NOT NULL,
	work_district INT(10) UNSIGNED,
	education TEXT,
	department BIGINT UNSIGNED NOT NULL,
	qualification_category VARCHAR(255),
	INDEX full_name_idx(full_name),
	FOREIGN KEY (doctor_position) REFERENCES prof_position(id),
	FOREIGN KEY (work_district) REFERENCES district(district_id),
	FOREIGN KEY (department) REFERENCES outpatient_department(id)
) COMMENT 'Доктора';

ALTER TABLE doctors CHANGE work_district work_district INT(10) UNSIGNED DEFAULT NULL;
ALTER TABLE doctors ADD COLUMN doctors_schedule_id BIGINT UNSIGNED NOT NULL;
ALTER TABLE doctors ADD FOREIGN KEY (doctors_schedule_id) REFERENCES doctors_schedule(id);
ALTER TABLE doctors ADD INDEX doctors_id_idx(id);

INSERT INTO doctors (id, full_name, doctor_position, work_district, education, department, qualification_category, doctors_schedule_id) VALUES
	(1, 'Сорочкова Людмила Викторовна', 10, NULL, 'Санкт-Петербургский государственный медицинский университет имени академика И.П.Павлова', 15, 'Высшая', 2),
	(2, 'Тихомирова Любовь Георгиевна', 11, NULL, 'Ленинградский ордена Трудового Красного Знамени педиатрический медицинский институт', 15, 'Высшая', 2),
	(3, 'Матяшкина Марина Васильевна', 12, NULL, 'Тверская государственная медицинская академия', 15, 'Первая', 2),
	(4, 'Баранова Елена Николаевна', 1, 2, 'Санкт-Петербургский медицинский институт им. ак. И.П. Павлова', 1, NULL, 1),
	(5, 'Водопьянова Анна Михайловна', 2, 7, 'Бурятский государственный университет» г.Улан-Удэ', 2, 'Вторая Кандидат медицинских наук', 1),
	(6, 'Акимова Наталья Ивановна', 3, 6, 'Кемеровский государственный медицинский институт', 3, 'Высшая', 1),
	(7, 'Гладышева Тамара Павловна', 13, NULL, 'Самарский государственный медицинский университет Федерального агентства по здравоохранению и социальному развитию', 6, 'Вторая', 4),
	(8, 'Завацкая Алиса Александровна', 13, NULL, 'Санкт-Петербургский государственный медицинский университет имени академика И.П. Павлова', 6, NULL, 5),
	(9, 'Сергеев Александр Михайлович', 14, NULL, 'Ленинградский санитарно-гигиенический медицинский институт', 9, 'Высшая', 5),
	(10, 'Пак Михаил Георгиевич', 15, NULL, 'Военно-медицинская академия имени С.М. Кирова', 8, NULL, 5),
	(11, 'Кривов Александр Петрович', 16, NULL, 'Военно-медицинская академия имени С.М.Кирова', 11, NULL, 8), -- !
	(12, 'Працкевич Светлана Александровна', 17, NULL, 'Санкт-Петербургская государственная медицинская академия им. И.И.Мечникова', 12, 'Высшая', 6),
	(13, 'Уртамова Лариса Валерьевна', 18, NULL, 'Томский ордена Трудового Красного Знамени', 4, 'Высшая', 5),
	(14, 'Юркянец Елена Валентиновна', 19, NULL, 'Санкт-Петербургская государственная медицинская академия им. И.И. Мечникова', 13, NULL, 4),
	(15, 'Карсакова Светлана Алексеевна', 20, NULL, 'Пермский государственный медицинский институт', 14, NULL, 5),
	(16, 'Бурмистров Виктор Александрович', 21, NULL, 'Свердловский государственный медицинский институт', 5, 'Высшая', 4),
	(17, 'Гуменюк Анна Викторовна', 22, NULL, 'Кубанская государственная медицинская академия', 7, NULL, 7),
	(18, 'Шувалова Дарья Александровна', 23, NULL, 'Государственный университет медицины и фармации «Николае Тестемицану» Молдова', 10, NULL, 5),
	(19, 'Ищук Денис Викторович', 21, NULL, 'Санкт-Петербургская государственная педиатрическая медицинская академия', 5, 'Первая', 5);

CREATE TABLE IF NOT EXISTS diagnosis (
	id SERIAL PRIMARY KEY,
	diagnosis_name VARCHAR(255),
	INDEX diagnosis_name_idx(diagnosis_name)
) COMMENT 'Диагноз';

INSERT INTO diagnosis (diagnosis_name) VALUES
	('хронический тонзиллит'),
	('вазомоторный ринит'),
	('серная пробка'),
	('острый назофарингит'),
	('ишемия миокарда'),
	('аритмия'),
	('гипертония'),
	('бронхит'),
	('бронхиальная астма'),
	('пневмония'),
	('анемия'),
	('цирроз печени'),
	('колит'),
	('гастрит'),
	('язвенная болезнь желудка'),
	('эндокардит'),
	('рассеянный склероз'),
	('болезнь Паркинсона'),
	('осеохондроз'),
	('желчнокаменная болезнь'),
	('варикозная болезнь');
	

CREATE TABLE IF NOT EXISTS visit_purpose (
	id SERIAL PRIMARY KEY,
	discription VARCHAR(255)
) COMMENT 'Цель посещения';

INSERT INTO visit_purpose VALUES
	(1, 'выписка льготного рецепта'),
	(2, 'получение заключения'),
	(3, 'оформление посыльного листа'),
	(4, 'медико-социальная экспертиза'),
	(5, 'оформление санаторно-курортной карты'),
	(6, 'выдача справки'),
	(7, 'выписка направления на анализы'),
	(8, 'исследование'),
	(9, 'направление на консультацию'),
	(10, 'госпитализация в другие учреждения'),
	(11, 'госпитализация'),
	(12, 'получение результатов исследования'),
	(13, 'консультация'),
	(14, 'прохождение процедуры'),
	(15, 'услуга');



CREATE TABLE IF NOT EXISTS services (
	id SERIAL PRIMARY KEY,
	service_id VARCHAR(50) UNIQUE,
	service_discription VARCHAR(255),
	unit BIGINT UNSIGNED NOT NULL,
	price DECIMAL (11,2)
) COMMENT 'Платные услуги';

ALTER TABLE services ADD INDEX id_service_id_idx (id, service_id);
ALTER TABLE services ADD FOREIGN KEY (unit) REFERENCES visit_purpose(id);

INSERT INTO services (id, service_id, service_discription, unit, price) VALUES
	(1, 'A26.08.046.999', 'Определение РНК короновируса SARS-CoV-2 в мазках методом ПЦР с забором мазка', 8, 1000.00),
	(2, 'В03.016.002', 'Общий (клинический) анализ крови', 8, 210.00),
	(3, 'А12.05.014', 'Исследование времени свертывания нестабилизированной крови', 8, 130.00),
	(4, 'А09.05.026', 'Исследование уровня холестерина в крови', 8, 170.00),
	(5, 'А26.06.036', 'Определение антигена Hepatitis В Virus', 8, 310.00),
	(6, 'В03.016.006', 'Анализ мочи общий', 8, 280.00),
	(7, 'А04.14.001', 'Ультразвуковое исследование печени', 8, 400.00),
	(8, 'А04.16.001', 'Ультразвуковое исследование органов брюшной полости', 8, 1100.00),
	(9, 'А06.03.019', 'Рентгенография позвоночника в динамике', 8, 1100.00),
	(10, 'А06.04.003', 'Рентгенография локтевого сустава', 8, 500.00),
	(11, 'В01.047.001', 'Прием (осмотр, консультация) врача-терапевта первичный', 13, 550.00),
	(12, 'В01.047.002', 'Прием (осмотр, консультация) врача-невролога', 13, 400.00),
	(13, 'В01.015.001', 'Прием (осмотр,консультация) врача-кардиолога', 13, 550.00),
	(14, 'А04.10.002', 'Эхокардиография', 8, 1750.00),
	(15, 'А04.10.019', 'Colonoscopy', 14, 1050.00);

CREATE TABLE IF NOT EXISTS patient (
	id SERIAL PRIMARY KEY,
	medical_card_id VARCHAR(255),
	full_name VARCHAR(255),
	birthday DATE,
	patient_adress VARCHAR(255),
	gender CHAR(1),
	disability ENUM('отсутствует', 'первая', 'вторая', 'третья', 'ребенок-инвалид'),
	INDEX medical_card_idx(medical_card_id)
) COMMENT 'Пациент';

INSERT INTO patient (id, medical_card_id, full_name, birthday, patient_adress, gender, disability) VALUES 
('1','56422','Carmella Dooley','2014-02-07','ул.Огнева д.6 к.1','m','отсутствует'),
('2','24248','Werner Schinner','2004-12-12','Пр.Дальневосточный д.34 к.1','m','отсутствует'),
('3','16331','Miss Adah Mosciski','1971-07-15','Пр.Дальневосточный д.34 к.1','f','отсутствует'),
('4','65234','Andrew Harber','2016-03-31','Пр.Дальневосточный д.36','m','отсутствует'),
('5','18662','Lilliana Mertz','1998-11-02','ул.Огнева д.6 к.1','m','отсутствует'),
('6','41675','Bethel Medhurst','1995-01-04','Пр.Дальневосточный д.36','m','отсутствует'),
('7','19325','Yessenia VonRueden','1998-03-03','Ул.Дыбенко д.9 к.1','m','первая'),
('8','61933','Anika Waelchi Jr','2012-10-29','ул.Огнева д.6 к.1','m','отсутствует'),
('9','32887','Maymie Pagac','1978-02-16','Пр.Дальневосточный д.34 к.1','f','отсутствует'),
('10','86510','Caden Gerhold','2012-09-21','Пр.Дальневосточный д.36','m','отсутствует'),
('11','65495','Providenci Ernser','1975-11-04','Пр.Дальневосточный д.34 к.1','m','отсутствует'),
('12','93062','Frederique Prohaska','1979-12-05','Ул.Дыбенко д.9 к.1','m','отсутствует'),
('13','66818','Arely Little','1981-02-01','Ул.Дыбенко д.9 к.1','m','отсутствует'),
('14','33881','Cruz Mayer','1984-11-16','Пр.Дальневосточный д.34 к.1','m','отсутствует'),
('15','77690','Kendra Kohler','1989-02-25','ул.Огнева д.6 к.1','f','отсутствует'),
('16','63154','Kobe Collier','1984-05-18','Пр.Дальневосточный д.36','m','отсутствует'),
('17','81211','Karson McGlynn','1992-03-09','Ул.Дыбенко д.9 к.1','m','третья'),
('18','66915','Vladimir Ferry','1992-12-01','ул.Огнева д.6 к.1','f','отсутствует'),
('19','64579','Gia Jacobs','1989-05-16','Пр.Искровский д.28','m','отсутствует'),
('20','71568','Pamela Deckow','2008-06-29','Ул.Шотмана д.3','f','отсутствует'),
('21','58162','Jaquelin Schmitt','1970-02-15','Пр.Дальневосточный д.36','f','отсутствует'),
('22','82651','Keven Rice','2002-01-03','ул.Огнева д.6 к.1','m','отсутствует'),
('23','52018','Scotty Rempel','1979-08-21','Пр.Искровский д.28','f','отсутствует'),
('24','34587','Aurelie Harvey','1982-01-05','Пр.Искровский д.28','f','отсутствует'),
('25','75480','Moses Glover','2006-06-27','Ул.Шотмана д.3','f','отсутствует'); 


CREATE TABLE IF NOT EXISTS visit (
	id SERIAL PRIMARY KEY,
	status ENUM('первичное', 'вторичное'),
	diagnosis_id BIGINT UNSIGNED DEFAULT NULL,
	purpose_id BIGINT UNSIGNED NOT NULL,
	patient_medical_card_id VARCHAR(255),
	doctor_id BIGINT UNSIGNED NOT NULL,
	date_of_visit DATETIME DEFAULT NOW(),
	INDEX visit_idx(id),
	FOREIGN KEY (diagnosis_id) REFERENCES diagnosis(id),
	FOREIGN KEY (purpose_id) REFERENCES visit_purpose(id),
	FOREIGN KEY (patient_medical_card_id) REFERENCES patient(medical_card_id),
	FOREIGN KEY (doctor_id) REFERENCES doctors(id)
) COMMENT 'Посещение';

ALTER TABLE visit 
ADD COLUMN is_paid BIT DEFAULT 0;

ALTER TABLE visit ADD COLUMN service_id BIGINT UNSIGNED DEFAULT NULL;
ALTER TABLE visit ADD FOREIGN KEY (service_id) REFERENCES services(id);

ALTER TABLE visit 
ADD COLUMN recipe VARCHAR(255) DEFAULT NULL;
ALTER TABLE visit ADD INDEX doctor_id_idx(doctor_id);

INSERT INTO visit (id, status, diagnosis_id, purpose_id, patient_medical_card_id, doctor_id, date_of_visit, is_paid, service_id, recipe) VALUES 
('1','первичное',1,'15','16331','14','1991-03-28 11:22:10',0,1,'Libero ex quisquam voluptates.'),
('2','первичное',4,'15','18662','1','1990-06-08 13:29:50',1,2,'Accusamus totam earum aliquam dicta.'),
('3','первичное',5,'15','19325','17','1980-05-21 15:56:43',1,3,'At facere tempora in exercitationem sed.'),
('4','первичное',8,'6','24248','6','2016-12-21 23:57:51',1,4,'Aut fugit voluptas nihil in tempora.'),
('5','первичное',16,'8','32887','1','1978-09-05 05:51:45',0,5,'Dolor et perspiciatis non ut.'),
('6','вторичное',16,'6','33881','19','1981-06-13 13:42:48',0,6,'Quidem et consequuntur sit et.'),
('7','первичное',21,'8','34587','15','2003-01-02 06:07:46',0,14,'Dolor similique qui dolorem dolorum at.'),
('8','вторичное',8,'15','41675','4','1996-11-22 16:33:54',0,2,'Exercitationem corporis accusantium itaque expedita dolores.'),
('9','вторичное',4,'15','52018','9','2019-10-26 17:02:52',0,3,'Aliquid rem vel illum vitae quaerat.'),
('10','первичное',20,'15','56422','12','1971-08-11 22:53:08',1,1,'Labore qui qui voluptatum et saepe.'),
('11','первичное',2,'6','58162','6','2005-09-28 11:44:33',1,2,'Explicabo repellat nobis velit est qui totam.'),
('12','вторичное',3,'6','61933','14','1985-03-07 19:41:42',0,1,'Delectus voluptatum sit repudiandae quia.'),
('13','вторичное',1,'15','63154','8','1983-09-25 02:24:05',0,1,'Quibusdam sed et vitae labore dolor.'),
('14','вторичное',6,'6','64579','16','1983-03-16 05:43:27',0,6,'Suscipit expedita repellendus laboriosam eius.'),
('15','первичное',16,'15','65234','11','1999-09-30 17:20:56',1,6,'Maxime omnis beatae voluptate voluptas.'),
('16','вторичное',20,'8','65495','6','1983-02-07 21:25:49',1,1,'Enim totam dolores non sit numquam ipsa.'),
('17','первичное',19,'8','66818','5','2013-12-01 19:12:38',0,6,'Quo voluptas porro nihil.'),
('18','вторичное',3,'15','66915','19','1989-05-20 10:50:30',0,8,'Voluptatem eveniet dolor modi aspernatur eius quia illo.'),
('19','первичное',14,'8','71568','19','1981-07-25 17:27:49',0,8,'Hic omnis ipsam ad incidunt vitae sunt et.'),
('20','первичное',13,'15','75480','7','2012-12-24 21:10:12',1,1,'Molestiae autem eum non quis.'),
('21','первичное',11,'15','77690','7','2016-01-16 03:22:35',0,1,'Perspiciatis alias et omnis ipsum architecto et ut.'),
('22','первичное',2,'15','81211','15','2015-01-12 08:31:43',1,6,'Commodi repellat dolores deserunt.'),
('23','вторичное',1,'15','82651','13','2015-08-18 18:24:02',0,6,'Laboriosam eos voluptatem tempore.'),
('24','первичное',6,'8','86510','10','1976-07-29 10:03:27',1,14,'Minima atque enim omnis est et.'), -- !
('25','первичное',1,'15','93062','19','1996-07-08 16:17:07',0,6,'Voluptatibus sed at deserunt incidunt impedit.'); 

CREATE OR REPLACE VIEW schedule_information AS
SELECT 
	pp.position_name 'Должность', 
	d.full_name 'ФИО', 
	ds.Monday `Понедельник`, 
	ds.Tuesday `Вторник`, 
	ds.Wednesday `Среда`, 
	ds.Thursday `Четверг`, 
	ds.Friday `Пятница`, 
	ds.Saturday `Суббота`, 
	ds.Sunday `Воскресенье`, 
	ds.uneven `Нечетные дни`, 
	ds.even `Четные дни` 
FROM prof_position pp 
JOIN doctors d ON pp.id = d.doctor_position 
JOIN doctors_schedule ds ON ds.id = d.doctors_schedule_id
ORDER BY pp.position_name;

SELECT * FROM schedule_information;

CREATE OR REPLACE VIEW visit_statistics AS
SELECT 
	pp.position_name 'Должность', 
	d.full_name 'ФИО', 
	COUNT(doctor_id) 'Всего посещений' 
FROM visit v
JOIN doctors d ON d.id = v.doctor_id
JOIN prof_position pp ON pp.id = d.doctor_position 
GROUP BY doctor_id;

SELECT * FROM visit_statistics;

DROP PROCEDURE IF EXISTS total_recipe;

DELIMITER //

CREATE PROCEDURE total_recipe (IN for_visit_id INT)
	BEGIN
		SELECT v.patient_medical_card_id '№ мед.карты',
		       p.full_name 'Пациент',
		       v.date_of_visit 'Дата',
		       di.diagnosis_name 'Диагноз', 
		       d.full_name 'ФИО врача', 
		       v.recipe 'Рецепт' 
		       FROM visit v
		       JOIN patient p 
		       		ON v.patient_medical_card_id = p.medical_card_id 
		       JOIN diagnosis di 
		       		ON v.diagnosis_id = di.id 
		       JOIN doctors d 
		       		ON v.doctor_id = d.id 
		       WHERE v.id = for_visit_id;
	END//

DELIMITER ;

CALL total_recipe(24); -- Талон с рецептом


DROP PROCEDURE IF EXISTS general_adress;

DELIMITER //

CREATE PROCEDURE general_adress (IN for_patient_adress VARCHAR(255))
	BEGIN
		SELECT p.full_name 
		FROM patient p
		JOIN district d
			ON p.patient_adress = d.adress 
			WHERE p.patient_adress = for_patient_adress;
	END//
	
DELIMITER ;

CALL general_adress('Ул.Дыбенко д.9 к.1'); -- Пациенты, проживающие по одному адресу.

DROP TRIGGER IF EXISTS check_patient_delete;

DELIMITER \\

CREATE TRIGGER check_patient_delete BEFORE DELETE ON patient
FOR EACH ROW 
	IF OLD.medical_card_id IN (SELECT patient_medical_card_id FROM visit) THEN
	SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT = 'Пациент имеет записи визита';
	END IF\\

DELIMITER ;

INSERT INTO visit (id, status, diagnosis_id, purpose_id, patient_medical_card_id, doctor_id, date_of_visit, is_paid, service_id, recipe) VALUES 
	('26','вторичное',16,'15','65234','11','1999-09-30 17:20:56',1,6,'Maxime omnis beatae voluptate voluptas.');

DELETE FROM patient WHERE medical_card_id = '65234';





