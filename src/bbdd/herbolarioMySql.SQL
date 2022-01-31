CREATE  TABLE USUARIOS(
IDENTIFICADOR  varchar(10) ,
USUARIO        varchar(10) NOT NULL,
CLAVE          varchar(10) NOT NULL,
constraint pK_usuarios primary key (identificador)
);

create table contador_fact(
numero decimal(10) ,
constraint PK_contador_fact primary key(numero)
);

create table contador_fact_cl(
numero decimal(10),
constraint PK_contador_fact_cl primary key(numero)
);

create table ivas
(cod_iva varchar(10),
tipo_iva decimal(10,3) not null,
constraint pk_ivas primary key(cod_iva)
);

create table almacenes
(cod_alm varchar(10),
descripcion varchar(50) not null,
direccion varchar(50),
telf varchar(9),
constraint pk_almacenes primary key(cod_alm))
;

create table familias
(cod_fam varchar(10),
descripcion varchar(50) not null,
constraint pk_familias primary key(cod_fam))
;

create table tarifas
(cod_tarifa varchar(10),
descripcion varchar(50) not null,
constraint pk_tarifas primary key(cod_tarifa))
;

create table formas_pago(
codigo varchar(10),
numero_vtos decimal(3) not null,
dias decimal(6) default 0,
constraint pk_formas_pago primary key(codigo))
;

create table clientes
(cod_cli varchar(10),
razon_social varchar(20) not null,
telf varchar(9),
direccion varchar(50) not null,
oferta varchar(1),
alb_fact varchar(1),
cod_iva varchar(10) not null,
cod_tarifa varchar(10) not null,
forma_pago varchar(10) not null,
constraint pk_clientes primary key(cod_cli),
constraint fk_cli_tar foreign key(cod_tarifa)
         references tarifas(cod_tarifa),
constraint fk_cli_iva foreign key(cod_iva)
        references ivas(cod_iva),
constraint fk_cli_formas_pago foreign key(forma_pago)
        references formas_pago(codigo),
constraint check_cli_albfact check (alb_fact in ('S','N')),
constraint check_cli_oferta check (oferta in ('S','N'))  )
;

create table facturas_cl (
num_factura decimal(10),
fecha_fact date,
importe decimal(12,3),
cod_cli varchar(10) NOT NULL,
constraint PK_facturas_cL primary Key (num_factura),
constraint fk_facturas_cl_clientes_cl foreign key(cod_cli)
                                     references clientes(cod_cli))
;

create table pedidos_cl(
n_ped decimal(10),
fecha_ped date,
cod_cli varchar(10) not null,
constraint pk_pedidos_cli primary key(n_ped),
constraint fk_ped_cl_cli foreign key(cod_cli)
        references clientes (cod_cli))
;

create table proveedores
(cod_pro varchar(10),
razon_social varchar(50) not null,
telf varchar(9),
direccion varchar(50) not null,
alb_fact varchar(1),
cod_pos varchar(10),
cod_iva varchar(10) not null,
forma_pago varchar(10) NOT NULL,
constraint pk_proveedores primary key(cod_pro),
constraint fk_pro_formas_pago foreign key(forma_pago)
        references formas_pago(codigo),
constraint check_pro_albfact check (alb_fact in ('S','N')),
constraint fk_pro_iva foreign key(cod_iva)
             references ivas(cod_iva))
;

create table facturas (
num_factura decimal(10),
fecha_fact date,
importe decimal(12,3),
cod_pro varchar(10) not null,
constraint PK_facturas primary Key (num_factura),
constraint fk_facturas_proveedores foreign key(cod_pro)
                                   references proveedores(cod_pro))
;

create table albaranes
(cod_albaran varchar(10),
f_albaran date,
f_entrada date,
cod_pro varchar(10) not null,
num_factura decimal(10),
constraint pk_albaranes primary key(cod_albaran),
constraint fk_alb_pro foreign key(cod_pro)
           references proveedores(cod_pro),
constraint fk_alb_Factura foreign key(num_factura)
           references Facturas (num_factura))
;

create table pedidos
(n_ped decimal(10),
fecha_ped date,
cod_pro varchar(10) not null,
constraint pk_pedidos primary key(n_ped),
constraint fk_ped_pro foreign key(cod_pro)
                 references proveedores(cod_pro))
;

create table articulos
(cod_art varchar(10),
descripcion varchar(50) not null,
precio_mer decimal(10,3),
cod_fam varchar(10) not null,
constraint pk_articulos primary key(cod_art),
constraint fk_art_fam foreign key(cod_fam)
         references familias(cod_fam))
;

create table existencias
(cod_alm varchar(10) ,
cod_art varchar(10) ,
f_caducidad date,
stock_ini decimal(10,3) default 0,
stock_teorico decimal(10,3) default 0,
pcmp decimal(10,3) default 0,
constraint pk_existencias primary key(f_caducidad,cod_alm,cod_art),
constraint ck_stock_ini check(stock_ini>=0),
constraint ck_stock_teorico check(stock_teorico>=0),
constraint ck_pcmp check(pcmp>=0),
constraint fk_exi_alm foreign key(cod_alm)
                  references almacenes(cod_alm),
constraint fk_exi_art foreign key(cod_art)
           references articulos(cod_art))
;

create table ofertas
(f_desde date,
f_hasta date,
cod_art varchar(10) not null,
pvo decimal(10,3) not null,
constraint pk_ofertas primary key(f_desde,cod_art),
constraint fk_ofe_art foreign key(cod_art)
             references articulos(cod_art))
;

create table albaranes_cl
(cod_albaran decimal(10),
f_salida date,
cod_cli varchar(10) not null,
num_factura decimal(10),
constraint pk_albaranes_cl primary key(cod_albaran),
constraint fk_alb_cl_cli foreign key(cod_cli)
           references clientes(cod_cli),
constraint fk_alb_cl_Factura_cL foreign key(num_factura)
           references Facturas_cL(num_factura))
;

create table lin_ped_cl
(n_ped decimal(10),
cod_art varchar(10),
cantidad decimal(10,3) not null,
cantidad_serv decimal(10,3) default 0,
constraint pk_lin_ped_cl primary key(n_ped,cod_art),
constraint fk_lin_ped_cl_pedcl foreign key(n_ped)
             references pedidos_cl(n_ped)
             on delete cascade,
constraint fk_lin_ped_cl_art foreign key(cod_art)
            references articulos(cod_art),
constraint chec_cantidades check(cantidad_serv<=cantidad))
;

create table realiza
(cod_tarifa varchar(10),
cod_art varchar(10) ,
precio_tar decimal(10,3) not null,
f_tarifa date,
precio_ant decimal(10,3),
constraint pk_realiza primary key(cod_tarifa,cod_art),
constraint fk_rea_tar foreign key(cod_tarifa)
         references tarifas(cod_tarifa)
                      on delete cascade,
constraint fk_rea_art foreign key(cod_art)
         references articulos(cod_art))
;

create table lin_alb_cl
(cod_albaran decimal(10) ,
cod_alm varchar(10) ,
cod_art varchar(10) ,
f_caducidad date ,
cant_sal decimal(10,3) not null,
precio_sal decimal(10,3) not null,
dto1  decimal(4,2),
dto2  decimal(4,2),
dto3  decimal(4,2),
constraint pk_lin_alb_cl primary key(f_caducidad,cod_albaran,cod_art, cod_alm),
constraint fk_lin_alb_cl_exi foreign key(f_caducidad,cod_alm,cod_art)
          references existencias(f_caducidad,cod_alm, cod_art),
constraint fk_lin_alb_cl_alb foreign key(cod_albaran)
          references albaranes_cl(cod_albaran) )
;

create table descuentos
(cod_dto varchar(10),
cod_alm varchar(10),
cod_cli varchar(10),
cod_fam varchar(10),
cod_art varchar(10),
f_caducidad date, 
descripcion varchar(50) not null,
d1 decimal(4,2) not null,
d2 decimal(4,2),
d3 decimal(4,2),
constraint pk_descuentos primary key(cod_dto),
constraint uni_dto
unique(cod_cli,cod_fam,cod_alm,cod_art,f_caducidad),
constraint fk_dto_cli foreign key (cod_cli)
           references clientes(cod_cli),
constraint fk_dto_fam foreign key (cod_fam)
           references familias(cod_fam),
constraint fk_dto_exi foreign key(F_caducidad,cod_alm,cod_art)
         references existencias(F_caducidad,cod_alm,cod_art))
;

create table lin_alb
(cod_albaran varchar(10) ,
cod_alm varchar(10) ,
cod_art varchar(10) ,
f_caducidad date ,
cant_ent decimal(10,3) not null,
precio_ent decimal(10,3) not null,
constraint pk_lin_alb primary Key(cod_albaran,f_caducidad,cod_alm,cod_art),
constraint fk_lin_alb_alb foreign key(cod_albaran)
           references albaranes(cod_albaran),
constraint fk_lin_alb_exis foreign key(F_caducidad,cod_alm,cod_art)
          references existencias(F_caducidad,cod_alm,cod_art))
;

create table lin_ped
(n_ped decimal(10) ,
cod_art varchar(10) ,
cantidad decimal(10,3) not null,
cantidad_serv decimal(10,3) ,
constraint pk_lin_ped primary key(cod_art,n_ped),
constraint fk_lin_ped_art foreign key(cod_art)
           references articulos(cod_art),
constraint fk_lin_ped_ped foreign key(n_ped)
          references pedidos(n_ped)
          on delete cascade,
constraint check_cantidades_pro check( cantidad_serv<=cantidad))
;

create table art_pro
(cod_pro varchar(10) ,
cod_art varchar(10) ,
cod_art_pro varchar(10) not null,
descripcion varchar(50) not null,
precio decimal(10,3) not null,
f_tarifa date,
precio_ant decimal(10,3),
constraint pk_art_pro primary key(cod_art,cod_pro),
constraint fk_art_pro_art foreign key(cod_art)
           references articulos(cod_art),
constraint Fk_art_pro_pro foreign key(cod_pro)
           references proveedores(cod_pro))
;

create table recibos (
num_factura decimal(10),
numero decimal(3),
fecha_vto date,
importe decimal(13,3),
constraint PK_recibos primary Key (num_factura,numero),
constraint fk_recibos_facturas foreign key(num_factura)
                                           references facturas (num_factura))
;

create table recibos_cl (
num_factura decimal(10),
numero decimal(3),
fecha_vto date,
importe decimal(12,3),
constraint PK_recibos_cL primary Key (num_factura,numero),
constraint fk_recibos_cL_facturas_cL foreign key(num_factura)
                                    references facturas_CL(num_factura))
;

create table ped_alb (
cod_albaran varchar(10),
N_ped decimal(10),
constraint PK_ped_alb primary key(cod_albaran,n_ped),
constraint fk_ped_alb_albaranes foreign key(cod_albaran)
                                     references albaranes (cod_albaran),
constraint fk_ped_alb_pedidos foreign key(n_ped)
                                     references pedidos (n_ped)ON DELETE CASCADE)
;

create table ped_alb_cl (
cod_albaran decimal(10),
N_ped decimal(10),
constraint PK_ped_alb_cl primary key(cod_albaran,n_ped),
constraint fk_ped_alb_cl_albaranes_cl foreign key(cod_albaran)
                                     references albaranes_cl (cod_albaran),
constraint fk_ped_alb_cl_pedidos_cl foreign key(n_ped)
                                     references pedidos_cl (n_ped)ON DELETE CASCADE)
;

insert into contador_fact values(0);
insert into contador_fact_cl values(0);
INSERT INTO IVAS VALUES (1,16)
;
INSERT INTO IVAS VALUES (2, 7)
;
INSERT INTO IVAS VALUES (3, 33)
;

INSERT INTO ALMACENES VALUES (1,'GENERAL','C/DOCTOR EZQUERDO Nº 22', 916532185)
;
INSERT INTO ALMACENES VALUES (2,'SUR','C/ODONELL Nº 13', 916324589)
;
INSERT INTO ALMACENES VALUES (3,'NORTE','C/MARTIN VALL Nº 7', 915997965)
;
INSERT INTO ALMACENES VALUES (4,'OESTE','C/VILLAVERDE S/N', 917653301)
;
INSERT INTO ALMACENES VALUES (5,'ESTE','C/ALBERTO AGUILERA Nº 8', 916754155)
;

INSERT INTO FAMILIAS VALUES (1 , 'TES')
;
INSERT INTO FAMILIAS VALUES (2 , 'MANZANILLAS')
;
INSERT INTO FAMILIAS VALUES (3 , 'HIERBAS DE SOJA')
;
INSERT INTO FAMILIAS VALUES (4, 'AROMATICAS')
;
INSERT INTO FAMILIAS VALUES (5 , 'HIERBAS SECAS')
;
INSERT INTO FAMILIAS VALUES (6 , 'POLEOS')
;

INSERT INTO  ARTICULOS VALUES(1,'MANZANILLA BOLSA.100G',888,2)
;
INSERT INTO  ARTICULOS VALUES(2,'TE DE PUEBLO BOLSA.100G',125,1)
;
INSERT INTO  ARTICULOS VALUES(3,'MANZANILLA BOLSA.200G',1525.35,2)
;
INSERT INTO  ARTICULOS VALUES(4,'TE DE PUEBLO BOLSA.500G',900,1)
;

insert into tarifas values ('1','General')
;
insert into tarifas values ('2','Clientes_grandes')
;
insert into tarifas values ('3','Clientes_medianos')
;

INSERT INTO REALIZA VALUES(1,1,1000.12,current_date,999)
;
INSERT INTO REALIZA VALUES(2,1,1010.12,'2045-05-17',999)
;
INSERT INTO REALIZA VALUES(3,1,1020.12,CURRENT_DATE,999)
;
INSERT INTO REALIZA VALUES(1,2,100.12,CURRENT_DATE,99)
;
INSERT INTO REALIZA VALUES(2,2,110.12,'2045-05-17',99)
;
INSERT INTO REALIZA VALUES(3,2,135,CURRENT_DATE,125)
;
INSERT INTO REALIZA VALUES(1,3,1525,CURRENT_DATE,1523)
;
INSERT INTO REALIZA VALUES(2,3,1600.12,'2045-05-17',1523)
;
INSERT INTO REALIZA VALUES(3,3,1712.4,CURRENT_DATE,1634.89)
;
INSERT INTO REALIZA VALUES(1,4,884,CURRENT_DATE,881)
;
INSERT INTO REALIZA VALUES(2,4,885.12,'2045-05-17',895.12)
;
INSERT INTO REALIZA VALUES(3,4,1234.62,CURRENT_DATE,1634.89)
;

insert into formas_pago values(1,1,0)
;
insert into formas_pago values(2,1,30)
;
insert into formas_pago values(3,1,60)
;
insert into formas_pago values(4,2,30)
;
insert into formas_pago values(5,2,60)
;
insert into formas_pago values(6,3,30)
;

INSERT INTO CLIENTES VALUES (1, 'JM S.A', 916804476, 'C/ RIO 47', 'S', 'N', 1, 1,1)
;
INSERT INTO CLIENTES VALUES (2, 'CARREFOUR', 916053284, 'C/ ROSA 32', 'N', 'S', 2, 2,2)
;
INSERT INTO CLIENTES VALUES (3, 'EL CORTE INGLES', 938047235, 'C/ MADRID 6', 'S', 'S', 3, 3,2)
;
INSERT INTO CLIENTES VALUES (4, 'HIERBAS LUIS', 94387374, 'C/ LEGANES 80', 'N', 'N', 1, 2,2)
;
INSERT INTO CLIENTES VALUES (5, 'PORREROS', 916548476, 'C/ TOLEDO 3', 'S', 'N', 1, 3,3)
;
INSERT INTO CLIENTES VALUES (6, 'MAR S.L', 916438743, 'C/ RIOJA 54', 'N', 'S', 2, 1,4)
;
INSERT INTO CLIENTES VALUES (7, 'HERBOLARIOS JUAN', 943437832, 'C/ MAR 71', 'N', 'N', 2, 2,3)
;
INSERT INTO CLIENTES VALUES (8, 'ALCOSTO', 914373464,'C/ BARDENAS 48', 'S', 'S', 2, 3,5)
;
INSERT INTO CLIENTES VALUES (9, 'ALCAMPO', 943893467, 'C/ MURILLO 10', 'S', 'N', 3, 2,6)
;
INSERT INTO CLIENTES VALUES (10, 'I.S. LUIS VIVES', 973689326, 'C/ VELAZQUEZ 23', 'N', 'S', 3, 2,5)
;

INSERT INTO PROVEEDORES VALUES (1,'HP HIERBAS S.L',926456231,'C/ PINAR 59','S',28957,1,1)
;
INSERT INTO PROVEEDORES VALUES (2, 'SORIA NATURAL', 914589436, 'C/ PIZARRO 25','N', 28456, 2,2)
;
INSERT INTO PROVEEDORES VALUES (3, 'OLIMPO', 926587725, 'C/ GOYA 59','S', 28759, 3,2)
;
INSERT INTO PROVEEDORES VALUES (4, 'RIOJA S.L', 944576431, 'C/ REY 3','N', 28924, 3,1)
;
INSERT INTO PROVEEDORES VALUES (5, 'HIERBAS MARRUECOS', 954783439, 'C/ JUEGO 93','S', 25547, 2,4)
;
INSERT INTO PROVEEDORES VALUES (6, 'ALUCILANDIA', 942348746, 'C/ AROSA 14','S', 27543, 1,5)
;
INSERT INTO PROVEEDORES VALUES (7, 'FELIPE RUIZ', 922394087, 'C/ ALICANTE','N', 25486, 1,5)
;
INSERT INTO PROVEEDORES VALUES (8, 'MIRAFLORES', 952184983, 'C/ FUENLABRADA 5','S', 29578, 2,3)
;
INSERT INTO PROVEEDORES VALUES (9, 'KIA S.L', 943782768, 'C/ TERUEL 37','N', 29375,3,6)
;
INSERT INTO PROVEEDORES VALUES (10, 'AVENTURAS', 932632579, 'C/ LEGANES 43','S', 24383, 1,4)
;

INSERT INTO ART_PRO VALUES(1,1,'87AE','MANZ 100',614.23,CURRENT_DATE,592.14)
;
INSERT INTO ART_PRO VALUES(2,1,'AE','MANZANILLA',615.23,'2010-2-12',542.14)
;
INSERT INTO ART_PRO VALUES(3,1,'87','MAN 100',619.23,CURRENT_DATE,543.14)
;
INSERT INTO ART_PRO VALUES(4,1,'AS87AE','MANZAN 100 ',619.23,CURRENT_DATE,543.14)
;
INSERT INTO ART_PRO VALUES(1,2,'123E','INFUSION TE',65.23,CURRENT_DATE,61.14)
;
INSERT INTO ART_PRO VALUES(2,2,'EAE','INF TE ',75.23,'2010-2-12',73.14)
;
INSERT INTO ART_PRO VALUES(5,2,'8EE7','INFUSION ',619.23,CURRENT_DATE,75.14)
;
INSERT INTO ART_PRO VALUES(6,2,'ASAE','INF100 TE',49.23,CURRENT_DATE,48.14)
;
INSERT INTO ART_PRO VALUES(1,3,'87AE','MANZ 200',1600.23,CURRENT_DATE,1495.14)
;
INSERT INTO ART_PRO VALUES(2,3,'A44','MAN-200',1601.23,'2010-2-12',1500.14)
;
INSERT INTO ART_PRO VALUES(7,3,'8744','M-200G',1603.23,CURRENT_DATE,1602.14)
;
INSERT INTO ART_PRO VALUES(9,3,'ASE','MANZAN 100 ',1600.23,'2045-12-18',1400.14)
;
INSERT INTO ART_PRO VALUES(9,4,'123E','500G TE',884.23,CURRENT_DATE,883.14)
;
INSERT INTO ART_PRO VALUES(5,4,'EAE','INF TE  500',885.23,'2010-2-12',773.14)
;
INSERT INTO ART_PRO VALUES(7,4,'8EE7','INFUSION500', 892.23,CURRENT_DATE,875.14)
;
INSERT INTO ART_PRO VALUES(6,4,'ASAE','INF500 TE',812.23,CURRENT_DATE,848.14)
;

INSERT INTO OFERTAS VALUES('2020-11-17','2026-01-20','1',20000)
;
INSERT INTO OFERTAS VALUES('2031-01-19','2038-02-20','2',12000)
;

INSERT INTO EXISTENCIAS VALUES(1,1,'2005-3-22',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(1,1,'2005-8-22',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(1,1,'2005-10-7',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(1,1,'2004-12-15',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(2,1,'2005-9-22',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(2,1,'2005-10-10',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(2,1,'2005-7-19',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(2,1,'2005-7-3',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(3,4,'2004-10-31',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(3,4,'2004-11-25',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(3,4,'2004-12-31',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(3,4,'2005-05-01',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(5,4,'2005-12-21',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(5,4,'2005-03-21',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(5,4,'2005-10-01',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(5,4,'2005-11-10',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(1,2,'2004-12-31',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(1,2,'2006-11-02',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(1,2,'2005-02-28',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(1,2,'2007-07-30',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(2,2,'2004-12-31',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(2,2,'2009-01-01',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(2,2,'2014-08-30',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES(2,2,'2126-12-21',0,0,0)
;
insert into existencias values(3,3,'2005-12-11',0,0,0)
;
insert into existencias values(3,3,'2005-12-12',0,0,0)
;
insert into existencias values(3,3,'2005-12-13',0,0,0)
;
insert into existencias values(3,3,'2005-12-14',0,0,0)
;
insert into existencias values(5,3,'2005-12-11',0,0,0)
;
insert into existencias values(5,3,'2005-12-12',0,0,0)
;
insert into existencias values(5,3,'2005-12-13',0,0,0)
;
insert into existencias values(5,3,'2005-12-14',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (3,2,'2005-08-28',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (3,2,'2005-11-11',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (3,2,'2004-12-31',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (3,2,'2004-11-11',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (4,2,'2005-11-28',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (4,2,'2004-12-15',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (4,2,'2005-01-20',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (4,2,'2004-12-28',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (1,4,'2004-12-15',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (1,4,'2005-01-01',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (1,4,'2005-02-05',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (1,4,'2004-11-10',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (2,4,'2004-12-01',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (2,4,'2004-12-16',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (2,4,'2005-05-20',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (2,4,'2005-02-06',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (3,1,'2004-10-25',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (3,1,'2004-12-12',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (3,1,'2005-01-15',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (3,1,'2005-06-13',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (4,1,'2005-07-31',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (4,1,'2004-11-05',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (4,1,'2005-03-08',0,0,0)
;
INSERT INTO EXISTENCIAS VALUES (4,1,'2005-05-17',0,0,0)
;
insert into existencias values (1,3,'2005-11-07',0,0,0)
;
insert into existencias values (1,3,'2004-11-30',0,0,0)
;
insert into existencias values (1,3,'2005-09-01',0,0,0)
;
insert into existencias values (1,3,'2005-05-16',0,0,0)
;
insert into existencias values (2,3,'2006-08-27',0,0,0)
;
insert into existencias values (2,3,'2004-12-12',0,0,0)
;
insert into existencias values (2,3,'2005-01-07',0,0,0)
;
insert into existencias values (2,3,'2005-12-22',0,0,0)
;

update existencias set stock_teorico=100
;

insert into descuentos values ('1','1',null,null,null,null,'Descuento 10%',0.1,null,null)
;
insert into descuentos values ('2','2',null,null,null,null,'Descuento 12%',0.12,null,null)
;
insert into descuentos values ('3','3',null,null,null,null,'Descuento 14%',0.14,null,null)
;
insert into descuentos values ('4','4',null,null,null,null,'Descuento 16%',0.16,null,null)
;
insert into descuentos values ('5','5',null,null,null,null,'Descuento 18%',0.18,null,null)
;

insert into albaranes values(1,'2004-01-10','2004-01-12',1,null);
insert into albaranes values(2,'2004-01-16','2004-01-18',1,null);
insert into albaranes values(3,'2004-01-20','2004-02-20',1,null);
insert into lin_alb values(1,1,1,'2005-03-22',10,895);
insert into lin_alb values(1,1,2,'2004-12-31',25,358);
insert into lin_alb values(2,2,2,'2004-12-31',34,358);
insert into lin_alb values(3,1,1,'2005-03-22',10,895);
insert into lin_alb values(3,1,2,'2006-11-02',25,358);
insert into albaranes values(4,'2004-01-10','2004-01-12',2,null);
insert into albaranes values(5,'2004-01-16','2004-01-19',2,null);
insert into albaranes values(6,'2004-01-20','2004-01-20',2,null);
insert into lin_alb values(4,1,1,'2005-03-22',10,895);
insert into lin_alb values(5,1,2,'2004-12-31',25,358);
insert into lin_alb values(5,2,2,'2004-12-31',34,358);
insert into lin_alb values(6,1,1,'2005-03-22',10,895);
insert into lin_alb values(6,1,2,'2006-11-02',25,358);
insert into albaranes values(7,'2004-01-10','2004-01-12',3,null);
insert into albaranes values(8,'2004-01-16','2004-01-23',3,null);
insert into lin_alb values(7,1,1,'2005-03-22',10,895);
insert into lin_alb values(7,3,1,'2005-06-13',25,358);
insert into lin_alb values(8,2,1,'2005-07-19',34,358);
insert into lin_alb values(8,3,1,'2005-06-13',10,895);
insert into lin_alb values(8,1,1,'2005-03-22',25,358);
insert into albaranes values(9,'2004-01-20','2004-01-26',4,null);
insert into lin_alb values(9,1,1,'2005-03-22',10,895);
insert into lin_alb values(9,3,1,'2005-06-13',25,358);
insert into lin_alb values(9,2,1,'2005-07-19',34,358);
insert into albaranes values(10,'2004-01-10','2004-01-13',5,null);
insert into albaranes values(11,'2004-01-16','2004-02-01',5,null);
insert into lin_alb values(10,1,2,'2006-11-02',10,895);
insert into lin_alb values(10,2,4,'2005-05-20 ',10,895);
insert into lin_alb values(11,1,2,'2006-11-02',25,358);
insert into lin_alb values(11,2,4,'2005-05-20',25,358);
insert into albaranes values(12,'2004-01-20','2004-01-23',6,null);
insert into lin_alb values(12,1,2,'2006-11-02',1,899);
insert into lin_alb values(12,2,4,'2005-05-20 ',85,894);
insert into albaranes_cl values(1,'2004-04-01',1,null);
insert into albaranes_cl values(2,'2004-05-01',1,null);
insert into albaranes_cl values(3,'2004-06-01',1,null);
insert into albaranes_cl values(4,'2004-07-01',1,null);
insert into albaranes_cl values(5,'2004-08-01',1,null);
insert into albaranes_cl values(6,'2004-09-01',1,null);
insert into albaranes_cl values(7,'2004-10-01',1,null);
insert into albaranes_cl values(8,'2004-11-01',1,null);
insert into albaranes_cl values(9,'2004-12-01',1,null);
insert into albaranes_cl values(10,'2005-01-01',1,null);
insert into albaranes_cl values(11,'2005-02-01',1,null);
insert into albaranes_cl values(12,'2005-03-01',1,null);
insert into lin_alb_cl values(1,1,1,'2005-03-22',2,12.5,10,null,null);
insert into lin_alb_cl values(2,1,1,'2005-03-22',2,12.5,10,null,null);
insert into lin_alb_cl values(3,1,1,'2005-03-22',4,12.5,10,null,null);
insert into lin_alb_cl values(4,1,1,'2005-03-22',5,12.5,10,null,null);
insert into lin_alb_cl values(5,1,1,'2005-03-22',2,12.5,10,null,null);
insert into lin_alb_cl values(6,1,1,'2005-03-22',6,12.5,10,null,null);
insert into lin_alb_cl values(7,1,1,'2005-03-22',2,12.5,10,null,null);
insert into lin_alb_cl values(8,1,1,'2005-03-22',2,12.5,10,null,null);
insert into lin_alb_cl values(9,1,1,'2005-03-22',1,12.5,10,null,null);
insert into lin_alb_cl values(10,1,1,'2005-03-22',7,12.5,10,null,null);
insert into lin_alb_cl values(11,1,1,'2005-03-22',2,12.5,10,null,null);
insert into lin_alb_cl values(12,1,1,'2005-03-22',2,12.5,10,null,null);
insert into lin_alb_cl values(1,1,2,'2004-12-31',2,12.5,10,null,null);
insert into lin_alb_cl values(2,1,2,'2004-12-31',2,12.5,10,null,null);
insert into lin_alb_cl values(3,1,2,'2004-12-31',4,12.5,10,null,null);
insert into lin_alb_cl values(4,1,2,'2004-12-31',5,12.5,10,null,null);
insert into lin_alb_cl values(5,1,2,'2004-12-31',2,12.5,10,null,null);
insert into lin_alb_cl values(6,1,2,'2004-12-31',6,12.5,10,null,null);
insert into lin_alb_cl values(7,1,2,'2004-12-31',2,12.5,10,null,null);
insert into lin_alb_cl values(8,1,2,'2004-12-31',2,12.5,10,null,null);
insert into lin_alb_cl values(9,1,2,'2004-12-31',1,12.5,10,null,null);
insert into lin_alb_cl values(10,1,2,'2004-12-31',4,12.5,10,null,null);
insert into lin_alb_cl values(11,1,2,'2004-12-31',2,12.5,10,null,null);
insert into lin_alb_cl values(12,1,2,'2004-12-31',2,12.5,10,null,null);
insert into descuentos values(6,1,1,null,null,null,'10+5+2',0.1,0.05,0.02);
insert into descuentos values(7,1,null,null,2,'2004-12-31','15%',0.15,null,null);
insert into descuentos values(8,1,4,1,null,null,'15+6',0.15,0.06,null);



