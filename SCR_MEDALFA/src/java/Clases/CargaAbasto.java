/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.sql.ResultSet;

/**
 *
 * @author Amerikillo
 */
public class CargaAbasto {

    ConectionDB con = new ConectionDB();

    public String cargaAbasto(String cla_uni, String id_usu, String fol_abasto) {
        String mensaje;
        if (!buscaAbasto(fol_abasto)) {
            try {
                con.conectar();
                try {
                    
                    ResultSet rset = con.consulta("select * from carga_abasto");
                    while (rset.next()) {
                        String det_pro = comparaInsumo(rset.getString(1), rset.getString(2), rset.getString(3), rset.getString(5));
                        String CB = comparaCB(rset.getString(1), rset.getString(2), rset.getString(3), rset.getString(6));
                        if (CB.equals("0")){
                        System.out.println("CB"+CB);
                        insertaInexistenteCB(rset.getString(6),rset.getString(1),rset.getString(2),rset.getString(3));
                        }
                        if (inventarioInicial()) {
                            insertaInexistente(det_pro, rset.getInt(4), cla_uni, fol_abasto, id_usu);
                        } else {
                            /*
                             * Para insumo nuevo
                             */
                            if (det_pro.equals("NA")) {
                                //System.out.println("inexistente");
                                insertaInexistente(det_pro, rset.getInt(4), cla_uni, fol_abasto, id_usu);
                            } /*
                             * Para insumo existente
                             */ else {
                                //System.out.println("existente");
                                insertaExistente(det_pro, rset.getInt(4), cla_uni, fol_abasto, id_usu);
                            }
                        }
                    }
                    mensaje = "Abasto cargado con Exito";
                } catch (Exception e) {
                    mensaje = e.getMessage();
                }
                con.cierraConexion();
            } catch (Exception e) {
                mensaje = e.getMessage();
            }
        } else {
            mensaje = "Abasto ya existente";
        }
        return mensaje;
    }

    public String comparaInsumo(String clave, String lote, String cadu, String origen) {
        String det_pro = "NA";
        try {
            con.conectar();
            try {
                ResultSet rset = con.consulta("select det_pro from detalle_productos where cla_pro = '" + clave + "' and lot_pro = '" + lote + "' and cad_pro = '" + cadu + "' and id_ori = '" + origen + "'  ");
                while (rset.next()) {
                    det_pro = rset.getString("det_pro");
                    System.out.println(det_pro);
                }
            } catch (Exception e) {
            }
            con.cierraConexion();
        } catch (Exception e) {
        }
        if (det_pro.equals("NA")) {
            creaDetalleProducto(clave, lote, cadu, origen);
            try {
                con.conectar();
                try {
                    ResultSet rset = con.consulta("select det_pro from detalle_productos where cla_pro = '" + clave + "' and lot_pro = '" + lote + "' and cad_pro = '" + cadu + "' and id_ori = '" + origen + "'  ");
                    while (rset.next()) {
                        det_pro = rset.getString("det_pro");
                    }
                } catch (Exception e) {
                }
                con.cierraConexion();
            } catch (Exception e) {
            }
        }
        return det_pro;
    }

    public String comparaCB(String clave, String lote, String cadu, String cb) {
        int cont = 0;
        String CB="0";
        try {
            con.conectar();
            try {
                ResultSet rset = con.consulta("select * from tb_codigob where f_cb='"+cb+"' and F_Clave='"+clave+"' and F_Lote='"+lote+"' and F_Cadu='"+cadu+"'");
                while (rset.next()) {
                cont++;    
                }
                CB = Integer.toString(cont);
            } catch (Exception e) {
            }
            con.cierraConexion();
        } catch (Exception e) {
        }
        
        return CB;
    }
    
    
    public void insertaInexistente(String det_pro, int cant, String cla_uni, String fol_abasto, String id_usu) {
        try {
            con.conectar();
            try {
                con.insertar("insert into inventario values (CURDATE(), '" + cla_uni + "', '" + det_pro + "', '" + cant + "', '0', '0')");
                con.insertar("insert into kardex values ('0', '0', '" + det_pro + "', '" + cant + "', 'CARGA DE ABASTO', '" + fol_abasto + "', CURDATE(), 'CARGA DE ABASTO', '" + id_usu + "', '0');");
            } catch (Exception e) {
            }
            con.cierraConexion();
        } catch (Exception e) {
        }
    }
    public void insertaInexistenteCB(String cb, String clave, String lote, String cadu) {
        try {
            con.conectar();
            try {
                con.insertar("insert into tb_codigob  values (0, '" + cb + "', '" + clave + "', '" + lote + "', '"+cadu+"')");                
            } catch (Exception e) {
            }
            con.cierraConexion();
        } catch (Exception e) {
        }
    }

    public void insertaExistente(String det_pro, int cant, String cla_uni, String fol_abasto, String id_usu) {
        int cant1 = 0;
        int cantf = 0;
        String dpro="";
        try {
            con.conectar();
            try {
                ResultSet rset = con.consulta("select cant,det_pro from inventario where det_pro = '" + det_pro + "'");
                while (rset.next()) {
                    cant1 = rset.getInt(1);
                    dpro = rset.getString(2);
                }
                if (dpro !=""){
                cantf = cant1 + cant;
                con.insertar("update inventario set cant = '" + cantf + "' where det_pro = '" + det_pro + "' ");
                }else{
                    con.insertar("insert into inventario values (curdate(), '"+cla_uni+"', '" + det_pro + "', '" + cant + "', 0, '0');");
                }

                con.insertar("insert into kardex values ('0', '0', '" + det_pro + "', '" + cant + "', 'CARGA DE ABASTO', '" + fol_abasto + "', CURDATE(), 'CARGA DE ABASTO', '" + id_usu + "', '0');");
            } catch (Exception e) {
            }
            con.cierraConexion();
        } catch (Exception e) {
        }
    }

    public boolean inventarioInicial() {
        int renglones = 0;
        try {
            con.conectar();
            try {
                ResultSet rset = con.consulta("select count(*) from inventario_inicial");
                while (rset.next()) {
                    renglones = rset.getInt(1);
                }
            } catch (Exception e) {
            }
            con.cierraConexion();
        } catch (Exception e) {
        }
        if (renglones == 0) {
            return false;
        } else {
            return true;
        }
    }

    public String creaDetalleProducto(String clave, String lote, String cadu, String ori) {
        try {
            con.conectar();
            try {
                con.insertar("insert into detalle_productos values('0', '" + clave + "', '" + lote + "', '" + cadu + "', '1', '" + ori + "', '0')");
            } catch (Exception e) {
            }
            con.cierraConexion();
        } catch (Exception e) {
        }
        return "a";
    }

    public boolean buscaAbasto(String abasto) {
        boolean existe = false;
        try {
            con.conectar();
            try {
                ResultSet rset = con.consulta("select id_kardex from kardex where fol_aba = '" + abasto + "' ");
                while (rset.next()) {
                    existe = true;
                    break;
                }
            } catch (Exception e) {
            }
            con.cierraConexion();
        } catch (Exception e) {
        }
        return existe;
    }

}
