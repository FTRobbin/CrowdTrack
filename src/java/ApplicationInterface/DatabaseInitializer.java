/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author RobbinNi
 */

package ApplicationInterface;

import DatabaseInterface.*;
import java.io.File;

public class DatabaseInitializer {
    
    public static String initialization(String filename) throws Exception {
        try {
            String path = Thread.currentThread().getContextClassLoader().getResource(filename).getPath();
            SQLExecutor.executeScript(new File(path));
        } catch (Exception e) {
            System.out.println("Error when initialization.");
            throw(e);
        }
        return "Success";
    }    
}
