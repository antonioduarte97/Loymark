go

-----------------------------------------------------------------CREATE DATABASE--------------------------------------------------------
create database Loymark

go


-----------------------------------------------------------------TABLA USUARIO-------------------------------------------------------


if not exists(select * from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA= 'dbo' and TABLE_NAME = 'usuarios')
create table usuario(
id_usuario int primary key identity(1,1),
nombre varchar(30) not null,
apellido varchar(30) not null,
correo_electronico varchar(30) not null,
fecha_nacimiento Date not null,
telefono bigint,
pais_residencia varchar(30) not null,
recibir_informacion bit not null
)

go


-----------------------------------------------------------------TABLA ACTIVIDADES--------------------------------------------------------


if not exists(select * from INFORMATION_SCHEMA.TABLES where TABLE_SCHEMA= 'dbo' and TABLE_NAME = 'actividades')
create table actividades(
id_actividad int primary key identity(1,1),
create_date datetime default getdate() not null,
id_usuario int not null,
actividad varchar(30) not null,
CONSTRAINT fk_IdUsuario FOREIGN KEY (id_usuario)
        REFERENCES dbo.usuario (id_usuario)
		ON DELETE CASCADE
)

go

-----------------------------------------------------------------SP REGISTAR USUARIO--------------------------------------------------------


create procedure usuario_registrar(
@nombre varchar(30),
@apellido varchar(30),
@correo_electronico varchar(30),
@fecha_nacimiento varchar(30),
@telefono bigint,
@pais_residencia varchar(30),
@recibir_informacion bit
)

as
begin

insert into usuario(nombre, apellido, correo_electronico, fecha_nacimiento, telefono, pais_residencia, recibir_informacion)
values
(
@nombre,
@apellido,
@correo_electronico,
@fecha_nacimiento,
@telefono,
@pais_residencia,
@recibir_informacion
)

end


go


-----------------------------------------------------------------SP MODIFICAR USUARIO--------------------------------------------------------


create procedure usuario_modificar(
@id_usuario int,
@nombre varchar(30),
@apellido varchar(30),
@correo_electronico varchar(30),
@fecha_nacimiento varchar(30),
@telefono bigint,
@pais_residencia varchar(30),
@recibir_informacion bit
)

as
begin

update usuario set
nombre = @nombre,
apellido = @apellido,
correo_electronico = @correo_electronico,
fecha_nacimiento = @fecha_nacimiento,
telefono = @telefono,
pais_residencia = @pais_residencia,
recibir_informacion = @recibir_informacion
where id_usuario = @id_usuario
end


go


-----------------------------------------------------------------SP OBTENER USUARIO--------------------------------------------------------

create procedure usuario_obtener(@idusuario int)

as
begin

select * from usuario where id_usuario = @idusuario
end

go


-----------------------------------------------------------------SP LISTAR USUARIO--------------------------------------------------------

create procedure usuario_listar

as
begin

select * from usuario
end

go


-----------------------------------------------------------------SP ELIMINAR USUARIO--------------------------------------------------------

create procedure usuario_eliminar(@idusuario int)

as
begin

delete from usuario where id_usuario = @idusuario
end


go


-----------------------------------------------------------------SP REGISTAR ACTIVIDADES--------------------------------------------------------


create procedure auditoria_registrar(
@create_date datetime,
@id_usuario int,
@actividad varchar(30)
)

as
begin
insert into actividades(create_date, id_usuario, actividad)
values
(
@create_date,
@id_usuario,
@actividad
)

end

go


-----------------------------------------------------------------SP LISTAR ACTIVIDADES--------------------------------------------------------


create procedure actividad_listar

as
begin

select * from actividades order by  create_date desc
end

go