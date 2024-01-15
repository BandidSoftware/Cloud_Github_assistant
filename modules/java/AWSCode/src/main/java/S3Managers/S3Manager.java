package S3Managers;

public interface S3Manager {
    void delete(String id) throws Exception;
    void add(String data) throws Exception;
    void query(String id) throws Exception;
}
