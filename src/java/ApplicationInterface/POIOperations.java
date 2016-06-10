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
 * @author RobbinNi, yjt-Lab
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
    
    public static String[] getInfo(int pid) throws Exception {
        ArrayList<String[]> ret = SQLExecutor.executeQuery("SELECT pid,name,category FROM acmdb05.Pois WHERE pid="+pid+";");
        return ret.get(1);
    }
    
    public static int addPoi(String poiName, String poiCategory) {
        try {
            SQLExecutor.executeUpdate("INSERT INTO acmdb05.Pois VALUES ( 0,'"+poiName+"', '"+poiCategory+"');");
        } catch(Exception e) {
            e.printStackTrace();
            return 0;
        }
        return 1;
    }
    
    public static int updatePoi(int pid, String poiName, String poiCategory) {
        try {
            SQLExecutor.executeUpdate("UPDATE acmdb05.Pois SET name='"+poiName+"', category='"+poiCategory+"' WHERE pid="+pid+";");
        } catch(Exception e) {
            e.printStackTrace();
            return 0;
        }
        return 1;
    }
    
    static class PoiAboutSuggestion implements Comparable<PoiAboutSuggestion>{
        public String poiName;
        public Integer times;
        public Integer pid;
        public PoiAboutSuggestion(String poiNam,Integer time,Integer pi) {
            poiName = poiNam;
            times = time;
            pid = pi;
        }
        
        @Override
        public int compareTo(PoiAboutSuggestion arg0) {
            return -times.compareTo(arg0.times);
        }
    }
    
    public static ArrayList<String> getSuggestion(String poiName) throws Exception {
        ArrayList<String[]> ret1 = SQLExecutor.executeQuery("SELECT pid FROM acmdb05.Pois WHERE name='"+poiName+"';");
        int pid = Integer.valueOf(ret1.get(0)[0]);
        ArrayList<String[]> ret2 = SQLExecutor.executeQuery("SELECT DISTINCT login FROM acmdb05.Visits WHERE pid="+pid+";");
        TreeMap<Integer,Integer> tm = new TreeMap<>();
        for (int i = 0; i < ret2.size(); i++) {
            ArrayList<String[]> ret3 = SQLExecutor.executeQuery("SELECT DISTINCT pid FROM acmdb05.Visits WHERE login='"+ret2.get(i)[0]+"';");
            for (int j = 0; j < ret3.size(); i++) {
                Integer re = Integer.valueOf(ret3.get(j)[0]);
                if (!tm.containsKey(re)) {
                    tm.put(re, 1);
                } else {
                    tm.put(re, tm.get(re)+1);
                }
            }
        }
        Iterator it = tm.keySet().iterator();
        ArrayList<PoiAboutSuggestion> pl = new ArrayList<>();
        while (it.hasNext()) {
            Integer pidtmp = (Integer)it.next();
            Integer timetmp = tm.get(pidtmp);
            ArrayList<String[]> ret4 = SQLExecutor.executeQuery("SELECT name FROM acmdb05.Pois WHERE pid="+pidtmp+";");
            String poiNametmp = ret4.get(0)[0];
            PoiAboutSuggestion pa = new PoiAboutSuggestion(poiNametmp,timetmp,pidtmp);
            pl.add(pa);
        }
        Collections.sort(pl);
        ArrayList<String> l = new ArrayList<>();
        for (int i = 0; i < pl.size(); i++) {
            l.add(pl.get(i).poiName);
        }
        return l;
    } 
}
