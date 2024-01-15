package DBManagers;

public interface DBManager {
    void initializeManager(String DB, String table) throws Exception;
    void add(String data) throws Exception;
    void delete(String id) throws Exception;
    void update(String id, String newData) throws Exception;
    String query(String id) throws Exception;

}
