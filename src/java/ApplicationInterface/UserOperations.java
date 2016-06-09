/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ApplicationInterface;

import DatabaseInterface.SQLExecutor;
import java.util.ArrayList;

/**
 *
 * @author RobbinNi
 */
public class UserOperations {
    
    public static int registerUser(String login, String name, String pass) throws Exception {
        //0 - Success 1 - Login Exists
        //check existence
        ArrayList<String[]> ret = SQLExecutor.executeQuery("SELECT count(*) FROM acmdb05.Users WHERE login='" + login + "';");
        if (ret.get(0)[0].equals("0")) {
            SQLExecutor.executeUpdate("INSERT INTO acmdb05.Users VALUES (\"" + login + "\", \"" + pass + "\", \"" + name + "\", 1" + ");");
            return 0;
        } else {
            return 1;
        }
    }

    public static ArrayList<String[]> checkLogin(String login, String pass) throws Exception {
        return SQLExecutor.executeQuery("SELECT * FROM acmdb05.Users WHERE login='" + login + "' AND password='" + pass + "';");
    }
    
    public static ArrayList<String[]> getFav(String login) throws Exception {
        return SQLExecutor.executeQuery("SELECT * FROM acmdb05.Favorites WHERE login='" + login + "';");
    }
    
}
