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
 * @author yjt-Lab
 */
public class FeedbackOperations {
    public static int hasFeedback(String login, int pid) throws Exception {
        ArrayList<String[]> ret = SQLExecutor.executeQuery("SELECT text,fdate FROM acmdb05.Feedbacks WHERE login='"+login+"' AND pid="+pid+";");
        if (ret.size() == 1) return 1; else return 0;
    }
    
    public static String[] getFeedback(String login, int pid) throws Exception {
        ArrayList<String[]> ret = SQLExecutor.executeQuery("SELECT score,text,fdate FROM acmdb05.Feedbacks WHERE login='"+login+"' AND pid="+pid+";");
        return ret.get(0);
    }
    
    public static String[] getFeedback(int fid) throws Exception {
        ArrayList<String[]> ret = SQLExecutor.executeQuery("SELECT login,fdate,score,text FROM acmdb05.Feedbacks WHERE fid="+fid+";");
        return ret.get(0);
    }
    
    public static int setFeedback(String login, int pid,int score, String text) {
        try {
            SQLExecutor.executeUpdate("INSERT INTO acmdb05.Feedbacks VALUES ( 0,'"+login+"', "+pid+", '"+text+"', "+score+", CURDATE());");
        } catch(Exception e) {
            e.printStackTrace();
            return 0;
        }
        return 1;
    }
    
    public static ArrayList<String[]> getAllFeedback(String login, int pid) throws Exception {
        ArrayList<String[]> ret = SQLExecutor.executeQuery("SELECT fid,login,fdate,score,text FROM acmdb05.Feedbacks WHERE login<>'"+login+"' AND pid="+pid+";");
        return ret;
    }
    
    public static int hasRating(String login, int fid) throws Exception {
        ArrayList<String[]> ret = SQLExecutor.executeQuery("SELECT rating FROM acmdb05.Rates WHERE login='"+login+"' AND fid="+fid+";");
        if (ret.size() == 1) return 1; else return 0;
    }
    
    public static String getRating(String login, int fid) throws Exception {
        ArrayList<String[]> ret = SQLExecutor.executeQuery("SELECT rating FROM acmdb05.Rates WHERE login='"+login+"' AND fid="+fid+";");
        return ret.get(0)[0];
    }
    
    public static int rateFeedback(String login, int fid,int rate) {
        try {
            SQLExecutor.executeUpdate("INSERT INTO acmdb05.Rates VALUES ('"+login+"', "+fid+", "+rate+");");
        } catch(Exception e) {
            e.printStackTrace();
            return 0;
        }
        return 1;
    }
    
    public static ArrayList<String[]> getUsefulFeedback(int pid, int top) throws Exception {
        ArrayList<String[]> ret = SQLExecutor.executeQuery("SELECT AVG(r1.rating) AS avgrating, r1.fid FROM acmdb05.Rates r1 GROUP BY r1.fid HAVING r1.fid IN (SELECT f.fid FROM acmdb05.Feedbacks f WHERE f.pid="+pid+") ORDER BY avgrating DESC LIMIT "+top+";");
        return ret;
    }
}
