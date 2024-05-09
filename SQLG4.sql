-- Creamos la Base de Datos GYMLASMOLES
CREATE DATABASE GYMLASMOLES

USE GYMLASMOLES;

-- Tabla Usuarios
CREATE TABLE Usuarios (
    IdUsuario INT PRIMARY KEY,
    NombreUsuario VARCHAR(50) NOT NULL,
    Clave VARCHAR(50) NOT NULL
);

ALTER TABLE Usuarios
ADD Nombre varchar (40);

-- Tabla Actividades
CREATE TABLE Actividades (
    IdActividad INT PRIMARY KEY,
    NombreActividad VARCHAR(100) NOT NULL,
    TipoActividad VARCHAR(50) NOT NULL
);

INSERT INTO Actividades (IdActividad, NombreActividad, TipoActividad) VALUES
(0001, 'BURPEES', 'Actividades Aeróbicas'),
(0002, 'SALTAR EN LA CUERDA', 'Fortalecimiento Muscular'),
(0003, 'CORRER EN CINTA', 'Fortalecimiento Òseo'),
(0004, 'CORRER EN CINTA', 'Fortalecimiento de Equilibrio');


-- Tabla UsuarioActividad (Tabla intermedia para la relación de muchos a muchos)
CREATE TABLE UsuarioActividad (
    IdUsuario INT FOREIGN KEY REFERENCES Usuarios(IdUsuario),
    IdActividad INT FOREIGN KEY REFERENCES Actividades(IdActividad),
    Fecha DATE NOT NULL,
    PRIMARY KEY (IdUsuario, IdActividad)
);



-- Tabla VisualizacionDisponibilidad
CREATE TABLE VisualizacionDisponibilidad (
    IdVisualizar INT PRIMARY KEY,
    ActividadDisponible BIT NOT NULL,
    FechaAct DATE NOT NULL,
    HorarioSelec TIME NOT NULL,
    NombreAct VARCHAR(100) NOT NULL,
    Instructor VARCHAR(100) NOT NULL,
    AFavorit BIT NOT NULL,
    Tarifas DECIMAL(10, 2) NOT NULL,
    IdActividad INT FOREIGN KEY REFERENCES Actividades(IdActividad)
);

-- Tabla Reservas
CREATE TABLE Reservas (
    IdReserva INT PRIMARY KEY,
    IdActividad INT FOREIGN KEY REFERENCES Actividades(IdActividad),
    ActividadReserv VARCHAR(100) NOT NULL,
    FechaActividad DATE NOT NULL,
    NombreActividad VARCHAR(100) NOT NULL,
    IdUsuario INT FOREIGN KEY REFERENCES Usuarios(IdUsuario)
);

-- Tabla HistorialReservas
CREATE TABLE HistorialReservas (
    IdHistorial INT PRIMARY KEY,
    NombreActividad VARCHAR(100) NOT NULL,
    FechaReserva DATE NOT NULL,
    FechaActividad2 DATE NOT NULL,
    FechaVencimiento DATE NOT NULL,
    IdUsuario INT FOREIGN KEY REFERENCES Usuarios(IdUsuario)
);

-- Tabla Calificaciones
CREATE TABLE Calificaciones (
    IdCalificacion INT PRIMARY KEY,
    IdActividad INT FOREIGN KEY REFERENCES Actividades(IdActividad),
    NombreActividad VARCHAR(100) NOT NULL,
    TipoActividad VARCHAR(50) NOT NULL,
    ComentarioAct TEXT,
    Calificacion INT NOT NULL
);

-- Tabla BuscarActividades
CREATE TABLE BuscarActividades1 (
    IdBuscar INT PRIMARY KEY,
    IdActividad INT FOREIGN KEY REFERENCES Actividades(IdActividad),
    TipoActividad VARCHAR(50) NOT NULL,
    ActDisponible VARCHAR NOT NULL,
    FechaActividad DATE NOT NULL,
    HorarioActividad VARCHAR NOT NULL,
    NombreAct VARCHAR(100) NOT NULL
	);


ALTER TABLE GYMLASMOLES.dbo.BuscarActividades1
ALTER COLUMN ActDisponible VARCHAR(100);


ALTER TABLE GYMLASMOLES.dbo.BuscarActividades1
ALTER COLUMN HorarioActividad VARCHAR(100);

ALTER TABLE GYMLASMOLES.dbo.BuscarActividades1
ALTER COLUMN IdBuscar VARCHAR(50);



-- Tabla AdministracionActiv
CREATE TABLE AdministracionActiv (
    IdAdministracion INT PRIMARY KEY,
    IdActividad INT UNIQUE FOREIGN KEY REFERENCES Actividades(IdActividad),
    AgregarAct BIT NOT NULL,
    Modificar BIT NOT NULL,
    Eliminar BIT NOT NULL,
    GestionUsuarios BIT NOT NULL,
    RevisarReservas BIT NOT NULL
);

INSERT INTO BuscarActividades1 (IdBuscar, IdActividad, TipoActividad, ActDisponible, FechaActividad, HorarioActividad, NombreAct) VALUES
(0001, 0001, 'Actividad Aeróbicas', 	'Si', '2024-05-09', '2024-05-09', 'BURPEES'),
(0002, 0002, 'Fortalecimiento Muscular', 'No', '2024-05-10', '2024-05-10', 'SALTAR LA CUERDA'),
(0003, 0003, 'Fortalecimiento Óseo', 'No', '2024-05-10', '2024-05-10', 'CORRER EN CINTA'),
(0004, 0004, 'Fortalecimiento de Equilibrio', 'Si', '2024-05-12', '2024-05-12', 'CORRER EN CINTA');


-- Creamos un Procedimiento Almacenado para que se haga una consulta del nombre de la actividad y que muestre la información de la actividad

-- NOMBRE ACTIVIDAES: 
-- BURPEES
-- SALTAR LA CUERDA
-- CORRER EN CINTA
-- CORRER EN CINTA

Create proc SP_CONSULTA_NOMBRE
@Nombre as varchar(50)
AS Begin
Select * from BuscarActividades1 where NombreAct = @Nombre
END;

Exec SP_CONSULTA_NOMBRE 'CORRER EN CINTA';

Select * FROM Actividades;