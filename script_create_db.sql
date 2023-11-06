create database truckplace;

create table "location"
(
    insee_code CHAR(5) PRIMARY KEY,
    zip_code CHAR(5) NOT null,
    city_name VARCHAR(255) NOT null,
    latitude DECIMAL (9,6),
    longitude DECIMAL (9,6)
);

create table photo
(
    photo_id SERIAL PRIMARY KEY,
    photo_name VARCHAR(255) NOT null,
    description VARCHAR(255) NOT null,
    size INT not null,
    mimetype VARCHAR(255) NOT null
);

create table "user"
(
    user_id SERIAL PRIMARY KEY,
    pseudo VARCHAR(255) unique NOT null,
    user_name VARCHAR(255) NOT null,
    firstname VARCHAR(255) NOT null,
    email VARCHAR(255) unique NOT null,    
    password CHAR(60) NOT null,
    admin boolean DEFAULT false,,
    is_delete boolean DEFAULT false,
    photo_id INT,
    CONSTRAINT fk_photo FOREIGN KEY (photo_id) REFERENCES photo (photo_id)
);

create table "group"
(
    group_id SERIAL primary key,
    group_name VARCHAR(255) not null,
    user_id INT not null,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES "user" (user_id)

);

CREATE TABLE "join"
(
    user_id INT NOT NULL,
    group_id INT NOT NULL,
    PRIMARY KEY (user_id , group_id),
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES "user" (user_id),
    CONSTRAINT fk_group FOREIGN KEY (group_id) REFERENCES "group" (group_id)
);

create table parking
(
    parking_id SERIAL PRIMARY KEY,
    parking_name VARCHAR(255) NOT null,
    latitude DECIMAL (9,6),
    longitude DECIMAL (9,6),
    nb_space_all INT not null,
    nb_space_free INT not null,
    registration_date TIMESTAMP not null,
    public_view BOOLEAN NOT NULL,
    main_road VARCHAR(255),
    direction VARCHAR(255),
    insee_code CHAR(5),
    user_id INT not null,
    photo_id INT,
    CONSTRAINT fk_location FOREIGN KEY (insee_code) REFERENCES "location" (insee_code),
    CONSTRAINT fk_photo FOREIGN KEY (photo_id) REFERENCES photo (photo_id),
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES "user" (user_id)
);

create table opinion
(
	opinion_id SERIAL primary key,
	opinion text not null,
	note int not null,
	user_id int not null,
	parking_id int not null,
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES "user" (user_id),
    CONSTRAINT fk_parking FOREIGN KEY (parking_id) REFERENCES parking (parking_id)
);

create table "like"
(   
    user_id INT NOT NULL,
    parking_id INT NOT NULL,
    PRIMARY KEY (user_id , parking_id),
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES "user" (user_id),
    CONSTRAINT fk_parking FOREIGN KEY (parking_id) REFERENCES parking (parking_id)
);

create table subscribe
(   
    user_id INT NOT NULL,
    parking_id INT NOT NULL,
    time_subscribe INT,
    PRIMARY KEY (user_id , parking_id),
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES "user" (user_id),
    CONSTRAINT fk_parking FOREIGN KEY (parking_id) REFERENCES parking (parking_id)
);

create table service
(
	service_id SERIAL PRIMARY KEY,
    service_name VARCHAR(255) NOT null
);

CREATE TABLE equip
(
    parking_id INT NOT NULL,
    service_id INT NOT NULL,
    PRIMARY KEY (parking_id , service_id),
    CONSTRAINT fk_parking FOREIGN KEY (parking_id) REFERENCES parking (parking_id),
    CONSTRAINT fk_service FOREIGN KEY (service_id) REFERENCES service (service_id)
);