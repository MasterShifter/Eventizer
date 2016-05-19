DROP DATABASE IF EXISTS planizator;
CREATE DATABASE planizator;
USE planizator;
	
CREATE TABLE roles
(
idRole int AUTO_INCREMENT PRIMARY KEY,
description varchar(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE accounts
(
idAccount int AUTO_INCREMENT PRIMARY KEY,
nickname varchar(25) NOT NULL UNIQUE,
password varchar(100) NOT NULL,
email varchar(200) NOT NULL UNIQUE,
dateCreated date NOT NULL,
idRole int NOT NULL DEFAULT 5,
roleSetBy_idAccount int NOT NULL DEFAULT 1,
loggued tinyint NOT NULL DEFAULT 0,
CONSTRAINT acc_idRole_fk FOREIGN KEY (idRole) REFERENCES roles (idRole),
CONSTRAINT acc_roleSetBy_idAccount_fk FOREIGN KEY (roleSetBy_idAccount) REFERENCES accounts (idAccount)
) ENGINE=InnoDB;

CREATE TABLE users
(
idUser int AUTO_INCREMENT PRIMARY KEY,
name varchar(25) NOT NULL,
surname varchar(100),
birthdate date,
photo varchar(200),
idAccount int NOT NULL,
CONSTRAINT use_idAccount_fk FOREIGN KEY (idAccount) REFERENCES accounts (idAccount)
) ENGINE=InnoDB;

CREATE TABLE events
(
idEvent int AUTO_INCREMENT PRIMARY KEY,
title varchar(100) NOT NULL,
description text NOT NULL,
location varchar(25) NOT NULL,
place varchar(100) NOT NULL,
dateStart datetime NOT NULL,
dateEnd datetime NOT NULL,
photo varchar(200),
ageLimit tinyint,
creador_idUser int NOT NULL,
CONSTRAINT eve_creador_idUser_fk FOREIGN KEY (creador_idUser) REFERENCES users (idUser)
) ENGINE=InnoDB;

CREATE TABLE userHasEvents
(
idUserHasEvent int AUTO_INCREMENT PRIMARY KEY,
idUser int NOT NULL,
idEvent int NOT NULL,
dateJoin date NOT NULL,
CONSTRAINT UseHasEve_idUser_fk FOREIGN KEY (idUser) REFERENCES users (idUser),
CONSTRAINT UseHasEve_idEvent_fk FOREIGN KEY (idEvent) REFERENCES events (idEvent)
) ENGINE=InnoDB;

CREATE TABLE messages
(
idMessage int AUTO_INCREMENT PRIMARY KEY,
title varchar(100) NOT NULL,
content text NOT NULL,
dateSent datetime NOT NULL
) ENGINE=InnoDB;

CREATE TABLE userHasMessages
(
idUserHasMessage int AUTO_INCREMENT PRIMARY KEY,
emisor_idUser int NOT NULL,
receiver_idUser int NOT NULL,
idMessage int NOT NULL,
CONSTRAINT UseHasMes_emisor_idUser_fk FOREIGN KEY (emisor_idUser) REFERENCES users (idUser),
CONSTRAINT UseHasMes_receiver_idUser_fk FOREIGN KEY (receiver_idUser) REFERENCES users (idUser),
CONSTRAINT UseHasMes_idMessage_fk FOREIGN KEY (idMessage) REFERENCES messages (idMessage)
) ENGINE=InnoDB;





INSERT INTO roles (description) VALUES ('Server');
INSERT INTO roles (description) VALUES ('SuperAdministrator');
INSERT INTO roles (description) VALUES ('Administrator');
INSERT INTO roles (description) VALUES ('Moderator');
INSERT INTO roles (description) VALUES ('User');

INSERT INTO accounts (nickname, password, email, dateCreated, idRole, roleSetBy_idAccount) VALUES ('server', 'serverpass', 'server@gmail.com', now(), 1, 1);
INSERT INTO accounts (nickname, password, email, dateCreated, idRole, roleSetBy_idAccount) VALUES ('JoseMaria', 'josemariapass', 'josemaria@gmail.com', now(), 2, 1);
INSERT INTO accounts (nickname, password, email, dateCreated, idRole, roleSetBy_idAccount) VALUES ('admin1', 'admin1pass', 'admin1@gmail.com', now(), 3, 2);
INSERT INTO accounts (nickname, password, email, dateCreated, idRole, roleSetBy_idAccount) VALUES ('admin2', 'admin2pass', 'admin2@gmail.com', now(), 3, 2);
INSERT INTO accounts (nickname, password, email, dateCreated, idRole, roleSetBy_idAccount) VALUES ('moderator1', 'moderatorpass', 'moderator@gmail.com', now(), 4, 3);

INSERT INTO accounts (nickname, password, email, dateCreated) VALUES ('MarcoOlivares', 'marcopass', 'marco@gmail.com', now());
INSERT INTO accounts (nickname, password, email, dateCreated) VALUES ('julioto85', 'juliopass', 'julio@gmail.com', now());
INSERT INTO accounts (nickname, password, email, dateCreated) VALUES ('mariaOlmo', 'mariapass', 'maria@gmail.com', now());
INSERT INTO accounts (nickname, password, email, dateCreated) VALUES ('AntonioRoyers', 'antoniopass', 'antonio@gmail.com', now());
INSERT INTO accounts (nickname, password, email, dateCreated) VALUES ('Zetrakian', 'zetrakianpass', 'zetrakian@gmail.com', now());



INSERT INTO users (name, surname, birthdate, idAccount) VALUES ('Jose María', 'Aparicio', '1994-12-21', 2);
INSERT INTO users (name, surname, birthdate, idAccount, photo) VALUES ('Admincio', '1', '1998-05-23', 3, 'https://bootstrapmaster.com/wp-content/themes/bootstrap/img/avatars/noavatar.png');
INSERT INTO users (name, surname, birthdate, idAccount, photo) VALUES ('Admincia', '2', '1998-06-24', 4, 'http://cdn2.hubspot.net/hub/53/blog/images/Sample-sally-Persona.png');
INSERT INTO users (name, surname, birthdate, idAccount) VALUES ('Moderador', 'Moderado', '1983-12-31', 5);
INSERT INTO users (name, surname, birthdate, idAccount, photo) VALUES ('Marco', 'Olivares', '1990-04-21', 6, 'http://static.pourfemme.it/625X0/coppia/pourfemme/it/img/brava-persona-positiva.jpg');
INSERT INTO users (name, surname, birthdate, idAccount, photo) VALUES ('Julio', 'Fuentes', '1985-01-01', 7, 'http://www.pielsinacne.com/wp-content/uploads/2014/12/hombre-joven-cara-alegre-estudiante.jpg');
INSERT INTO users (name, surname, birthdate, idAccount, photo) VALUES ('María Dolores', 'Olmos', '1983-03-20', 8, 'http://tusbuenosmomentos.com/wp-content/uploads/2013/03/persona-especial.jpg');
INSERT INTO users (name, surname, birthdate, idAccount, photo) VALUES ('Antonio', 'Rogers', '2000-11-04', 9, 'https://guftahot.files.wordpress.com/2012/10/persona-feliz-3.jpg');
INSERT INTO users (name, surname, birthdate, idAccount, photo) VALUES ('Abraham', 'Zetrakian', '1965-05-26', 10, 'http://vignette3.wikia.nocookie.net/the-strain/images/9/9f/Aber-setrakian.jpg/revision/latest/scale-to-width-down/250?cb=20151011014627');


INSERT INTO events (title, description, location, place, dateStart, dateEnd, creador_idUser, photo) VALUES ('Excursión al prado', 'Vamos a hacer una excursión al prado, literalmente, no el del museo, vamos a acampar en medio del campo y a vivir en plena naturaleza, apuntaos.', 'El Prado de San Sebastián', 'La puerta verde', '2016-07-15 17:00:00', '2016-07-15 19:00:00', 5, 'http://www.urbanrail.net/eu/es/sevilla/img/M1-09-Prado-S-Sebastian1.jpg');

INSERT INTO events (title, description, location, place, dateStart, dateEnd, creador_idUser, photo) VALUES ('La piscina de Paco', 'Vamos a ir todos a la piscina de Paco y a bebernos todo el agua, ya que al no usar cloro y estar techada es potable.', 'La piscina de Paco', 'Quedamos en su casa', '2016-07-22 17:00:00', '2016-08-22 00:00:00', 6, 'http://www.piscinasalma.com/web/piscinasalma/images/piscinas/m1000/piscina-m1000_03.jpg');

INSERT INTO events (title, description, location, place, dateStart, dateEnd, creador_idUser, photo) VALUES ('Quedada Fans de Sandro Rey', 'Soy un chico al que Sandro Rey le cambió la vida, me dijo que tendría un empaste y lo tuve cuando no me lave los dientes, es un genio, quiero darle el homenaje de una quedada en su honor y semejanza.', 'La plaza del Rey', 'Al lado de la fuente', '2016-04-12 17:00:00', '2016-04-12 20:00:00', 7, 'http://s03.s3c.es/imag/_v0/640x300/e/c/1/sandro-rey.jpg');

INSERT INTO events (title, description, location, place, dateStart, dateEnd, creador_idUser, photo) VALUES ('Quedada para ver Shrek 5', 'Somos un grupo joven de amigos que compartimos nuestro fanatismo por la saga Shrek, nos encanta la trama que trae y como los personajes se van desarrollando a medida que las entregas evolucionan y evolucionan mas, la queda es en casa del Richard, traed botellines.', 'La parada del 88 en Puente de Mayo', 'Al lado de la parada', '2016-04-12 17:00:00', '2016-04-12 20:00:00', 7, 'http://yosisideral.emisorasunidas.com/sites/default/files/images/shrek-610x350.jpg');



INSERT INTO userHasEvents (idUser, idEvent, dateJoin) VALUES (1, 1, now());
INSERT INTO userHasEvents (idUser, idEvent, dateJoin) VALUES (1, 2, now());
INSERT INTO userHasEvents (idUser, idEvent, dateJoin) VALUES (3, 3, now());
INSERT INTO userHasEvents (idUser, idEvent, dateJoin) VALUES (5, 2, now());
INSERT INTO userHasEvents (idUser, idEvent, dateJoin) VALUES (9, 1, now());
INSERT INTO userHasEvents (idUser, idEvent, dateJoin) VALUES (2, 1, now());
INSERT INTO userHasEvents (idUser, idEvent, dateJoin) VALUES (3, 2, now());
INSERT INTO userHasEvents (idUser, idEvent, dateJoin) VALUES (4, 3, now());
INSERT INTO userHasEvents (idUser, idEvent, dateJoin) VALUES (6, 2, now());
INSERT INTO userHasEvents (idUser, idEvent, dateJoin) VALUES (7, 1, now());

INSERT INTO messages (title, content, dateSent) VALUES ("Hola", "No me gusta tu actitud, ten cuidado", now());
INSERT INTO messages (title, content, dateSent) VALUES ("Esto es la guerra", "Si vuelves a hacer ruido a las 3 de la mañana habra consecuencias", now());
INSERT INTO messages (title, content, dateSent) VALUES ("Hola guapa", "Te invito a montarte en mi limusina", now());
INSERT INTO messages (title, content, dateSent) VALUES ("Estoy interesado en el evento", "Donde tengo que firmar?", now());

INSERT INTO userHasMessages (emisor_idUser, receiver_idUser, idMessage) VALUES (2, 4, 1);
INSERT INTO userHasMessages (emisor_idUser, receiver_idUser, idMessage) VALUES (2, 5, 2);
INSERT INTO userHasMessages (emisor_idUser, receiver_idUser, idMessage) VALUES (4, 7, 3);
INSERT INTO userHasMessages (emisor_idUser, receiver_idUser, idMessage) VALUES (8, 9, 4);