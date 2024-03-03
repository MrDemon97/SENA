/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
/*++-------------------------SCRIPT BASE DE DATOS RELACIONAL mySQL "BANCA SENA"-------------------++*/
/*++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/

/*----------------------------------POR JAIR CORAL Y BRIAN SENA 2024------------------------------------*/

/*--------------------------------------------------------------------------------------------------*/
/*||                           SENTENCIAS DDL DATA DEIFINITION LANGUAJE                           ||*/
/*--------------------------------------------------------------------------------------------------*/
/*--------------------------------INICO INSTRUCCIÓN CREAR BASE DE DATOS-----------------------------*/
CREATE DATABASE banca_sena;
/*----------------------------------FIN INSTRUCCIÓN CREAR BASE DE DATOS-----------------------------*/

/*Se ordena mediante instruccion conectarse a base de datos creaada para poder realizar consultas y
modificaciones*/
USE banca_sena;
/*Un vez conectada, se inica a crear las tablas, para la creación se tendrá en cuenta el 
diagrama entidad-relacion como base para entender y crear las 
talas de esta base de datos.*/
/*---------------------------------------------------------------------------------------------------*/

/*----------------------------------CREACION DE TABLAS PADRE-----------------------------------------*/

/*---------------------------INICIO INSTRUCCION CREAR TABLA CLIENTE----------------------------------*/
CREATE TABLE cliente(
	cliente_id INT(10) NOT NULL,
    nombre_cliente VARCHAR(80) NOT NULL,
    /*Habrá clientes que no tengan correo, pero esto no será impedimento para crear cuenta*/
    correo_cliente VARCHAR(50),
    telefono_cliente VARCHAR(15) NOT NULL,
    clave_cliente VARCHAR(50) NOT NULL,
    /*Se crea una constraint (REQUISITO)llamada pk_cliente que define a cliente id como clave primaria*/ 
    CONSTRAINT pk_cliente PRIMARY KEY(cliente_id),
    /*Se crea una constraint para que el número de teléfono sea unico e irrepetible*/
    CONSTRAINT UNIQUE (telefono_cliente)
);
/*----------------------------FIN INSTRUCCION CREAR TABLA CLIENTE--------------------------------------*/

/*--------------------------------CREACION DE TABLAS HIJAS---------------------------------------------*/

/*---------------------------INICIO INSTRUCCIÓN CREAR TABLA CLIENTE------------------------------------*/
CREATE TABLE cuenta(
	cuenta_id VARCHAR(10) NOT NULL,
    fecha_apertura DATE NOT NULL,
    /*En el tipo de cuenta almacenaremos que tipo de cuenta es siendo 1: AHORROS 2: CORRIENTE*/
    tipo_cuenta VARCHAR(1) NOT NULL,
    saldo_cuenta DOUBLE NOT NULL,
    cliente_id INT NOT NULL, 
    /* Se crea constrait para llamada pk_cuenta que define a cuenta_id como clave primaria*/
    CONSTRAINT pk_cuenta PRIMARY KEY(cuenta_id),
    /* Se crea una una referencia a la columna cliente_id de la tabla cliente llamada cuenta_cliente_id_fk,
    teniendo claro que un cliente puede tener muchas cuentas y una cuenta tiene un solo cliente 1:N*/
    CONSTRAINT cuenta_cliente_id_fk FOREIGN KEY (cliente_id) REFERENCES cliente(cliente_id)
);
/*-------------------------------FIN INSTRUCCIÓN CREAR TABLA CLIENTE----------------------------------*/

/*---------------------------INICIO INSTRUCCIÓN CREAR TABLA TRANSACCIÓN-------------------------------*/
CREATE TABLE transaccion(
	transaccion_id INT NOT NULL,
    /*El tipo de dato admitido por una columna de tipo DATE (FECHA) se debe ingresar asi YYYY-MM-DD dónde
    YYYY: cuatro dígitos del año, MM dos digitos del mes y DD dos digitos del día, cualquier error en el orden
    de ingreso puede llevar a que salte un error*/
    fecha_transaccion DATE NOT NULL,
    valor_transaccion DOUBLE NOT NULL,
    /* C para consignacion D para deposito*/
    tipo_transaccion VARCHAR(1) NOT NULL,
    cuenta_id VARCHAR(10) NOT NULL,
    /*Se crea una constraint (REQUISITO)llamada pk_transaccion que define a transaccion_id como clave primaria*/
    CONSTRAINT pk_transaccion PRIMARY KEY (transaccion_id),
    /* Se crea una una referencia a la columna cuenta_id de la tabla cliente llamada transaccion_cuenta_id_fk,
    teniendo claro que una cuenta  puede tener muchas transacciones y una transacción tiene una sola cuenta 1:N*/
    CONSTRAINT transaccion_cuenta_id_fk FOREIGN KEY (cuenta_id) REFERENCES cuenta(cuenta_id)    	
);
/*--------------------------------FIN INSTRUCCIÓN CREAR TABLA TRANSACCIÓN--------------------------------*/

/*----------------------------INICIO INSTRUCCIÓN CREAR TABLA ADMINISTRADOR-------------------------------*/
CREATE TABLE administrador(
	administrador_id VARCHAR(15) NOT NULL,
    nombre_administrador VARCHAR(80) NOT NULL,
    clave_administrador VARCHAR(50) NOT NULL,
    CONSTRAINT pk_administrador PRIMARY KEY (administrador_id)
);
/*-------------------------------FIN INSTRUCCIÓN CREAR TABLA ADMINISTRADOR--------------------------------*/

    /*--------------------------------------------------------------------------------------------------*/
    /*||                        SENTENCIAS DML MANIPULATION LANGUAJE                                  ||*/
    /*--------------------------------------------------------------------------------------------------*/

/*---------------------------INICO INSTRUCCIÓN INSERTAR DATOS EN TABLA CLIENTES---------------------------*/
/*---Al insertar datos en la tabla clientes se nos solicita que la clave del cliente debe estár cifrada
se usa la función SHA1 (Secure Hash Algorithm 1), un algoritmo de hash criptográfico que toma una entrada
y produce una cadena de salida de 160 bits, generalmente representada como una cadena hexadecimal de 40
 caracteres---*/
INSERT INTO cliente(cliente_id, nombre_cliente, correo_cliente, telefono_cliente, clave_cliente) VALUES
	(1, 'Juan Pérez', 'juan@example.com', '3137278621', SHA1('1234')),
	(2, 'María Rodríguez', 'maria@example.com', '3137278622', SHA1('5678')),
	(3, 'Luis García', NULL, '3137278623', SHA1('9876')),
	(4, 'Ana Martínez', 'ana@example.com', '3137278624', SHA1('5432')),
	(5, 'Pedro Sánchez', NULL, '3137278625', SHA1('7890')),
	(6, 'Laura Hernández', 'laura@example.com', '3137278626', SHA1('4321')),
	(7, 'Carlos López', NULL, '3137278627', SHA1('8765')),
	(8, 'Sofía Díaz', 'sofia@example.com', '3137278628', SHA1('9012')),
	(9, 'Diego Martín', NULL, '3137278629', SHA1('3456')),
	(10, 'Elena Gómez', 'elena@example.com', '3137278630', SHA1('6789')),
	(11, 'Andrés Castro', NULL, '3137278631', SHA1('2345')),
	(12, 'Isabel Ruiz', 'isabel@example.com', '3137278632', SHA1('8901')),
	(13, 'Javier Rojas', NULL, '3137278633', SHA1('4567')),
	(14, 'Patricia Torres', 'patricia@example.com', '3137278634', SHA1('0123')),
	(15, 'Manuel González', NULL, '3137278635', SHA1('7890')),
	(16, 'Marta Navarro', 'marta@example.com', '3137278636', SHA1('3456')),
	(17, 'Roberto Pérez', NULL, '3137278637', SHA1('9012')),
	(18, 'Carmen Ruiz', 'carmen@example.com', '3137278638', SHA1('5678')),
	(19, 'Francisco Sánchez', NULL, '3137278639', SHA1('2345')),
	(20, 'Rosa Martínez', 'rosa@example.com', '3137278640', SHA1('8901'));

/*---------------------------FIN INSTRUCCIÓN INSERTAR DATOS EN TABLA CLIENTES---------------------------*/

/*---------------------------INICO INSTRUCCIÓN INSERTAR DATOS EN TABLA CUENTAS---------------------------*/
INSERT INTO cuenta(cuenta_id, fecha_apertura, tipo_cuenta, saldo_cuenta, cliente_id) VALUES 
(9876543210, '2024-01-01', '1', 5000000.00, 1),
(1234567890, '2024-01-02', '2', 7000000.00, 2),
(2345678901, '2024-01-03', '1', 3500000.00, 3),
(3456789012, '2024-01-04', '2', 9000000.00, 4),
(4567890123, '2024-01-05', '1', 6000000.00, 5),
(5678901234, '2024-01-06', '2', 8000000.00, 6),
(6789012345, '2024-01-07', '1', 4500000.00, 7),
(7890123456, '2024-01-08', '2', 10000000.00, 8),
(8901234567, '2024-01-09', '1', 8500000.00, 9),
(9012345678, '2024-01-10', '2', 9500000.00, 10),
(1123456789, '2024-01-11', '1', 7000000.00, 11),
(2234567890, '2024-01-12', '2', 1000000.00, 12),
(3345678901, '2024-01-13', '1', 2000000.00, 13),
(4456789012, '2024-01-14', '2', 5000000.00, 14),
(5567890123, '2024-01-15', '1', 3000000.00, 15),
(6678901234, '2024-01-16', '2', 4000000.00, 16),
(7789012345, '2024-01-17', '1', 8000000.00, 17),
(8890123456, '2024-01-18', '2', 9500000.00, 18),
(9901234567, '2024-01-19', '1', 6000000.00, 19),
(1122334455, '2024-01-21', '1', 8500000.00, 20),
(2233445566, '2024-01-22', '2', 9500000.00, 4),
(3344556677, '2024-01-23', '1', 7000000.00, 3),
(4455667788, '2024-01-24', '2', 8500000.00, 4),
(5566778899, '2024-01-25', '1', 9000000.00, 6);		
/*---------------------------FIN INSTRUCCIÓN INSERTAR DATOS EN TABLA CUENTA-----------------------------------*/

/*---------------------------INICIO INSTRUCCIÓN INSERTAR DATOS EN TABLA TRANSACCION---------------------------*/
INSERT INTO transaccion (transaccion_id, fecha_transaccion, valor_transaccion, tipo_transaccion, cuenta_id) VALUES
(1, '2024-01-01', 15000.00, 'D', '9876543210'),
(2, '2024-01-02', 20000.00, 'C', '1234567890'),
(3, '2024-01-03', 50000.00, 'D', '2345678901'),
(4, '2024-01-04', 45000.00, 'D', '3456789012'),
(5, '2024-01-05', 25000.00, 'C', '4567890123'),
(6, '2024-01-06', 30000.00, 'D', '5678901234'),
(7, '2024-01-07', 15000.00, 'C', '6789012345'),
(8, '2024-01-08', 50000.00, 'D', '7890123456'),
(9, '2024-01-09', 18000.00, 'C', '8901234567'),
(10, '2024-01-10', 40000.00, 'D', '9012345678'),
(11, '2024-01-11', 22000.00, 'C', '1123456789'),
(12, '2024-01-12', 17000.00, 'D', '2234567890'),
(13, '2024-01-13', 35000.00, 'C', '3345678901'),
(14, '2024-01-14', 50000.00, 'D', '4456789012'),
(15, '2024-01-15', 8000.00, 'C', '5567890123'),
(16, '2024-01-16', 30000.00, 'D', '6678901234'),
(17, '2024-01-17', 15000.00, 'C', '7789012345'),
(18, '2024-01-18', 40000.00, 'D', '8890123456'),
(19, '2024-01-19', 20000.00, 'C', '9901234567'),
(20, '2024-01-20', 17000.00, 'D', '2234567890'),
(21, '2024-01-21', 35000.00, 'C', '1123456789'),
(22, '2024-01-22', 15000.00, 'D', '2234567890'),
(23, '2024-01-23', 45000.00, 'C', '3345678901'),
(24, '2024-01-24', 30000.00, 'D', '4456789012'),
(25, '2024-01-25', 15000.00, 'C', '5567890123'),
(26, '2024-01-26', 40000.00, 'D', '6678901234'),
(27, '2024-01-27', 20000.00, 'C', '7789012345'),
(28, '2024-01-28', 17000.00, 'D', '8890123456'),
(29, '2024-01-29', 35000.00, 'C', '9901234567'),
(30, '2024-01-30', 15000.00, 'D', '2234567890'),
(31, '2024-01-31', 45000.00, 'C', '3345678901'),
(32, '2024-02-01', 30000.00, 'D', '4456789012'),
(33, '2024-02-02', 15000.00, 'C', '5567890123'),
(34, '2024-02-03', 40000.00, 'D', '6678901234'),
(35, '2024-02-04', 20000.00, 'C', '7789012345'),
(36, '2024-02-05', 17000.00, 'D', '8890123456'),
(37, '2024-02-06', 35000.00, 'C', '9901234567'),
(38, '2024-02-07', 15000.00, 'D', '2234567890'),
(39, '2024-02-08', 45000.00, 'C', '3345678901');
/*---------------------------FIN INSTRUCCIÓN INSERTAR DATOS EN TABLA TRANSACCION---------------------------*/

/*---------------------------INICIO INSTRUCCIÓN INSERTAR DATOS EN TABLA ADMINISTADOR---------------------------*/
INSERT INTO administrador(administrador_id, nombre_administrador, clave_administrador) VALUES
('admin01','Pablo Perez', sha1(1568)),
('admin02','Juan Rodriguez', sha1(8745)),
('admin03','Maria Garcia', sha1(3921)),
('admin04','Ana Martinez', sha1(6702)),
('admin05','Luisa Lopez', sha1(5418))
/*---------------------------FIN INSTRUCCIÓN INSERTAR DATOS EN TABLA ADMINISTADOR---------------------------*/


    