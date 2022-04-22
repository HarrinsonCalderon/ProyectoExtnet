create table Usuario(
idUsuario int ,
email varchar(100),
contrasena varchar(100),
token varchar(100),
fkidPersona int,
primary key(idUsuario)
);
create table PersonaN(
idPersona int,
nombre varchar(100),
email varchar(100),
contrasena varchar(100),
primary key(idPersona)
);
create table Proyecto(
idProyecto int,
nombre varchar(100),
fkidPersona int,
primary key(idProyecto)
);
create table Tarea(
idTarea int,
nombre varchar(100),
comentario varchar(100),
fechaInicia date,
fechaFin date,
documento varchar(100),
imagen blob,
fkidProyecto int,
fkidestadoTarea int,
primary key(idTarea)
);
create table estadoTarea(
idestadoTarea int,
nombre varchar(100),
primary key(idestadoTarea)
);

alter table Usuario add constraint fk_UwP foreign key (fkidPersona) references PersonaN(idPersona);
alter table Proyecto add constraint fk_PP foreign key (fkidPersona) references PersonaN(idPersona);
alter table Tarea add constraint fk_TP foreign key (fkidProyecto) references Proyecto(idProyecto);
alter table Tarea add constraint fk_TPpp foreign key (fkidestadoTarea) references estadoTarea(idestadoTarea);

--Secuencias y disparadores
--PersonaN
CREATE SEQUENCE seq_PersonaN START WITH 1;
CREATE OR REPLACE TRIGGER tr_PersonaN 
BEFORE INSERT ON PersonaN
FOR EACH ROW
BEGIN
  SELECT seq_PersonaN.NEXTVAL
  INTO   :new.idPersona
  FROM   dual;
END;
--Usuario
CREATE SEQUENCE seq_Usuario START WITH 1;
CREATE OR REPLACE TRIGGER tr_Usuario 
BEFORE INSERT ON Usuario
FOR EACH ROW
BEGIN
  SELECT seq_Usuario.NEXTVAL
  INTO   :new.idUsuario
  FROM   dual;
END;
--Proyecto
CREATE SEQUENCE seq_Proyecto START WITH 1;
CREATE OR REPLACE TRIGGER tr_Proyecto 
BEFORE INSERT ON Proyecto
FOR EACH ROW
BEGIN
  SELECT seq_Proyecto.NEXTVAL
  INTO   :new.idProyecto
  FROM   dual;
END;
--Tarea 
CREATE SEQUENCE seq_Tarea START WITH 1;
CREATE OR REPLACE TRIGGER tr_Tarea
BEFORE INSERT ON Tarea
FOR EACH ROW
BEGIN
  SELECT seq_Tarea.NEXTVAL
  INTO   :new.idTarea
  FROM   dual;
END;
--estadoTarea 
CREATE SEQUENCE seq_estadoTarea START WITH 1;
CREATE OR REPLACE TRIGGER tr_estadoTarea
BEFORE INSERT ON estadoTarea
FOR EACH ROW
BEGIN
  SELECT seq_estadoTarea.NEXTVAL
  INTO   :new.idestadoTarea
  FROM   dual;
END;
insert into PersonaN values(0,'pepe','pepe@gmail.com','pepe'); 
insert into PersonaN values(0,'pepe2','pepe2@gmail.com','pepe2'); 
insert into PersonaN values(0,'pepe3','pepe3@gmail.com','pepe3'); 

insert into usuario values(0,'pepe@gmail.com','pepe','',1);
insert into usuario values(0,'pepe2@gmail.com','pepe2','',2);
insert into usuario values(0,'pepe3@gmail.con','pepe3','',3);

--Para tomar el hostname
--SELECT  host_name
--FROM    v$instance
 
select * from PersonaN;
select * from Usuario;

--Procedimientos 
--Login
create or replace procedure p_login(ema in varchar,contra in varchar, bandera out number)
as
begin
bandera:=0;
select count(*) into bandera from usuario where usuario.email=ema and usuario.contrasena=contra;
end;

SET SERVEROUTPUT ON;
declare 
bandera int;
begin 
 p_login('pepe@gmail.com','pepe',bandera);
 DBMS_OUTPUT.PUT_LINE(bandera);
end;


--Registro

create or replace procedure p_registro(nomb varchar,emai in varchar,contras in varchar, band out number)
is
conta number;
idd number;
begin

 conta:=0;
 select count(*) into conta from Usuario where Usuario.email=emai;
 if conta>0 then
  band:=0;
 else 
   insert into PersonaN values(0,nomb,emai,contras);
   select MAX(idPersona) into idd from PersonaN;
   insert into usuario values(0,emai,contras,'',idd);

  band:=1;
 end if;
end;

SET SERVEROUTPUT ON;
declare 
bandera int;
begin 
 p_registro('marie','marie3@gmail.com','marie',bandera);
 DBMS_OUTPUT.PUT_LINE(bandera);
end;

--Agregar pesonaN
create or replace procedure p_agregarPersona(nombre in varchar,email in varchar)
is
total number;
begin
    total:=0;
     insert into PersonaN values(0,nombre,email,nombre);
     select MAX(idPersona) into total from PersonaN;
    insert into usuario values(0,email,nombre,'',total);
end;

SET SERVEROUTPUT ON;
declare 
bandera int;
begin 
 p_agregarPersona('marie','marie3@gmail.com',bandera);
 DBMS_OUTPUT.PUT_LINE(bandera);
end;

--Actualizar pesonaN
create or replace procedure p_actualizarPersona(nom in varchar,ema in varchar, idd in number)
is

begin
     update PersonaN set nombre=nom,email=ema,contrasena=nom where idpersona=idd;
     update usuario  set email=ema,contrasena=nom where fkidpersona=idd;
end;

SET SERVEROUTPUT ON;
 
begin 
 p_actualizarPersona('marie12','marie3@gmail.com12',5);
end;
--Eliminar pesonaN
create or replace procedure p_eliminarPersona(idd in number)
is
begin
     delete from  usuario    where fkidpersona=idd;
     delete from PersonaN   where idpersona=idd;
    
end;

SET SERVEROUTPUT ON;
 
begin 
 p_eliminarPersona(40);
end;

select * from Usuario;

select * from PersonaN;


select * from PersonaN where idpersona=2;
select MAX(idPersona)  from PersonaN;

 

