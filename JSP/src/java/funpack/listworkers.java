/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package funpack;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Класс отвечает за работу с таблицей LIST_WORKERS
 * @author EgorovTolik
 */
public class listworkers {
    private static final Logger logger = Logger.getLogger(listworkers.class.getSimpleName());
    
    static final String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
    static final String name = "root";
    static final String pass = "root";
    
    public static void add(String Magazine, String Name, String salary) {
        try {
            String insert = "INSERT INTO LIST_WORKERS(id, MAGAZINE_ID, WORKER_ID, SALARY) VALUES (SQ.NEXTVAL, ?, ?, ?)";
            DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            Connection con = DriverManager.getConnection(url,name,pass);
            
            PreparedStatement ps = con.prepareStatement(insert);
            ps.setInt(1, Integer.parseInt(Magazine));
            ps.setInt(2, Integer.parseInt(Name));
            ps.setInt(3, Integer.parseInt(salary));
            ps.executeUpdate();
            con.close();
        } catch (Exception ex) {Logger.getLogger(listworkers.class.getName()).log(Level.SEVERE, null, ex);}
    }
}
