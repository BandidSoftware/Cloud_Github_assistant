
class PyMetrics:

    @staticmethod
    def _list_iteration(token_list, target_token, action):
        return [action(token_list, i) for i, token in enumerate(token_list) if token == target_token]

    @staticmethod
    def _count_tokens(token_list):
        tokens = sum(1 for token in token_list if token != "\n")
        return {"tokens": tokens}

    @staticmethod
    def _count_lines_of_code(token_list):
        lines_of_code = sum(1 for token in token_list if token == "\n")
        return {"lines_of_code": lines_of_code}

    @staticmethod
    def _count_imports(token_list):
        imports = PyMetrics._list_iteration(token_list, "import", lambda lst, idx: lst[idx + 1])
        return {"imports": imports, "num_imports": len(imports)}

    @staticmethod
    def _count_classes(token_list):
        class_indices = PyMetrics._list_iteration(token_list, "class", lambda lst, idx: idx)
        class_names = [token_list[idx + 1] for idx in class_indices]
        return {"classes": class_names, "num_classes": len(class_indices)}

    @staticmethod
    def _count_functions(token_list):
        func_indices = PyMetrics._list_iteration(token_list, "def", lambda lst, idx: idx)
        func_names = [token_list[idx + 1] for idx in func_indices]
        return {"functions": func_names, "num_functions": len(func_indices)}

    @staticmethod
    def calculate_metrics(token_list):
        metrics = {}
        metrics.update(PyMetrics._count_lines_of_code(token_list))
        metrics.update(PyMetrics._count_tokens(token_list))
        metrics.update(PyMetrics._count_imports(token_list))
        metrics.update(PyMetrics._count_classes(token_list))
        metrics.update(PyMetrics._count_functions(token_list))
        return metrics
