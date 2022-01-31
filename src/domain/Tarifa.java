package domain;

import exceptions.DomainException;
import util.Validator;

public class Tarifa {
  private String cod_tarifa;  // varchar (10) primary key
  private String descripcion; // varchar (50) not null

  public Tarifa() {
  }

  public Tarifa(String cod_tarifa, String descripcion) {
    this.cod_tarifa = cod_tarifa;
    this.descripcion = descripcion;
  }

  public Tarifa(String cod_tarifa) {
    this.cod_tarifa = cod_tarifa;
  }

  public String getCod_tarifa() {
    return cod_tarifa;
  }

  public String getDescripcion() {
    return descripcion;
  }

  public void setCod_tarifa(String cod_tarifa) {
    if (cod_tarifa != null) {
      cod_tarifa = cod_tarifa.trim();
      if (Validator.length(cod_tarifa, 1, 10)) {
        this.cod_tarifa = cod_tarifa;
      } else {
        throw new DomainException("La longitud del codigo de tarifa no es correcta [1-10]");
      }
    } else {
      throw new DomainException("El codigo de tarifa es obligatorio");
    }
  }

  public void setDescripcion(String descripcion) {
    if (descripcion != null) {
      descripcion = descripcion.trim();
      if (Validator.length(descripcion, 5, 50)) { // minimo 5 caracteres
        this.descripcion = descripcion;
      } else {
        throw new DomainException("La longitud de la descripcion de la tarifa no es correcta [5-50]");
      }
    } else {
      throw new DomainException("La descripcion de la tarifa es obligatoria");
    }
  }

  @Override
  public String toString() {
    return "Tarifas [cod_tarifa=" + cod_tarifa + ", descripcion=" + descripcion + "]";
  }

}
