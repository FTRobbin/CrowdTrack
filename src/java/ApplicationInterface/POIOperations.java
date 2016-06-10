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
    
    public static ArrayList<String[]> getList(String conditions) throws Exception {
        return SQLExecutor.executeQuery("SELECT * FROM acmdb05.Pois " + conditions + " ;");
    }
    
    public static ArrayList<String[]> getAvgSortedList(String conditions) throws Exception {
        return SQLExecutor.executeQuery("SELECT p.pid, p.name, p.category, p.istate, p.city, p.street, p.price, a.avg FROM acmdb05.Pois p, (SELECT pid, avg(score) AS avg FROM acmdb05.Feedbacks GROUP BY pid) AS a " + conditions + " p.pid = a.pid ORDER BY avg DESC;"
);
    }

    public static ArrayList<String[]> getTrustAvgSortedList(String conditions, String login) throws Exception {
        return SQLExecutor.executeQuery("SELECT p.pid, p.name, p.category, p.istate, p.city, p.street, p.price, a.avg FROM acmdb05.Pois p, (SELECT pid, avg(score) AS avg FROM (SELECT f.pid, f.score FROM acmdb05.Feedbacks f, acmdb05.Trusts t WHERE t.login1 = \"" + login + "\" AND f.login = t.login2) AS ft GROUP BY pid) AS a " + conditions + " p.pid = a.pid ORDER BY avg DESC;"
);
    }

        
    public static ArrayList<String[]> getKeywordList(String keywordCondition, int keywordCnt) throws Exception {
        return SQLExecutor.executeQuery("SELECT tp.pid, tp.name, tp.category, tp.istate, tp.city, tp.street, tp.price from \n" +
"	(SELECT p.pid, p.name, p.category, p.istate, p.city, p.street, p.price, count(*) AS c from acmdb05.Pois p, acmdb05.Haskeywords h WHERE p.pid = h.pid AND (" + keywordCondition + ") GROUP by p.pid) AS tp WHERE tp.c = " + keywordCnt + ";");
    }
    
    public static ArrayList<String[]> getKeywordList(String conditions, String keywordCondition, int keywordCnt) throws Exception {
        return SQLExecutor.executeQuery("SELECT tp.pid, tp.name, tp.category, tp.istate, tp.city, tp.street, tp.price from \n" +
"	(SELECT p.pid, p.name, p.category, p.istate, p.city, p.street, p.price, count(*) AS c from acmdb05.Pois p, acmdb05.Haskeywords h WHERE p.pid = h.pid AND (" + keywordCondition + ") GROUP by p.pid) AS tp WHERE tp.c = " + keywordCnt + conditions + ";");    }
    
    public static ArrayList<String[]> getKeywordAvgSortedList(String conditions, String keywordCondition, int keywordCnt) throws Exception {
        return SQLExecutor.executeQuery("SELECT B.pid, B.name, B.category, B.istate, B.city, B.street, B.price, B.avg FROM" + " (SELECT tp.pid, tp.name, tp.category, tp.istate, tp.city, tp.street, tp.price from \n" +
"	(SELECT pp.pid, pp.name, pp.category, pp.istate, pp.city, pp.street, pp.price, count(*) AS c from acmdb05.Pois pp, acmdb05.Haskeywords h WHERE pp.pid = h.pid AND (" + keywordCondition + ") GROUP by pp.pid) AS tp WHERE tp.c = " + keywordCnt + ") AS A, "
        + "(SELECT p.pid, p.name, p.category, p.istate, p.city, p.street, p.price, a.avg FROM acmdb05.Pois p, (SELECT pid, avg(score) AS avg FROM acmdb05.Feedbacks GROUP BY pid) AS a " + conditions + " p.pid = a.pid) AS B" + " WHERE A.pid = B.pid ORDER BY avg DESC;");
    }

    public static ArrayList<String[]> getKeywordTrustAvgSortedList(String conditions, String login, String keywordCondition, int keywordCnt) throws Exception {
        return SQLExecutor.executeQuery("SELECT B.pid, B.name, B.category, B.istate, B.city, B.street, B.price, B.avg FROM" + " (SELECT tp.pid, tp.name, tp.category, tp.istate, tp.city, tp.street, tp.price from \n" +
"	(SELECT pp.pid, pp.name, pp.category, pp.istate, pp.city, pp.street, pp.price, count(*) AS c from acmdb05.Pois pp, acmdb05.Haskeywords h WHERE pp.pid = h.pid AND (" + keywordCondition + ") GROUP by pp.pid) AS tp WHERE tp.c = " + keywordCnt + ") AS A, "
        + "(SELECT p.pid, p.name, p.category, p.istate, p.city, p.street, p.price, a.avg FROM acmdb05.Pois p, (SELECT pid, avg(score) AS avg FROM (SELECT f.pid, f.score FROM acmdb05.Feedbacks f, acmdb05.Trusts t WHERE t.login1 = \"" + login + "\" AND f.login = t.login2) AS ft GROUP BY pid) AS a " + conditions + " p.pid = a.pid ORDER BY avg DESC) AS B" + " WHERE A.pid = B.pid ORDER BY avg DESC;");
    }

    public static ArrayList<ArrayList<String>> getFavList(ArrayList<String[]> poiList, String login) throws Exception {
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
    
    public static ArrayList<String[]> getCategoryList() throws Exception {
        return SQLExecutor.executeQuery("SELECT DISTINCT category FROM acmdb05.Pois;");
    }
    
    public static ArrayList<String[]> getMostVisitsList(int top, String cond) throws Exception {
        return SQLExecutor.executeQuery("SELECT p.pid, p.name, p.category, p.istate, p.city, p.street, p.price, c.cnt FROM acmdb05.Pois p, (SELECT pid, count(*) as cnt FROM acmdb05.Visits v GROUP BY v.vid) AS c WHERE p.pid = c.pid " + cond + " ORDER BY c.cnt LIMIT " + top + ";");
    }
    
    public static ArrayList<String[]> getMostExpensiveList(int top, String cond) throws Exception {
        return SQLExecutor.executeQuery("SELECT p.pid, p.name, p.category, p.istate, p.city, p.street, p.price, a.avg FROM acmdb05.Pois p, (SELECT vv.pid, avg(cost) AS avg FROM (SELECT v.pid, v.vid, ve.cost FROM acmdb05.Visits v, acmdb05.VisEvent ve WHERE v.vid = ve.vid) AS vv GROUP BY vv.pid) AS a WHERE p.pid = a.pid "  + cond + " ORDER BY a.avg LIMIT " + top + ";");
    }
    
    public static ArrayList<String[]> getHighestRatedList(int top, String cond) throws Exception {
        return SQLExecutor.executeQuery("SELECT p.pid, p.name, p.category, p.istate, p.city, p.street, p.price, a.avg FROM acmdb05.Pois p, (SELECT pid, avg(score) AS avg FROM acmdb05.Feedbacks GROUP BY pid) AS a WHERE p.pid = a.pid " + cond + " ORDER BY avg DESC LIMIT " + top + ";");
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
