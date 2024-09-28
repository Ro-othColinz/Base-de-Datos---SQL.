-- Explorar la tabla “menu_items” para conocer los productos del menú.

SELECT * 
FROM  menu_items;
-- Una vez visualizados los campos que conforma la tabla “menu_items” procede a realizar las siguientes consultas:

-- 1.-Encontrar el número de artículos en el menú.

SELECT COUNT (menu_item_id)
FROM menu_items

-- Respuesta: 32


-- 2.- ¿Cuál es el artículo menos caro y el más caro en el menú?

SELECT item_name, price
FROM menu_items
ORDER BY price DESC
LIMIT 1;
--Respuesta: "Shrimp Scampi" de 19.95

SELECT item_name, price
FROM menu_items
ORDER BY price ASC
LIMIT 1;
--Respuesta: "Edamame" de 5.00

-- 3.- ¿Cuántos platos americanos hay en el menú?

SELECT COUNT (category)
FROM menu_items
WHERE category = 'American'

-- Respuesta: 6 platos son americanos 

-- 4.- ¿Cuál es el precio promedio de los platos?

SELECT AVG (price)
FROM menu_items;	

-- Respuesta: 13.2859375000000000 por eso lo reduje 

SELECT ROUND (AVG (price),2)
FROM menu_items;

-- R2: 13.29



-- Explorar la tabla “order_details” para conocer los datos que han sido recolectados.

SELECT *
FROM order_details;

-- Una vez visualizados los campos que conforma la tabla “order_details” procede a realizar las siguientes consultas:

-- 1.- ¿Cuántos pedidos únicos se realizaron en total?

SELECT COUNT (order_id)
FROM order_details;

-- Respuesta: 12234 pedidos unicos.

-- 2.-¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos?

SELECT order_id, COUNT (item_id)
FROM order_details
GROUP BY order_id
ORDER BY COUNT (item_id) DESC
LIMIT 5;

-- Respuesta: 440,2675,3473,4305, 443 estos son solo 5 pedidos con 14 articulos cada uno.

-- 3.- ¿Cuándo se realizó el primer pedido y el último pedido?

SELECT order_date
FROM order_details
GROUP BY order_details_id
ORDER BY order_date ASC
LIMIT 1;

--Respuesta: El primer pedido se hizo el 2023-01-01.

SELECT order_date
FROM order_details
GROUP BY order_details_id
ORDER BY order_date DESC
LIMIT 1;

-- Respuesta: el ultimo pedido se realizo el 2023-03-31.

-- 4.- ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'?

SELECT COUNT (order_id)
FROM order_details
WHERE  order_date  BETWEEN '2023-01-01' AND '2023-01-05'

-- Respuesta: 702 pedidos.

-- Usar ambas tablas para conocer la reacción de los clientes respecto al menú.
SELECT * 
FROM  menu_items;

SELECT *
FROM order_details;


-- Realizar un left join entre entre order_details y menu_items con el identificador item_id(tabla order_details) y menu_item_id(tabla menu_items).

SELECT *
FROM order_details AS O
LEFT JOIN menu_items AS M
ON O.item_id = M.menu_item_id
	
--Una vez que hayas explorado los datos en las tablas correspondientes y respondido las preguntas planteadas, realiza un análisis adicional utilizando este join entre las tablas.

-- 1.- ¿Cuales fueron los platillos mas solicitados del menu?

SELECT COUNT (O.item_id), M.item_name
FROM order_details AS O
LEFT JOIN menu_items AS M
ON O.item_id = M.menu_item_id
GROUP BY M.item_name
ORDER BY  COUNT (O.item_id) DESC
LIMIT 10;

-- Análisis: Esta consulta nos muestra cuales son los platillos mas solicitados del menú, dejando en un margen de 10 para ser mas concisos. 
--La siguiente consulta complementa a la primera. 

--  2.- ¿¿Cuál es el promedio de los platillos más solicitados del menú

SELECT M.item_name, ROUND (AVG (O.item_id),2) AS "Promedio"
FROM order_details AS O
LEFT JOIN menu_items AS M
ON O.item_id = M.menu_item_id
GROUP BY M.item_name
ORDER BY  COUNT (O.item_id) DESC
LIMIT 10;

--Análisis: como pueden ver la consulta refleja el promedio de los platillos más solicitados del menú es por ello que muestra de una mejor manera la primera consulta. 


-- 3.- ¿A que categoria pertenecen los platilos mas pedidos?

SELECT COUNT (O.item_id), M.item_name, category
FROM order_details AS O
LEFT JOIN menu_items AS M
ON O.item_id = M.menu_item_id
GROUP BY M.menu_item_id 
ORDER BY  COUNT (O.item_id) DESC
LIMIT 10;

-- Análisis: Con esta consulta podemos visualizar las categorías de los platillos más solicitados del menú siguiendo el margen de 10, dejando claro que los platillos que pertenecen a la categoría de “American “ son los mas solicitados. 

-- 4.- ¿En qué fechas se hicieron mas pedidos? 
SELECT O.order_date, COUNT (O.order_id)
FROM order_details AS O
LEFT JOIN menu_items AS M ON O.item_id = M.menu_item_id
GROUP BY  (O.order_date)
ORDER BY COUNT (O.order_id) DESC;

-- Análisis: la consulta enumera la fecha de cada pedido, junto con el número de pedidos realizados en esa fecha ordenándolos de mayor a menor. En este caso no pude limitar los datos, pero al observar los primeros números te da una idea de cual seria el mejor mes de ventas. 

-- 5.- ¿En que fechas se hicieron pedidos de platillos mas caros?
SELECT COUNT (M.price),O.order_date
FROM order_details AS O
LEFT JOIN menu_items AS M
ON O.item_id = M.menu_item_id
GROUP BY O.order_date 
ORDER BY  COUNT (M.price) DESC
LIMIT 10;

-- Análisis: Considero que esta consulta hace más solida la consulta anterior pues en ella busca las fechas principales con más pedidos considerando su precio y ordenándolos por fecha en este caso limitando en 10 para hacer mas conciso el resultado. 

-- 6.- ¿Cuáles son los platillos con mas artículos? 

SELECT O.order_id, COUNT (O.item_id)
FROM order_details AS O
LEFT JOIN menu_items AS M
ON O.item_id = M.menu_item_id
GROUP BY  O.order_id
ORDER BY COUNT(O.item_id) DESC
LIMIT 10;

--Análisis: Esta consulta la tome del ejercicio anterior y busca los pedidos principales con la mayor cantidad de artículos ordenando cada uno y limitándolos en 10 datos. Decidí poner esta consulta también porque es importante obtener la mayor cantidad de datos posibles para que los dueños puedan entender mejor su negocio y puedan tomar las decisiones correctas para cumplir su objetivo de cambiar su menú.


