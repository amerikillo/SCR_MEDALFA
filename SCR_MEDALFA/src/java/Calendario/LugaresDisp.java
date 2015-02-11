/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Calendario;

import Clases.ConectionDB;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

/**
 *
 * @author Amerikillo
 */
public class LugaresDisp {

    ConectionDB con = new ConectionDB();
    String horas[][] = new String[][]{
        {"06:30:00.0", "0"},
        {"07:00:00.0", "1"},
    {"07:30:00.0", "2"},
    {"08:00:00.0", "3"},
    {"08:30:00.0", "4"},
    {"09:00:00.0", "5"},
    {"09:30:00.0", "6"},
    {"10:00:00.0", "7"},
    {"10:30:00.0", "8"},
    {"11:00:00.0", "9"},
    {"11:30:00.0", "10"},
    {"12:00:00.0", "11"},
    {"12:30:00.0", "12"},
    {"13:00:00.0", "13"},
    {"13:30:00.0", "14"},
    {"14:00:00.0", "15"},
    {"14:30:00.0", "16"},
    {"15:00:00.0", "17"},
    {"15:30:00.0", "18"},
    {"16:00:00.0", "19"},
    {"16:30:00.0", "20"},
    {"17:00:00.0", "21"},
    {"17:30:00.0", "22"},
    {"18:00:00.0", "23"},
    {"18:30:00.0", "24"},
    {"19:00:00.0", "25"},
    {"19:30:00.0", "26"},
    {"20:00:00.0", "27"},
    {"20:30:00.0", "28"},
    {"21:00:00.0", "29"},
    {"21:30:00.0", "30"},
    {"22:00:00.0", "31"},
    {"22:30:00.0", "32"},
    {"23:00:00.0", "33"},
    {"23:30:00.0", "34"}
    };

    public ArrayList devuelveLugares(String fecha) {
        ArrayList a = new ArrayList();
        DateFormat df3 = new SimpleDateFormat("yyyy-MM-dd");
        DateFormat df2 = new SimpleDateFormat("HH:mm:ss");
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String tabla[][] = new String[dameConsultorios()][48];
        try {
            con.conectar();
            try {
                int renglon = 0;
                ResultSet rset = con.consulta("select url from eventos group by url order by id");
                while (rset.next()) {
                    tabla[renglon][0] = rset.getString(1);
                    renglon++;
                }
                rset = con.consulta("select url, start, end from eventos");
                while (rset.next()) {
                    int reng = dameRenglon(rset.getString(1), tabla);

                    if (df3.parse(rset.getString(2)).before(df3.parse((fecha)))) {
                    } else {
                        if (df3.parse((fecha)).before(df3.parse(rset.getString(2)))) {
                        } else {
                            String fec1[] = rset.getString(2).split(" ");
                            String fec2[] = rset.getString(3).split(" ");

                            String horaIni = fec1[1];
                            String horaFin = fec2[1];

                            for (int i = 0; i < 34; i++) {
                                if (horaFin.equals(horas[i][0])) {
                                    tabla[reng][i - 1] = "FinalizaEvento";
                                }
                            }
                            try {
                                for (int i = 0; i < 34; i++) {
                                    if (horaIni.equals(horas[i][0])) {
                                        if (tabla[reng][i] == null) {
                                            tabla[reng][i] = "IniciaEvento";
                                            int j = i + 1;

                                            while (tabla[reng][j] == null) {
                                                tabla[reng][j] = "ContinuaEvento";
                                                j++;
                                            }
                                        }
                                    }
                                }
                            } catch (Exception e) {
                                System.out.println("Error en: " + e.getMessage());
                            }
                        }
                    }
                }

                imprimeTabla(tabla);
                String f_actual = df3.format(new Date());
                if (f_actual.equals(fecha)) {
                    String hora = df2.format(new Date());
                    a = lugaresDisponibles(tabla, fecha, hora,1);
                } else {
                    a = lugaresDisponibles(tabla, fecha, "05:00:00",1);
                }
            } catch (Exception e) {
            }
            con.cierraConexion();
        } catch (Exception e) {
        }
        return a;
    }

    public int dameConsultorios() {
        int i = 0;
        try {
            con.conectar();
            try {
                ResultSet rset = con.consulta("select url from eventos group by url order by id");
                while (rset.next()) {
                    i++;
                }
            } catch (Exception e) {
            }
            con.cierraConexion();
        } catch (Exception e) {
        }
        return i;
    }

    public void imprimeTabla(String tabla[][]) {
        for (int i = 0; i < dameConsultorios(); i++) {
            for (int j = 0; j < 48; j++) {
                System.out.print("[" + tabla[i][j] + "]");
            }
            System.out.println("");
        }
    }

    public int dameRenglon(String nombre, String tabla[][]) {
        int r = 0;
        for (int i = 0; i < dameConsultorios(); i++) {
            if (nombre.equals(tabla[i][0])) {
                r = i;
            }
        }
        return r;
    }

    public String dameHora(int i) {
        String hora = "";
        for (int k = 0; k < 34; k++) {
            if (i == Integer.parseInt(horas[k][1])) {
                hora = horas[k - 1][0];
            }
        }
        return hora;
    }

    public ArrayList lugaresDisponibles(String tabla[][], String fecha, String hora,int num) {

        ArrayList a = new ArrayList();
        DateFormat df3 = new SimpleDateFormat("yyyy-MM-dd");
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        int numLibres = 0;
        for (int i = 0; i < 48; i++) {
            for (int j = 0; j < dameConsultorios(); j++) {
                try {
                    if (tabla[j][i] == null) {
                        String nuevaHora = dameHora(i+num);
                        String horaActual = (fecha + " " + hora);
                        String diaActual = (fecha) + " " + nuevaHora;
                        if (df.parse(diaActual).after(df.parse(horaActual))) {
                            System.out.println("Consultorio:" + j + " pertenece a:  " + tabla[j][0] + " hora " + nuevaHora);
                            a.add("Consultorio: " + j + "," + tabla[j][0] + "," + nuevaHora);
                            numLibres++;
                        }
                    }
                } catch (Exception e) {
                    System.out.println("Error en consultorio" + e.getMessage());
                }
                if (numLibres == 8) {
                    break;
                }
            }
            if (numLibres == 8) {
                break;
            }
        }
        return a;
    }
}
