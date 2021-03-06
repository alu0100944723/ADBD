CREATE OR REPLACE FUNCTION pedirProducto()
RETURNS TRIGGER AS $pedirProducto()$
BEGIN
INSERT INTO Producto_Pedido(ID_Producto,ID_Pedido) VALUES(NEW.ID,NEW.Lote) WHERE Stock <= 1.0;
END;
$pedirProducto()$ LANGUAGE plpgsql;

CREATE TRIGGER SOLICIRAR_PRODUCTO AFTER UPDATE 
ON Producto FOR EACH ROW 
EXECUTE PROCEDURE pedirProducto();


