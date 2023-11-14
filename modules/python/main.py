from modules.python.DatamartManager import DatamartManager
from modules.python.FileManager import FileManager
from modules.python.reader.JSONReader import JSONReader
from modules.python.tokenizer.JSONTokenizer import JSONTokenizer
from modules.python.writer.JSONWriter import TokenizedCodeWriter

if __name__ == "__main__":

    json_folder = "data"
    json_file_name = "ejemplo.json"
    datamart_folder = "DataMart"

    json_reader = JSONReader(folder=json_folder)
    metadata, content = json_reader.read_json(json_file_name)

    tokenizer = JSONTokenizer(metadata, content)
    actual_output = tokenizer.tokenize_json()
    print(actual_output)

    file_manager = FileManager(datamart_folder)
    code_writer = TokenizedCodeWriter(file_manager)

    datamart_manager = DatamartManager(file_manager=file_manager, code_writer=code_writer)
    datamart_manager.save_tokenized_code(actual_output)


