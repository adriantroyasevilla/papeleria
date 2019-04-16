--Inicio de las tablas de la BD papeleria

--Creacion tabla cliente.No todos los clientes serán registrados
CREATE TABLE cliente (

    id_cliente INTEGER UNSIGNED AUTO_INCREMENT,
    DNI VARCHAR(9) UNIQUE NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    dirección VARCHAR(50) NOT NULL,
    número INTEGER(2) NOT NULL,
    piso INTEGER(2) NOT NULL,
    puerta VARCHAR(1), 
    población VARCHAR(40) NOT NULL,
    código_postal VARCHAR(5) NOT NULL,
    nacionalidad VARCHAR(30) DEFAULT 'ESPAÑA' NOT NULL,
    email VARCHAR(50) UNIQUE,
    fecha_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    active TINYINT(1) DEFAULT 1,
    PRIMARY KEY (id_cliente)
)

--Creacion tabla de stock. Se relaciona con proveedor MUCHOS a UNO respectivamente
CREATE TABLE stock (

    id_producto INTEGER UNSIGNED AUTO_INCREMENT,
    id_proveedor INTEGER UNSIGNED,
    categoría ENUM ('prensa', 'material escolar', 'alimentación', 'otro') NOT NULL,
    descripción TEXT NOT NULL,
    precio DOUBLE(5,2) NOT NULL,
    cantidad INTEGER(2) NOT NULL,
    PRIMARY KEY(id_producto),
    FOREIGN KEY(id_proveedor) REFERENCES proveedor (id_proveedor)
)

--Creacion tabla proveedor.
CREATE TABLE proveedor (

    id_proveedor INTEGER UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    dirección VARCHAR(40) NOT NULL,
    número INTEGER(2) NOT NULL,
    código_postal VARCHAR(5) NOT NULL,
    población VARCHAR(40) NOT NULL,
    teléfono VARCHAR(12) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    año_fundación DATE NOT NULL,
    PRIMARY KEY(id_proveedor)
)

--Creacion tabla facturacion. Relacion UNO a UNO con cliente. Relacion UNO a VARIOS con stock. 
--El atributo cantidad_producto hace referencia a laa cantidad de un producto y no al número total de productos.
CREATE TABLE facturacion (

    id_factura INTEGER UNSIGNED AUTO_INCREMENT,
    id_cliente INTEGER UNSIGNED,
    id_producto INTEGER UNSIGNED,
    descripción TEXT NOT NULL,
    precio DOUBLE(5,2) NOT NULL,
    cantidad_producto INTEGER(2) NOT NULL,
    fecha_compra TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    PRIMARY KEY(id_factura),
    FOREIGN KEY(id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY(id_producto) REFERENCES stock(id_producto)
)
--Creacion tabla de pedidos. Relacion UNO a UNO con proveedor. Relacion UNO a MUCHOS con stock.
--El atributo cantidad_producto hace referencia a laa cantidad de un producto y no al número total de productos.
CREATE TABLE pedidos (

    id_pedido INTEGER UNSIGNED AUTO_INCREMENT,
    id_proveedor INTEGER UNSIGNED,
    id_producto INTEGER UNSIGNED,
    cantidad_producto INTEGER(2) NOT NULL,
    fecha_solicitud TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    fecha_recibido TIMESTAMP,
    PRIMARY KEY(id_pedido),
    FOREIGN KEY(id_proveedor) REFERENCES proveedor(id_proveedor),
    FOREIGN KEY(id_producto) REFERENCES stock(id_producto)
)