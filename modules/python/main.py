from modules.python.reader.JSONReader import JSONReader
from modules.python.tokenizer.JSONTokenizer import JSONTokenizer

if __name__ == "__main__":

    json_folder = "data"
    json_file_name = "ejemplo.json"

    json_reader = JSONReader(folder=json_folder)
    metadata, content = json_reader.read_json(json_file_name)

    tokenizer = JSONTokenizer()
    actual_output = tokenizer.tokenize_json(metadata, content)
    print(actual_output)


