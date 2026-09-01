-- ══════════════════════════════════════════
-- MiniStore — Soluciones con Outer JOINs
-- Autor: [Tu nombre]
-- Fecha: [Fecha de entrega]
-- ══════════════════════════════════════════


-- ── CONSULTA 1: LEFT JOIN ─────────────────
-- Pregunta de negocio:
-- ¿Qué productos del catálogo nunca fueron vendidos?
-- Mostrá todos los productos y sus ventas asociadas.
-- Los productos sin ventas aparecerán con NULL en las columnas de ventas.

-- Consulta principal:
SELECT
    p.producto_id,
    p.nombre,
    p.categoria,
    p.precio,
    v.venta_id,
    v.cliente_id,
    v.cantidad,
    v.fecha_venta
FROM productos p
LEFT JOIN ventas v
    ON p.producto_id = v.producto_id
ORDER BY p.producto_id, v.venta_id;

-- Filtro adicional:
-- Muestra únicamente los productos que nunca fueron vendidos.
SELECT
    p.producto_id,
    p.nombre,
    p.categoria,
    p.precio
FROM productos p
LEFT JOIN ventas v
    ON p.producto_id = v.producto_id
WHERE v.venta_id IS NULL
ORDER BY p.producto_id;



-- ── CONSULTA 2: RIGHT JOIN ────────────────
-- Pregunta de negocio:
-- ¿Existen ventas registradas con productos
-- que no figuran en nuestro catálogo?

-- Consulta principal:
SELECT
    p.producto_id AS producto_catalogo_id,
    p.nombre,
    p.categoria,
    p.precio,
    v.venta_id,
    v.producto_id AS producto_vendido_id,
    v.cliente_id,
    v.cantidad,
    v.fecha_venta
FROM productos p
RIGHT JOIN ventas v
    ON p.producto_id = v.producto_id
ORDER BY v.venta_id;

-- Filtro adicional:
-- Muestra únicamente las ventas cuyo producto no existe en el catálogo.
SELECT
    p.producto_id AS producto_catalogo_id,
    p.nombre,
    v.venta_id,
    v.producto_id AS producto_vendido_id,
    v.cliente_id,
    v.cantidad,
    v.fecha_venta
FROM productos p
RIGHT JOIN ventas v
    ON p.producto_id = v.producto_id
WHERE p.producto_id IS NULL
ORDER BY v.venta_id;



-- ── CONSULTA 3: FULL OUTER JOIN ───────────
-- Pregunta de negocio:
-- Vista completa de auditoría que muestre
-- todos los productos y todas las ventas sin perder ninguna fila.

-- Consulta principal:
SELECT
    p.producto_id AS producto_catalogo_id,
    p.nombre,
    p.categoria,
    p.precio,
    v.venta_id,
    v.producto_id AS producto_vendido_id,
    v.cliente_id,
    v.cantidad,
    v.fecha_venta
FROM productos p
FULL OUTER JOIN ventas v
    ON p.producto_id = v.producto_id
ORDER BY
    COALESCE(p.producto_id, v.producto_id),
    v.venta_id;

-- Filtro adicional:
-- Muestra únicamente los registros sin coincidencia entre ambas tablas.
SELECT
    p.producto_id AS producto_catalogo_id,
    p.nombre,
    p.categoria,
    p.precio,
    v.venta_id,
    v.producto_id AS producto_vendido_id,
    v.cliente_id,
    v.cantidad,
    v.fecha_venta
FROM productos p
FULL OUTER JOIN ventas v
    ON p.producto_id = v.producto_id
WHERE p.producto_id IS NULL
   OR v.venta_id IS NULL
ORDER BY
    COALESCE(p.producto_id, v.producto_id),
    v.venta_id;