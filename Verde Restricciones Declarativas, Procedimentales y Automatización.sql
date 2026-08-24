--Automatizacion
--Secuencias
CREATE SEQUENCE SEQ_Usuarios
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE SEQ_numerosContacto
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE SEQ_Comprador
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE SEQ_Vendedor
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE SEQ_PersonaNatural
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE SEQ_Empresa
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE SEQ_CarritoCompra
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE SEQ_LineaProducto
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE SEQ_Resena
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE SEQ_Producto
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE SEQ_Cupones
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE SEQ_Garantia
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE SEQ_ProductoGlobal
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE SEQ_Categoria
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE SEQ_Pedido
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE SEQ_Pagos
START WITH 1
INCREMENT BY 1
NOCACHE;

CREATE SEQUENCE SEQ_Factura
START WITH 1
INCREMENT BY 1
NOCACHE;

--Triggers de implementacion

CREATE OR REPLACE TRIGGER TRG_Usuarios_PK
BEFORE INSERT ON Usuarios
FOR EACH ROW
BEGIN
    IF :NEW.Id IS NULL THEN
        :NEW.Id := LPAD(SEQ_Usuarios.NEXTVAL, 10, '0'); -- Rellenar con ceros para 10 caracteres
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TRG_numerosContacto_PK
BEFORE INSERT ON numerosContacto
FOR EACH ROW
BEGIN
    IF :NEW.Telofono IS NULL THEN
        :NEW.Telofono := LPAD(SEQ_numerosContacto.NEXTVAL, 10, '0');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TRG_Comprador_PK
BEFORE INSERT ON Comprador
FOR EACH ROW
BEGIN
    IF :NEW.IdUsuario IS NULL THEN
        :NEW.IdUsuario := LPAD(SEQ_Comprador.NEXTVAL, 10, '0');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TRG_Vendedor_PK
BEFORE INSERT ON Vendedor
FOR EACH ROW
BEGIN
    IF :NEW.IdUsuario IS NULL THEN
        :NEW.IdUsuario := LPAD(SEQ_Vendedor.NEXTVAL, 10, '0');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TRG_PersonaNatural_PK
BEFORE INSERT ON PersonaNatural
FOR EACH ROW
BEGIN
    IF :NEW.IdUsuario IS NULL THEN
        :NEW.IdUsuario := LPAD(SEQ_PersonaNatural.NEXTVAL, 10, '0');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TRG_Empresa_PK
BEFORE INSERT ON Empresa
FOR EACH ROW
BEGIN
    IF :NEW.IdUsuario IS NULL THEN
        :NEW.IdUsuario := LPAD(SEQ_Empresa.NEXTVAL, 10, '0');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TRG_CarritoCompra_PK
BEFORE INSERT ON CarritoCompra
FOR EACH ROW
BEGIN
    IF :NEW.IdCarrito IS NULL THEN
        :NEW.IdCarrito := LPAD(SEQ_CarritoCompra.NEXTVAL, 10, '0');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TRG_LineaProducto_PK
BEFORE INSERT ON LineaProducto
FOR EACH ROW
BEGIN
    IF :NEW.IdLinea IS NULL THEN
        :NEW.IdLinea := LPAD(SEQ_LineaProducto.NEXTVAL, 10, '0');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TRG_Resena_PK
BEFORE INSERT ON Resena
FOR EACH ROW
BEGIN
    IF :NEW.IdResena IS NULL THEN
        :NEW.IdResena := LPAD(SEQ_Resena.NEXTVAL, 10, '0');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TRG_Producto_PK
BEFORE INSERT ON Producto
FOR EACH ROW
BEGIN
    IF :NEW.IdProducto IS NULL THEN
        :NEW.IdProducto := LPAD(SEQ_Producto.NEXTVAL, 10, '0');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TRG_Cupones_PK
BEFORE INSERT ON Cupones
FOR EACH ROW
BEGIN
    IF :NEW.IdCupon IS NULL THEN
        :NEW.IdCupon := LPAD(SEQ_Cupones.NEXTVAL, 10, '0');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TRG_Garantia_PK
BEFORE INSERT ON Garantia
FOR EACH ROW
BEGIN
    IF :NEW.IdGarantia IS NULL THEN
        :NEW.IdGarantia := LPAD(SEQ_Garantia.NEXTVAL, 10, '0');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TRG_ProductoGlobal_PK
BEFORE INSERT ON ProductoGlobal
FOR EACH ROW
BEGIN
    IF :NEW.IdProductoG IS NULL THEN
        :NEW.IdProductoG := LPAD(SEQ_ProductoGlobal.NEXTVAL, 10, '0');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TRG_Categoria_PK
BEFORE INSERT ON Categoria
FOR EACH ROW
BEGIN
    IF :NEW.IdCategoria IS NULL THEN
        :NEW.IdCategoria := LPAD(SEQ_Categoria.NEXTVAL, 10, '0');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TRG_Pedido_PK
BEFORE INSERT ON Pedido
FOR EACH ROW
BEGIN
    IF :NEW.IdPedido IS NULL THEN
        :NEW.IdPedido := LPAD(SEQ_Pedido.NEXTVAL, 10, '0');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TRG_Pagos_PK
BEFORE INSERT ON Pagos
FOR EACH ROW
BEGIN
    IF :NEW.IdPago IS NULL THEN
        :NEW.IdPago := LPAD(SEQ_Pagos.NEXTVAL, 10, '0');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TRG_Factura_PK
BEFORE INSERT ON Factura
FOR EACH ROW
BEGIN
    IF :NEW.IdFactura IS NULL THEN
        :NEW.IdFactura := LPAD(SEQ_Factura.NEXTVAL, 10, '0');
    END IF;
END;
/

--Integridad delcarativa

ALTER TABLE Usuarios
ADD CONSTRAINT CK_Email_Valid CHECK (REGEXP_LIKE(Email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'));

ALTER TABLE Resena
ADD CONSTRAINT CK_Resena_Calificacion CHECK (CalificacionResena BETWEEN 0 AND 5);

ALTER TABLE Producto
ADD CONSTRAINT CK_Producto_Calificacion CHECK (CalificacionProducto BETWEEN 0 AND 5);

ALTER TABLE Vendedor
ADD CONSTRAINT CK_Vendedor_Calificacion CHECK (CalificacionVendedor BETWEEN 0 AND 5);

ALTER TABLE Cupones
ADD CONSTRAINT CK_Cupones_Descuento CHECK (Descuento BETWEEN 0 AND 100);

ALTER TABLE Garantia
ADD CONSTRAINT CK_Garantia_Fechas CHECK (FechaFin > FechaInicio);

ALTER TABLE Pedido
ADD CONSTRAINT chk_Ttipo CHECK (Estado IN ('Pa', 'Ca', 'Pe'));

ALTER TABLE CarritoCompra
ADD CONSTRAINT chk_CCtipo CHECK (Estado IN ('A', 'V'));

ALTER TABLE Comprador
ADD CONSTRAINT chk_Tdireccion
CHECK (
    REGEXP_LIKE(    
        Direccion,
        '^(Calle|Carrera|Transversal|Diagonal) \d+( [A-Za-z]+)? #\d+-\d+, [A-Za-z\s]+$'
    )
);

ALTER TABLE Pedido
ADD CONSTRAINT chk_PedidosDireccion
CHECK (
    REGEXP_LIKE(    
        Direccion,
        '^(Calle|Carrera|Transversal|Diagonal) \d+( [A-Za-z]+)? #\d+-\d+, [A-Za-z\s]+$'
    )
);


ALTER TABLE Factura
ADD CONSTRAINT chk_Factipo CHECK (EstadoFactura IN ('E', 'C'));

ALTER TABLE PersonaNatural
ADD CONSTRAINT chk_TDocumento CHECK (TipoDocumento IN ('TI', 'CC'));

ALTER TABLE PersonaNatural
ADD CONSTRAINT chk_Genero CHECK (genero IN ('Ma', 'Fe', 'NB'));

ALTER TABLE Comprador
ADD CONSTRAINT chk_TPago CHECK (MetodoPago IN ('TC', 'TD'));

ALTER TABLE Pagos
ADD CONSTRAINT chk_TPagoPagos CHECK (MetodoPago IN ('TC', 'TD'));


--integridad Operativa
CREATE OR REPLACE TRIGGER TRG_UpdateCalificacionProducto
AFTER INSERT OR UPDATE ON Resena
FOR EACH ROW
BEGIN
    UPDATE Producto
    SET CalificacionProducto = (
        SELECT AVG(CalificacionResena)
        FROM Resena
        WHERE IdProducto = :NEW.IdProducto
    )
    WHERE IdProducto = :NEW.IdProducto;
END;
/

CREATE OR REPLACE TRIGGER TRG_CheckCuponesStock
BEFORE UPDATE ON Cupones
FOR EACH ROW
BEGIN
    IF :NEW.CantidadCupones < 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'La cantidad de cupones no puede ser negativa.');
    END IF;
END;
/

CREATE OR REPLACE TRIGGER TRG_UpdateStockProducto
AFTER INSERT OR UPDATE ON LineaProducto
FOR EACH ROW
DECLARE
    v_Cantidad NUMBER;
BEGIN
    UPDATE Producto
    SET Cantidad = Cantidad - :NEW.CantidadDeseada
    WHERE IdProducto = :NEW.IdProducto;
    SELECT Cantidad 
    INTO v_Cantidad
    FROM Producto
    WHERE IdProducto = :NEW.IdProducto;
    IF v_Cantidad < 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'El stock del producto no puede ser negativo.');
    END IF;
END;
/


CREATE OR REPLACE TRIGGER TRG_ValidatePedidoBeforePagos
BEFORE INSERT ON Pagos
FOR EACH ROW
DECLARE
    v_Estado VARCHAR2(20);
BEGIN
    SELECT Estado 
    INTO v_Estado
    FROM Pedido
    WHERE IdPedido = :NEW.IdPedido;
    IF v_Estado NOT IN ('Confirmado', 'En Proceso') THEN
        RAISE_APPLICATION_ERROR(-20003, 'El pedido debe estar "Confirmado" o "En Proceso" para realizar el pago.');
    END IF;
END;
/


--On update


-- Trigger para numerosContacto actualizando IdUsuario
CREATE OR REPLACE TRIGGER TRG_UpdateNumerosContacto
AFTER UPDATE OF Id ON Usuarios
FOR EACH ROW
BEGIN
    UPDATE numerosContacto
    SET IdUsuario = :NEW.Id
    WHERE IdUsuario = :OLD.Id;
END;
/

-- Trigger para Comprador actualizando IdUsuario
CREATE OR REPLACE TRIGGER TRG_UpdateComprador
AFTER UPDATE OF Id ON Usuarios
FOR EACH ROW
BEGIN
    UPDATE Comprador
    SET IdUsuario = :NEW.Id
    WHERE IdUsuario = :OLD.Id;
END;
/

-- Trigger para Vendedor actualizando IdUsuario
CREATE OR REPLACE TRIGGER TRG_UpdateVendedor
AFTER UPDATE OF Id ON Usuarios
FOR EACH ROW
BEGIN
    UPDATE Vendedor
    SET IdUsuario = :NEW.Id
    WHERE IdUsuario = :OLD.Id;
END;
/

-- Trigger para PersonaNatural actualizando IdUsuario
CREATE OR REPLACE TRIGGER TRG_UpdatePersonaNatural
AFTER UPDATE OF IdUsuario ON Vendedor
FOR EACH ROW
BEGIN
    UPDATE PersonaNatural
    SET IdUsuario = :NEW.IdUsuario
    WHERE IdUsuario = :OLD.IdUsuario;
END;
/

-- Trigger para Empresa actualizando IdUsuario
CREATE OR REPLACE TRIGGER TRG_UpdateEmpresa
AFTER UPDATE OF IdUsuario ON Vendedor
FOR EACH ROW
BEGIN
    UPDATE Empresa
    SET IdUsuario = :NEW.IdUsuario
    WHERE IdUsuario = :OLD.IdUsuario;
END;
/

-- Trigger para CarritoCompra actualizando IdUsuario
CREATE OR REPLACE TRIGGER TRG_UpdateCarritoCompra
AFTER UPDATE OF IdUsuario ON Comprador
FOR EACH ROW
BEGIN
    UPDATE CarritoCompra
    SET IdUsuario = :NEW.IdUsuario
    WHERE IdUsuario = :OLD.IdUsuario;
END;
/

-- Trigger para LineaProducto actualizando IdCarrito
CREATE OR REPLACE TRIGGER TRG_UpdateLineaProducto_Carrito
AFTER UPDATE OF IdCarrito ON CarritoCompra
FOR EACH ROW
BEGIN
    UPDATE LineaProducto
    SET IdCarrito = :NEW.IdCarrito
    WHERE IdCarrito = :OLD.IdCarrito;
END;
/

-- Trigger para LineaProducto actualizando IdProducto
CREATE OR REPLACE TRIGGER TRG_UpdateLineaProducto_Producto
AFTER UPDATE OF IdProducto ON Producto
FOR EACH ROW
BEGIN
    UPDATE LineaProducto
    SET IdProducto = :NEW.IdProducto
    WHERE IdProducto = :OLD.IdProducto;
END;
/

-- Trigger para LineaProducto actualizando IdPedido
CREATE OR REPLACE TRIGGER TRG_UpdateLineaProducto_Pedido
AFTER UPDATE OF IdPedido ON Pedido
FOR EACH ROW
BEGIN
    UPDATE LineaProducto
    SET IdPedido = :NEW.IdPedido
    WHERE IdPedido = :OLD.IdPedido;
END;
/

-- Trigger para Resena actualizando IdUsuario
CREATE OR REPLACE TRIGGER TRG_UpdateResena_Comprador
AFTER UPDATE OF IdUsuario ON Comprador
FOR EACH ROW
BEGIN
    UPDATE Resena
    SET IdUsuario = :NEW.IdUsuario
    WHERE IdUsuario = :OLD.IdUsuario;
END;
/

-- Trigger para Resena actualizando IdProducto
CREATE OR REPLACE TRIGGER TRG_UpdateResena_Producto
AFTER UPDATE OF IdProducto ON Producto
FOR EACH ROW
BEGIN
    UPDATE Resena
    SET IdProducto = :NEW.IdProducto
    WHERE IdProducto = :OLD.IdProducto;
END;
/

-- Trigger para Garantia actualizando IdProducto
CREATE OR REPLACE TRIGGER TRG_UpdateGarantia
AFTER UPDATE OF IdProducto ON Producto
FOR EACH ROW
BEGIN
    UPDATE Garantia
    SET IdProducto = :NEW.IdProducto
    WHERE IdProducto = :OLD.IdProducto;
END;
/

-- Trigger para Cupones actualizando IdProducto
CREATE OR REPLACE TRIGGER TRG_UpdateCupones
AFTER UPDATE OF IdProducto ON Producto
FOR EACH ROW
BEGIN
    UPDATE Cupones
    SET IdProducto = :NEW.IdProducto
    WHERE IdProducto = :OLD.IdProducto;
END;
/

-- Trigger para Producto actualizando IdProductoG
CREATE OR REPLACE TRIGGER TRG_UpdateProductoGlobal
AFTER UPDATE OF IdProductoG ON ProductoGlobal
FOR EACH ROW
BEGIN
    UPDATE Producto
    SET IdProductoG = :NEW.IdProductoG
    WHERE IdProductoG = :OLD.IdProductoG;
END;
/

-- Trigger para Pagos actualizando IdPedido
CREATE OR REPLACE TRIGGER TRG_UpdatePagos
AFTER UPDATE OF IdPedido ON Pedido
FOR EACH ROW
BEGIN
    UPDATE Pagos
    SET IdPedido = :NEW.IdPedido
    WHERE IdPedido = :OLD.IdPedido;
END;
/

-- Trigger para Factura actualizando IdPago
CREATE OR REPLACE TRIGGER TRG_UpdateFactura
AFTER UPDATE OF IdPago ON Pagos
FOR EACH ROW
BEGIN
    UPDATE Factura
    SET IdPago = :NEW.IdPago
    WHERE IdPago = :OLD.IdPago;
END;
/

----- Disparadores no ok 
DROP SEQUENCE SEQ_Usuarios; -- Provoca que el disparador falle al intentar usar la secuencia
INSERT INTO Usuarios (Id, Email) VALUES (NULL, 'test@example.com');
DROP SEQUENCE SEQ_numerosContacto; -- Provoca fallo en el disparador.

INSERT INTO numerosContacto (Telofono, TipoTelefono, IdUsuario)
VALUES (NULL, 'Celular', 1); -- Falta el ID generado por el disparador.
DROP SEQUENCE SEQ_Comprador; -- Provoca fallo en el disparador.

INSERT INTO Comprador (IdUsuario, MetodoPago, Direccion)
VALUES (NULL, 'TC', 'Calle 123 #45-67, Ciudad');
DROP SEQUENCE SEQ_Vendedor; -- Provoca fallo en el disparador.

INSERT INTO Vendedor (IdUsuario, CalificacionVendedor)
VALUES (NULL, 5); -- Calificación es válida, pero falla por el ID.
DROP SEQUENCE SEQ_PersonaNatural; -- Provoca fallo en el disparador.

INSERT INTO PersonaNatural (IdUsuario, TipoDocumento, Genero)
VALUES (NULL, 'CC', 'Ma'); -- ID nulo provoca fallo.

DROP SEQUENCE SEQ_Empresa; -- Provoca fallo en el disparador.

INSERT INTO Empresa (IdUsuario, NombreEmpresa, NIT)
VALUES (NULL, 'Empresa Test', '900123456-7'); -- ID nulo falla.
DROP SEQUENCE SEQ_CarritoCompra; -- Provoca fallo en el disparador.

INSERT INTO CarritoCompra (IdCarrito, Estado, IdUsuario)
VALUES (NULL, 'A', 1); -- Estado válido, pero falla por el ID.

DROP SEQUENCE SEQ_LineaProducto; -- Provoca fallo en el disparador.

INSERT INTO LineaProducto (IdLinea, IdCarrito, IdProducto, CantidadDeseada)
VALUES (NULL, 1, 1, 10); -- ID nulo falla.
DROP SEQUENCE SEQ_Resena; -- Provoca fallo en el disparador.

INSERT INTO Resena (IdResena, IdProducto, IdUsuario, CalificacionResena, Comentario)
VALUES (NULL, 1, 1, 5, 'Muy buen producto.'); -- ID nulo falla.
DROP SEQUENCE SEQ_Producto; -- Provoca fallo en el disparador.

INSERT INTO Producto (IdProducto, Nombre, CalificacionProducto, Cantidad)
VALUES (NULL, 'Producto Prueba', 4.5, 100); -- ID nulo falla.
DROP SEQUENCE SEQ_Cupones; -- Provoca fallo en el disparador.

INSERT INTO Cupones (IdCupon, Descuento, CantidadCupones, IdProducto, FechaVencimiento)
VALUES (NULL, 10, 50, 1, SYSDATE + 30); -- ID nulo falla.
DROP SEQUENCE SEQ_Garantia; -- Provoca fallo en el disparador.

INSERT INTO Garantia (IdGarantia, FechaInicio, FechaFin, IdProducto)
VALUES (NULL, SYSDATE, SYSDATE + 90, 1); -- ID nulo falla.
DROP SEQUENCE SEQ_ProductoGlobal; -- Provoca fallo en el disparador.

INSERT INTO ProductoGlobal (IdProductoG, NombreGlobal, CategoriaGlobal)
VALUES (NULL, 'Producto Global', 'Electrónica'); -- ID nulo falla.
DROP SEQUENCE SEQ_Categoria; -- Provoca fallo en el disparador.

INSERT INTO Categoria (IdCategoria, NombreCategoria, Descripcion)
VALUES (NULL, 'Categoría Prueba', 'Descripción de categoría de prueba.'); -- ID nulo falla.
DROP SEQUENCE SEQ_Pedido; -- Provoca fallo en el disparador.

INSERT INTO Pedido (IdPedido, Direccion, Estado, IdUsuario)
VALUES (NULL, 'Calle 123 #45-67, Ciudad', 'Pa', 1); -- ID nulo falla.
DROP SEQUENCE SEQ_Pedido; -- Provoca fallo en el disparador.

INSERT INTO Pedido (IdPedido, Direccion, Estado, IdUsuario)
VALUES (NULL, 'Calle 123 #45-67, Ciudad', 'Pa', 1); -- ID nulo falla.
DROP SEQUENCE SEQ_Pagos; -- Provoca fallo en el disparador.

INSERT INTO Pagos (IdPago, IdPedido, MetodoPago, Monto)
VALUES (NULL, 1, 'TC', 100.00); -- ID nulo falla.
DROP SEQUENCE SEQ_Factura; -- Provoca fallo en el disparador.

INSERT INTO Factura (IdFactura, IdPago, EstadoFactura, Fecha)
VALUES (NULL, 1, 'E', SYSDATE); -- ID nulo falla.
