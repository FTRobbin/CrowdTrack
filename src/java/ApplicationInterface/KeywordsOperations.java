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
}
