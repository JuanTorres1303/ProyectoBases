-- Creaci�n de tablas
-- Tabla Usuarios
CREATE TABLE Usuarios (
    Id VARCHAR(10) NOT NULL,             
    UserName VARCHAR(50) NOT NULL,       
    Email VARCHAR(100) NOT NULL,         
    Contrase�a VARCHAR(50) NOT NULL,                       
    FechaRegistro DATE NOT NULL         
);

-- Tabla de n�meros de contacto
CREATE TABLE numerosContacto(
    Telofono VARCHAR(10) NOT NULL,
    IdUsuario VARCHAR(10) NOT NULL
);

-- Tabla Comprador
CREATE TABLE Comprador (
    IdUsuario VARCHAR(10) NOT NULL,
    Direccion VARCHAR(100) NOT NULL,
    MetodoPago VARCHAR(50) NOT NULL
);

-- Tabla Vendedor
CREATE TABLE Vendedor (
    IdUsuario VARCHAR(10) NOT NULL,
    DescripcionVendedor VARCHAR(200) NOT NULL,
    CalificacionVendedor FLOAT NOT NULL
);

-- Tabla PersonaNatural (Hereda de Vendedor)
CREATE TABLE PersonaNatural (
    IdUsuario VARCHAR(10) NOT NULL,
    Nombre VARCHAR(10) NOT NULL,
    Nidentificacion VARCHAR(20) NOT NULL,
    Direccion VARCHAR(100) NOT NULL,
    TipoDocumento VARCHAR(10) NOT NULL,
    Genero VARCHAR(50)
);

-- Tabla Empresa (Hereda de Vendedor)
CREATE TABLE Empresa (
    IdUsuario VARCHAR(10) NOT NULL,
    NombreEmpresa VARCHAR(20) NOT NULL,
    Nit VARCHAR(15) NOT NULL,
    RepresentanteLegal VARCHAR(100) NOT NULL
);

-- Tabla CarritoCompra
CREATE TABLE CarritoCompra (
    IdCarrito VARCHAR(10) NOT NULL,
    FechaCreacion DATE NOT NULL,
    Estado VARCHAR(20) NOT NULL,
    IdUsuario VARCHAR(10) NOT NULL 
);

-- Tabla LineaProducto
CREATE TABLE LineaProducto (
    IdLinea VARCHAR(10) NOT NULL,
    FechaA�adido DATE NOT NULL,
    CantidadDeseada INT NOT NULL,
    Total FLOAT NOT NULL,
    IdCarrito VARCHAR(10) NOT NULL,
    IdPedido VARCHAR(10) NOT NULL,
    IdProducto VARCHAR(10) NOT NULL
);

-- Tabla Rese�a
CREATE TABLE Resena (
    IdResena VARCHAR(10) NOT NULL,
    Comentario VARCHAR(200),
    FechaResena DATE NOT NULL,
    CalificacionResena FLOAT,
    IdUsuario VARCHAR(10) NOT NULL,
    IdProducto VARCHAR(10) NOT NULL
);

-- Tabla Producto
CREATE TABLE Producto (
    IdProducto VARCHAR(10) NOT NULL,
    FechaIngreso DATE NOT NULL,
    Estado VARCHAR(20) NOT NULL,
    PrecioUnitario DECIMAL(10, 2) NOT NULL,  -- Cambiado de INT a DECIMAL
    Cantidad INT NOT NULL,
    CalificacionProducto FLOAT,
    IdUsuario VARCHAR(10) NOT NULL,
    IdProductoG VARCHAR(10) NOT NULL
);

-- Tabla Cupones
CREATE TABLE Cupones (
    IdCupon VARCHAR(10) NOT NULL,
    CodigoCupon VARCHAR(10) NOT NULL,
    Descuento INT NOT NULL,
    CantidadCupones INT,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    EstadoCupon VARCHAR(20) NOT NULL,
    IdProducto VARCHAR(10) NOT NULL 
);

-- Tabla Garantia
CREATE TABLE Garantia (
    IdGarantia VARCHAR(10) NOT NULL,
    Duracion INT NOT NULL,  -- Cambiado de NUMBER a INT
    Cobertura VARCHAR(200) NOT NULL,
    Proveedor VARCHAR(100) NOT NULL,
    FechaInicio DATE NOT NULL,
    FechaFin DATE NOT NULL,
    IdProducto VARCHAR(10) NOT NULL 
);

-- Tabla ProductoGlobal
CREATE TABLE ProductoGlobal (
    IdProductoG VARCHAR(10) NOT NULL,
    NombreProducto VARCHAR(100) NOT NULL,
    Descripcion VARCHAR(100) NOT NULL,
    Fotografia VARCHAR(255) NOT NULL,
    Tama�o VARCHAR(100) NOT NULL,
    IdCategoria VARCHAR(10) NOT NULL    
);

-- Tabla Categoria
CREATE TABLE Categoria (
    IdCategoria VARCHAR(10) NOT NULL,
    NombreCategoria VARCHAR(100) NOT NULL,
    DescripcionCategoria VARCHAR(100),
    FechaCategoria DATE NOT NULL    
);

-- Tabla Pedido
CREATE TABLE Pedido (
    IdPedido VARCHAR(10) NOT NULL,
    FechaPedido DATE NOT NULL,
    Estado VARCHAR(20) NOT NULL,
    Direccion VARCHAR(255) NOT NULL
);

-- Tabla Pagos
CREATE TABLE Pagos (
    IdPago VARCHAR(10) NOT NULL,
    MontoTotal FLOAT NOT NULL,
    MetodoPago VARCHAR(50) NOT NULL,
    FechaPago DATE NOT NULL,
    EstadoPago VARCHAR(20) NOT NULL,
    IdPedido VARCHAR(10) NOT NULL 
);

-- Tabla Factura
CREATE TABLE Factura (
    IdFactura VARCHAR(10) NOT NULL,
    NumeroFactura VARCHAR(20) NOT NULL,  -- Cambiado de VARCHAR(200) a VARCHAR(20)
    FechaEmision DATE NOT NULL,
    EstadoFactura VARCHAR(20) NOT NULL,
    IdPago VARCHAR(10) NOT NULL
);


-- PRIMARY KEYS
ALTER TABLE Usuarios
ADD CONSTRAINT PK_Usuarios PRIMARY KEY (Id);
ALTER TABLE numerosContacto
ADD CONSTRAINT PK_numerosContacto PRIMARY KEY(Telofono);
ALTER TABLE Comprador
ADD CONSTRAINT PK_Comprador PRIMARY KEY (IdUsuario);
ALTER TABLE Vendedor
ADD CONSTRAINT PK_Vendedor PRIMARY KEY (IdUsuario);
ALTER TABLE PersonaNatural
ADD CONSTRAINT PK_PersonaNatural PRIMARY KEY (IdUsuario);
ALTER TABLE Empresa
ADD CONSTRAINT PK_Empresa PRIMARY KEY (IdUsuario);
ALTER TABLE CarritoCompra
ADD CONSTRAINT PK_CarritoCompra PRIMARY KEY (IdCarrito);
ALTER TABLE LineaProducto
ADD CONSTRAINT PK_LineaProducto PRIMARY KEY (IdLinea);
ALTER TABLE Resena
ADD CONSTRAINT PK_Rese�a PRIMARY KEY (IdResena);
ALTER TABLE Producto
ADD CONSTRAINT PK_Producto PRIMARY KEY (IdProducto);
ALTER TABLE Cupones
ADD CONSTRAINT PK_Cupones PRIMARY KEY (IdCupon);
ALTER TABLE Garantia
ADD CONSTRAINT PK_Garantia PRIMARY KEY (IdGarantia);
ALTER TABLE ProductoGlobal
ADD CONSTRAINT PK_ProductoGlobal PRIMARY KEY (IdProductoG);
ALTER TABLE Categoria
ADD CONSTRAINT PK_Categoria PRIMARY KEY (IdCategoria);
ALTER TABLE Pedido
ADD CONSTRAINT PK_Pedido PRIMARY KEY (IdPedido);
ALTER TABLE Pagos
ADD CONSTRAINT PK_Pagos PRIMARY KEY (IdPago);
ALTER TABLE Factura
ADD CONSTRAINT PK_Factura PRIMARY KEY (IdFactura);


-- UNIQUE KEYS
ALTER TABLE Usuarios
ADD CONSTRAINT UK_Usuarios_UserName UNIQUE (UserName);
ALTER TABLE Usuarios
ADD CONSTRAINT UK_Usuarios_Email UNIQUE (Email);


-- FOREIGN KEYS
-- numerosContacto
ALTER TABLE numerosContacto
ADD CONSTRAINT FK_numerosContacto_Usuario FOREIGN KEY (IdUsuario)
REFERENCES Usuarios(Id)
ON DELETE SET NULL;

-- Comprador
ALTER TABLE Comprador
ADD CONSTRAINT FK_Comprador_Usuario FOREIGN KEY (IdUsuario)
REFERENCES Usuarios(Id)
ON DELETE CASCADE;

-- Vendedor
ALTER TABLE Vendedor
ADD CONSTRAINT FK_Vendedor_Usuario FOREIGN KEY (IdUsuario)
REFERENCES Usuarios(Id)
ON DELETE CASCADE;

-- PersonaNatural
ALTER TABLE PersonaNatural
ADD CONSTRAINT FK_PersonaNatural_Vendedor FOREIGN KEY (IdUsuario)
REFERENCES Vendedor(IdUsuario)
ON DELETE CASCADE;

-- Empresa
ALTER TABLE Empresa
ADD CONSTRAINT FK_Empresa_Vendedor FOREIGN KEY (IdUsuario)
REFERENCES Vendedor(IdUsuario)
ON DELETE CASCADE;

-- CarritoCompra
ALTER TABLE CarritoCompra
ADD CONSTRAINT FK_CarritoCompra_Comprador FOREIGN KEY (IdUsuario)
REFERENCES Comprador(IdUsuario)
ON DELETE CASCADE;

-- LineaProducto
ALTER TABLE LineaProducto
ADD CONSTRAINT FK_LineaProducto_CarritoCompra FOREIGN KEY (IdCarrito)
REFERENCES CarritoCompra(IdCarrito)
ON DELETE CASCADE;

ALTER TABLE LineaProducto
ADD CONSTRAINT FK_LineaProducto_Producto FOREIGN KEY (IdProducto)
REFERENCES Producto(IdProducto)
ON DELETE SET NULL;

ALTER TABLE LineaProducto
ADD CONSTRAINT FK_LineaProducto_Pedido FOREIGN KEY (IdPedido)
REFERENCES Pedido(IdPedido)
ON DELETE SET NULL;

-- Resena
ALTER TABLE Resena
ADD CONSTRAINT FK_Resena_Comprador FOREIGN KEY (IdUsuario)
REFERENCES Comprador(IdUsuario)
ON DELETE CASCADE;

ALTER TABLE Resena
ADD CONSTRAINT FK_Resena_Producto FOREIGN KEY (IdProducto)
REFERENCES Producto(IdProducto)
ON DELETE SET NULL;

-- Producto
ALTER TABLE Producto
ADD CONSTRAINT FK_Producto_Vendedor FOREIGN KEY (IdUsuario)
REFERENCES Vendedor(IdUsuario)
ON DELETE CASCADE;

ALTER TABLE Producto
ADD CONSTRAINT FK_Producto_ProductoGlobal FOREIGN KEY (IdProductoG)
REFERENCES ProductoGlobal(IdProductoG)
ON DELETE SET NULL;

-- Cupones
ALTER TABLE Cupones
ADD CONSTRAINT FK_Cupones_Producto FOREIGN KEY (IdProducto)
REFERENCES Producto(IdProducto)
ON DELETE SET NULL;

-- Garantia
ALTER TABLE Garantia
ADD CONSTRAINT FK_Garantia_Producto FOREIGN KEY (IdProducto)
REFERENCES Producto(IdProducto)
ON DELETE CASCADE;

-- ProductoGlobal
ALTER TABLE ProductoGlobal
ADD CONSTRAINT FK_ProductoGlobal_Categoria FOREIGN KEY (IdCategoria)
REFERENCES Categoria(IdCategoria)
ON DELETE SET NULL;

-- Pagos
ALTER TABLE Pagos
ADD CONSTRAINT FK_Pagos_Pedido FOREIGN KEY (IdPedido)
REFERENCES Pedido(IdPedido)
ON DELETE CASCADE;

-- Factura
ALTER TABLE Factura
ADD CONSTRAINT FK_Factura_Pagos FOREIGN KEY (IdPago)
REFERENCES Pagos(IdPago)
ON DELETE CASCADE;




-- XConstraints
-- Eliminar claves primarias
ALTER TABLE Usuarios DROP CONSTRAINT PK_Usuarios;
ALTER TABLE numerosContacto DROP CONSTRAINT PK_numerosContacto;
ALTER TABLE Comprador DROP CONSTRAINT PK_Comprador;
ALTER TABLE Vendedor DROP CONSTRAINT PK_Vendedor;
ALTER TABLE PersonaNatural DROP CONSTRAINT PK_PersonaNatural;
ALTER TABLE Empresa DROP CONSTRAINT PK_Empresa;
ALTER TABLE CarritoCompra DROP CONSTRAINT PK_CarritoCompra;
ALTER TABLE LineaProducto DROP CONSTRAINT PK_LineaProducto;
ALTER TABLE Resena DROP CONSTRAINT PK_Rese�a;
ALTER TABLE Producto DROP CONSTRAINT PK_Producto;
ALTER TABLE Cupones DROP CONSTRAINT PK_Cupones;
ALTER TABLE Garantia DROP CONSTRAINT PK_Garantia;
ALTER TABLE ProductoGlobal DROP CONSTRAINT PK_ProductoGlobal;
ALTER TABLE Categoria DROP CONSTRAINT PK_Categoria;
ALTER TABLE Pedido DROP CONSTRAINT PK_Pedido;
ALTER TABLE Pagos DROP CONSTRAINT PK_Pagos;
ALTER TABLE Factura DROP CONSTRAINT PK_Factura;

-- Eliminar claves �nicas
ALTER TABLE Usuarios DROP CONSTRAINT UK_Usuarios_UserName;
ALTER TABLE Usuarios DROP CONSTRAINT UK_Usuarios_Email;

-- Eliminar claves for�neas
ALTER TABLE numerosContacto DROP CONSTRAINT FK__numerosContacto_Usuario;
ALTER TABLE Comprador DROP CONSTRAINT FK_Comprador_Usuario;
ALTER TABLE Vendedor DROP CONSTRAINT FK_Vendedor_Usuario;
ALTER TABLE PersonaNatural DROP CONSTRAINT FK_PersonaNatural_Vendedor;
ALTER TABLE Empresa DROP CONSTRAINT FK_Empresa_Vendedor;
ALTER TABLE CarritoCompra DROP CONSTRAINT FK_CarritoCompra_Comprador;
ALTER TABLE LineaProducto DROP CONSTRAINT FK_LineaProducto_CarritoCompra;
ALTER TABLE LineaProducto DROP CONSTRAINT FK_LineaProducto_Producto;
ALTER TABLE Resena DROP CONSTRAINT FK_Resena_Comprador;
ALTER TABLE Resena DROP CONSTRAINT FK_Resena_Producto;
ALTER TABLE Producto DROP CONSTRAINT FK_Producto_Vendedor;
ALTER TABLE Cupones DROP CONSTRAINT FK_Cupones_Producto;
ALTER TABLE Garantia DROP CONSTRAINT FK_Garantia_Producto;
ALTER TABLE Producto DROP CONSTRAINT FK_Producto_ProductoGlobal;
ALTER TABLE ProductoGlobal DROP CONSTRAINT FK_ProductoGlobal_Categoria;
ALTER TABLE Pagos DROP CONSTRAINT FK_Pagos_Pedido;
ALTER TABLE Factura DROP CONSTRAINT FK_Factura_Pagos;
ALTER TABLE LineaProducto DROP CONSTRAINT FK_LineaProducto_Pedido;

-- Xtablas (Eliminacion de tablas)
DROP TABLE Factura;
DROP TABLE Pagos;
DROP TABLE LineaProducto;
DROP TABLE Pedido;
DROP TABLE Cupones;
DROP TABLE Garantia;
DROP TABLE Producto;
DROP TABLE ProductoGlobal;
DROP TABLE Categoria;
DROP TABLE Resena;
DROP TABLE Comprador;
DROP TABLE Vendedor;
DROP TABLE Usuarios;
DROP TABLE personaNatural;
DROP TABLE Empresa;


----- poblar ok 
INSERT INTO Usuarios (Id, UserName, Email, Contrase�a, FechaRegistro)
VALUES ('U001', 'JuanPerez', 'juanp@gmail.com', 'pass123', TO_DATE('2023-01-01', 'YYYY-MM-DD'));
INSERT INTO Usuarios (Id, UserName, Email, Contrase�a, FechaRegistro)
VALUES ('U002', 'MariaLopez', 'marial@gmail.com', 'pass456', TO_DATE('2023-02-15', 'YYYY-MM-DD'));
INSERT INTO Usuarios (Id, UserName, Email, Contrase�a, FechaRegistro)
VALUES ('U003', 'CarlosGarcia', 'carlosg@gmail.com', 'pass789', TO_DATE('2023-03-10', 'YYYY-MM-DD'));
INSERT INTO Usuarios (Id, UserName, Email, Contrase�a, FechaRegistro)
VALUES ('U004', 'AnaMartinez', 'anam@gmail.com', 'pass321', TO_DATE('2023-04-20', 'YYYY-MM-DD'));

INSERT INTO numerosContacto (Telofono, IdUsuario)
VALUES ('3001234567', 'U001');
INSERT INTO numerosContacto (Telofono, IdUsuario)
VALUES ('3107654321', 'U002');
INSERT INTO numerosContacto (Telofono, IdUsuario)
VALUES ('3209876543', 'U003');
INSERT INTO numerosContacto (Telofono, IdUsuario)
VALUES ('3301122334', 'U004');

INSERT INTO Comprador (IdUsuario, Direccion, MetodoPago)
VALUES ('U001', 'Calle 123 #45-67, Ciudad X', 'TC');
INSERT INTO Comprador (IdUsuario, Direccion, MetodoPago)
VALUES ('U002', 'Carrera 54 #78-90, Ciudad Y', 'TD');
INSERT INTO Comprador (IdUsuario, Direccion, MetodoPago)
VALUES ('U003', 'Avenida 12 #34-56, Ciudad Z', 'TC');
INSERT INTO Comprador (IdUsuario, Direccion, MetodoPago)
VALUES ('U004', 'Diagonal 98 #76-54, Ciudad W', 'TD');


INSERT INTO Vendedor (IdUsuario, DescripcionVendedor, CalificacionVendedor)
VALUES ('U001', 'Venta de ropa', 4.5);
INSERT INTO Vendedor (IdUsuario, DescripcionVendedor, CalificacionVendedor)
VALUES ('U002', 'Venta de electr�nicos', 4.8);
INSERT INTO Vendedor (IdUsuario, DescripcionVendedor, CalificacionVendedor)
VALUES ('U003', 'Venta de libros', 4.3);
INSERT INTO Vendedor (IdUsuario, DescripcionVendedor, CalificacionVendedor)
VALUES ('U004', 'Venta de alimentos', 4.7);


INSERT INTO PersonaNatural (IdUsuario, Nombre, Nidentificacion, Direccion, TipoDocumento, Genero)
VALUES ('U001', 'Juan', '123456789', 'Calle 123 #45', 'CC', 'Ma');
INSERT INTO PersonaNatural (IdUsuario, Nombre, Nidentificacion, Direccion, TipoDocumento, Genero)
VALUES ('U002', 'Maria', '987654321', 'Carrera 54 #78', 'CC', 'Fe');
INSERT INTO PersonaNatural (IdUsuario, Nombre, Nidentificacion, Direccion, TipoDocumento, Genero)
VALUES ('U003', 'Carlos', '456789123', 'Avenida 12 #34', 'TI', 'Ma');
INSERT INTO PersonaNatural (IdUsuario, Nombre, Nidentificacion, Direccion, TipoDocumento, Genero)
VALUES ('U004', 'Ana', '789123456', 'Diagonal 98 #76', 'CC', 'Fe');


INSERT INTO Empresa (IdUsuario, NombreEmpresa, Nit, RepresentanteLegal)
VALUES ('U001', 'RopaXpress', '800123456-1', 'Juan Perez');
INSERT INTO Empresa (IdUsuario, NombreEmpresa, Nit, RepresentanteLegal)
VALUES ('U002', 'ElectroMax', '900765432-2', 'Maria Lopez');
INSERT INTO Empresa (IdUsuario, NombreEmpresa, Nit, RepresentanteLegal)
VALUES ('U003', 'BookLand', '700987654-3', 'Carlos Garcia');
INSERT INTO Empresa (IdUsuario, NombreEmpresa, Nit, RepresentanteLegal)
VALUES ('U004', 'FoodMarket', '600123987-4', 'Ana Martinez');


INSERT INTO CarritoCompra (IdCarrito, FechaCreacion, Estado, IdUsuario)
VALUES ('C001', TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'A', 'U001');
INSERT INTO CarritoCompra (IdCarrito, FechaCreacion, Estado, IdUsuario)
VALUES ('C002', TO_DATE('2023-06-05', 'YYYY-MM-DD'), 'V', 'U002');
INSERT INTO CarritoCompra (IdCarrito, FechaCreacion, Estado, IdUsuario)
VALUES ('C003', TO_DATE('2023-06-10', 'YYYY-MM-DD'), 'A', 'U003');
INSERT INTO CarritoCompra (IdCarrito, FechaCreacion, Estado, IdUsuario)
VALUES ('C004', TO_DATE('2023-06-15', 'YYYY-MM-DD'), 'V', 'U004');


INSERT INTO Categoria (IdCategoria, NombreCategoria, DescripcionCategoria, FechaCategoria)
VALUES ('CAT001', 'Electr�nicos', 'Dispositivos electr�nicos y accesorios.', TO_DATE('2023-05-01', 'YYYY-MM-DD'));
INSERT INTO Categoria (IdCategoria, NombreCategoria, DescripcionCategoria, FechaCategoria)
VALUES ('CAT002', 'Muebles', 'Mobiliario para el hogar y oficina.', TO_DATE('2023-05-05', 'YYYY-MM-DD'));
INSERT INTO Categoria (IdCategoria, NombreCategoria, DescripcionCategoria, FechaCategoria)
VALUES ('CAT003', 'Libros', 'Libros de diferentes g�neros.', TO_DATE('2023-05-10', 'YYYY-MM-DD'));
INSERT INTO Categoria (IdCategoria, NombreCategoria, DescripcionCategoria, FechaCategoria)
VALUES ('CAT004', 'Accesorios', 'Accesorios varios.', TO_DATE('2023-05-15', 'YYYY-MM-DD'));


INSERT INTO ProductoGlobal (IdProductoG, NombreProducto, Descripcion, Fotografia, Tama�o, IdCategoria)
VALUES ('PG001', 'Laptop X1', 'Laptop de �ltima generaci�n', 'laptop_x1.jpg', '15 pulgadas', 'CAT001');
INSERT INTO ProductoGlobal (IdProductoG, NombreProducto, Descripcion, Fotografia, Tama�o, IdCategoria)
VALUES ('PG002', 'Televisor 4K', 'Televisor 4K UHD Smart', 'tv_4k.jpg', '55 pulgadas', 'CAT002');
INSERT INTO ProductoGlobal (IdProductoG, NombreProducto, Descripcion, Fotografia, Tama�o, IdCategoria)
VALUES ('PG003', 'Libro Aventura', 'Novela de aventuras', 'libro_aventura.jpg', '300 p�ginas', 'CAT003');
INSERT INTO ProductoGlobal (IdProductoG, NombreProducto, Descripcion, Fotografia, Tama�o, IdCategoria)
VALUES ('PG004', 'Silla Gamer', 'Silla ergon�mica para gaming', 'silla_gamer.jpg', 'Grande', 'CAT004');

INSERT INTO Producto (IdProducto, FechaIngreso, Estado, PrecioUnitario, Cantidad, CalificacionProducto, IdUsuario, IdProductoG)
VALUES ('P001', TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Disponible', 50.00, 100, 4.5, 'U001', 'PG001');
INSERT INTO Producto (IdProducto, FechaIngreso, Estado, PrecioUnitario, Cantidad, CalificacionProducto, IdUsuario, IdProductoG)
VALUES ('P002', TO_DATE('2023-06-05', 'YYYY-MM-DD'), 'Disponible', 150.00, 50, 4.8, 'U002', 'PG002');
INSERT INTO Producto (IdProducto, FechaIngreso, Estado, PrecioUnitario, Cantidad, CalificacionProducto, IdUsuario, IdProductoG)
VALUES ('P003', TO_DATE('2023-06-10', 'YYYY-MM-DD'), 'Agotado', 75.00, 0, 3.7, 'U003', 'PG003');
INSERT INTO Producto (IdProducto, FechaIngreso, Estado, PrecioUnitario, Cantidad, CalificacionProducto, IdUsuario, IdProductoG)
VALUES ('P004', TO_DATE('2023-06-15', 'YYYY-MM-DD'), 'Disponible', 200.00, 30, 4.2, 'U004', 'PG004');


INSERT INTO Cupones (IdCupon, CodigoCupon, Descuento, CantidadCupones, FechaInicio, FechaFin, EstadoCupon, IdProducto)
VALUES ('C001', 'CUPON10', 10, 50, TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-07-01', 'YYYY-MM-DD'), 'Activo', 'P001');
INSERT INTO Cupones (IdCupon, CodigoCupon, Descuento, CantidadCupones, FechaInicio, FechaFin, EstadoCupon, IdProducto)
VALUES ('C002', 'CUPON20', 20, 30, TO_DATE('2023-06-05', 'YYYY-MM-DD'), TO_DATE('2023-07-10', 'YYYY-MM-DD'), 'Activo', 'P002');
INSERT INTO Cupones (IdCupon, CodigoCupon, Descuento, CantidadCupones, FechaInicio, FechaFin, EstadoCupon, IdProducto)
VALUES ('C003', 'CUPON15', 15, 20, TO_DATE('2023-06-10', 'YYYY-MM-DD'), TO_DATE('2023-07-15', 'YYYY-MM-DD'), 'Inactivo', 'P003');
INSERT INTO Cupones (IdCupon, CodigoCupon, Descuento, CantidadCupones, FechaInicio, FechaFin, EstadoCupon, IdProducto)
VALUES ('C004', 'CUPON30', 30, 10, TO_DATE('2023-06-15', 'YYYY-MM-DD'), TO_DATE('2023-07-20', 'YYYY-MM-DD'), 'Activo', 'P004');


INSERT INTO Garantia (IdGarantia, Duracion, Cobertura, Proveedor, FechaInicio, FechaFin, IdProducto)
VALUES ('G001', 12, 'Cobertura total por fallas de f�brica.', 'ProveedorX', TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2024-06-01', 'YYYY-MM-DD'), 'P001');
INSERT INTO Garantia (IdGarantia, Duracion, Cobertura, Proveedor, FechaInicio, FechaFin, IdProducto)
VALUES ('G002', 24, 'Cobertura parcial para repuestos.', 'ProveedorY', TO_DATE('2023-06-05', 'YYYY-MM-DD'), TO_DATE('2025-06-05', 'YYYY-MM-DD'), 'P002');
INSERT INTO Garantia (IdGarantia, Duracion, Cobertura, Proveedor, FechaInicio, FechaFin, IdProducto)
VALUES ('G003', 6, 'Cobertura limitada.', 'ProveedorZ', TO_DATE('2023-06-10', 'YYYY-MM-DD'), TO_DATE('2023-12-10', 'YYYY-MM-DD'), 'P003');
INSERT INTO Garantia (IdGarantia, Duracion, Cobertura, Proveedor, FechaInicio, FechaFin, IdProducto)
VALUES ('G004', 18, 'Cobertura completa.', 'ProveedorA', TO_DATE('2023-06-15', 'YYYY-MM-DD'), TO_DATE('2024-12-15', 'YYYY-MM-DD'), 'P004');


INSERT INTO Resena (IdResena, Comentario, FechaResena, CalificacionResena, IdUsuario, IdProducto)
VALUES ('R001', 'Excelente calidad, muy satisfecho.', TO_DATE('2023-07-01', 'YYYY-MM-DD'), 5, 'U001', 'P001');
INSERT INTO Resena (IdResena, Comentario, FechaResena, CalificacionResena, IdUsuario, IdProducto)
VALUES ('R002', 'Lleg� tarde, pero en buen estado.', TO_DATE('2023-07-05', 'YYYY-MM-DD'), 4, 'U002', 'P002');
INSERT INTO Resena (IdResena, Comentario, FechaResena, CalificacionResena, IdUsuario, IdProducto)
VALUES ('R003', 'Regular calidad, esperaba m�s.', TO_DATE('2023-07-10', 'YYYY-MM-DD'), 3, 'U003', 'P003');
INSERT INTO Resena (IdResena, Comentario, FechaResena, CalificacionResena, IdUsuario, IdProducto)
VALUES ('R004', 'No lo recomiendo.', TO_DATE('2023-07-15', 'YYYY-MM-DD'), 2, 'U004', 'P004');


INSERT INTO Pedido (IdPedido, FechaPedido, Estado, Direccion)
VALUES ('PD1001', TO_DATE('2023-06-01', 'YYYY-MM-DD'), 'Pa', 'Calle 123 #45-67, Ciudad X');
INSERT INTO Pedido (IdPedido, FechaPedido, Estado, Direccion)
VALUES ('PD1002', TO_DATE('2023-06-05', 'YYYY-MM-DD'), 'Pe', 'Carrera 54 #78-90, Ciudad Y');
INSERT INTO Pedido (IdPedido, FechaPedido, Estado, Direccion)
VALUES ('PD1003', TO_DATE('2023-06-10', 'YYYY-MM-DD'), 'Ca', 'Avenida 12 #34-56, Ciudad Z');
INSERT INTO Pedido (IdPedido, FechaPedido, Estado, Direccion)
VALUES ('PD1004', TO_DATE('2023-06-15', 'YYYY-MM-DD'), 'Pa', 'Diagonal 98 #76-54, Ciudad W');



INSERT INTO LineaProducto (IdLinea, FechaA�adido, CantidadDeseada, Total, IdCarrito, IdPedido, IdProducto)
VALUES ('LP001', TO_DATE('2023-06-02', 'YYYY-MM-DD'), 2, 100.00, 'C001', 'PD1001', 'P001');
INSERT INTO LineaProducto (IdLinea, FechaA�adido, CantidadDeseada, Total, IdCarrito, IdPedido, IdProducto)
VALUES ('LP002', TO_DATE('2023-06-06', 'YYYY-MM-DD'), 1, 50.00, 'C002', 'PD1002', 'P002');
INSERT INTO LineaProducto (IdLinea, FechaA�adido, CantidadDeseada, Total, IdCarrito, IdPedido, IdProducto)
VALUES ('LP003', TO_DATE('2023-06-11', 'YYYY-MM-DD'), 3, 150.00, 'C003', 'PD1003', 'P003');
INSERT INTO LineaProducto (IdLinea, FechaA�adido, CantidadDeseada, Total, IdCarrito, IdPedido, IdProducto)
VALUES ('LP004', TO_DATE('2023-06-16', 'YYYY-MM-DD'), 5, 250.00, 'C004', 'PD1004', 'P004');


INSERT INTO Pagos (IdPago, MontoTotal, MetodoPago, FechaPago, EstadoPago, IdPedido)
VALUES ('PAY001', 100.00, 'TC', TO_DATE('2023-06-02', 'YYYY-MM-DD'), 'Confirmado', 'PD1001');
INSERT INTO Pagos (IdPago, MontoTotal, MetodoPago, FechaPago, EstadoPago, IdPedido)
VALUES ('PAY002', 150.00, 'TD', TO_DATE('2023-06-06', 'YYYY-MM-DD'), 'Pendiente', 'PD1002');
INSERT INTO Pagos (IdPago, MontoTotal, MetodoPago, FechaPago, EstadoPago, IdPedido)
VALUES ('PAY003', 200.00, 'TC', TO_DATE('2023-06-11', 'YYYY-MM-DD'), 'Confirmado', 'PD1003');
INSERT INTO Pagos (IdPago, MontoTotal, MetodoPago, FechaPago, EstadoPago, IdPedido)
VALUES ('PAY004', 250.00, 'TD', TO_DATE('2023-06-16', 'YYYY-MM-DD'), 'Pendiente', 'PD1004');


INSERT INTO Factura (IdFactura, NumeroFactura, FechaEmision, EstadoFactura, IdPago)
VALUES ('F001', 'FAC001', TO_DATE('2023-06-02', 'YYYY-MM-DD'), 'E', 'PAY001');
INSERT INTO Factura (IdFactura, NumeroFactura, FechaEmision, EstadoFactura, IdPago)
VALUES ('F002', 'FAC002', TO_DATE('2023-06-06', 'YYYY-MM-DD'), 'C', 'PAY002');
INSERT INTO Factura (IdFactura, NumeroFactura, FechaEmision, EstadoFactura, IdPago)
VALUES ('F003', 'FAC003', TO_DATE('2023-06-11', 'YYYY-MM-DD'), 'E', 'PAY003');
INSERT INTO Factura (IdFactura, NumeroFactura, FechaEmision, EstadoFactura, IdPago)
VALUES ('F004', 'FAC004', TO_DATE('2023-06-16', 'YYYY-MM-DD'), 'C', 'PAY004');

---- Poblarnook 
INSERT INTO Usuarios (Id, UserName, Email, Contrase�a, FechaRegistro)
VALUES ('U007', 'JuanPerez', 'juanperez@gmail', '12345', TO_DATE('2023-01-01', 'YYYY-MM-DD'));
INSERT INTO numerosContacto (Telofono, IdUsuario)
VALUES ('3501234567', 'U999');
INSERT INTO Comprador (IdUsuario, Direccion, MetodoPago)
VALUES ('U001', 'DireccionSinFormatoValido', 'TC');
INSERT INTO Vendedor (IdUsuario, DescripcionVendedor, CalificacionVendedor)
VALUES ('U001', 'Venta de ropa', 6.0);
INSERT INTO PersonaNatural (IdUsuario, Nombre, Nidentificacion, Direccion, TipoDocumento, Genero)
VALUES ('U001', 'Pedro', '123456789', 'Calle 10 #20', 'PP', 'Ma');
INSERT INTO Empresa (IdUsuario, NombreEmpresa, Nit, RepresentanteLegal)
VALUES ('U002', 'TechCorp', '123456', 'Maria Lopez');
INSERT INTO CarritoCompra (IdCarrito, FechaCreacion, Estado, IdUsuario)
VALUES ('C008', '2023-13-01', 'A', 'U001');
INSERT INTO Resena (IdResena, Comentario, FechaResena, CalificacionResena, IdUsuario, IdProducto)
VALUES ('R008', 'Muy bueno', TO_DATE('2023-07-01', 'YYYY-MM-DD'), 3, NULL, 'P001');
INSERT INTO Producto (IdProducto, FechaIngreso, Estado, PrecioUnitario, Cantidad, CalificacionProducto, IdUsuario, IdProductoG)
VALUES ('P005', TO_DATE('2023-07-01', 'YYYY-MM-DD'), 'Descontinuado', 50.00, 100, 4.5, 'U001', 'PG001');
INSERT INTO ProductoGlobal (IdProductoG, NombreProducto, Descripcion, Fotografia, Tama�o, IdCategoria)
VALUES ('PG005', 'Tablet Z1', 'Tablet de �ltima generaci�n', 'tablet_z1.jpg', '10 pulgadas', 'CAT999');
INSERT INTO Categoria (IdCategoria, NombreCategoria, DescripcionCategoria, FechaCategoria)
VALUES ('CAT999', 'Electrodom�sticos', 'Dispositivos para el hogar.', TO_DATE('2023-02-30', 'YYYY-MM-DD'));
INSERT INTO Cupones (IdCupon, CodigoCupon, Descuento, CantidadCupones, FechaInicio, FechaFin, EstadoCupon, IdProducto)
VALUES ('C011', 'CUPONX', 20, 5, TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-07-01', 'YYYY-MM-DD'), 'Activo', 'P999');
INSERT INTO Garantia (IdGarantia, Duracion, Cobertura, Proveedor, FechaInicio, FechaFin, IdProducto)
VALUES ('G010', 12, 'Cobertura completa', 'ProveedorX', TO_DATE('2023-06-01', 'YYYY-MM-DD'), TO_DATE('2023-07-01', 'YYYY-MM-DD'), 'P999');
INSERT INTO Pedido (IdPedido, FechaPedido, Estado, Direccion)
VALUES ('PD011', '2023-15-12', 'Pe', 'Calle 123 #45-67, Ciudad X');
INSERT INTO LineaProducto (IdLinea, FechaA�adido, CantidadDeseada, Total, IdCarrito, IdPedido, IdProducto)
VALUES ('LP010', TO_DATE('2023-07-01', 'YYYY-MM-DD'), 2, 100.00, 'C999', 'PD001', 'P001');
INSERT INTO Pagos (IdPago, MontoTotal, MetodoPago, FechaPago, EstadoPago, IdPedido)
VALUES ('PAY005', 200.00, 'TC', TO_DATE('2023-07-01', 'YYYY-MM-DD'), 'Confirmado', 'PD999');
INSERT INTO Factura (IdFactura, NumeroFactura, FechaEmision, EstadoFactura, IdPago)
VALUES ('F005', 'FAC005', TO_DATE('2023-07-01', 'YYYY-MM-DD'), 'C', 'PAY999');


----- XPOBLAR 
DELETE FROM Factura;
DELETE FROM Pagos;
DELETE FROM LineaProducto;
DELETE FROM Resena;
DELETE FROM Cupones;
DELETE FROM Garantia;
DELETE FROM Producto;
DELETE FROM ProductoGlobal;
DELETE FROM CarritoCompra;
DELETE FROM Categoria;
DELETE FROM PersonaNatural;
DELETE FROM Empresa;
DELETE FROM Vendedor;
DELETE FROM Comprador;
DELETE FROM numerosContacto;
DELETE FROM Usuarios;
DELETE FROM Pedido;

-- CONSULTAS
-- CONSULTAS GERENCIALES
-- Consultar en que mes se realizaron la mayor cantidad de registro

SELECT 
    TO_CHAR(FechaRegistro, 'MM') AS Mes,
    COUNT(*) AS CantidadRegistros
FROM 
    Usuarios
GROUP BY 
    TO_CHAR(FechaRegistro, 'MM')
HAVING 
    COUNT(*) = (
        SELECT 
            MAX(CantidadRegistros)
        FROM (
            SELECT 
                TO_CHAR(FechaRegistro, 'MM') AS Mes,
                COUNT(*) AS CantidadRegistros
            FROM 
                Usuarios
            GROUP BY 
                TO_CHAR(FechaRegistro, 'MM')
        )
    );
    
    
--Consulltar el producto que mas se vendio en el a�o
SELECT 
    P.IdProducto,
        SUM(LP.CantidadDeseada) AS CantidadTotalVendida
FROM 
    Producto P
JOIN 
    LineaProducto LP ON P.IdProducto = LP.IdCarrito
JOIN 
    Pedido PD ON LP.IdPedido = PD.IdPedido
WHERE 
    EXTRACT(YEAR FROM PD.FechaPedido) = 2023
GROUP BY 
    P.IdProducto
HAVING 
    SUM(LP.CantidadDeseada) = (
        SELECT 
            MAX(SumaCantidad)
        FROM (
            SELECT 
                SUM(LP.CantidadDeseada) AS SumaCantidad
            FROM 
                Producto P
            JOIN 
                LineaProducto LP ON P.IdProducto = LP.IdCarrito
            JOIN 
                Pedido PD ON LP.IdPedido = PD.IdPedido
            WHERE 
                EXTRACT(YEAR FROM PD.FechaPedido) =  2023 --A�o seleccionado como ejemplo  este se puede cambiar a su preferencia   
            GROUP BY 
                P.IdProducto
        )
    );
-- Consultar los vendedores que venden menos productos en el a�o
SELECT 
    V.IdUsuario AS Vendedor,
    COUNT(LP.IdLinea) AS ProductosVendidos
FROM 
    Vendedor V
JOIN 
    Producto P ON V.IdUsuario = P.IdUsuario
JOIN 
    LineaProducto LP ON P.IdProducto = LP.IdProducto
JOIN 
    Pedido PD ON LP.IdPedido = PD.IdPedido
WHERE 
    EXTRACT(YEAR FROM PD.FechaPedido) = 2023
GROUP BY 
    V.IdUsuario
HAVING 
    COUNT(LP.IdLinea) = (
        SELECT 
            MIN(ConteoProductos)
        FROM (
            SELECT 
                V.IdUsuario,
                COUNT(LP.IdLinea) AS ConteoProductos
            FROM 
                Vendedor V
            JOIN 
                Producto P ON V.IdUsuario = P.IdUsuario
            JOIN 
                LineaProducto LP ON P.IdProducto = LP.IdProducto
            JOIN 
                Pedido PD ON LP.IdPedido = PD.IdPedido
            WHERE 
                EXTRACT(YEAR FROM PD.FechaPedido) = 2023
            GROUP BY 
                V.IdUsuario
        )
    );

------- CONSULTAS OPERATIVAS 
---consultar los cupoones 
SELECT 
    CodigoCupon, 
    Descuento, 
    CantidadCupones, 
    FechaInicio, 
    FechaFin, 
    EstadoCupon
FROM 
    Cupones;
---consultar las rese�as
SELECT 
    Comentario, 
    FechaResena, 
    CalificacionResena
FROM 
    Resena;
-------consultar el carrito de compras
SELECT 
    FechaCreacion, 
    Estado
FROM 
    CarritoCompra;
------- consultar producto global
SELECT 
    NombreProducto, 
    Descripcion, 
    Fotografia, 
    Tama�o
FROM 
    ProductoGlobal;
----consultar la linea de producto
SELECT 
    FechaA�adido, 
    CantidadDeseada, 
    Total
FROM 
    LineaProducto;
----- consultar la factura
SELECT 
    NumeroFactura, 
    FechaEmision, 
    EstadoFactura
FROM 
    Factura;
-----consultar los pagos
SELECT 
    MontoTotal, 
    MetodoPago, 
    FechaPago, 
    EstadoPago
FROM 
    Pagos;
----consultar la garantia
SELECT 
    Duracion, 
    Cobertura, 
    Proveedor, 
    FechaInicio, 
    FechaFin
FROM 
    Garantia;
--consultar las categorias
SELECT 
    NombreCategoria, 
    DescripcionCategoria, 
    FechaCategoria
FROM 
    Categoria;
------ consultar los productos 
SELECT 
    FechaIngreso, 
    Estado, 
    PrecioUnitario, 
    Cantidad, 
    CalificacionProducto
FROM 
    Producto;
---consultar los pedidos
SELECT 
    FechaPedido, 
    Estado, 
    Direccion
FROM 
    Pedido;










