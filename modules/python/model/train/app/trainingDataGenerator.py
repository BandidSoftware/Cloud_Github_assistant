import ast
from readFile import readFile

class trainingDataGenerator():

    def __init__(self, file_path):
        self.file_path = file_path

    def training_data_generator(self):
        functions_data = []
        read_file = readFile(self.file_path)
        code = read_file.read_file()
        tree = ast.parse(code)
        for node in ast.walk(tree):
            if isinstance(node, ast.FunctionDef):
                function_name = node.name
                function_content = ast.get_source_segment(code, node.body[0])
                functions_data.append((function_name, function_content))
        return functions_data