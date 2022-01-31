package util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import exceptions.ServiceException;

public class Teclado {
  private static BufferedReader stdin = new BufferedReader(new InputStreamReader(System.in));

  public double leerNumero() throws ServiceException {
    String Input;
    double numero;
    try {
      Input = stdin.readLine();
    } catch (IOException e) {
      throw new ServiceException(e.getMessage(), e);
    }
    numero = Double.parseDouble(Input);
    return numero;
  }

  public int leerEntero() throws ServiceException {
    int entero;
    String Input;
    try {
      Input = stdin.readLine();
    } catch (IOException e) {
      throw new ServiceException(e.getMessage(), e);
    }
    entero = Integer.parseInt(Input);
    return entero;
  }

  public String leerCadena() throws ServiceException {
    String Input;
    try {
      Input = stdin.readLine();
    } catch (IOException e) {
      throw new ServiceException(e.getMessage(), e);
    }
    return Input;
  }

}