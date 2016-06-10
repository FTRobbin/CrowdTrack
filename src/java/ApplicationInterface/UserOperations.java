/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ApplicationInterface;

import DatabaseInterface.SQLExecutor;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Queue;

/**
 *
 * @author RobbinNi, yjt-Lab
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
    
    public static int computeDegree(String user1, String user2) throws Exception {
        HashSet<String> hm =new HashSet<>();
        Queue<String> uq = new LinkedList<>();
        Queue<Integer> dq = new LinkedList<>();
        hm.add(user1);
        uq.offer(user1);
        dq.offer(0);
        while (!uq.isEmpty()) {
            String u = uq.poll();
            Integer d = dq.poll();
            ArrayList<String[]> ret = SQLExecutor.executeQuery("SELECT DISTINCT f1.login FROM acmdb05.Favorites f1 WHERE f1.pid IN (SELECT f2.pid FROM acmdb05.Favorites f2 WHERE f2.login='"+u+"');");
            for (int i = 0; i < ret.size(); i++) {
                String s = ret.get(i)[0];
                if (!hm.contains(s)) {
                    uq.offer(s);
                    dq.offer(d+1);
                    if (s == user2) return d+1;
                    hm.add(s);
                }
            }
        }
        return -1;
    }
}
