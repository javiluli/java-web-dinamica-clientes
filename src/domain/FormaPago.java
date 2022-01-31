package domain;

import exceptions.DomainException;
import util.Validator;

public class FormaPago {
  private String  codigo;      // varchar (10) primary key
  private int     numero_vtos; // number (3) not null
  private Integer dias;        // number (6) default 0

  public FormaPago() {
  }

  public FormaPago(String codigo, int numero_vtos, Integer dias) {
    this.codigo = codigo;
    this.numero_vtos = numero_vtos;
    this.dias = dias;
  }

  public FormaPago(String codigo) {
    this.codigo = codigo;
  }

  public String getCodigo() {
    return codigo;
  }

  public int getNumero_vtos() {
    return numero_vtos;
  }

  public Integer getDias() {
    return dias;
  }

  public void setCodigo(String codigo) {
    if (codigo != null) {
      codigo = codigo.trim();
      if (Validator.length(codigo, 1, 10)) {
        this.codigo = codigo;
      } else {
        throw new DomainException("La longitud del codigo de la forma de pago no es correcta [1-10]");
      }
    } else {
      throw new DomainException("El codigo de la forma de pago es obligatorio");
    }
  }

  public void setNumero_vtos(int numero_vtos) {
    if (numero_vtos > 0 && Validator.lengthInteger(numero_vtos) <= 3) {
      this.numero_vtos = numero_vtos;
    } else {
      throw new DomainException("El numero de vencimientos no es correcto [1-999]");
    }
  }

  public void setDias(Integer dias) {
    if (dias == null) {
      this.dias = null;
    } else {
      if (dias.intValue() >= 0) {
        if (Validator.lengthInteger(dias.intValue()) <= 6) {
          this.dias = dias;
        } else {
          throw new DomainException("El dia de la forma de pago no es correcto [1-999999]");
        }
      } else
        throw new DomainException("El dia de la forma debe ser 0 o mayor");
    }
  }

  @Override
  public String toString() {
    return "FormasPago [codigo=" + codigo + ", numero_vtos=" + numero_vtos + ", dias=" + dias + "]";
  }

}
