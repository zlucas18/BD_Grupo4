CREATE DATABASE GymLM;
USE GymLM;

CREATE TABLE Instructor
(
	Id_Instructor varchar (10) Primary Key,
	NombreInstructor varchar (25),
	NTelefono varchar (10),
	Id_Usuario varchar (10),
);

CREATE TABLE Usuarios 
(
	Id_Usuario varchar(10) Primary Key,
	NombreUsuario Varchar (40),
	Clave Varchar (50)
);

CREATE TABLE UsuarioActividad
(
	Id_Usuario varchar(10) FOREIGN KEY REFERENCES Usuarios(Id_Usuario),
	Id_Actividad int FOREIGN KEY REFERENCES Actividades(Id_Actividad),
	PRIMARY KEY (Id_Usuario, Id_Actividad)
);

CREATE TABLE Administrador
(
	Id_Administrador int Primary Key,
	NombreAdmin varchar (20),
	ClaveA Varchar (10)
);

CREATE TABLE Actividades
(
	Id_Actividad int PRIMARY KEY,
	NombreActividad varchar (50) Not Null,
	TipoActividad Varchar (40),
	Id_Instructor varchar (10), /*Clave Foranea*/
	Id_Reserva int, /*Clave Foranea*/
	Id_CaYCo int, /*Clave Foranea*/
	Id_Administrador int, /*Clave Foranea*/
	Id_Usuario varchar(10), /*Clave Foranea*/
	/*relaciones entre tablas*/
	constraint FK_Instructor FOREIGN KEY (Id_Instructor) REFERENCES Instructor(Id_Instructor),
	constraint FK_Usuarios FOREIGN KEY (Id_Usuario) REFERENCES Usuarios(Id_Usuario),
	constraint FK_Administrador FOREIGN KEY (Id_Administrador) REFERENCES Administrador(Id_Administrador),
	constraint FK_Reservas FOREIGN KEY (Id_Reserva) REFERENCES Reservas(Id_Reserva),
	constraint FK_CalificYCom FOREIGN KEY (Id_CaYCo) REFERENCES CalificacionYCom(Id_CaYCo),
);



INSERT INTO Actividades (Id_Actividad, NombreActividad, TipoActividad) VALUES
(001, 'Cinta de correr', 'Actividades Aeróbicas'),
(002, 'Bicicleta Elíptica', 'Actividades Aeróbicas'),
(003, 'Bicicleta Estática', 'Actividades Aeróbicas'),
(004, 'Pilates', 'Fortalecimiento Muscular'),
(005, 'Sentadillas', 'Fortalecimiento Muscular'),
(005, 'Lagartijas', 'Fortalecimiento Muscular');

SELECT * FROM Actividades;

CREATE TABLE Reservas
(
	Id_Reserva int PRIMARY KEY,
	Fecha Date,
	HorAct Time
	
);
 

CREATE TABLE CalificacionYCom
(
	Id_CaYCo int PRIMARY KEY,
	Calific int,
	Coment Varchar (100)
);

--RadioButton: Opción 1: Me gustó. Opción 2: No me gustó. Opción 3: Podría Mejorar.

-- Procedimiento Almacenado para buscar las actividades que se encuentran en el gimnasio por Tipo de actividad
CREATE PROC SP_Consulta_Actividad
@Actividad as Varchar (40)
AS
BEGIN
SELECT * FROM Actividades WHERE TipoActividad = @Actividad
END;

EXEC SP_Consulta_Actividad 'Fortalecimiento muscular'

-- Creacion del Trigger
CREATE TRIGGER TR_Actividades
ON Actividades
FOR INSERT 
AS
PRINT 'La tabla Actividades fue alterada'









