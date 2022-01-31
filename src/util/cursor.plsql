set serveroutput ON;

DECLARE

  -- definir el cursor y su sentencia select
  CURSOR cclientes IS SELECT cod_cli, razon_social FROM clientes WHERE oferta = 'S';
  -- definimos una variable del mismo tipo del cursor
  lienaclientes cclientes%ROWTYPE;
  
BEGIN
  -- abrimos el cursor
  OPEN cclientes;
  -- leemos la primera fila
  FETCH cclientes into lienaclientes;
  -- minetras el FECTH encuentre filas
  WHILE cclientes%FOUND LOOP
      dbms_output.Put_line(lienaclientes.cod_cli || ' ' || lienaclientes.razon_social);
      -- se lee la siguiente fila
      FETCH cclientes into lienaclientes;
  END LOOP;
  
  -- cierra el cursor y limpia memoria
  CLOSE cclientes;
END;

/

