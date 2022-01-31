prompt Borrando la tabla IVAS
drop table ivas cascade constraint
/
prompt Borrando la tabla ALMACENES
drop table almacenes cascade constraint
/
prompt Borrando la tabla FORMAS_PAGO
drop table formas_pago cascade constraint
/
prompt Borrando la tabla FACTURAS
drop table FACTURAS cascade constraint
/
prompt Borrando la tabla FACTURAS_CL
drop table FACTURAS_CL cascade constraint
/
prompt Borrando la tabla RECIBOS
drop table RECIBOS cascade constraint
/
prompt Borrando la tabla RECIBOS_CL
drop table RECIBOS_CL cascade constraint
/
prompt Borrando la tabla FAMILIAS
drop table familias cascade constraint
/
prompt Borrando la tabla TARIFAS
drop table tarifas cascade constraint
/
prompt Borrando la tabla CLIENTES
drop table clientes cascade constraint
/ 
prompt Borrando la tabla PEDIDOS_CL
drop table pedidos_cl cascade constraint
/
prompt Borrando la tabla PROVEEDORES
drop table proveedores cascade constraint
/
prompt Borrando la tabla ALBARANES
drop table albaranes cascade constraint
/
prompt Borrando la tabla PEDIDOS
drop table pedidos cascade constraint
/
prompt Borrando la tabla ARTICULOS
drop table articulos cascade constraint
/
prompt Borrando la tabla EXISTENCIAS
drop table existencias cascade constraint
/
prompt Borrando la tabla OFERTAS
drop table ofertas cascade constraint
/
prompt Borrando la tabla ALBARANES_CL
drop table albaranes_cl cascade constraint
/
prompt Borrando la tabla LIN_PED_CL
drop table lin_ped_cl cascade constraint
/
prompt Borrando la tabla REALIZA
drop table realiza cascade constraint
/
prompt Borrando la tabla LIN_ALB_CL
drop table lin_alb_cl cascade constraint
/
prompt Borrando la tabla DESCUENTOS
drop table descuentos cascade constraint
/
prompt Borrando la tabla LIN_ALB
drop table lin_alb cascade constraint
/
prompt Borrando la tabla LIN_PED
drop table lin_ped cascade constraint
/
prompt Borrando la tabla ART_PRO
drop table art_pro cascade constraint
/
prompt Borrando la tabla CONTADOR_FACT
drop table CONTADOR_FACT cascade constraint
/
prompt Borrando la tabla CONTADOR_FACT_CL
drop table CONTADOR_FACT_CL cascade constraint
/
prompt Borrando la tabla PED_ALB
drop table PED_ALB cascade constraint
/
prompt Borrando la tabla PED_ALB_CL
drop table PED_ALB_CL cascade constraint
/
drop table usuarios;
-- TABLA USUARIOS PARA ACCESO POR INTERNET
CREATE  TABLE USUARIOS(
IDENTIFICADOR  VARCHAR2(10) PRIMARY key,
USUARIO        VARCHAR2(10) NOT NULL,
CLAVE          VARCHAR2(10) NOT NULL
);
INSERT INTO USUARIOS VALUES(1,'angel','numancia');
INSERT INTO USUARIOS VALUES(2,'alumno','alumno');
 
PROMPT ************************************
PROMPT COMIENZA LA CREACION DE LAS TABLAS DEL HERBOLARIO
PROMPT ************************************
PROMPT creando la tabla CONTADOR_FACT
--
create table contador_fact(
numero number(10) constraint PK_contador_fact primary key)
/
insert into contador_fact values(0)
/
PROMPT creando la tabla CONTADOR_FACT_CL
--
create table contador_fact_cl(
numero number(10) constraint PK_contador_fact_cl primary key)
/
insert into contador_fact_cl values(0)
/
PROMPT creando la tabla IVAS
--
create table ivas 
(cod_iva varchar2(10),
tipo_iva number(10,3) not null,
--
constraint pk_ivas primary key(cod_iva))
/
PROMPT creando la tabla ALMACENES
--
create table almacenes
(cod_alm varchar2(10),
descripcion varchar2(50) not null,
direccion varchar2(50),
telf varchar2(9),
--
constraint pk_almacenes primary key(cod_alm))
/
PROMPT creando la tabla FAMILIAS
--
create table familias
(cod_fam varchar2(10),
descripcion varchar2(50) not null,
--
constraint pk_familias primary key(cod_fam))
/
PROMPT creando la tabla TARIFAS
--
create table tarifas
(cod_tarifa varchar2(10),
descripcion varchar2(50) not null,
--
constraint pk_tarifas primary key(cod_tarifa))
/
PROMPT creando la tabla FORMAS_PAGO
--
create table formas_pago(
codigo varchar2(10),
numero_vtos number(3) not null,
dias number(6) default 0,
--
constraint pk_formas_pago primary key(codigo))
/
PROMPT creando la tabla CLIENTES
--
create table clientes
(cod_cli varchar2(10),
razon_social varchar2(20) not null,
telf varchar2(9),
direccion varchar2(50) not null,
oferta varchar2(1) default ('S'),
alb_fact varchar2(1)default('N'),
cod_iva varchar2(10) not null,
cod_tarifa varchar2(10) not null,
forma_pago varchar2(10) not null,
--
constraint pk_clientes primary key(cod_cli),
--
constraint fk_cli_tar foreign key(cod_tarifa)
         references tarifas(cod_tarifa),
constraint fk_cli_iva foreign key(cod_iva)
        references ivas(cod_iva),
constraint fk_cli_formas_pago foreign key(forma_pago)
        references formas_pago(codigo),
--
constraint check_cli_albfact check (alb_fact in ('S','N')),
constraint check_cli_oferta check (oferta in ('S','N'))  )
/
PROMPT creando la tabla FACTURAS_CL
--
create table facturas_cl (
num_factura number(10),
fecha_fact date,
importe number(12,3),
cod_cli VARCHAR2(10) NOT NULL,
constraint PK_facturas_cL primary Key (num_factura),
constraint fk_facturas_cl_clientes_cl foreign key(cod_cli)
                                     references clientes)
/
PROMPT creando la tabla PEDIDOS_CL
--
create table pedidos_cl
(n_ped number(10),
fecha_ped date default sysdate,
cod_cli varchar2(10) not null,
--
constraint pk_pedidos_cli primary key(n_ped),
--
constraint fk_ped_cl_cli foreign key(cod_cli)
        references clientes (cod_cli))
/
PROMPT creando la tabla PROVEEDORES
--
create table proveedores
(cod_pro varchar2(10),
razon_social varchar2(50) not null,
telf varchar2(9),
direccion varchar2(50) not null,
alb_fact varchar2(1)default('N'),
cod_pos varchar2(10),
cod_iva varchar2(10) not null,
forma_pago varchar2(10) NOT NULL,
--
constraint pk_proveedores primary key(cod_pro),
--
constraint fk_pro_formas_pago foreign key(forma_pago)references formas_pago(codigo),
constraint check_pro_albfact check (alb_fact in ('S','N')),
constraint fk_pro_iva foreign key(cod_iva) references ivas(cod_iva))
/
PROMPT creando la tabla FACTURAS
--
create table facturas (
num_factura number(10),
fecha_fact date,
importe number(12,3),
cod_pro varchar2(10) not null,
constraint PK_facturas primary Key (num_factura),
constraint fk_facturas_proveedores foreign key(cod_pro)
                                   references proveedores)
/
PROMPT creando la tabla ALBARANES
--
create table albaranes
(cod_albaran varchar2(10),
f_albaran date,
f_entrada date default sysdate,
cod_pro varchar2(10) not null,
num_factura number(10),
--
constraint pk_albaranes primary key(cod_albaran),
--
constraint fk_alb_pro foreign key(cod_pro) references proveedores(cod_pro),
constraint fk_alb_Factura foreign key(num_factura) references Facturas)
/
PROMPT creando la tabla PEDIDOS
--
create table pedidos
(n_ped number(10),
fecha_ped date default sysdate, 
cod_pro varchar2(10) not null,
--
constraint pk_pedidos primary key(n_ped),
--
constraint fk_ped_pro foreign key(cod_pro)
                 references proveedores(cod_pro))
/
PROMPT borrando SECUENCIA PARA PEDIDOS S_PEDIDOS
drop sequence S_PEDIDOS
/
PROMPT CREANDO SECUENCIA PARA PEDIDOS S_PEDIDOS
CREATE SEQUENCE S_PEDIDOS INCREMENT BY 1 START WITH 1 
    MAXVALUE 1.0E27 MINVALUE 1 NOCYCLE 
    CACHE 20 ORDER
/
PROMPT creando la tabla ARTICULOS
--
create table articulos
(cod_art varchar2(10),
descripcion varchar2(50) not null,
precio_mer number(10,3),
cod_fam varchar2(10) not null,
--
constraint pk_articulos primary key(cod_art),
--
constraint fk_art_fam foreign key(cod_fam)
         references familias(cod_fam))
/
PROMPT creando la tabla EXISTENCIAS
--
create table existencias
(cod_alm varchar2(10) ,
cod_art varchar2(10) ,
f_caducidad date,
stock_ini number(10,3) default 0,
stock_teorico number(10,3) default 0,
pcmp number(10,3) default 0,
--
constraint pk_existencias primary key(f_caducidad,cod_alm,cod_art),
--
constraint ck_stock_ini check(stock_ini>=0),
constraint ck_stock_teorico check(stock_teorico>=0),
constraint ck_pcmp check(pcmp>=0),
--
constraint fk_exi_alm foreign key(cod_alm)
                  references almacenes(cod_alm),
constraint fk_exi_art foreign key(cod_art)
           references articulos(cod_art))
/
PROMPT creando la tabla OFERTAS
--
create table ofertas
(f_desde date,
f_hasta date,
cod_art varchar2(10) not null,
pvo number(10,3) not null,
--
constraint pk_ofertas primary key(f_desde,cod_art),
--
constraint fk_ofe_art foreign key(cod_art)
             references articulos(cod_art))
/
CREATE  or replace TRIGGER CONTROL_FECHAS
BEFORE INSERT 
ON OFERTAS 
FOR EACH ROW when (new.f_desde < new.f_hasta)
declare
error1 exception;
error2 exception;
error3 exception;
cursor c1 is select f_desde,f_hasta from ofertas where cod_art=:new.cod_art;
begin
if :new.f_desde < sysdate then
   raise error1;
else
   for cur_c1 in c1 loop
     if (:new.f_desde between cur_c1.f_desde and cur_c1.f_hasta) then
       raise error3;
     end if;
     if (:new.f_hasta between cur_c1.f_desde and cur_c1.f_hasta) then
       raise error2;
     end if;  
   end loop;    
end if;
EXCEPTION
when error1 then
 RAISE_APPLICATION_ERROR(-20001,'fecha inicial de oferta inferior a la actual');
 when error2 then
 RAISE_APPLICATION_ERROR(-20001,'Ya existe una oferta  para el articulo que incluye la fecha final');
when error3 then
 RAISE_APPLICATION_ERROR(-20001,'Ya existe una oferta para el articulo  que incluye la fecha inicial');
when others then
 RAISE_APPLICATION_ERROR(-20002,sqlcode||'***'||sqlerrm);
End;
/
PROMPT creando la tabla ALBARANES_CL
--
create table albaranes_cl
(cod_albaran number(10),
f_salida date default sysdate,
cod_cli varchar2(10) not null,
num_factura number(10),
--
constraint pk_albaranes_cl primary key(cod_albaran),
--
constraint fk_alb_cl_cli foreign key(cod_cli)
           references clientes(cod_cli),
--
constraint fk_alb_cl_Factura_cL foreign key(num_factura)
           references Facturas_cL)
/
PROMPT creando la tabla LIN_PED_CL
--
create table lin_ped_cl
(n_ped number(10),
cod_art varchar2(10),
cantidad number(10,3) not null,
cantidad_serv number(10,3) default 0,
--
constraint pk_lin_ped_cl primary key(n_ped,cod_art),
--
constraint fk_lin_ped_cl_pedcl foreign key(n_ped)
             references pedidos_cl(n_ped)
             on delete cascade,
constraint fk_lin_ped_cl_art foreign key(cod_art)
            references articulos(cod_art),
constraint chec_cantidades check(cantidad_serv<=cantidad)
)
/
PROMPT creando la tabla REALIZA
--
create table realiza
(cod_tarifa varchar2(10),
cod_art varchar2(10) ,
precio_tar number(10,3) not null,
f_tarifa date default sysdate,
precio_ant number(10,3),
--
constraint pk_realiza primary key(cod_tarifa,cod_art),
--
constraint fk_rea_tar foreign key(cod_tarifa)
         references tarifas(cod_tarifa)
                      on delete cascade,
constraint fk_rea_art foreign key(cod_art)
         references articulos(cod_art))
/
PROMPT creando la tabla LIN_ALB_CL
--
create table lin_alb_cl
(cod_albaran number(10) ,
cod_alm varchar2(10) ,
cod_art varchar2(10) ,
f_caducidad date ,
cant_sal number(10,3) not null,
precio_sal number(10,3) not null,
dto1  number(4,2),
dto2  number(4,2),
dto3  number(4,2),
--
constraint pk_lin_alb_cl primary key(f_caducidad,cod_albaran,cod_art, cod_alm),
--
constraint fk_lin_alb_cl_exi foreign key(f_caducidad,cod_art,cod_alm)
          references existencias(f_caducidad,cod_art,cod_alm),
constraint fk_lin_alb_cl_alb foreign key(cod_albaran)
          references albaranes_cl(cod_albaran) )
/
PROMPT creando la tabla DESCUENTOS
--
create table descuentos
(cod_dto varchar2(10),
cod_alm varchar2(10),
cod_cli varchar2(10),
cod_fam varchar2(10),
cod_art varchar2(10),
f_caducidad date, 
descripcion varchar2(50) not null,
d1 number(4,2) not null,
d2 number(4,2),
d3 number(4,2),
--
constraint pk_descuentos primary key(cod_dto),
--
constraint uni_dto 
unique(cod_cli,cod_fam,cod_alm,cod_art,f_caducidad),
--
constraint fk_dto_cli foreign key (cod_cli)
           references clientes(cod_cli),
constraint fk_dto_fam foreign key (cod_fam)
           references familias(cod_fam),
constraint fk_dto_exi foreign key(cod_alm,cod_art,F_caducidad)
         references existencias(cod_alm,cod_art,F_caducidad)) 
/
PROMPT creando la tabla LIN_ALB
--
create table lin_alb
(cod_albaran varchar2(10) ,
cod_alm varchar2(10) ,
cod_art varchar2(10) ,
f_caducidad date ,
cant_ent number(10,3) not null,
precio_ent number(10,3) not null,
--
constraint pk_lin_alb primary Key(cod_albaran,f_caducidad,cod_alm,cod_art),
--
constraint fk_lin_alb_alb foreign key(cod_albaran)
           references albaranes(cod_albaran),
constraint fk_lin_alb_exis foreign key(cod_alm,cod_art,F_caducidad)
          references existencias(cod_alm,cod_art,F_caducidad))
/
PROMPT creando la tabla LIN_PED
--
create table lin_ped
(n_ped number(10) ,
cod_art varchar2(10) ,
cantidad number(10,3) not null,
cantidad_serv number(10,3) ,
--
constraint pk_lin_ped primary key(cod_art,n_ped),
--
constraint fk_lin_ped_art foreign key(cod_art) references articulos(cod_art),
constraint fk_lin_ped_ped foreign key(n_ped) references pedidos(n_ped) on delete cascade,
constraint check_cantidades_pro check( cantidad_serv<=cantidad))
/
PROMPT creando la tabla ART_PRO
--
create table art_pro
(cod_pro varchar2(10) ,
cod_art varchar2(10) ,
cod_art_pro varchar2(10) not null,
descripcion varchar2(50) not null,
precio number(10,3) not null,
f_tarifa date default sysdate,
precio_ant number(10,3),
--
constraint pk_art_pro primary key(cod_art,cod_pro),
--
constraint fk_art_pro_art foreign key(cod_art)
           references articulos(cod_art),
constraint Fk_art_pro_pro foreign key(cod_pro)
           references proveedores(cod_pro))
/
prompt creando la tabla RECIBOS
--
create table recibos (
num_factura                                                                                           number(10),
numero number(3),
fecha_vto date,
importe number(13,3),
constraint PK_recibos primary Key (num_factura,numero),
constraint fk_recibos_facturas foreign key(num_factura)
                                           references facturas)
/
prompt creando la tabla RECIBOS_CL
--
create table recibos_cl (
num_factura number(10),
numero number(3),
fecha_vto date,
importe number(12,3),
constraint PK_recibos_cL primary Key (num_factura,numero),
constraint fk_recibos_cL_facturas_cL foreign key(num_factura)
                                    references facturas_CL)
/
prompt creando la tabla PED_ALB
--
create table ped_alb (
cod_albaran varchar2(10),
N_ped number(10),
--
constraint PK_ped_alb primary key(cod_albaran,n_ped),
constraint fk_ped_alb_albaranes foreign key(cod_albaran)
                                     references albaranes,
constraint fk_ped_alb_pedidos foreign key(n_ped)
                                     references pedidos ON DELETE CASCADE)
/
prompt creando la tabla PED_ALB_CL
--
create table ped_alb_cl (
cod_albaran number(10),
N_ped number(10),
--
constraint PK_ped_alb_cl primary key(cod_albaran,n_ped),
constraint fk_ped_alb_cl_albaranes_cl foreign key(cod_albaran)
                                     references albaranes_cl,
constraint fk_ped_alb_cl_pedidos_cl foreign key(n_ped)
                                     references pedidos_cl ON DELETE CASCADE)
/
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/*  DATOS DE LAS TABLAS */ 
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
--****************************************
prompt insertando filas en la tabla IVAS
--**************************************
INSERT INTO IVAS VALUES (1,16)
/
INSERT INTO IVAS VALUES (2, 7)
/
INSERT INTO IVAS VALUES (3, 33)
/
--****************************************
prompt insertando filas en la tabla ALMACENES
--****************************************
INSERT INTO ALMACENES VALUES (1,'GENERAL','C/DOCTOR EZQUERDO Nº 22', 916532185)
/
INSERT INTO ALMACENES VALUES (2,'SUR','C/ODONELL Nº 13', 916324589)
/
INSERT INTO ALMACENES VALUES (3,'NORTE','C/MARTIN VALL Nº 7', 915997965)
/
INSERT INTO ALMACENES VALUES (4,'OESTE','C/VILLAVERDE S/N', 917653301)
/
INSERT INTO ALMACENES VALUES (5,'ESTE','C/ALBERTO AGUILERA Nº 8', 916754155)
/
--*******************************************************
prompt insertando filas en la tabla FAMILIAS
--*******************************************************
INSERT INTO FAMILIAS VALUES (1 , 'TES')
/
INSERT INTO FAMILIAS VALUES (2 , 'MANZANILLAS')
/
INSERT INTO FAMILIAS VALUES (3 , 'HIERBAS DE SOJA')
/
INSERT INTO FAMILIAS VALUES (4, 'AROMATICAS')
/
INSERT INTO FAMILIAS VALUES (5 , 'HIERBAS SECAS')
/
INSERT INTO FAMILIAS VALUES (6 , 'POLEOS')
/
--*******************************************************
prompt insertando filas en la tabla ARTICULOS
--*******************************************************
INSERT INTO  ARTICULOS VALUES(1,'MANZANILLA BOLSA.100G',888,2)
/
INSERT INTO  ARTICULOS VALUES(2,'TE DE PUEBLO BOLSA.100G',125,1)
/
INSERT INTO  ARTICULOS VALUES(3,'MANZANILLA BOLSA.200G',1525.35,2)
/
INSERT INTO  ARTICULOS VALUES(4,'TE DE PUEBLO BOLSA.500G',900,1)
/
--*******************************************************
prompt insertando filas de la tabla TARIFAS
--*******************************************************
insert into tarifas values ('1','General')
/
insert into tarifas values ('2','Clientes_grandes')
/
insert into tarifas values ('3','Clientes_medianos')
/
--*******************************************************
prompt insertando filas en la tabla REALIZA
--*******************************************************
INSERT INTO REALIZA VALUES(1,1,1000.12,SYSDATE,999)
/
INSERT INTO REALIZA VALUES(2,1,1010.12,'17/05/2045',999)
/
INSERT INTO REALIZA VALUES(3,1,1020.12,SYSDATE,999)
/
INSERT INTO REALIZA VALUES(1,2,100.12,SYSDATE,99)
/
INSERT INTO REALIZA VALUES(2,2,110.12,'17/05/2045',99)
/
INSERT INTO REALIZA VALUES(3,2,135,SYSDATE,125)
/
INSERT INTO REALIZA VALUES(1,3,1525,SYSDATE,1523)
/
INSERT INTO REALIZA VALUES(2,3,1600.12,'17/05/2045',1523)
/
INSERT INTO REALIZA VALUES(3,3,1712.4,SYSDATE,1634.89)
/
INSERT INTO REALIZA VALUES(1,4,884,SYSDATE,881)
/
INSERT INTO REALIZA VALUES(2,4,885.12,'17/05/2045',895.12)
/
INSERT INTO REALIZA VALUES(3,4,1234.62,SYSDATE,1634.89)
/
--*******************************************************
--*******************************************************
prompt insertando filas en la tabla FORMAS_PAGO
--*******************************************************
insert into formas_pago values(1,1,0)
/
insert into formas_pago values(2,1,30)
/
insert into formas_pago values(3,1,60)
/
insert into formas_pago values(4,2,30)
/
insert into formas_pago values(5,2,60)
/
insert into formas_pago values(6,3,30)
/
--*******************************************************
prompt insertando filas en la tabla CLIENTES
--*******************************************************
INSERT INTO CLIENTES VALUES (1, 'JM S.A', 916804476, 'C/ RIO 47', 'S', 'N', 1, 1,1)
/
INSERT INTO CLIENTES VALUES (2, 'CARREFOUR', 916053284, 'C/ ROSA 32', 'N', 'S', 2, 2,2)
/
INSERT INTO CLIENTES VALUES (3, 'EL CORTE INGLES', 938047235, 'C/ MADRID 6', 'S', 'S', 3, 3,2)
/
INSERT INTO CLIENTES VALUES (4, 'HIERBAS LUIS', 94387374, 'C/ LEGANES 80', 'N', 'N', 1, 2,2)
/
INSERT INTO CLIENTES VALUES (5, 'PORREROS', 916548476, 'C/ TOLEDO 3', 'S', 'N', 1, 3,3)
/
INSERT INTO CLIENTES VALUES (6, 'MAR S.L', 916438743, 'C/ RIOJA 54', 'N', 'S', 2, 1,4)
/
INSERT INTO CLIENTES VALUES (7, 'HERBOLARIOS JUAN', 943437832, 'C/ MAR 71', 'N', 'N', 2, 2,3)
/
INSERT INTO CLIENTES VALUES (8, 'ALCOSTO', 914373464,'C/ BARDENAS 48', 'S', 'S', 2, 3,5)
/
INSERT INTO CLIENTES VALUES (9, 'ALCAMPO', 943893467, 'C/ MURILLO 10', 'S', 'N', 3, 2,6)
/
INSERT INTO CLIENTES VALUES (10, 'I.S. LUIS VIVES', 973689326, 'C/ VELAZQUEZ 23', 'N', 'S', 3, 2,5)
/
--*******************************************************
prompt insertando filas en la tabla PROVEEDORES
--*******************************************************
INSERT INTO PROVEEDORES VALUES (1,'HP HIERBAS S.L',926456231,'C/ PINAR 59','S',28957,1,1)
/
INSERT INTO PROVEEDORES VALUES (2, 'SORIA NATURAL', 914589436, 'C/ PIZARRO 25','N', 28456, 2,2)
/
INSERT INTO PROVEEDORES VALUES (3, 'OLIMPO', 926587725, 'C/ GOYA 59','S', 28759, 3,2)
/
INSERT INTO PROVEEDORES VALUES (4, 'RIOJA S.L', 944576431, 'C/ REY 3','N', 28924, 3,1)
/
INSERT INTO PROVEEDORES VALUES (5, 'HIERBAS MARRUECOS', 954783439, 'C/ JUEGO 93','S', 25547, 2,4)
/
INSERT INTO PROVEEDORES VALUES (6, 'ALUCILANDIA', 942348746, 'C/ AROSA 14','S', 27543, 1,5)
/
INSERT INTO PROVEEDORES VALUES (7, 'FELIPE RUIZ', 922394087, 'C/ ALICANTE','N', 25486, 1,5)
/
INSERT INTO PROVEEDORES VALUES (8, 'MIRAFLORES', 952184983, 'C/ FUENLABRADA 5','S', 29578, 2,3)
/
INSERT INTO PROVEEDORES VALUES (9, 'KIA S.L', 943782768, 'C/ TERUEL 37','N', 29375,3,6)
/
INSERT INTO PROVEEDORES VALUES (10, 'AVENTURAS', 932632579, 'C/ LEGANES 43','S', 24383, 1,4)
/
--*******************************************************
PROMPT insertando filas en la tabla ART_PRO
--*******************************************************

INSERT INTO ART_PRO VALUES(1,1,'87AE','MANZ 100',614.23,SYSDATE,592.14)
/
INSERT INTO ART_PRO VALUES(2,1,'AE','MANZANILLA',615.23,'12/2/2010',542.14)
/
INSERT INTO ART_PRO VALUES(3,1,'87','MAN 100',619.23,SYSDATE,543.14)
/
INSERT INTO ART_PRO VALUES(4,1,'AS87AE','MANZAN 100 ',619.23,SYSDATE,543.14)
/
INSERT INTO ART_PRO VALUES(1,2,'123E','INFUSION TE',65.23,SYSDATE,61.14)
/
INSERT INTO ART_PRO VALUES(2,2,'EAE','INF TE ',75.23,'12/2/2010',73.14)
/
INSERT INTO ART_PRO VALUES(5,2,'8EE7','INFUSION ',619.23,SYSDATE,75.14)
/
INSERT INTO ART_PRO VALUES(6,2,'ASAE','INF100 TE',49.23,SYSDATE,48.14)
/
INSERT INTO ART_PRO VALUES(1,3,'87AE','MANZ 200',1600.23,SYSDATE,1495.14)
/
INSERT INTO ART_PRO VALUES(2,3,'A44','MAN-200',1601.23,'12/2/2010',1500.14)
/
INSERT INTO ART_PRO VALUES(7,3,'8744','M-200G',1603.23,SYSDATE,1602.14)
/
INSERT INTO ART_PRO VALUES(9,3,'ASE','MANZAN 100 ',1600.23,'18/12/2045',1400.14)
/
INSERT INTO ART_PRO VALUES(9,4,'123E','500G TE',884.23,SYSDATE,883.14)
/
INSERT INTO ART_PRO VALUES(5,4,'EAE','INF TE  500',885.23,'12/2/2010',773.14)
/
INSERT INTO ART_PRO VALUES(7,4,'8EE7','INFUSION500', 892.23,SYSDATE,875.14)
/
INSERT INTO ART_PRO VALUES(6,4,'ASAE','INF500 TE',812.23,SYSDATE,848.14)
/
--*******************************************************
prompt insertando filas en la tabla OFERTAS
--*******************************************************
INSERT INTO OFERTAS VALUES('17/11/2020','20/01/2026','1',20000)
/
INSERT INTO OFERTAS VALUES('19/01/2031','20/02/2038','2',12000)
/
--*******************************************************
prompt insertando filas en la tabla Existencias 
--*******************************************************
--*******************************************************
INSERT INTO EXISTENCIAS VALUES(1,1,'22/3/2005',0,0,0)
/ 
INSERT INTO EXISTENCIAS VALUES(1,1,'22/8/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(1,1,'10/7/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(1,1,'15/12/2004',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(2,1,'22/9/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(2,1,'10/10/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(2,1,'19/7/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(2,1,'3/7/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(3,4,'31/10/2004',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(3,4,'25/11/2004',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(3,4,'31/12/2004',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(3,4,'01/05/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(5,4,'21/12/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(5,4,'21/03/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(5,4,'01/10/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(5,4,'10/11/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(1,2,'31/12/2004',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(1,2,'02/11/2006',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(1,2,'28/02/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(1,2,'30/07/2007',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(2,2,'31/12/2004',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(2,2,'02/01/2009',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(2,2,'30/08/2014',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES(2,2,'21/12/2126',0,0,0)
/
insert into existencias values(3,3,'11/12/05',0,0,0)
/
insert into existencias values(3,3,'12/12/05',0,0,0)
/
insert into existencias values(3,3,'13/12/05',0,0,0)
/
insert into existencias values(3,3,'14/12/05',0,0,0)
/
insert into existencias values(5,3,'11/12/05',0,0,0)
/
insert into existencias values(5,3,'12/12/05',0,0,0)
/
insert into existencias values(5,3,'13/12/05',0,0,0)
/
insert into existencias values(5,3,'14/12/05',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (3,2,'28/08/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (3,2,'11/11/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (3,2,'31/12/2004',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (3,2,'11/11/2004',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (4,2,'28/11/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (4,2,'15/12/2004',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (4,2,'20/01/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (4,2,'28/12/2004',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (1,4,'15/12/2004',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (1,4,'01/01/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (1,4,'05/02/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (1,4,'10/11/2004',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (2,4,'01/12/2004',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (2,4,'16/12/2004',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (2,4,'20/05/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (2,4,'06/02/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (3,1,'25/10/2004',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (3,1,'12/12/2004',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (3,1,'15/01/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (3,1,'13/06/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (4,1,'31/07/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (4,1,'05/11/2004',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (4,1,'08/03/2005',0,0,0)
/
INSERT INTO EXISTENCIAS VALUES (4,1,'17/05/2005',0,0,0)
/
insert into existencias values (1,3,'07/11/2005',0,0,0)
/
insert into existencias values (1,3,'30/11/2004',0,0,0)
/
insert into existencias values (1,3,'01/09/2005',0,0,0)
/
insert into existencias values (1,3,'16/05/2005',0,0,0)
/
insert into existencias values (2,3,'27/08/2006',0,0,0)
/
insert into existencias values (2,3,'12/12/2004',0,0,0)
/
insert into existencias values (2,3,'07/01/2005',0,0,0)
/
insert into existencias values (2,3,'22/12/2005',0,0,0)
/
update existencias set stock_teorico=100
/
--*******************************************************
prompt insertando filas en la tabla DESCUENTOS
--*******************************************************
insert into descuentos values ('1','1',null,null,null,null,'Descuento 10%',0.1,null,null)
/
insert into descuentos values ('2','2',null,null,null,null,'Descuento 12%',0.12,null,null)
/
insert into descuentos values ('3','3',null,null,null,null,'Descuento 14%',0.14,null,null)
/
insert into descuentos values ('4','4',null,null,null,null,'Descuento 16%',0.16,null,null)
/
insert into descuentos values ('5','5',null,null,null,null,'Descuento 18%',0.18,null,null)
/
COMMIT
/
insert into albaranes values(1,'10/01/2004','12/01/2004',1,null);
insert into albaranes values(2,'16/01/2004','18/01/2004',1,null);
insert into albaranes values(3,'20/01/2004','20/02/2004',1,null);
insert into lin_alb values(1,1,1,'22/03/05',10,895);
insert into lin_alb values(1,1,2,'31/12/04',25,358);
insert into lin_alb values(2,2,2,'31/12/04',34,358);
insert into lin_alb values(3,1,1,'22/03/05',10,895);
insert into lin_alb values(3,1,2,'02/11/06',25,358);
insert into albaranes values(4,'10/01/2004','12/01/2004',2,null);
insert into albaranes values(5,'16/01/2004','19/01/2004',2,null);
insert into albaranes values(6,'20/01/2004','20/01/2004',2,null);
insert into lin_alb values(4,1,1,'22/03/05',10,895);
insert into lin_alb values(5,1,2,'31/12/04',25,358);
insert into lin_alb values(5,2,2,'31/12/04',34,358);
insert into lin_alb values(6,1,1,'22/03/05',10,895);
insert into lin_alb values(6,1,2,'02/11/06',25,358);
insert into albaranes values(7,'10/01/2004','12/01/2004',3,null);
insert into albaranes values(8,'16/01/2004','23/01/2004',3,null);
insert into lin_alb values(7,1,1,'22/03/05',10,895);
insert into lin_alb values(7,3,1,'13/06/05',25,358);
insert into lin_alb values(8,2,1,'19/07/05',34,358);
insert into lin_alb values(8,3,1,'13/06/05',10,895);
insert into lin_alb values(8,1,1,'22/03/05',25,358);
insert into albaranes values(9,'20/01/2004','26/01/2004',4,null);
insert into lin_alb values(9,1,1,'22/03/05',10,895);
insert into lin_alb values(9,3,1,'13/06/05',25,358);
insert into lin_alb values(9,2,1,'19/07/05',34,358);
insert into albaranes values(10,'10/01/2004','13/01/2004',5,null);
insert into albaranes values(11,'16/01/2004','01/02/2004',5,null);
insert into lin_alb values(10,1,2,'02/11/06',10,895);
insert into lin_alb values(10,2,4,'20/05/05 ',10,895);
insert into lin_alb values(11,1,2,'02/11/06',25,358);
insert into lin_alb values(11,2,4,'20/05/05',25,358);
insert into albaranes values(12,'20/01/2004','23/01/2004',6,null);
insert into lin_alb values(12,1,2,'02/11/06',1,899);
insert into lin_alb values(12,2,4,'20/05/05 ',85,894);
insert into albaranes_cl values(1,'01/04/2004',1,null);
insert into albaranes_cl values(2,'01/05/2004',1,null);
insert into albaranes_cl values(3,'01/06/2004',1,null);
insert into albaranes_cl values(4,'01/07/2004',1,null);
insert into albaranes_cl values(5,'01/08/2004',1,null);
insert into albaranes_cl values(6,'01/09/2004',1,null);
insert into albaranes_cl values(7,'01/10/2004',1,null);
insert into albaranes_cl values(8,'01/11/2004',1,null);
insert into albaranes_cl values(9,'01/12/2004',1,null);
insert into albaranes_cl values(10,'01/01/2005',1,null);
insert into albaranes_cl values(11,'01/02/2005',1,null);
insert into albaranes_cl values(12,'01/03/2005',1,null);
insert into lin_alb_cl values(1,1,1,'22/03/05',2,12.5,10,null,null);
insert into lin_alb_cl values(2,1,1,'22/03/05',2,12.5,10,null,null);
insert into lin_alb_cl values(3,1,1,'22/03/05',4,12.5,10,null,null);
insert into lin_alb_cl values(4,1,1,'22/03/05',5,12.5,10,null,null);
insert into lin_alb_cl values(5,1,1,'22/03/05',2,12.5,10,null,null);
insert into lin_alb_cl values(6,1,1,'22/03/05',6,12.5,10,null,null);
insert into lin_alb_cl values(7,1,1,'22/03/05',2,12.5,10,null,null);
insert into lin_alb_cl values(8,1,1,'22/03/05',2,12.5,10,null,null);
insert into lin_alb_cl values(9,1,1,'22/03/05',1,12.5,10,null,null);
insert into lin_alb_cl values(10,1,1,'22/03/05',7,12.5,10,null,null);
insert into lin_alb_cl values(11,1,1,'22/03/05',2,12.5,10,null,null);
insert into lin_alb_cl values(12,1,1,'22/03/05',2,12.5,10,null,null);
insert into lin_alb_cl values(1,1,2,'31/12/04',2,12.5,10,null,null);
insert into lin_alb_cl values(2,1,2,'31/12/04',2,12.5,10,null,null);
insert into lin_alb_cl values(3,1,2,'31/12/04',4,12.5,10,null,null);
insert into lin_alb_cl values(4,1,2,'31/12/04',5,12.5,10,null,null);
insert into lin_alb_cl values(5,1,2,'31/12/04',2,12.5,10,null,null);
insert into lin_alb_cl values(6,1,2,'31/12/04',6,12.5,10,null,null);
insert into lin_alb_cl values(7,1,2,'31/12/04',2,12.5,10,null,null);
insert into lin_alb_cl values(8,1,2,'31/12/04',2,12.5,10,null,null);
insert into lin_alb_cl values(9,1,2,'31/12/04',1,12.5,10,null,null);
insert into lin_alb_cl values(10,1,2,'31/12/04',4,12.5,10,null,null);
insert into lin_alb_cl values(11,1,2,'31/12/04',2,12.5,10,null,null);
insert into lin_alb_cl values(12,1,2,'31/12/04',2,12.5,10,null,null);
insert into descuentos values(6,1,1,null,null,null,'10+5+2',0.1,0.05,0.02);
insert into descuentos values(7,1,null,null,2,'31/12/2004','15%',0.15,null,null);
insert into descuentos values(8,1,4,1,null,null,'15+6',0.15,0.06,null);
commit;
CREATE OR REPLACE TRIGGER CONTROL_OFERTAS AFTER INSERT 
    ON OFERTAS 
    FOR EACH ROW 
    declare
cursor c1(codigo varchar2) is select * from realiza
                                            where  cod_art=codigo and
                                                   cod_tarifa in (select cod_tarifa
                                                                  from clientes
                                                                 where oferta='S');
error exception ;
begin
for lineac1 in c1(:new.cod_art) loop
if lineac1.F_tarifa<=:new.F_desde then
     if lineac1.precio_tar<:new.pvo then
      raise error;
     end if;
 elsif  lineac1.F_tarifa>:new.F_desde  and lineac1.F_tarifa<:new.F_hasta then
     if lineac1.precio_tar<:new.pvo or lineac1.precio_ant<:new.pvo then
      raise error;
     end if;
elsif  lineac1.F_Tarifa>:new.F_hasta then
     if  lineac1.precio_ant<:new.pvo then
      raise error;
     end if;
elsif lineac1.F_Tarifa=:new.F_hasta  then
    if lineac1.precio_tar<:new.pvo then
      raise error;
     end if;
end if;
end loop;
exception
when error then
raise_application_error(-20001,'Hay precios de venta inferiores al precio de la oferta en la tarifa  ');
when  others then
raise_application_error(-20002,sqlcode||'  '||sqlerrm);
END;
/
-- TRIGGER
CREATE OR REPLACE TRIGGER CONTROL_STOCK
AFTER INSERT
ON LIN_ALB_CL
FOR EACH ROW
DECLARE 
ERROR EXCEPTION;
CANTIDAD NUMBER;
BEGIN
SELECT STOCK_TEORICO INTO CANTIDAD FROM EXISTENCIAS WHERE COD_ALM=:NEW.COD_ALM AND
                                                           COD_ART=:NEW.COD_ART AND
                                                           F_CADUCIDAD=:NEW.F_CADUCIDAD;
IF CANTIDAD - :NEW.CANT_SAL < 0 THEN
RAISE ERROR;
ELSE 
 UPDATE EXISTENCIAS SET STOCK_TEORICO=STOCK_TEORICO-:NEW.CANT_SAL
  WHERE COD_ALM=:NEW.COD_ALM AND
       COD_ART=:NEW.COD_ART AND
       F_CADUCIDAD=:NEW.F_CADUCIDAD;
END IF;
EXCEPTION
WHEN ERROR THEN
	RAISE_APPLICATION_ERROR(-20001,'NO HAY  STOCK PARA ATENDER LA SALIDA');
WHEN OTHERS THEN
	RAISE_APPLICATION_ERROR(-20002,'ERROR:'||SQLCODE||SQLERRM);
END; 
/
-- TRIGGER
CREATE OR REPLACE TRIGGER MODSTOCK
  BEFORE INSERT 
  ON LIN_ALB
  FOR EACH ROW
BEGIN
  UPDATE  EXISTENCIAS 
  SET STOCK_TEORICO = STOCK_TEORICO+:NEW.CANT_ENT,PCMP=(PCMP*STOCK_TEORICO+:NEW.CANT_ENT*:NEW.PRECIO_ENT)/(STOCK_TEORICO+:NEW.CANT_ENT) 
  WHERE F_CADUCIDAD=:NEW.F_CADUCIDAD AND COD_ALM=:NEW.COD_ALM AND COD_ART=:NEW.COD_ART;
 
EXCEPTION
  WHEN OTHERS THEN
    RAISE_APPLICATION_ERROR (-20002,'ERROR:'||SQLCODE||SQLERRM);
END;
--trigger
/