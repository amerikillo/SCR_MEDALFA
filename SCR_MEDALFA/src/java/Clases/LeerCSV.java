/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Clases;

import java.io.BufferedReader;
import java.io.FileReader;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

/**
 *
 * @author Amerikillo
 */
public class LeerCSV {

    DateFormat df3 = new SimpleDateFormat("dd/MM/yyyy");
    DateFormat df2 = new SimpleDateFormat("yyyy-MM-dd");
    ConectionDB con = new ConectionDB();

    public boolean leeCSV(String ruta, String nombre) {
        String csvFile = ruta + "abastos/" + nombre;
        BufferedReader br = null;
        String line = "";
        String cvsSplitBy = ",";
        try {
            con.conectar();
            try {
                con.insertar("delete from carga_abasto");
            } catch (SQLException ex) {
                System.out.println(ex.getMessage());
            }
            try {
                br = new BufferedReader(new FileReader(csvFile));
                while ((line = br.readLine()) != null) {
                    // use comma as separator
                    String inserta = "insert into carga_abasto values (";
                    String[] linea = line.split(cvsSplitBy);
                    for (int i = 0; i < linea.length; i++) {
                        if (i != 1) {
                            if (i == 3) {
                                String cadu = df2.format(df3.parse(linea[i]));
                                inserta = inserta + " '" + cadu.trim() + "' , ";
                            } else {
                                if (i == linea.length - 1) {
                                    inserta = inserta + " '" + linea[i].trim() + "' ) ";
                                } else {
                                    inserta = inserta + " '" + linea[i].trim() + "' , ";
                                }
                            }
                        }
                    }
                    con.insertar(inserta);
                }
            } catch (Exception e) {
                return false;
            }
            con.cierraConexion();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return true;
    }
}
