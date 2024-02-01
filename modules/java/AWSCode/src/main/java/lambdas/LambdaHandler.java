package lambdas;

import com.amazonaws.services.lambda.AWSLambdaClient;
import com.amazonaws.services.sqs.AmazonSQSClient;

public abstract class LambdaHandler {

    AWSLambdaClient lambdaClient;
    AmazonSQSClient sqsClient;
    public void initializeHandler(){
        String accessKey = System.getenv("AWS_REGION");

    }

}
