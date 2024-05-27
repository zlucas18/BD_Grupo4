-- Creamos la Base de Datos Proyecto 1: Gym Las Moles
CREATE DATABASE GymLM

-- Seleccionar BD
USE GymLM;

/*Tabla Historial de Busqueda opcional (En el programa aparezca con un botón que diga generar Historial de Busqueda Actividades)*/

-- Creación de la Tabla Instructor

CREATE TABLE Instructor
(
	Id_Instructor VARCHAR (10) PRIMARY KEY,
	NombreInstructor VARCHAR (25),
	NTelefono VARCHAR (10),
	Id_Usuario VARCHAR (10), -- Llave Foránea para realción con Usuarios
	--Relación entre tablas
	CONSTRAINT FK_Usuarios FOREIGN KEY(Id_Usuario) REFERENCES UsuariosG(Id_Usuario)

);

SELECT * FROM Instructor;

UPDATE Instructor SET NTelefono = '3004393891'

INSERT INTO Instructor (Id_Instructor, NombreInstructor, NTelefono, Id_Usuario) VALUES
('I1', 'Breiner', '3004393891', 1),
('I2', 'Brandon P', '3127517342', 2),
('I3', 'David Andres', '3160600231', 3),
('I4', 'Lucas Zapata', '3214867542', 4);

-- Creamos un Índice No Agrupado para NombreInstructor en orden alfabético

SELECT * FROM Instructor

CREATE NONCLUSTERED INDEX IDX_NombreInstructor
ON Instructor (NombreInstructor)

EXECUTE sp_helpindex 'Instructor'

SELECT Id_Instructor, NombreInstructor FROM Instructor


-- Procedimiento almacenado para insertar instructor

CREATE PROCEDURE SP_InsertarInstructor
@IdInstructor as VARCHAR(10),
@Nombre_Instructor as VARCHAR(25),
@N_Telefono as VARCHAR(10),
@IdUsuario as VARCHAR(10) --?
AS
BEGIN
	INSERT INTO Instructor (Id_Instructor, NombreInstructor, NTelefono)
	VALUES (@IdInstructor, @Nombre_Instructor, @N_Telefono);
END;

-- Procedimiento almacenado para Actualizar Instructor

CREATE PROCEDURE SP_ActualizarInstructor
@IdInstructor as VARCHAR(10),
@Nombre_instructor as VARCHAR(25),
@N_Telefono as VARCHAR(10),
@IdUsuario as VARCHAR(10) --?
AS
BEGIN
	UPDATE Instructor SET NombreInstructor = @Nombre_instructor, NTelefono = @N_Telefono
	WHERE Id_Instructor = @IdInstructor; 
END;

-- Procedimiento almacenado para Eliminar Instructor

CREATE PROCEDURE SP_EliminarInstructor
@IdInstructor as VARCHAR(10)
AS
BEGIN
	DELETE FROM Instructor WHERE Id_Instructor = @IdInstructor;
END;

-------------------------------------------------------------------------------------------------------

-- Creación de la Tabla UsuariosG

CREATE TABLE UsuariosG 
(
  Id_Usuario VARCHAR(10) PRIMARY KEY,
  NombreUsuario VARCHAR(50),
  Clave VARCHAR(40),
  Id_actividad INT,
  FOREIGN KEY (Id_actividad) REFERENCES Actividades(Id_Actividad)
 
);

SELECT * FROM UsuariosG;

UPDATE UsuariosG SET NombreUsuario = 'Camilo Herrera', Clave = 'Milo5657H'
WHERE Id_Usuario = 4

ALTER TABLE UsuariosG
ADD Id_actividad INT;

ALTER TABLE UsuariosG
ADD CONSTRAINT FK_actividad 
FOREIGN KEY (Id_actividad)
REFERENCES Actividades(Id_Actividad)

DELETE FROM UsuariosG
WHERE Id_Usuario = '1' --?

SELECT * FROM UsuariosG;


-- Creamos un Índice No Agrupado

CREATE CLUSTERED INDEX IDX_NombreAlfabetico
ON UsuariosG (NombreUsuario)

execute sp_helpindex 'UsuariosG' 

SELECT Id_Usuario, NombreUsuario FROM UsuariosG;


-- Procedimiento almacenado para Insertar Usuarios

CREATE PROCEDURE SP_InsertarUsuario
@IdUsuario as VARCHAR(10),
@Nombre_Usuario as VARCHAR(40),
@ClaveUsuario as VARCHAR(50)
AS
BEGIN
	INSERT INTO Usuarios (Id_Usuario, NombreUsuario, Clave)
	VALUES (@IdUsuario, @Nombre_Usuario, @ClaveUsuario);
END;


-- Procedimiento almacenado para Actualizar Usuarios

CREATE PROCEDURE SP_ActualizarUsuario
@IdUsuario as VARCHAR(10),
@Nombre_Usuario as VARCHAR(40),
@ClaveUsuario as VARCHAR(50)
AS
BEGIN
	UPDATE Usuarios SET NombreUsuario = @Nombre_Usuario, Clave = @ClaveUsuario
	WHERE Id_Usuario = @IdUsuario;
END;

-- Procedimiento para Eliminar Usuarios

CREATE PROCEDURE SP_EliminarUsuario
@IdUsuario as VARCHAR(10)
AS
BEGIN
	DELETE FROM Usuarios 
	WHERE Id_Usuario = @IdUsuario;
END;

-------------------------------------------------------------------------------------------------------

-- Creación de la Tabla UsuarioActividad
-- Tabla intermedia para relación de muchos a muchos de las tablas UsuariosG y Actividades

CREATE TABLE UsuarioActividad
(
	Id_Usuario VARCHAR (10) FOREIGN KEY REFERENCES UsuariosG(Id_Usuario),
	Id_Actividad INT FOREIGN KEY REFERENCES Actividades(Id_Actividad),
	PRIMARY KEY (Id_Usuario, Id_Actividad)
);

-------------------------------------------------------------------------------------------------------

-- Creación de la Tabla Administrador

CREATE TABLE Administrador
(
	Id_Administrador int Primary Key,
	NombreAdmin varchar (20),
	ClaveA Varchar (10),
	Id_Usuario VARCHAR (10) -- Llave Foránea para relación con Usuarios
	--Relación entre tablas
	CONSTRAINT FK_Usuario FOREIGN KEY (Id_Usuario) REFERENCES UsuariosG(Id_Usuario)
);

SELECT * FROM Administrador

INSERT INTO Administrador (Id_Administrador, NombreAdmin, ClaveA, Id_Usuario) VALUES
(1017, 'Breiner', '0123', 1),
(9001, 'Brandon P', 'a1111', '1'),
(9002, 'David Ándres', 'a1111', '2'),
(9003, 'Lucas Zapata', 'a1111', '3');

-- Procedimiento almacenado para insertar Administrador

CREATE PROCEDURE SP_InsertarAdministrador
@IdAdministrador as INT,
@Nombre_Admin as VARCHAR(20),
@ClaveAdmin as VARCHAR(10)
AS
BEGIN 
	INSERT INTO Administrador (Id_Administrador, NombreAdmin, ClaveA)
	VALUES (@IdAdministrador, @Nombre_Admin, @ClaveAdmin);
END;

-- Procedimiento almacenado para Actualizar Administrador

CREATE PROCEDURE SP_ActualizarAdmin
@IdAdministrador as INT,
@Nombre_Admin as VARCHAR(20),
@ClaveAdmin as VARCHAR(10),
@Id_Usuario as VARCHAR (10)
AS
BEGIN
	UPDATE Administrador SET NombreAdmin = @Nombre_Admin, ClaveA = @ClaveAdmin, Id_Usuario = @Id_Usuario
	WHERE Id_Administrador = @IdAdministrador;
END;

-- Procedimiento almacenado para Eliminar Administrador

CREATE PROCEDURE SP_EliminarAdmin
@IdAdministrador as INT
AS
BEGIN
	DELETE FROM Administrador
	WHERE Id_Administrador = @IdAdministrador;
END;

-------------------------------------------------------------------------------------------------------

-- Creación de la tabla Actividades

CREATE TABLE Actividades
(
	Id_Actividad INT PRIMARY KEY,
	NombreActividad VARCHAR (50) NOT NULL,
	TipoActividad VARCHAR (40) NOT NULL,
	Id_Instructor VARCHAR (10), /*Llave Foranea*/
	Id_Reserva INT, /*Llave Foranea*/
	Id_CaYCo INT, /*Llave Foranea*/
	Id_Administrador INT, /*Llave Foranea*/
	/*relaciones entre tablas*/
	CONSTRAINT FK_Instructor FOREIGN KEY (Id_Instructor) REFERENCES Instructor(Id_Instructor),
	CONSTRAINT FK_Administrador FOREIGN KEY (Id_Administrador) REFERENCES Administrador(Id_Administrador),
	CONSTRAINT FK_Reservas FOREIGN KEY (Id_Reserva) REFERENCES Reservas(Id_Reserva),
	CONSTRAINT FK_CalificYCom FOREIGN KEY (Id_CaYCo) REFERENCES CalificacionYCom(Id_CaYCo),
);

ALTER TABLE Actividades
DROP COLUMN Id_Usuario;

ALTER TABLE Actividades 
DROP CONSTRAINT FK_UsuariosA;

ADD CantidadUsuarios INT DEFAULT 0;


INSERT INTO Actividades (Id_Actividad, NombreActividad, TipoActividad, Id_Instructor, Id_Reserva, Id_CaYCo, Id_Administrador) VALUES
(1, 'los Pilates', 'Fortalecimiento Muscular', 'I1', 01, 01, 1017),
(2, 'Levantamiento de Pesas', 'Fortalecimiento Muscular', 'I2', 02, 01, 1017),
(3, 'Sentadillas', 'Fortalecimiento Muscular', 'I2', 02, 02, 1017),
(4, 'Correr en cinta', 'Actividad aeróbica', 'I2', 001, 01, 9001),
(5, 'Máquina elíptica', 'Actividad aeróbica', 'I3', 002, 02, 9002),
(6, 'Bicicleta estática', 'Actividad aeróbica', 'I4', 003, 03, 9003);

SELECT * FROM Actividades;

--Creamos un Índice no agrupado para NombreActividad por Orden Alfabético

CREATE NONCLUSTERED INDEX IDX_NombreActividad
ON Actividades (NombreActividad)

SELECT Id_Actividad, NombreActividad FROM Actividades


--Trigger que Aumenta la cantidad de usuarios por actividad
CREATE TRIGGER AumentarCantidadUsuario
ON UsuariosG 
AFTER INSERT 
AS
BEGIN
	UPDATE Actividades
	SET CantidadUsuarios = CantidadUsuarios + 1
	FROM Actividades
	JOIN inserted ON Actividades.Id_Actividad = inserted.Id_actividad;
END;

INSERT INTO UsuariosG (Id_Usuario, NombreUsuario, Clave, Id_actividad) VALUES
(1017, 'Juan', 'Juan123', 6);

SELECT * FROM Actividades

-- Procedimiento Almacenado para Insertar Actividades

CREATE PROCEDURE SP_SumarActividad
@IdActividad as INT,
@Nombre_Actividad as VARCHAR(50),
@Tipo_Actividad as VARCHAR (40),
@IdInstructor as VARCHAR (10), --
@IdReserva as INT, --
@IdCaYCo as INT, --
@IdAdmin as INT, --
@IdUser as VARCHAR(10) --
AS
BEGIN
	INSERT INTO Actividades (Id_Actividad, NombreActividad, TipoActividad, Id_Instructor, Id_Reserva, Id_CaYCo, Id_Administrador, Id_Usuario)
	VALUES (@IdActividad, @Nombre_Actividad, @Tipo_Actividad, @IdInstructor, @IdReserva, @IdCaYCo, @IdAdmin, @IdUser);
END;

-- Procedimiento Almacenado para Actualizar Actividades

CREATE PROCEDURE SP_ActualizarAct
@IdActividad as INT,
@Nombre_Actividad as VARCHAR(50),
@Tipo_Actividad as VARCHAR (40),
@IdInstructor as VARCHAR (10), --
@IdReserva as INT, --
@IdCaYCo as INT, --
@IdAdmin as INT, --
@IdUser as VARCHAR(10) --
AS
BEGIN
	UPDATE Actividades SET NombreActividad = @Nombre_Actividad, TipoActividad = @Tipo_Actividad, Id_Instructor = @IdInstructor, Id_Reserva = @IdReserva, Id_CaYCo = @IdCaYCo, Id_Administrador =  @IdAdmin, Id_Usuario = @IdUser
	WHERE Id_Actividad = @IdActividad;
END;

-- Procedimiento Almacenado para Eliminar Actividades

CREATE PROCEDURE SP_EliminarActividad
@IdActividad as INT
AS
BEGIN
	DELETE FROM Actividades
	WHERE Id_Actividad = @IdActividad;
END;

-------------------------------------------------------------------------------------------------------

-- Creación de la Tabla Reservas

CREATE TABLE Reservas
(
	Id_Reserva INT PRIMARY KEY,
	Fecha DATE,
	HorAct TIME,
	Id_Usuario VARCHAR(10)

	CONSTRAINT FK_UsuariosR FOREIGN KEY (Id_Usuario)REFERENCES UsuariosG(Id_Usuario)
);

UPDATE Reservas SET Id_Reserva = 003
WHERE Fecha = '2024-05-30'

INSERT INTO Reservas (Id_Reserva, Fecha, HorAct, Id_Usuario) VALUES
(01, '2024-05-28', '10:00:00', '1'),
(02, '2024-05-27', '12:00:00', '4'),
(03, '2024-05-30', '8:00:00', '3');

-- Índice para Fecha de Reserva mas cercana

SELECT * FROM Reservas;

CREATE NONCLUSTERED INDEX IDX_Fecha
ON Reservas (Fecha)

EXEC sp_helpindex 'Reservas'

SELECT Id_Reserva, Fecha FROM Reservas

-- Procedimiento Almacenado para Insertar Reservas

CREATE PROCEDURE SP_InsertarReserva
@IdReserva as INT,
@FechaR as DATE,
@HoraAct as TIME,
@IdUsuario as VARCHAR(10)
AS
BEGIN
	INSERT INTO Reservas (Id_Reserva, Fecha, HorAct, Id_Usuario)
	VALUES (@IdReserva, @FechaR, @HoraAct, @IdUsuario);
END;

-- Procedimiento almacenado para Actualizar Reserva

CREATE PROCEDURE SP_ActualizarReserva
@IdReserva as INT,
@FechaR as DATE,
@HoraAct as TIME,
@IdUsuario as VARCHAR(10)
AS
BEGIN
	UPDATE Reservas SET Fecha = @FechaR, HorAct = @HoraAct, Id_Usuario = @IdUsuario
	WHERE Id_Reserva = @IdReserva;
END;

-- Procedimiento almacenado para eliminar Reservas

CREATE PROCEDURE SP_EliminarReserva
@IdReserva as INT
AS
BEGIN
	DELETE FROM Reservas
	WHERE Id_Reserva = @IdReserva;
END;
 
 -------------------------------------------------------------------------------------------------------

-- Creación de la Tabla CalificaciónYCom

CREATE TABLE CalificacionYCom
(
	Id_CaYCo INT PRIMARY KEY,
	Calific INT,
	Coment VARCHAR (100),
    Id_Usuario VARCHAR(10)

	CONSTRAINT FK_UsuariosC FOREIGN KEY(Id_Usuario) REFERENCES UsuariosG(Id_Usuario)
);

INSERT INTO CalificacionYCom (Id_CaYCo, Calific, Coment, Id_Usuario) VALUES
(01, 5, 'Excelente Actividad', '1'),
(02, 1, 'La Actividad se acabó mas pronto de lo que duraba', '2'),
(03, 4, 'Agreguen más ejercicios a la actividad!', '3');

-- Creamos un índice para Calificación de menor a Mayor

SELECT * FROM CalificacionYCom

CREATE NONCLUSTERED INDEX IDX_Calificacion 
ON CalificacionYCom (Calific)

EXECUTE sp_helpindex 'CalificacionYCom'

SELECT Id_CaYCo, Calific FROM CalificacionYCom;

-- Procedimiento almacenado para Insertar CalificacionYComentarios

CREATE PROCEDURE SP_InsertarCalificYComent
@IdCaYCo as INT,
@Calificacion as INT,
@Comentarios as VARCHAR(100),
@IdUsuario as VARCHAR(10)
AS
BEGIN
	INSERT INTO CalificacionYCom (Id_CaYCo, Calific, Coment, Id_Usuario)
	VALUES (@IdCaYCo, @Calificacion, @Comentarios, @IdUsuario);
END;

-- Procedimiento Almacenado para Actualizar CalificacionYComentarios

CREATE PROCEDURE SP_ActualizarCayCo
@IdCaYCo as INT,
@Calificacion as INT,
@Comentarios as VARCHAR(100),
@IdUsuario as VARCHAR(10)
AS
BEGIN
	UPDATE CalificacionYCom SET Calific = @Calificacion, Coment = @Comentarios, Id_Usuario = @IdUsuario
	WHERE Id_CaYCo = @IdCaYCo;
END;

-- Procedimiento Almacenado para Eliminar CalificacionYComentarios

CREATE PROCEDURE SP_EliminarCalificYComen
@IdCaYCo as INT
AS
BEGIN
	DELETE FROM CalificacionYCom
	WHERE Id_CaYCo = @IdCaYCo;
END;

-------------------------------------------------------------------------------------------------------

-- Vistas

SELECT * FROM Actividades

SELECT Id_Actividad,NombreActividad,TipoActividad,Id_Instructor
FROM Actividades;

CREATE VIEW listadoActividades
AS
SELECT Id_Actividad,NombreActividad,TipoActividad
From Actividades;


SELECT * FROM listadoActividades

EXEC sp_helptext listadoActividades;

ALTER VIEW listadoActividades with encryption
AS
SELECT Id_Actividad,NombreActividad,TipoActividad
From Actividades;





