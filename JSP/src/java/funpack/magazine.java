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
 * Класс отвечает за работу с таблицей MAGAZINE
 * @author EgorovTolik
 */
public class magazine {
    static Connection Con = null;
    //static ResultSetMetaData MetaData = null;
    static PreparedStatement ps = null;
    static Statement stmt = null;
    static ResultSet result = null;
    
    private static final Logger logger = Logger.getLogger(magazine.class.getSimpleName());
    
    static final String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe";
    static final String name = "root";
    static final String pass = "root";
    
    static final String TAB = "MAGAZINE";
    static final String F1 = "ID";
    static final String F2 = "NAME";
    static final String F3 = "START_DATE";
    static final String F4 = "COUNT_MAG";
    static final String F5 = "COUNT_PAGE";
    static final String F6 = "COMM";
    static final String F7 = "CATEGORY_ID";
    /**
     * Метод добавляет запись в таблицу MAGAZINE
     * @param Name Название журнала
     */
    public static void add(String pName, String pPage, String pComm, String pCategory, Connection pCon) {
        try {
            /*JOptionPane.showMessageDialog(null, insert);
            JOptionPane.showMessageDialog(null, pName);*/
SimpleDateFormat formatter1 = new SimpleDateFormat("dd.MM.yyyy");
String date_time = formatter1.format(new java.util.Date());
            String insert = "INSERT INTO "+TAB+
                    " VALUES (SQ.NEXTVAL, ?, to_date('"+date_time+"','dd.mm.yyyy'), 0, ?, ?, ?)";

            //DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            //Con = DriverManager.getConnection(url,name,pass);

            ps = pCon.prepareStatement(insert);
            ps.setString(1, pName);
            //ps.setString(2, date_time);
            ps.setString(2, pPage);
            ps.setString(3, pComm);
            ps.setString(4, pCategory);
            ps.executeUpdate();
            //Con.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
    }
    /**
     * Метод для получения полной информации из таблицы MAGAZINE
     * @return 
     */
    public static List get(Connection pCon) {
        String query = "SELECT * FROM "+TAB;
        List list = new ArrayList();
        try { //list=misc.executeQuery(query);
            //DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            //Con = DriverManager.getConnection(url,name,pass);
            stmt = pCon.createStatement();
            result = stmt.executeQuery(query);
            while(result.next()) {
                list.add(result.getString(F1));
                list.add(result.getString(F2));
                list.add(result.getDate(F3).toString());
                list.add(result.getString(F4));
                list.add(result.getString(F5));
                list.add(result.getString(F6));
                list.add(result.getString(F7));
            }
            //Con.close();
            stmt.close(); result.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
        return list;
    }
    
    public static List getForCBox(Connection pCon) {
        String query = "SELECT * FROM "+TAB+" ORDER BY "+F1;
        List list = new ArrayList();
        try {
            //DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            //Con = DriverManager.getConnection(url,name,pass);
            stmt = pCon.createStatement();
            result = stmt.executeQuery(query);
            while(result.next()) {
                list.add(result.getString(F1));
                list.add(result.getString(F2));
            }
            //Con.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
        return list;
    }
    
    public static List getForList(Connection pCon) {
        String query = "SELECT r.magazine_id "+F1+", mag.Name \""+F2+"\", count(*) \"COUNT\""+
            " FROM \"RELEASE\" r, magazine mag"+
            " WHERE r.magazine_id = mag.id"+
            " GROUP BY r.magazine_id, mag.Name"+
            " ORDER BY "+F1;
        List list = new ArrayList();
        try { //list=misc.executeQuery(query);
            //DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            //Con = DriverManager.getConnection(url,name,pass);
            stmt = pCon.createStatement();
            result = stmt.executeQuery(query);
            while(result.next()) {
                list.add(result.getString(F1));
                list.add(result.getString(F2));
                list.add(result.getString("COUNT"));
            }
            //Con.close();
            stmt.close(); result.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
        return list;
    }
    
    public static List getLincs(Connection pCon) {
        String query = "SELECT "+F1+", "+F2+" FROM "+TAB;
        List list = new ArrayList();
        try { 
            //DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            //Con = DriverManager.getConnection(url,name,pass);
            stmt = pCon.createStatement();
            result = stmt.executeQuery(query);
            while(result.next()) {
                list.add("magazine.jsp?mag_id="+result.getString(F1));
                list.add(result.getString(F2));
            }
            //Con.close();
            stmt.close(); result.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
        return list;
    }
    
    public static List getFoID(String pID, Connection pCon) {//JOptionPane.showMessageDialog(null, "pID = "+pID);
        String query = "SELECT * FROM "+TAB+" WHERE "+F1+" = "+pID;
        List list = new ArrayList();
        try { 
            //JOptionPane.showMessageDialog(null, query);
            //DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            //Con = DriverManager.getConnection(url,name,pass);
            stmt = pCon.createStatement();
            result = stmt.executeQuery(query);
            while(result.next()) {
                //list.add(result.getString(F1));
                list.add(result.getString(F2));//1
                list.add(result.getDate(F3).toString());//2
                list.add(result.getString(F4));//3
                list.add(result.getString(F5));//4
                list.add(result.getString(F7));//6
                list.add(result.getString(F6));//5
            }
            //Con.close();
            stmt.close(); result.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
        return list;
    }
    
    public static String getNameFoID(String pID, Connection pCon) {//JOptionPane.showMessageDialog(null, "pID = "+pID);
        String query = "SELECT "+F2+" FROM "+TAB+" WHERE "+F1+" = "+pID;
        String res = "";
        try { 
            //DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            //Con = DriverManager.getConnection(url,name,pass);
            stmt = pCon.createStatement();
            result = stmt.executeQuery(query);
            result.next(); res=result.getString(F2);
            //Con.close();
            stmt.close(); result.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
        return res;
    }
    
    public static String getFirstID(Connection pCon){//JOptionPane.showMessageDialog(null, "getFirstID");
        String query = "SELECT MIN("+F1+") "+F1+" FROM "+TAB;
        String res = null;
        try { 
            //DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            //Con = DriverManager.getConnection(url,name,pass);
            stmt = pCon.createStatement();
            result = stmt.executeQuery(query);
            result.next(); res = result.getString(F1);
            //Con.close();
            stmt.close(); result.close();
        } catch (Exception ex) { Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
        if(res==null)res = "-1";
        return res;
    }
    
    public static String getLastID(Connection pCon){//JOptionPane.showMessageDialog(null, "getFirstID");
        String query = "SELECT MAX("+F1+") "+F1+" FROM "+TAB;
        String res = null;
        try { 
            //DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            //Con = DriverManager.getConnection(url,name,pass);
            stmt = pCon.createStatement();
            result = stmt.executeQuery(query);
            result.next(); res = result.getString(F1);
            //Con.close();
            stmt.close(); result.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
        if(res==null)res = "-1";
        return res;
    }
    
    public static void upd(String pID, String pName, String pPage, String pComm, String pCat, Connection pCon) {
        try {
            String change = "UPDATE "+TAB+" SET"+
                    " "+F2+" = \'"+pName+"\',"+
                    " "+F5+" = "+pPage+","+
                    " "+F6+" = \'"+pComm+"\',"+
                    " "+F7+" = "+pCat+
                    " WHERE "+F1+" = "+pID;
            
            //DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            //Con = DriverManager.getConnection(url,name,pass);
            stmt = pCon.createStatement(); stmt.executeQuery(change);
            //Con.close();
            stmt.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
    }
    
    public static void del(String pID, Connection pCon){
        String query1 = "DELETE RELEASE WHERE MAGAZINE_ID = "+pID;
        String query2 = "UPDATE LIST_WORKERS SET MAGAZINE_ID = NULL WHERE MAGAZINE_ID = "+pID;
        String query3 = "DELETE "+TAB+" WHERE "+F1+" = "+pID;
        try { 
            //DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
            //Con = DriverManager.getConnection(url,name,pass);
            stmt = pCon.createStatement();
            stmt.executeQuery(query1);
            stmt.executeQuery(query2);
            stmt.executeQuery(query3);
            //Con.close();
            stmt.close();
        } catch (Exception ex) {Logger.getLogger(magazine.class.getName()).log(Level.SEVERE, null, ex);}
    }
}
