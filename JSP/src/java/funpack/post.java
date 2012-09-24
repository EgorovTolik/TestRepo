/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package funpack;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Класс отвечает за работу с таблицей POST
 * @author EgorovTolik
 */
public class post {
    static Connection Con = null;
    //static ResultSetMetaData MetaData = null;
    static PreparedStatement ps = null;
    static Statement stmt = null;
    static ResultSet result = null;
    
    private static final Logger logger = Logger.getLogger(post.class.getSimpleName());
    
    static final String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
    static final String name = "root";
    static final String pass = "root";
    
    static final String TAB = "POST";
    static final String F1 = "ID";
    static final String F2 = "NAME";
    
    public static void add(String Name) {
        try {
            String insert = "INSERT INTO "+TAB+" VALUES (SQ.NEXTVAL, ?)";
            DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            Con = DriverManager.getConnection(url,name,pass);
            
            ps = Con.prepareStatement(insert);
            
            ps.setString(1, Name); ps.executeUpdate(); Con.close();
        } catch (Exception ex) {Logger.getLogger(post.class.getName()).log(Level.SEVERE, null, ex);}
    }
    /**
     * Метод для получения полной информации из таблицы POST
     * @return 
     */
    public static List get() {
        String query = "SELECT * FROM "+TAB;
        List list = new ArrayList();
        try {
            DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            Con = DriverManager.getConnection(url,name,pass);
            stmt = Con.createStatement();
            result = stmt.executeQuery(query);
            while(result.next()) {
                list.add(result.getString(F1));
                list.add(result.getString(F2));
            }
            Con.close();
        } catch (Exception ex) {Logger.getLogger(post.class.getName()).log(Level.SEVERE, null, ex);}
        return list;
    }
    
    public static void del(String pID){
        String query = null;
        try { 
            DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            Con = DriverManager.getConnection(url,name,pass);
            stmt = Con.createStatement();
            query = "UPDATE WORKER SET POST_ID = NULL WHERE POST_ID = "+pID;
            stmt.executeQuery(query);
            
            query = "DELETE "+TAB+" WHERE "+F1+" = "+pID;
            stmt.executeQuery(query);
            Con.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
    }
    
    public static String getFirstID(){//JOptionPane.showMessageDialog(null, "getFirstID");
        String query = "SELECT MIN("+F1+") "+F1+" FROM "+TAB;
        String res = null;
        try { 
            DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            Con = DriverManager.getConnection(url,name,pass);
            stmt = Con.createStatement();
            result = stmt.executeQuery(query);
            result.next(); res = result.getString(F1);
            Con.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
        if(res==null)res="-1";
        return res;
    }
    
    public static String getLastID(){//JOptionPane.showMessageDialog(null, "getFirstID");
        String query = "SELECT MAX("+F1+") "+F1+" FROM "+TAB;
        String res = null;
        try { 
            DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            Con = DriverManager.getConnection(url,name,pass);
            stmt = Con.createStatement();
            result = stmt.executeQuery(query);
            result.next(); res = result.getString(F1);
            Con.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
        if(res==null)res="-1";
        return res;
    }
    
    public static String getNameFoID(String pID) {//JOptionPane.showMessageDialog(null, "pID = "+pID);
        String query = "SELECT "+F2+" FROM "+TAB+" WHERE "+F1+" = "+pID;
        String res = null;
        try { 
            DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            Con = DriverManager.getConnection(url,name,pass);
            stmt = Con.createStatement();
            result = stmt.executeQuery(query);
            result.next(); res=result.getString(F2);
            Con.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
        if(res==null)res="-1";
        return res;
    }
    
    public static void upd(String pID, String pName) {
        try {
            String change = "UPDATE "+TAB+" SET"+
                    " "+F2+" = \'"+pName+"\'"+
                    " WHERE "+F1+" = "+pID;

            DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            Con = DriverManager.getConnection(url,name,pass);
            stmt = Con.createStatement(); stmt.executeQuery(change);
            Con.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
    }
}