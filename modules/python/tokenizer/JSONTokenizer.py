import ast
import json


class JSONTokenizer:
    def __init__(self):
        self.tokens = []

    def tokenize_json(self, metadata, code):
        self.tokens = []
        self.tokenize_code(metadata, code)
        return {"metadata": metadata, "tokenizer": self.tokens}

    def tokenize_code(self, metadata, code):
        tree = ast.parse(code)
        self._parse_tree(tree)

    def _parse_tree(self, node):
        for child in ast.iter_child_nodes(node):
            if isinstance(child, ast.FunctionDef):
                self._tokenize_function_def(child)
            elif isinstance(child, ast.AsyncFunctionDef):
                self._tokenize_function_def(child, async_func=True)
            elif isinstance(child, ast.ClassDef):
                self._tokenize_class_def(child)
            elif isinstance(child, ast.Import):
                self._tokenize_import(child)
            elif isinstance(child, ast.ImportFrom):
                self._tokenize_import_from(child)
            elif isinstance(child, ast.Assign):
                self._tokenize_assignment(child)
            elif isinstance(child, ast.Expr):
                self._parse_tree(child.value)
            elif isinstance(child, ast.Call):
                self._tokenize_function_call(child)
            elif isinstance(child, (ast.Str, ast.Bytes)):
                self._tokenize_literal(child)
            elif isinstance(child, ast.Num):
                self._tokenize_number(child)
            elif isinstance(child, ast.Name):
                self._tokenize_name(child)
            elif isinstance(child, ast.Attribute):
                self._tokenize_attribute(child)
            elif isinstance(child, ast.operator):
                self._tokenize_operator(child)
            else:
                self._parse_tree(child)

    def _tokenize_function_def(self, node, async_func=False):
        self.tokens.append({"token": "def", "name": node.name, "type": "function", "async": async_func})
        for arg in node.args.args:
            self.tokens.append({"token": "argument", "name": arg.arg, "type": "variable"})

    def _tokenize_class_def(self, node):
        self.tokens.append({"token": "class", "name": node.name, "type": "class"})

    def _tokenize_import(self, node):
        for alias in node.names:
            self.tokens.append({"token": "import", "name": alias.name, "type": "module"})

    def _tokenize_import_from(self, node):
        for alias in node.names:
            self.tokens.append({"token": "import", "name": alias.name, "type": "module", "from": node.module})

    def _tokenize_assignment(self, node):
        for target in node.targets:
            if isinstance(target, ast.Name):
                self.tokens.append({"token": "assign", "name": target.id, "type": "variable"})

    def _tokenize_function_call(self, node):
        func_name = self._get_function_name(node.func)
        self.tokens.append({"token": "call", "name": func_name, "type": "function"})
        for arg in node.args:
            self._parse_tree(arg)
        for keyword in node.keywords:
            self._parse_tree(keyword.value)

    def _tokenize_literal(self, node):
        self.tokens.append({"token": "literal", "name": str(node.s), "type": "literal"})

    def _tokenize_number(self, node):
        self.tokens.append({"token": "literal", "name": str(node.n), "type": "literal"})

    def _tokenize_name(self, node):
        self.tokens.append({"token": "name", "name": node.id, "type": "variable"})

    def _tokenize_attribute(self, node):
        self.tokens.append({"token": "attribute", "name": node.attr, "type": "attribute", "parent": self._get_attribute_chain(node)})

    def _tokenize_operator(self, node):
        self.tokens.append({"token": "operator", "name": node.__class__.__name__, "type": "operator"})

    def _get_attribute_chain(self, node):
        if isinstance(node.value, ast.Attribute):
            return self._get_attribute_chain(node.value) + [node.attr]
        elif isinstance(node.value, ast.Name):
            return [node.value.id, node.attr]
        else:
            return [node.attr]

    def _get_function_name(self, func):
        if isinstance(func, ast.Attribute):
            return f"{self._get_function_name(func.value)}.{func.attr}"
        elif isinstance(func, ast.Name):
            return func.id
        else:
            return "unknown"
