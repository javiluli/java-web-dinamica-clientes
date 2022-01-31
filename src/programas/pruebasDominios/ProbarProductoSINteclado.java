package programas.pruebasDominios;

import java.text.ParseException;

import domain.Cliente;
import domain.Iva;
import domain.Tarifa;
import exceptions.DomainException;

public class ProbarProductoSINteclado {

  /**
   * @param args
   * @throws ParseException
   */
  public static void main(String[] args) {
    // definimos los objetos y variables que vamos a usar;
    Iva pais = null;
    Tarifa variedad = null;
    Cliente producto = null;
    try {
      // CUALQUIER exception en este bloque se trata y/o se propaga al bloque externo
      // como una DomainException o ServiceException

      System.out.println(producto.toString());
      System.out.println("Fin proceso:todo ok");

    } catch (DomainException e) {// siempre que hay que validar dominios
      if (e.getCause() == null) {

        System.out.println(e.getMessage());// Error Lógico para usuario
      } else {
        e.printStackTrace();// para administrador
        System.out.println("error interno");// Error interno para usuario

      }

    }
  }

}
