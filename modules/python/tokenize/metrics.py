from collections import Counter
import json


class CodeMetrics:
    def __init__(self, json_data):
        data = json.loads(json_data)
        self.metadata = data.get("metadata", {})
        self.tokens = data.get("tokens", [])

    def metric_line_count(self):
        return sum(1 for token in self.tokens if token["tipo"] == "NEWLINE")

    def metric_import_count(self):
        return len(self.metadata.get("clases_importadas", []))

    def metric_operator_count(self):
        return sum(1 for token in self.tokens if token["tipo"] == "OP")

    def metric_most_common_operators(self, n=3):
        operators = [token["palabra"] for token in self.tokens if token["tipo"] == "OP"]
        counter = Counter(operators)
        return counter.most_common(n)

    def metric_variable_count(self):
        variables = [token["palabra"] for token in self.tokens if token["tipo"] == "NAME"]
        return len(set(variables))

    def metric_function_count(self):
        functions = [token["palabra"] for token in self.tokens if
                     token["tipo"] == "NAME" and token["clase"] == "nombre_reservado"]
        return len(set(functions))

    def metric_comment_count(self):
        return sum(1 for token in self.tokens if token["tipo"] == "COMMENT")

    def metric_empty_line_count(self):
        return sum(1 for token in self.tokens if token["tipo"] == "NEWLINE" and token["palabra"].strip() == "")

    def generate_metrics_json(self):
        metrics_json = {
            "line_count": self.metric_line_count(),
            "import_count": self.metric_import_count(),
            "operator_count": self.metric_operator_count(),
            "most_common_operators": self.metric_most_common_operators(),
            "variable_count": self.metric_variable_count(),
            "function_count": self.metric_function_count(),
            "comment_count": self.metric_comment_count(),
            "empty_line_count": self.metric_empty_line_count(),
            "cyclomatic_complexity": self.metric_cyclomatic_complexity()
        }
        return json.dumps(metrics_json)
