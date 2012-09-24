/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package funpack;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * В этом классе описаны некоторые общие вспомогательные функции
 * @author EgorovTolik
 */
public class misc {
    private static final Logger logger = Logger.getLogger(misc.class.getSimpleName());
    
    static final String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
    static final String name = "root";
    static final String pass = "root";
    
    public static List executeQuery(String query) {
        Statement LocalSTMT = null;
        ResultSet ReSET;
        ResultSetMetaData MetaData;
        List list = new ArrayList();
        try{
            DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            Connection con = DriverManager.getConnection(url,name,pass);
            LocalSTMT = con.createStatement();
            
            ReSET = LocalSTMT.executeQuery(query);
            MetaData = ReSET.getMetaData();
            int numberOfColumns = MetaData.getColumnCount();
            list.add(String.format("%d", numberOfColumns));
            for(int col=1;col<=numberOfColumns;col++)list.add(MetaData.getColumnLabel(col));
            
            while (ReSET.next()) {
                for(int i=1;i<=numberOfColumns;i++){
                    list.add(ReSET.getObject(i).toString());
                    logger.log(Level.INFO,ReSET.getObject(i).toString());
                }
            }
            con.close();
        } catch (Exception ex) {Logger.getLogger(misc.class.getName()).log(Level.SEVERE, null, ex);}
        return list;
    }
    
    public static Connection openCon() {
        Connection con = null;
        try{
            DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            con = DriverManager.getConnection(url,name,pass);
        } catch (Exception ex) {Logger.getLogger(misc.class.getName()).log(Level.SEVERE, null, ex);}
        return con;
    }
    
    public static void closeCon(Connection con) {
        try{ con.close();
        } catch (Exception ex) {Logger.getLogger(misc.class.getName()).log(Level.SEVERE, null, ex);}
    }
}
