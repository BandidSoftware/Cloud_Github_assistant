package lambdas;

public interface Lambda {
    String parseInput(String rawInput);
    String executeCode(String input, String context) throws LambdaExecutionError;

}
