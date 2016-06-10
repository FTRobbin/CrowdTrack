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
import java.util.Set;

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

    public static ArrayList<String[]> getTrust(String login) throws Exception {
        return SQLExecutor.executeQuery("SELECT * FROM acmdb05.Trusts WHERE login1='" + login + "';");
    }
    
    public static ArrayList<String[]> getList() throws Exception {
        return SQLExecutor.executeQuery("SELECT * FROM acmdb05.Users;");
    }
    
    public static Boolean userTrustUserQuery(String login, String login1) throws Exception {
        return (SQLExecutor.executeQuery("SELECT * FROM acmdb05.Trusts WHERE login1='" + login + "' AND login2='" + login1 + "' ;")).size() > 0;
    }

    
    public static ArrayList<ArrayList<String> > getTrustList(ArrayList<String[]> userList, String login) throws Exception {
        ArrayList<String[]> trustList = UserOperations.getTrust(login);
        Set<String> faved = new HashSet<>();
        trustList.stream().forEach((ss) -> {
            faved.add(ss[1].intern());
        });
        ArrayList<ArrayList<String>> ret = new ArrayList<>();
        for (String[] ss : userList) {
            ArrayList<String> Line = new ArrayList<>();
            for (int i = 0; i < ss.length; ++i) {
                Line.add(ss[i]);
            }
            if (faved.contains(ss[0].intern())) {
                Line.add("Trusted");
            } else {
                Line.add("Trust");
            }
            ret.add(Line);
        }
        return ret;
    }
    
    public static int changeTrust(String login, String login1) throws Exception {
        if (userTrustUserQuery(login, login1)) {
            SQLExecutor.executeUpdate("DELETE FROM acmdb05.Trusts WHERE login1='" + login + "' AND login2='" + login1 + "' ;");
        } else {
            SQLExecutor.executeUpdate("INSERT INTO acmdb05.Trusts VALUES (\"" + login + "\", \"" + login1 + "\");");
        }
        return 0;
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
            ArrayList<String[]> ret = SQLExecutor.executeQuery("SELECT DISTINCT login FROM acmdb05.Favorites WHERE pid IN (SELECT pid FROM acmdb05.Favorites WHERE login='"+u+"');");
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
