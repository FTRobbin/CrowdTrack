/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ApplicationInterface;
import DatabaseInterface.*;
import java.util.ArrayList;
/**
 *
 * @author yjt-Lab
 */
public class Visit {
    public static int doVisit(String login, String poiName, String visDate, int cost, int numberofheads) {
        try {
            SQLExecutor.executeUpdate("INSERT INTO VisEvent VALUES ( 0,"+cost+numberofheads+")");
            ArrayList<String[]> ret1 = SQLExecutor.executeQuery("SELECT vid FROM acmdb05.VisEvent WHERE cost=" + cost + "AND numberofheads="+numberofheads+";");
            int vid = Integer.valueOf(ret1.get(0)[0]);
            ArrayList<String[]> ret2 = SQLExecutor.executeQuery("SELECT pid FROM acmdb05.Pois WHERE name='"+poiName+"';");
            int pid = Integer.valueOf(ret2.get(0)[0]);
            SQLExecutor.executeUpdate("INSERT INTO Visit VALUES ( '"+login+"',"+pid+","+vid+",'"+visDate+"')");
        } catch(Exception e) {
            e.printStackTrace();
            return 0;
        }
        return 1;
    }
}
