package DBManagers;

import java.util.HashMap;
import java.util.List;

public interface DBManager {
    void initializeManager(List<String> dbDetails) throws Exception;
    void closeManager();
    void add(HashMap data) throws Exception;
    void delete(String id) throws Exception;
    void update(String id, HashMap newData) throws Exception;
    List query(String id) throws Exception;


}
