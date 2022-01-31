package domain;

import exceptions.DomainException;
import util.Validator;

public class Cliente {
  String    cod_cli;      // varchar2(10) primary key
  String    razon_social; // varchar2(20) not null
  String    telf;         // varchar2(9)
  String    direccion;    // varchar2(50) not null
  String    oferta;       // varchar2(1) default ('S')
  String    alb_fact;     // varchar2(1) default ('N')
  Iva       iva;          // varchar2(10) not null FK
  Tarifa    tarifa;       // varchar2(10) not null FK
  FormaPago formaPago;    // varchar2(10) not null FK

  // constructor por defecto
  public Cliente() {
  }

  // constructor completo
  public Cliente(String cod_cli, String razon_social, String telf, String direccion, String oferta, String alb_fact,
      Iva iva, Tarifa tarifa, FormaPago formaPago) {
    this.cod_cli = cod_cli;
    this.razon_social = razon_social;
    this.telf = telf;
    this.direccion = direccion;
    this.oferta = oferta;
    this.alb_fact = alb_fact;
    this.iva = iva;
    this.tarifa = tarifa;
    this.formaPago = formaPago;
  }

  /**
   * @param cod_cli
   */
  public String getCod_cli() {
    return cod_cli;
  }

  public String getRazon_social() {
    return razon_social;
  }

  public String getTelf() {
    return telf;
  }

  public String getDireccion() {
    return direccion;
  }

  public String getOferta() {
    return oferta;
  }

  public String getAlb_fact() {
    return alb_fact;
  }

  public Iva getIva() {
    return iva;
  }

  public Tarifa getTarifa() {
    return tarifa;
  }

  public FormaPago getFormaPago() {
    return formaPago;
  }

  public void setCod_cli(String cod_cli) {
    if (cod_cli != null && cod_cli.trim().length() > 0) {
      if (Validator.length(cod_cli, 1, 10)) { // minimo 5 caracteres
        this.cod_cli = cod_cli.trim();
      } else {
        throw new DomainException("La longitud del codigo de cliente no es correcta [5-10]");
      }
    } else {
      throw new DomainException("El codigo de cliente es obligatorio");
    }
  }

  public void setRazon_social(String razon_social) {
    if (razon_social != null && razon_social.trim().length() > 0) {
      if (Validator.length(razon_social, 5, 20)) { // minimo 5 caracteres
        this.razon_social = razon_social.trim();
      } else {
        throw new DomainException("La longitud de la razon social no es correcta [5-20]");
      }
    } else {
      throw new DomainException("La razon social es obligatoria");
    }
  }

  public void setTelf(String telf) {
    if (telf.trim().length() == 0) {
      this.telf = null;
    } else {
      if (telf.trim().length() == 9) { // numero de 9 digitos
        boolean isNumeric = telf.matches("[+-]?\\d*(\\.\\d+)?"); // asegura que sean solo numeros
        if (isNumeric) {
          this.telf = telf.trim();
        } else {
          throw new DomainException("La telefono lo deben forma unicamente numeros");
        }
      } else {
        throw new DomainException("La longitud del telefono no es correcta [9 digitos]");
      }
    }
  }

  public void setDireccion(String direccion) {
    if (direccion != null && direccion.trim().length() > 0) {
      if (Validator.length(direccion, 5, 50)) { // minimo 5 caracteres
        this.direccion = direccion.trim();
      } else {
        throw new DomainException("La longitud de la direccion no es correcta [5-50]");
      }
    } else {
      throw new DomainException("La direccion es obligatoria");
    }
  }

  public void setOferta(String oferta) { // default ('S')
    if (oferta == "n" || oferta == "N") {
      this.oferta = "N";
    } else {
      this.oferta = "S";
    }
  }

  public void setAlb_fact(String alb_fact) { // default ('N')
    if (alb_fact == "s" || alb_fact == "S") {
      this.alb_fact = "S";
    } else {
      this.alb_fact = "N";
    }
  }

  public void setIva(Iva iva) {
    if (iva != null) {
      this.iva = iva;
    } else {
      throw new DomainException("El iva es obligatorio");
    }
  }

  public void setTarifa(Tarifa tarifa) {
    if (tarifa != null) {
      this.tarifa = tarifa;
    } else {
      throw new DomainException("La tarifa es obligatoria");
    }
  }

  public void setFormaPago(FormaPago formaPago) {
    if (formaPago != null) {
      this.formaPago = formaPago;
    } else {
      throw new DomainException("La forma de pago es obligatoria");
    }
  }

  @Override
  public String toString() {
    return "Cliente [cod_cli=" + cod_cli + ", razon_social=" + razon_social + ", telf=" + telf + ", direccion="
        + direccion + ", oferta=" + oferta + ", alb_fact=" + alb_fact + ", iva=" + iva + ", tarifa=" + tarifa
        + ", formaPago=" + formaPago + "]";
  }

}
