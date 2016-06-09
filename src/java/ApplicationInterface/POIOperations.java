/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ApplicationInterface;

import java.util.*;
import java.text.SimpleDateFormat;
import DatabaseInterface.*;
/**
 *
 * @author RobbinNi
 */
public class POIOperations {
    
    public static ArrayList<String[]> getList() throws Exception {
        return SQLExecutor.executeQuery("SELECT * FROM acmdb05.Pois;");
    }
    
    public static ArrayList<ArrayList<String>> getFavList(String login) throws Exception {
        ArrayList<String[]> poiList = getList();
        ArrayList<String[]> favList = UserOperations.getFav(login);
        Set<String> faved = new HashSet<>();
        favList.stream().forEach((ss) -> {
            faved.add(ss[0].intern());
        });
        ArrayList<ArrayList<String>> ret = new ArrayList<>();
        for (String[] ss : poiList) {
            ArrayList<String> Line = new ArrayList<>();
            for (int i = 0; i < ss.length; ++i) {
                Line.add(ss[i]);
            }
            if (faved.contains(ss[0].intern())) {
                Line.add("Yes");
            } else {
                Line.add("No");
            }
            ret.add(Line);
        }
        return ret;
    }
    
    public static Boolean userFavPoiQuery(String login, String pid) throws Exception {
        return (SQLExecutor.executeQuery("SELECT * FROM acmdb05.Favorites WHERE login='" + login + "' AND pid=" + pid + " ;")).size() > 0;
    }
    
    public static int changeFav(String login, String pid) throws Exception {
        if (userFavPoiQuery(login, pid)) {
            SQLExecutor.executeUpdate("DELETE FROM acmdb05.Favorites WHERE login='" + login + "' AND pid=" + pid + " ;");
        } else {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            SQLExecutor.executeUpdate("INSERT INTO acmdb05.Favorites VALUES (" + pid + ", \"" + login + "\", \"" + format.format(new Date()) + "\");");
        }
        return 0;
    }
}
