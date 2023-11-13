import os
import unittest
from modules.python.tokenizer.JSONTokenizer import JSONTokenizer


class TokenizerTest(unittest.TestCase):
    def test_tokenization(self):
        current_directory = os.path.dirname(__file__)
        json_file_path = os.path.join(current_directory, "data", "ejemplo.json")

        tokenizer = JSONTokenizer()
        json_data = tokenizer.read_json_file(json_file_path)
        actual_output = tokenizer.tokenize_json(json_data)
        
        expected_output = {"metadata": {"other_data": "not_relevant"},
                           "tokenizer": [
                               {"token": "import", "name": "math", "type": "module"},
                               {"token": "def", "name": "calcular_distancia", "type": "function"},
                               {"token": "argument", "name": "x", "type": "variable"},
                               {"token": "argument", "name": "y", "type": "variable"},
                               {"token": "return", "type": "keyword"},
                               {"token": "math", "type": "module"},
                               {"token": "sqrt", "type": "function"},
                               {"token": "(", "type": "punctuation"},
                               {"token": "x", "type": "variable"},
                               {"token": "**", "type": "operator"},
                               {"token": "2", "type": "literal"},
                               {"token": "+", "type": "operator"},
                               {"token": "y", "type": "variable"},
                               {"token": "**", "type": "operator"},
                               {"token": "2", "type": "literal"},
                               {"token": ")", "type": "punctuation"},
                               {"token": "punto_a", "type": "variable"},
                               {"token": "=", "type": "operator"},
                               {"token": "(", "type": "punctuation"},
                               {"token": "3", "type": "literal"},
                               {"token": ",", "type": "punctuation"},
                               {"token": "4", "type": "literal"},
                               {"token": ")", "type": "punctuation"},
                               {"token": "resultado", "type": "variable"},
                               {"token": "=", "type": "operator"},
                               {"token": "calcular_distancia", "type": "function"},
                               {"token": "(", "type": "punctuation"},
                               {"token": "*", "type": "operator"},
                               {"token": "punto_a", "type": "variable"},
                               {"token": ")", "type": "punctuation"},
                               {"token": "print", "type": "function"},
                               {"token": "(", "type": "punctuation"},
                               {"token": "resultado", "type": "variable"},
                               {"token": ")", "type": "punctuation"}
                           ]
                           }

        self.assertEqual(actual_output, expected_output)


if __name__ == "__main__":
    unittest.main()
