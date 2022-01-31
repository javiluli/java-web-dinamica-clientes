package programas.pruebasDominios;

import domain.Cliente;
import domain.FormaPago;
import domain.Iva;
import domain.Tarifa;
import exceptions.DomainException;
import exceptions.ServiceException;
import servicios.ServiciosCliente;

public class ProbarCliente {

  public static void main(String[] args) {
    // definimos los objetos y variables que vamos a usar
    Iva iva = null;
    Tarifa tarifa = null;
    FormaPago formaPago = null;
    Cliente cliente = null;
    ServiciosCliente sCliente = null;

    try {

      /* ##### Se crea el Obj. Clientes() ##### */
      cliente = new Cliente();
      cliente.setCod_cli("154878");
      cliente.setRazon_social("alguna");
      cliente.setTelf("918746372");
      cliente.setDireccion("Nosequeponer");
      cliente.setOferta("S");
      cliente.setAlb_fact("S");

      // Se crea el Obj. Ivas()
      iva = new Iva();
      iva.setCod_iva("1");
      cliente.setIva(iva);

      // Se crea el Obj. Tarifas()
      tarifa = new Tarifa();
      tarifa.setCod_tarifa("1");
      cliente.setTarifa(tarifa);

      // Se crea el Obj. FormasPago()
      formaPago = new FormaPago();
      formaPago.setCodigo("2");
      cliente.setFormaPago(formaPago);

      sCliente = new ServiciosCliente();
      sCliente.insertarCliente(cliente);

      Cliente nuevoCliente = sCliente.recuperarCliente(cliente);
      System.out.println(nuevoCliente);

      System.out.println("Fin proceso, todo OK");

    } catch (ServiceException | DomainException e) { // capturamos errores de dominio y servicios
      if (e.getCause() == null) { // la exception la ha levantado el programador
        System.out.println(e.getMessage()); // Error Lógico para usuario
      } else {
        e.printStackTrace(); // para administrador
        System.out.println("Error interno"); // Error interno para usuario
      }
    }
  }

}
