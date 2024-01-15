package DBManagers;


import software.amazon.awssdk.auth.credentials.AwsBasicCredentials;
import software.amazon.awssdk.auth.credentials.StaticCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.dynamodb.DynamoDbClient;
import software.amazon.awssdk.services.dynamodb.model.*;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DynamoDBManager implements DBManager{

    private Region region;
    private String tableName;
    private String primaryKey;
    private DynamoDbClient dynamoDbClient;
    public void initializeManager(List<String> dbDetails) throws Exception {

        parseDetails(dbDetails);

        AwsBasicCredentials credentials = setUpCredentials();

        this.dynamoDbClient = DynamoDbClient.builder()
                .region(region)
                .credentialsProvider(StaticCredentialsProvider.create(credentials))
                .build();

        System.out.println("Connection started");
    }
    private static AwsBasicCredentials setUpCredentials() {
        String accessKey = System.getenv("AWS_ACCESS_KEY");
        String secretKey = System.getenv("AWS_SECRET_KEY");

        AwsBasicCredentials credentials = AwsBasicCredentials.create(accessKey, secretKey);
        return credentials;
    }

    private void parseDetails(List<String> dbDetails) {
        this.region = Region.of(dbDetails.get(0));
        this.tableName = dbDetails.get(1);
        this.primaryKey = dbDetails.get(2);
    }
    @Override
    public void closeManager() {
        this.dynamoDbClient.close();
        System.out.println("Connection closed");
    }

    public void add(HashMap data) throws Exception {
        //todo crear clases especificas que parseen los hashmaps correctos
        PutItemRequest putItemRequest = PutItemRequest.builder()
                .tableName(this.tableName)
                .item(data)
                .build();

        this.dynamoDbClient.putItem(putItemRequest);

        System.out.println("Data added correctly.");
    }

    public void delete(String id) throws Exception {
        Map<String, AttributeValue> key = parseKey(id);

        DeleteItemRequest deleteItemRequest = DeleteItemRequest.builder()
                .tableName(this.tableName)
                .key(key)
                .build();

        dynamoDbClient.deleteItem(deleteItemRequest);

        System.out.println("Deletion succesfull.");
    }


    public void update(String id, HashMap newData) throws Exception {
        //todo crear clases especificas que parseen los hashmaps correctos
        Map<String, AttributeValue> key = parseKey(id);

        UpdateItemRequest updateItemRequest = UpdateItemRequest.builder()
                .tableName(this.tableName)
                .key(key)
                .attributeUpdates(newData)
                .build();

        dynamoDbClient.updateItem(updateItemRequest);
        System.out.println("Update successfulll suuu");
    }

    public List query(String id) throws Exception {
        QueryRequest queryRequest = QueryRequest.builder()
                .tableName(this.tableName)
                .indexName(this.primaryKey)
                .keyConditionExpression("#"+ this.primaryKey+ "= :value") //serias dudas sobre esto
                .expressionAttributeNames(Collections.singletonMap("#" + this.primaryKey, this.primaryKey))
                .expressionAttributeValues(Collections.singletonMap(":value", AttributeValue.builder().s(id).build()))
                .build();

        QueryResponse queryResponse = dynamoDbClient.query(queryRequest);
        List<Map<String, AttributeValue>> items = queryResponse.items();

        System.out.println("Query results");
        for (Map<String, AttributeValue> item : items) {
            System.out.println("Item: " + item);
        }

        return items;
    }

    private Map<String, AttributeValue> parseKey(String id) {
        Map<String, AttributeValue> key = new HashMap<>();
        key.put(this.primaryKey, AttributeValue.builder().n(id).build());
        return key;
    }
}
