package recursos;

public class DBQuery {

  // IVA
  private static final String SELECT_IVA      = "SELECT cod_iva, tipo_iva FROM ivas WHERE cod_iva = ?";
  private static final String SELECT_ALL_IVAS = "SELECT cod_iva, tipo_iva FROM ivas";
  private static final String INSERT_IVA      = "INSERT INTO ivas (cod_iva, tipo_iva) VALUES (?, ?)";
  private static final String UPDATE_IVA      = "UPDATE ivas SET tipo_iva = ? WHERE cod_iva = ?";
  private static final String DELETE_IVA      = "DELETE FROM ivas WHERE cod_iva = ?";

  // Tarifa
  private static final String SELECT_TARIFA      = "SELECT cod_tarifa, descripcion FROM tarifas WHERE cod_tarifa = ?";
  private static final String SELECT_ALL_TARIFAS = "SELECT cod_tarifa, descripcion FROM tarifas";
  private static final String INSERT_TARIFA      = "INSERT INTO tarifas (cod_tarifa, descripcion) VALUES (?, ?)";
  private static final String UPDATE_TARIFA      = "UPDATE tarifas SET descripcion = ? WHERE cod_tarifa = ?";
  private static final String DELETE_TARIFA      = "DELETE FROM tarifas WHERE cod_tarifa = ?";

  // FormaPago
  private static final String SELECT_FORMAPAGO      = "SELECT codigo, numero_vtos, dias FROM formas_pago WHERE codigo = ?";
  private static final String SELECT_ALL_FORMASPAGO = "SELECT codigo, numero_vtos, dias FROM formas_pago";
  private static final String INSERT_FORMAPAGO      = "INSERT INTO formas_pago (codigo, numero_vtos, dias) VALUES (?, ?, ?)";
  private static final String UPDATE_FORMAPAGO      = "UPDATE formas_pago SET numero_vtos = ?, dias = ? WHERE codigo = ?";
  private static final String DELETE_FORMAPAGO      = "DELETE FROM formas_pago WHERE codigo = ?";

  // Cliente
  private static final String SELECT_CLIENTE                = "SELECT cod_cli, razon_social, telf, direccion, oferta, alb_fact, cod_iva, cod_tarifa, forma_pago codigo FROM clientes WHERE cod_cli = ?";
  private static final String SELECT_ALL_CLIENTES           = "SELECT cod_cli, razon_social, telf, direccion, oferta, alb_fact, cod_iva, cod_tarifa, forma_pago codigo FROM clientes";
  private static final String SELECT_ALL_CLIENTES_CONOFERTA = "SELECT cod_cli, razon_social, telf, direccion, oferta, alb_fact, cod_iva, cod_tarifa, forma_pago codigo FROM clientes WHERE oferta = 'S'";
  private static final String SELECT_ALL_CLIENTES_SINOFERTA = "SELECT cod_cli, razon_social, telf, direccion, oferta, alb_fact, cod_iva, cod_tarifa, forma_pago codigo FROM clientes WHERE oferta = 'N'";

  // recuepra un cliente con los codigos de sus tablas agenas y los datos
  // asociados a las columnas de las tablas
  private static final String SELECT_ALL_CLIENTE_COMPLETO = "SELECT c.cod_cli, c.razon_social, c.telf, c.direccion, c.oferta, c.alb_fact, i.cod_iva, i.tipo_iva, t.cod_tarifa, t.descripcion, fp.codigo COD_FORMAPAGO, fp.numero_vtos NUM_VOTOS, fp.dias DIAS"
      + "                                                    FROM clientes c, ivas i, tarifas t, formas_pago fp"
      + "                                                    WHERE c.cod_iva = i.cod_iva AND c.cod_tarifa = t.cod_tarifa AND c.forma_pago = fp.codigo"
      + "                                                    ORDER BY c.razon_social";

  private static final String INSERT_CLIENTE = "INSERT INTO clientes (cod_cli,"
      + "                                                                  razon_social,"
      + "                                                                  telf,"
      + "                                                                  direccion,"
      + "                                                                  oferta,"
      + "                                                                  alb_fact,"
      + "                                                                  cod_iva,"
      + "                                                                  cod_tarifa,"
      + "                                                                  forma_pago) VALUES (? ,? ,? ,? ,? ,? ,? ,? ,?)";
  private static final String UPDATE_CLIENTE = "UPDATE clientes SET razon_social = ?,"
      + "                                                                telf = ?,"
      + "                                                                direccion = ?,"
      + "                                                                oferta =  ?,"
      + "                                                                alb_fact =  ?,"
      + "                                                                cod_iva = ?,"
      + "                                                                cod_tarifa = ?,"
      + "                                                                forma_pago = ? WHERE cod_cli = ?";

  private static final String ModificarClienteConcurrente = "UPDATE clientes SET razon_social = ?,"
      + "                                                                        telf = ?,"
      + "                                                                        direccion = ?,"
      + "                                                                        oferta = ?,"
      + "                                                                        alb_fact = ?,"
      + "                                                                        cod_iva = ?,"
      + "                                                                        cod_tarifa = ?, "
      + "                                                                        forma_pago = ? "
      + "                                                                    WHERE cod_cli= ? AND "
      + "                                                                        razon_social = ? AND "
      + "                                                                        NVL(telf,'null') = ? AND "
      + "                                                                        direccion = ? AND "
      + "                                                                        oferta = ? AND "
      + "                                                                        alb_fact =?  AND "
      + "                                                                        cod_iva = ? AND "
      + "                                                                        cod_tarifa = ? AND "
      + "                                                                        forma_pago = ? ";
  private static final String DELETE_CLIENTE              = "DELETE clientes WHERE cod_cli = ?";

  // Get Query IVA

  public static String getSelectIva() {
    return SELECT_IVA;
  }

  public static String getSelectAllIvas() {
    return SELECT_ALL_IVAS;
  }

  public static String getInsertIva() {
    return INSERT_IVA;
  }

  public static String getUpdateIva() {
    return UPDATE_IVA;
  }

  public static String getDeleteIva() {
    return DELETE_IVA;
  }

  // Get Query Tarifa

  public static String getSelectTarifa() {
    return SELECT_TARIFA;
  }

  public static String getSelectAllTarifas() {
    return SELECT_ALL_TARIFAS;
  }

  public static String getInsertTarifas() {
    return INSERT_TARIFA;
  }

  public static String getUpdateTarifas() {
    return UPDATE_TARIFA;
  }

  public static String getDeleteTarifas() {
    return DELETE_TARIFA;
  }

  // Get Query FormaPago

  public static String getSelectFormaPago() {
    return SELECT_FORMAPAGO;
  }

  public static String getSelectAllFormasPago() {
    return SELECT_ALL_FORMASPAGO;
  }

  public static String getInsertFormaPago() {
    return INSERT_FORMAPAGO;
  }

  public static String getUpdateFormaPago() {
    return UPDATE_FORMAPAGO;
  }

  public static String getDeleteFormaPago() {
    return DELETE_FORMAPAGO;
  }

  // Get Query Cliente

  public static String getSelectCliente() {
    return SELECT_CLIENTE;
  }

  public static String getSelectAllClientes() {
    return SELECT_ALL_CLIENTES;
  }

  public static String getSelectAllClientesConOferta() {
    return SELECT_ALL_CLIENTES_CONOFERTA;
  }

  public static String getSelectAllClientesSinOferta() {
    return SELECT_ALL_CLIENTES_SINOFERTA;
  }

  public static String getSelectAllClienteCompleto() {
    return SELECT_ALL_CLIENTE_COMPLETO;
  }

  public static String getInsertCliente() {
    return INSERT_CLIENTE;
  }

  public static String getUpdateCliente() {
    return UPDATE_CLIENTE;
  }

  public static String getModificarClienteConcurrente() {
    return ModificarClienteConcurrente;
  }

  public static String getDeleteCliente() {
    return DELETE_CLIENTE;
  }

}
