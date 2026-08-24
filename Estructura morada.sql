--- vistas 
---/ calificacion del vendedor
CREATE OR REPLACE VIEW VistaCalificacionVendedor AS
SELECT 
    V.IdUsuario AS IdVendedor,
    V.DescripcionVendedor,
    ROUND(SUM(P.CalificacionProducto * P.Cantidad) / NULLIF(SUM(P.Cantidad), 0), 2) AS CalificacionVendedor
FROM 
    Vendedor V
LEFT JOIN 
    Producto P ON V.IdUsuario = P.IdUsuario
WHERE 
    P.Estado = 'Disponible' -- Considerar solo productos disponibles
GROUP BY 
    V.IdUsuario, 
    V.DescripcionVendedor;
------ /total 
CREATE OR REPLACE VIEW VistaTotalPago AS
SELECT 
    LP.IdLinea AS IdLineaProducto,
    LP.IdPedido AS IdPedido,
    P.IdProducto,
    P.PrecioUnitario,
    LP.CantidadDeseada,
    ROUND(LP.CantidadDeseada * P.PrecioUnitario, 2) AS TotalPago
FROM 
    LineaProducto LP
JOIN 
    Producto P ON LP.IdProducto = P.IdProducto;
    
-------XVistas
DROP VIEW VistaCalificacionVendedor;
DROP VIEW VistaTotalPago;


--INDICES 
-- Crear �ndice en Contrase�a en la tabla Usuarios
CREATE INDEX IDX_Contrase�a_Usuarios
ON Usuarios (Contrase�a);

-- Crear �ndice en Nombre en la tabla PersonaNatural
CREATE INDEX IDX_Nombre_PersonaNatural
ON PersonaNatural (Nombre);

-- Crear �ndice en NombreEmpresa en la tabla Empresa
CREATE INDEX IDX_NombreEmpresa_Empresa
ON Empresa (NombreEmpresa);

-- Crear �ndice en NombreProducto en la tabla ProductoGlobal
CREATE INDEX IDX_NombreProducto_ProductoGlobal
ON ProductoGlobal (NombreProducto);

-- Crear �ndice en CodigoCupon en la tabla Cupones
CREATE INDEX IDX_CodigoCupon_Cupones
ON Cupones (CodigoCupon);

-- Crear �ndice en Estado en la tabla Pedido
CREATE INDEX IDX_Estado_Pedido
ON Pedido (Estado);

-- Crear �ndice en Estado en la tabla Pagos
CREATE INDEX IDX_Estado_Pagos
ON Pagos (EstadoPago);

-- Crear �ndice en CalificacionResena en la tabla Rese�a
CREATE INDEX IDX_CalificacionResena_Resena
ON Resena (CalificacionResena);

------- Xindices
DROP INDEX IDX_Contrase�a_Usuarios;
DROP INDEX IDX_Nombre_PersonaNatural;
DROP INDEX IDX_NombreEmpresa_Empresa;
DROP INDEX IDX_NombreProducto_ProductoGlobal;
DROP INDEX IDX_CodigoCupon_Cupones;
DROP INDEX IDX_Estado_Pedido;
DROP INDEX IDX_Estado_Pagos;
DROP INDEX IDX_CalificacionResena_Resena;



