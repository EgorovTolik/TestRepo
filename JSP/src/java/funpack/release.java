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
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 * Класс отвечает за работу с таблицей RELEASE
 * @author EgorovTolik
 */
public class release {
    
    static Connection Con = null;
    //static ResultSetMetaData MetaData = null;
    static PreparedStatement ps = null;
    static Statement stmt = null;
    static ResultSet result = null;
    
    private static final Logger logger = Logger.getLogger(release.class.getSimpleName());
    
    static final String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
    static final String name = "root";
    static final String pass = "root";
    
    static final String TAB = "RELEASE";
    static final String F1 = "ID";
    static final String F2 = "NAME";
    static final String F3 = "COMM";
    static final String F4 = "MAGAZINE_ID";
    static final String F5 = "START_DATE";
    static final String F6 = "IMG_NAME";
    
    public static void add(String Name, String Comm, String Magazine, String ImgName) {
        try {
SimpleDateFormat formatter1 = new SimpleDateFormat("dd.MM.yyyy");
String date_time = formatter1.format(new java.util.Date());
            String insert = "INSERT INTO "+TAB+" VALUES (SQ.NEXTVAL, ?, ?, ?, to_date('"+date_time+"','dd.mm.yyyy'), ?)";
            
            DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            Con = DriverManager.getConnection(url,name,pass);
//JOptionPane.showMessageDialog(null, insert);      
            ps = Con.prepareStatement(insert);
            ps.setString(1, Name);
            ps.setString(2, Comm);
            ps.setInt(3, Integer.parseInt(Magazine));
            ps.setString(4, ImgName);
            ps.executeUpdate();
            insert = "UPDATE MAGAZINE SET COUNT_MAG = (SELECT COUNT_MAG+1 FROM MAGAZINE WHERE ID = "+Magazine+
                    ") WHERE ID = "+Magazine;
            stmt = Con.createStatement(); stmt.executeQuery(insert);
            Con.close();
        } catch (Exception ex) {Logger.getLogger(release.class.getName()).log(Level.SEVERE, null, ex);}
    }
    /**
     * Метод для получения полной информации из таблицы RELEASE
     * @return 
     */
    public static List get(Connection pCon) {
        String query = "SELECT * FROM "+TAB;
        List list = new ArrayList();
        try {
            //DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            //Con = DriverManager.getConnection(url,name,pass);
            stmt = pCon.createStatement();
            result = stmt.executeQuery(query);
            while(result.next()) {
                list.add(result.getString(F1));//1
                list.add(result.getString(F2));//2
                list.add(result.getString(F3));//3
                list.add(result.getString(F4));//4
                list.add(result.getDate(F5).toString());//5
                list.add(result.getString(F6));//6
            }
            //Con.close();
            stmt.close(); result.close();
        } catch (Exception ex) {Logger.getLogger(release.class.getName()).log(Level.SEVERE, null, ex);}
        return list;
    }
    /**
     * Метод для получения полной информации из таблицы RELEASE (с параметрами)
     * Way - метод получения данных (1 - По журналу; 2 - По типу журнала)
     * pID - параметр конкретизации
     * @return 
     */
    public static List get(int Way, String pID, Connection pCon) {
        String query = "SELECT * FROM "+TAB;
        switch(Way)
        {
            case 1: query = query + " WHERE "+F4+" = "+pID; break;
            case 2: query = query + " WHERE "+F4+" IN "+
                    "(SELECT ID FROM MAGAZINE WHERE CATEGORY_ID = "+pID+")"; break;
            case 3: query = query + " WHERE lower("+F2+") LIKE \'%\'||lower(\'"+pID+"\')||\'%\'"; break;
        }
        query = query + " ORDER BY "+F1;
        List list = new ArrayList();
        try {
            //DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            //Con = DriverManager.getConnection(url,name,pass);
            stmt = pCon.createStatement();
            result = stmt.executeQuery(query);
            while(result.next()) {
                list.add(result.getString(F1));//1
                list.add(result.getString(F2));//2
                list.add(result.getString(F3));//3
                list.add(result.getString(F4));//4
                list.add(result.getDate(F5).toString());//5
                list.add(result.getString(F6));//6
            }
            //Con.close();
            stmt.close(); result.close();
        } catch (Exception ex) {Logger.getLogger(release.class.getName()).log(Level.SEVERE, null, ex);}
        return list;
    }
    
    public static List getLincs(String pID, Connection pCon) {
        String query = "SELECT "+F1+", "+F2+" FROM "+TAB+" WHERE "+F4+" = "+pID;
        List list = new ArrayList();
        try {
            //JOptionPane.showMessageDialog(null, query);
            //DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            //Con = DriverManager.getConnection(url,name,pass);
            stmt = pCon.createStatement(); result = stmt.executeQuery(query);
            while(result.next()) {
                list.add("release.jsp?mag_id="+pID+"&rel_id="+result.getString(F1));
                list.add(result.getString(F2));
            }
            //Con.close();
            stmt.close(); result.close();
        } catch (Exception ex) {Logger.getLogger(release.class.getName()).log(Level.SEVERE, null, ex);}
        return list;
    }
    
    public static List getFoID(String pID, Connection pCon) {
        String query = "SELECT * FROM "+TAB+" WHERE "+F1+" = "+pID;
        List list = new ArrayList();
        try {//JOptionPane.showMessageDialog(null, query);
            //DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            //Con = DriverManager.getConnection(url,name,pass);
            stmt = pCon.createStatement(); result = stmt.executeQuery(query);
            while(result.next()) {
                list.add(result.getString(F1));//1
                list.add(result.getString(F2));//2
                list.add(result.getString(F3));//3
                list.add(result.getString(F4));//4
                list.add(result.getDate(F5).toString());//5
                list.add(result.getString(F6));//6
                /*list.add(result.getString(F2));
                list.add(result.getString(F4));
                list.add(result.getDate(F5).toString());
                list.add(result.getString(F3));*/
            }
            //Con.close();
            stmt.close(); result.close();
        } catch (Exception ex) {Logger.getLogger(release.class.getName()).log(Level.SEVERE, null, ex);}
        return list;
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
    
    public static String getFirstID(String magID){//JOptionPane.showMessageDialog(null, "getFirstID");
        String query = "SELECT MIN("+F1+") "+F1+" FROM "+TAB+" WHERE "+F4+" = "+magID;
        String res = null;
        try { 
            DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            Con = DriverManager.getConnection(url,name,pass);
            stmt = Con.createStatement();
            result = stmt.executeQuery(query);
            result.next(); res = result.getString(F1);
            Con.close(); stmt.close(); result.close();
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
            Con.close(); stmt.close(); result.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
        if(res==null)res="-1";
        return res;
    }
    
    public static void del(String pID){
        try { 
            DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            Con = DriverManager.getConnection(url,name,pass);
            stmt = Con.createStatement();
        String query = "SELECT "+F4+" WHERE "+F1+" = "+pID;
            result = stmt.executeQuery(query);
            result.next(); String MagID = result.getString(F4);
            
        query = "UPDATE MAGAZINE SET COUNT_MAG = (SELECT COUNT_MAG-1 FROM MAGAZINE WHERE ID = "+MagID+
                    ") WHERE ID = "+MagID;
            stmt.executeQuery(query);
            
        query = "DELETE "+TAB+" WHERE "+F1+" = "+pID;
            stmt.executeQuery(query);
            Con.close();
            stmt.close(); result.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
    }
    
    public static int getCountRow(String magID, Connection pCon){//JOptionPane.showMessageDialog(null, "getFirstID");
        String query = "SELECT COUNT(*) "+F1+" FROM "+TAB;
        if(magID!=null)query = query+" WHERE "+F4+" = "+magID;
        int res = -1;
        try { 
            //DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            //Con = DriverManager.getConnection(url,name,pass);
            stmt = pCon.createStatement();
            result = stmt.executeQuery(query);
            result.next(); res = result.getInt(F1);
            //Con.close();
            stmt.close(); result.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
        return res;
    }
    
    public static void upd(String pID, String pName, String pComm, String pImgName) {
        try {
            String change = "UPDATE "+TAB+" SET"+
                    " "+F2+" = \'"+pName+"\',"+
                    " "+F3+" = \'"+pComm+"\',"+
                    " "+F6+" = \'"+pImgName+"\'"+
                    " WHERE "+F1+" = "+pID;
            
            DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            Con = DriverManager.getConnection(url,name,pass);
            stmt = Con.createStatement(); stmt.executeQuery(change);
            Con.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
    }
}
