/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ApplicationInterface;

/**
 *
 * @author RobbinNi
 */

import java.util.ArrayList;
import DatabaseInterface.*;

public class Login {
    public static ArrayList<String[]> checkLogin(String login, String pass) throws Exception {
        return SQLExecutor.executeQuery("SELECT * FROM acmdb05.Users WHERE login='" + login + "' AND password='" + pass + "';");
    }
}
