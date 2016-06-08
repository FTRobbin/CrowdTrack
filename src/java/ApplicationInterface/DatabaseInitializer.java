/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author RobbinNi
 */

package ApplicationInterface;

import DatabaseInterface.*;

public class DatabaseInitializer {
    
    public static String initialization() throws Exception {
        try {
            SQLExecutor.executeUpdate("DROP DATABASE IF EXISTS acmdb05;");
        } catch (Exception e) {
            System.out.println("Error when initialization.");
            throw(e);
        }
        return "Success";
    }
}
