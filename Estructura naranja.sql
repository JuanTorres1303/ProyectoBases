-- ========================
-- Paquete: UsuarioPkg
-- ========================
CREATE OR REPLACE PACKAGE UsuarioPkg IS
    PROCEDURE InsertarUsuario(
        p_UserName IN VARCHAR2,
        p_Email IN VARCHAR2,
        p_Contrase�a IN VARCHAR2,
        p_FechaRegistro IN DATE
    );

    PROCEDURE ActualizarUsuario(
        p_UserName IN VARCHAR2,
        p_Email IN VARCHAR2,
        p_Contrase�a IN VARCHAR2
    );

    PROCEDURE InsertarContacto(
        p_Telefono IN VARCHAR2,
        p_IdUsuario IN VARCHAR2
    );

    PROCEDURE ActualizarContacto(
        p_TelefonoActual IN VARCHAR2,
        p_TelefonoNuevo IN VARCHAR2
    );

    FUNCTION ObtenerContactos(
        p_IdUsuario IN VARCHAR2
    ) RETURN SYS_REFCURSOR;
END UsuarioPkg;
/

CREATE OR REPLACE PACKAGE BODY UsuarioPkg IS
    PROCEDURE InsertarUsuario(
        p_UserName IN VARCHAR2,
        p_Email IN VARCHAR2,
        p_Contrase�a IN VARCHAR2,
        p_FechaRegistro IN DATE
    ) IS
    BEGIN
        INSERT INTO Usuarios (UserName, Email, Contrase�a, FechaRegistro)
        VALUES (SEQ_Usuarios.NEXTVAL, p_UserName, p_Email, p_Contrase�a, p_FechaRegistro);
    END InsertarUsuario;

    PROCEDURE ActualizarUsuario(
        p_Id IN VARCHAR2,
        p_UserName IN VARCHAR2,
        p_Email IN VARCHAR2,
        p_Contrase�a IN VARCHAR2
    ) IS
    BEGIN
        UPDATE Usuarios
        SET UserName = p_UserName,
            Email = p_Email,
            Contrase�a = p_Contrase�a
        WHERE Id = p_Id;
    END ActualizarUsuario;

    PROCEDURE InsertarContacto(
        p_Telefono IN VARCHAR2,
        p_IdUsuario IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO numerosContacto (Telofono, IdUsuario)
        VALUES (p_Telefono, p_IdUsuario);
    END InsertarContacto;

    PROCEDURE ActualizarContacto(
        p_TelefonoActual IN VARCHAR2,
        p_TelefonoNuevo IN VARCHAR2
    ) IS
    BEGIN
        UPDATE numerosContacto
        SET Telofono = p_TelefonoNuevo
        WHERE Telofono = p_TelefonoActual;
    END ActualizarContacto;

    FUNCTION ObtenerContactos(
        p_IdUsuario IN VARCHAR2
    ) RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
        SELECT Telofono
        FROM numerosContacto
        WHERE IdUsuario = p_IdUsuario;
        RETURN cur;
    END ObtenerContactos;
END UsuarioPkg;
/

-- ========================
-- Paquete: VendedorPkg
-- ========================
CREATE OR REPLACE PACKAGE VendedorPkg IS
    PROCEDURE RegistrarVendedor(
        p_IdUsuario IN VARCHAR2,
        p_Descripcion IN VARCHAR2
    );

    PROCEDURE ActualizarCalificacionVendedor(
        p_IdUsuario IN VARCHAR2
    );

    PROCEDURE RegistrarEmpresa(
        p_IdUsuario IN VARCHAR2,
        p_NombreEmpresa IN VARCHAR2,
        p_Nit IN VARCHAR2,
        p_Representante IN VARCHAR2
    );

    PROCEDURE RegistrarPersonaNatural(
        p_IdUsuario IN VARCHAR2,
        p_Nombre IN VARCHAR2,
        p_Nidentificacion IN VARCHAR2,
        p_Direccion IN VARCHAR2,
        p_TipoDocumento IN VARCHAR2,
        p_Genero IN VARCHAR2
    );
END VendedorPkg;
/

CREATE OR REPLACE PACKAGE BODY VendedorPkg IS
    PROCEDURE RegistrarVendedor(
        p_IdUsuario IN VARCHAR2,
        p_Descripcion IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO Vendedor (IdUsuario, DescripcionVendedor, CalificacionVendedor)
        VALUES (p_IdUsuario, p_Descripcion, NULL); -- La calificaci�n se deriva
    END RegistrarVendedor;

    PROCEDURE ActualizarCalificacionVendedor(
        p_IdUsuario IN VARCHAR2
    ) IS
        v_Calificacion FLOAT;
    BEGIN
        -- Calcular la calificaci�n promedio de un vendedor basado en las rese�as de sus productos
        SELECT NVL(AVG(r.CalificacionResena), 0)
        INTO v_Calificacion
        FROM Producto p
        JOIN Resena r ON p.IdProducto = r.IdProducto
        WHERE p.IdUsuario = p_IdUsuario;

        -- Actualizar la calificaci�n del vendedor
        UPDATE Vendedor
        SET CalificacionVendedor = v_Calificacion
        WHERE IdUsuario = p_IdUsuario;
    END ActualizarCalificacionVendedor;

    PROCEDURE RegistrarEmpresa(
        p_IdUsuario IN VARCHAR2,
        p_NombreEmpresa IN VARCHAR2,
        p_Nit IN VARCHAR2,
        p_Representante IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO Empresa (IdUsuario, NombreEmpresa, Nit, RepresentanteLegal)
        VALUES (p_IdUsuario, p_NombreEmpresa, p_Nit, p_Representante);
    END RegistrarEmpresa;

    PROCEDURE RegistrarPersonaNatural(
        p_IdUsuario IN VARCHAR2,
        p_Nombre IN VARCHAR2,
        p_Nidentificacion IN VARCHAR2,
        p_Direccion IN VARCHAR2,
        p_TipoDocumento IN VARCHAR2,
        p_Genero IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO PersonaNatural (IdUsuario, Nombre, Nidentificacion, Direccion, TipoDocumento, Genero)
        VALUES (p_IdUsuario, p_Nombre, p_Nidentificacion, p_Direccion, p_TipoDocumento, p_Genero);
    END RegistrarPersonaNatural;
END VendedorPkg;
/

-- ========================
-- Paquete: ProductoPkg
-- ========================
CREATE OR REPLACE PACKAGE ProductoPkg IS
    PROCEDURE RegistrarProducto(
        p_Estado IN VARCHAR2,
        p_PrecioUnitario IN NUMBER,
        p_Cantidad IN NUMBER,
        p_IdUsuario IN VARCHAR2,
        p_IdProductoG IN VARCHAR2
    );

    PROCEDURE ActualizarCalificacionProducto(
        p_IdProducto IN VARCHAR2
    );
END ProductoPkg;
/

CREATE OR REPLACE PACKAGE BODY ProductoPkg IS
    PROCEDURE RegistrarProducto(
        p_Estado IN VARCHAR2,
        p_PrecioUnitario IN NUMBER,
        p_Cantidad IN NUMBER,
        p_IdUsuario IN VARCHAR2,
        p_IdProductoG IN VARCHAR2
    ) IS
    BEGIN
        INSERT INTO Producto (IdProducto, FechaIngreso, Estado, PrecioUnitario, Cantidad, CalificacionProducto, IdUsuario, IdProductoG)
        VALUES (SEQ_Producto.NEXTVAL, SYSDATE, p_Estado, p_PrecioUnitario, p_Cantidad, NULL, p_IdUsuario, p_IdProductoG); -- La calificaci�n se deriva
    END RegistrarProducto;

    PROCEDURE ActualizarCalificacionProducto(
        p_IdProducto IN VARCHAR2
    ) IS
        v_Calificacion FLOAT;
    BEGIN
        -- Calcular la calificaci�n promedio de un producto basado en sus rese�as
        SELECT NVL(AVG(CalificacionResena), 0)
        INTO v_Calificacion
        FROM Resena
        WHERE IdProducto = p_IdProducto;

        -- Actualizar la calificaci�n del producto
        UPDATE Producto
        SET CalificacionProducto = v_Calificacion
        WHERE IdProducto = p_IdProducto;
    END ActualizarCalificacionProducto;
END ProductoPkg;
/
-- ========================
-- Paquete: CompradorPkg
-- ========================
CREATE OR REPLACE PACKAGE CompradorPkg IS
    -- Crear un carrito para un comprador
    PROCEDURE CrearCarrito(
        p_IdUsuario IN VARCHAR2
    );

    -- Agregar una l�nea de producto al carrito
    PROCEDURE AgregarLineaProducto(
        p_IdCarrito IN VARCHAR2,
        p_IdProducto IN VARCHAR2,
        p_Cantidad IN NUMBER
    );

    -- Vaciar un carrito de compras
    PROCEDURE VaciarCarrito(
        p_IdCarrito IN VARCHAR2
    );

    -- Actualizar el estado de un carrito
    PROCEDURE ActualizarEstadoCarrito(
        p_IdCarrito IN VARCHAR2,
        p_NuevoEstado IN VARCHAR2
    );

    -- Actualizar una l�nea de producto
    PROCEDURE ActualizarLineaProducto(
        p_IdLinea IN VARCHAR2,
        p_CantidadDeseada IN NUMBER
    );
END CompradorPkg;
/

CREATE OR REPLACE PACKAGE BODY CompradorPkg IS
    PROCEDURE CrearCarrito(
        p_IdUsuario IN VARCHAR2
    ) IS
        v_IdCarrito VARCHAR2(10);
    BEGIN
        -- Generar un nuevo ID de carrito usando la secuencia
        SELECT LPAD(SEQ_CarritoCompra.NEXTVAL, 10, '0') INTO v_IdCarrito FROM DUAL;

        -- Insertar el carrito de compras
        INSERT INTO CarritoCompra (IdCarrito, FechaCreacion, Estado, IdUsuario)
        VALUES (v_IdCarrito, SYSDATE, 'Activo', p_IdUsuario);
    END CrearCarrito;

    PROCEDURE AgregarLineaProducto(
        p_IdCarrito IN VARCHAR2,
        p_IdProducto IN VARCHAR2,
        p_Cantidad IN NUMBER
    ) IS
        v_PrecioUnitario NUMBER;
        v_IdLinea VARCHAR2(10);
    BEGIN
        -- Obtener el precio unitario del producto
        SELECT PrecioUnitario
        INTO v_PrecioUnitario
        FROM Producto
        WHERE IdProducto = p_IdProducto;

        -- Generar un nuevo ID de l�nea de producto
        SELECT LPAD(SEQ_LineaProducto.NEXTVAL, 10, '0') INTO v_IdLinea FROM DUAL;

        -- Insertar la l�nea de producto
        INSERT INTO LineaProducto (IdLinea, FechaA�adido, CantidadDeseada, Total, IdCarrito, IdProducto)
        VALUES (v_IdLinea, SYSDATE, p_Cantidad, p_Cantidad * v_PrecioUnitario, p_IdCarrito, p_IdProducto);
    END AgregarLineaProducto;

    PROCEDURE VaciarCarrito(
        p_IdCarrito IN VARCHAR2
    ) IS
    BEGIN
        DELETE FROM LineaProducto WHERE IdCarrito = p_IdCarrito;
    END VaciarCarrito;

    PROCEDURE ActualizarEstadoCarrito(
        p_IdCarrito IN VARCHAR2,
        p_NuevoEstado IN VARCHAR2
    ) IS
    BEGIN
        UPDATE CarritoCompra
        SET Estado = p_NuevoEstado
        WHERE IdCarrito = p_IdCarrito;
    END ActualizarEstadoCarrito;

    PROCEDURE ActualizarLineaProducto(
        p_IdLinea IN VARCHAR2,
        p_CantidadDeseada IN NUMBER
    ) IS
        v_PrecioUnitario NUMBER;
    BEGIN
        -- Obtener el precio unitario del producto
        SELECT PrecioUnitario
        INTO v_PrecioUnitario
        FROM Producto
        WHERE IdProducto = (SELECT IdProducto FROM LineaProducto WHERE IdLinea = p_IdLinea);

        -- Actualizar la cantidad deseada y el total
        UPDATE LineaProducto
        SET CantidadDeseada = p_CantidadDeseada,
            Total = p_CantidadDeseada * v_PrecioUnitario
        WHERE IdLinea = p_IdLinea;
    END ActualizarLineaProducto;
END CompradorPkg;
/

-- ========================
-- Paquete: PagoPkg
-- ========================
CREATE OR REPLACE PACKAGE PagoPkg IS
    -- Crear un pedido
    PROCEDURE CrearPedido(
        p_IdUsuario IN VARCHAR2,
        p_Direccion IN VARCHAR2
    );

    -- Registrar un pago
    PROCEDURE RegistrarPago(
        p_IdPedido IN VARCHAR2,
        p_MontoTotal IN NUMBER,
        p_MetodoPago IN VARCHAR2
    );

    -- Generar una factura
    PROCEDURE GenerarFactura(
        p_IdPago IN VARCHAR2
    );

    -- Actualizar el estado de un pedido
    PROCEDURE ActualizarEstadoPedido(
        p_IdPedido IN VARCHAR2,
        p_NuevoEstado IN VARCHAR2
    );

    -- Actualizar el estado de un pago
    PROCEDURE ActualizarEstadoPago(
        p_IdPago IN VARCHAR2,
        p_NuevoEstado IN VARCHAR2
    );
END PagoPkg;
/

CREATE OR REPLACE PACKAGE BODY PagoPkg IS
    PROCEDURE CrearPedido(
        p_IdUsuario IN VARCHAR2,
        p_Direccion IN VARCHAR2
    ) IS
        v_IdPedido VARCHAR2(10);
    BEGIN
        -- Generar un nuevo ID de pedido
        SELECT LPAD(SEQ_Pedido.NEXTVAL, 10, '0') INTO v_IdPedido FROM DUAL;

        -- Insertar el pedido
        INSERT INTO Pedido (IdPedido, FechaPedido, Estado, Direccion)
        VALUES (v_IdPedido, SYSDATE, 'Pendiente', p_Direccion);
    END CrearPedido;

    PROCEDURE RegistrarPago(
        p_IdPedido IN VARCHAR2,
        p_MontoTotal IN NUMBER,
        p_MetodoPago IN VARCHAR2
    ) IS
        v_IdPago VARCHAR2(10);
    BEGIN
        -- Generar un nuevo ID de pago
        SELECT LPAD(SEQ_Pagos.NEXTVAL, 10, '0') INTO v_IdPago FROM DUAL;

        -- Insertar el pago
        INSERT INTO Pagos (IdPago, MontoTotal, MetodoPago, FechaPago, EstadoPago, IdPedido)
        VALUES (v_IdPago, p_MontoTotal, p_MetodoPago, SYSDATE, 'Pagado', p_IdPedido);

        -- Actualizar el estado del pedido
        UPDATE Pedido
        SET Estado = 'Pagado'
        WHERE IdPedido = p_IdPedido;
    END RegistrarPago;

    PROCEDURE GenerarFactura(
        p_IdPago IN VARCHAR2
    ) IS
        v_IdFactura VARCHAR2(10);
    BEGIN
        -- Generar un nuevo ID de factura
        SELECT LPAD(SEQ_Factura.NEXTVAL, 10, '0') INTO v_IdFactura FROM DUAL;

        -- Insertar la factura
        INSERT INTO Factura (IdFactura, NumeroFactura, FechaEmision, EstadoFactura, IdPago)
        VALUES (v_IdFactura, TO_CHAR(SYSDATE, 'YYYYMMDD') || LPAD(SEQ_Factura.NEXTVAL, 6, '0'), 
                SYSDATE, 'Emitida', p_IdPago);
    END GenerarFactura;

    PROCEDURE ActualizarEstadoPedido(
        p_IdPedido IN VARCHAR2,
        p_NuevoEstado IN VARCHAR2
    ) IS
    BEGIN
        UPDATE Pedido
        SET Estado = p_NuevoEstado
        WHERE IdPedido = p_IdPedido;
    END ActualizarEstadoPedido;

    PROCEDURE ActualizarEstadoPago(
        p_IdPago IN VARCHAR2,
        p_NuevoEstado IN VARCHAR2
    ) IS
    BEGIN
        UPDATE Pagos
        SET EstadoPago = p_NuevoEstado
        WHERE IdPago = p_IdPago;
    END ActualizarEstadoPago;
END PagoPkg;
/

--------------------
--------------------
--Producto Global
--------------------
--------------------

-- CABECERA DEL PAQUETE
CREATE OR REPLACE PACKAGE ProductoGlobalPkg IS
    -- Adicionar un producto global
    PROCEDURE AdicionarProductoGlobal(
        p_NombreProducto IN VARCHAR2,
        p_Descripcion IN VARCHAR2,
        p_Fotografia IN VARCHAR2,
        p_Tamano IN VARCHAR2,
        p_IdCategoria IN VARCHAR2
    );

    -- Modificar un producto global
    PROCEDURE ModificarProductoGlobal(
        p_IdProductoG IN VARCHAR2,
        p_NombreProducto IN VARCHAR2,
        p_Descripcion IN VARCHAR2,
        p_Fotografia IN VARCHAR2,
        p_Tamano IN VARCHAR2,
        p_IdCategoria IN VARCHAR2
    );

    -- Consultar productos globales por categor�a
    FUNCTION ConsultarProductosPorCategoria(
        p_IdCategoria IN VARCHAR2
    ) RETURN SYS_REFCURSOR;

    -- Consultar categor�as
    FUNCTION ConsultarCategorias RETURN SYS_REFCURSOR;

    -- Eliminar un producto global
    PROCEDURE EliminarProductoGlobal(
        p_IdProductoG IN VARCHAR2
    );
END ProductoGlobalPkg;
/

--Cuerpo
CREATE OR REPLACE PACKAGE BODY ProductoGlobalPkg IS
    -- Adicionar un producto global
    PROCEDURE AdicionarProductoGlobal(
        p_NombreProducto IN VARCHAR2,
        p_Descripcion IN VARCHAR2,
        p_Fotografia IN VARCHAR2,
        p_Tamano IN VARCHAR2,
        p_IdCategoria IN VARCHAR2
    ) IS
        v_IdProductoG VARCHAR2(10);
    BEGIN
        -- Generar un nuevo ID para ProductoGlobal
        SELECT LPAD(SEQ_ProductoGlobal.NEXTVAL, 10, '0') INTO v_IdProductoG FROM DUAL;

        -- Insertar el producto global
        INSERT INTO ProductoGlobal (IdProductoG, NombreProducto, Descripcion, Fotografia, Tama�o, IdCategoria)
        VALUES (v_IdProductoG, p_NombreProducto, p_Descripcion, p_Fotografia, p_Tamano, p_IdCategoria);
    END AdicionarProductoGlobal;

    -- Modificar un producto global
    PROCEDURE ModificarProductoGlobal(
        p_IdProductoG IN VARCHAR2,
        p_NombreProducto IN VARCHAR2,
        p_Descripcion IN VARCHAR2,
        p_Fotografia IN VARCHAR2,
        p_Tamano IN VARCHAR2,
        p_IdCategoria IN VARCHAR2
    ) IS
    BEGIN
        -- Actualizar los datos del producto global
        UPDATE ProductoGlobal
        SET NombreProducto = p_NombreProducto,
            Descripcion = p_Descripcion,
            Fotografia = p_Fotografia,
            Tama�o = p_Tamano,
            IdCategoria = p_IdCategoria
        WHERE IdProductoG = p_IdProductoG;
    END ModificarProductoGlobal;

    -- Consultar productos globales por categor�a
    FUNCTION ConsultarProductosPorCategoria(
        p_IdCategoria IN VARCHAR2
    ) RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
        SELECT IdProductoG, NombreProducto, Descripcion, Fotografia, Tama�o
        FROM ProductoGlobal
        WHERE IdCategoria = p_IdCategoria;
        RETURN cur;
    END ConsultarProductosPorCategoria;

    -- Consultar todas las categor�as
    FUNCTION ConsultarCategorias RETURN SYS_REFCURSOR IS
        cur SYS_REFCURSOR;
    BEGIN
        OPEN cur FOR
        SELECT IdCategoria, NombreCategoria, DescripcionCategoria, FechaCategoria
        FROM Categoria;
        RETURN cur;
    END ConsultarCategorias;

    -- Eliminar un producto global
    PROCEDURE EliminarProductoGlobal(
        p_IdProductoG IN VARCHAR2
    ) IS
    BEGIN
        -- Borrar el producto global
        DELETE FROM ProductoGlobal
        WHERE IdProductoG = p_IdProductoG;
    END EliminarProductoGlobal;
END ProductoGlobalPkg;
/