/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DatabaseInterface;

import java.sql.*;

/**
 *
 * @author RobbinNi
 */
public class SQLExecutor {

    private static class Connector {
        public Connection con;
        public Statement stmt;
    
        public Connector() throws Exception {
            try {
                String userName = "acmdbu05",
                       password = "du78qt4q",
                        url = "jdbc:mysql://georgia.eng.utah.edu/acmdb05";
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                con = DriverManager.getConnection (url, userName, password);
                stmt = con.createStatement();
            } catch (Exception e) {
                System.err.println("Unable to establish mysql jdbc connection. " + e.getMessage());
                throw(e);
            }
        }
    }
        
    public static String executeQuery(String sqlQuery) throws Exception {
        Connector con = new Connector();
        String ret = "";
        ResultSet results;
        try {
            results = con.stmt.executeQuery(sqlQuery);
        } catch (Exception e) {
            System.err.println("Unable to execute query : \"" + sqlQuery + '"');
            System.err.println(e.getMessage());
            throw(e);
        }
        System.out.println("Executed query : \"" + sqlQuery + '"');
        while (results.next()) {
            //TODO : concat into a string
        }
        con.stmt.close();
        con.con.close();
        return ret;
    }
    
    public static int executeUpdate(String sqlUpdate) throws Exception {
        Connector con = new Connector();
        int ret;
        try {
            ret = con.stmt.executeUpdate(sqlUpdate);           
        } catch (Exception e) {
            System.err.println("Unable to execute update : \"" + sqlUpdate + '"');
            System.err.println(e.getMessage());
            throw(e);
        }
        System.out.println("Executed query : \"" + sqlUpdate + '"');
        con.stmt.close();
        con.con.close();
        return ret;
    }
}
