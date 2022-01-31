package domain;

import exceptions.DomainException;
import util.Validator;

public class Iva {

  private String cod_iva;  // varchar (10) primary key
  private double tipo_iva; // number (10,3) not null

  // constructores por defecto
  public Iva() {
  }

  // constructor completo
  public Iva(String cod_iva, double tipo_iva) {
    this.cod_iva = cod_iva;
    this.tipo_iva = tipo_iva;
  }

  // Constructor con solo la PK
  public Iva(String cod_iva) {
    this.cod_iva = cod_iva;
  }

  // Getters
  public String getCod_iva() {
    return cod_iva;
  }

  public double getTipo_iva() {
    return tipo_iva;
  }

  // Setters
  public void setCod_iva(String cod_iva) {
    if (cod_iva != null) {
      cod_iva = cod_iva.trim();
      if (Validator.length(cod_iva, 1, 10)) {
        this.cod_iva = cod_iva;
      } else {
        throw new DomainException("La longitud del codigo IVA no es correcta [1-10]");
      }
    } else {
      throw new DomainException("El codigo de IVA es obligatorio");
    }
  }

  public void setTipo_iva(double tipo_iva) {
    if (tipo_iva > 0) {
      if (Validator.lengthDecimal(tipo_iva, 10, 3)) {
        this.tipo_iva = tipo_iva;
      } else {
        throw new DomainException("El tipo de IVA no es correcto [9999999.999]");
      }
    } else {
      throw new DomainException("El tipo de IVA debe ser mayor a 0");
    }
  }

  @Override
  public String toString() {
    return "Ivas [cod_iva=" + cod_iva + ", tipo_iva=" + tipo_iva + "]";
  }

}
