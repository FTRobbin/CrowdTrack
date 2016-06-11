/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ApplicationInterface;

import DatabaseInterface.*;
import java.util.*;

/**
 *
 * @author RobbinNi
 */
public class KeywordsOperations {

    public static ArrayList<String[]> getKeywordsList() throws Exception {
       return SQLExecutor.executeQuery("SELECT wid, word FROM acmdb05.Keywords;");
    }
    
    public static int existKeyword(String keyword) {
        try {
            ArrayList<String[]> ret = SQLExecutor.executeQuery("SELECT wid FROM acmdb05.Keywords WHERE word='"+keyword+"';");
            if (ret.size()==1) return Integer.valueOf(ret.get(0)[0]);
        } catch(Exception e) {
            e.printStackTrace();
            return 0;
        }
        return 0;
    }
    
    public static int addKeyword(int pid, String keyword) {
        try {
            int wid = existKeyword(keyword);
            if (wid == 0) wid = SQLExecutor.executeUpdateAndID("INSERT INTO acmdb05.Keywords VALUES ( 0,'"+keyword+"');");
            SQLExecutor.executeUpdate("INSERT INTO acmdb05.Haskeywords VALUES ( "+pid+", "+wid+");");
        } catch(Exception e) {
            e.printStackTrace();
            return 0;
        }
        return 1;
    }
}
