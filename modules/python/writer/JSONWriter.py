import uuid


class TokenizedCodeWriter:
    def __init__(self, file_manager):
        self.file_manager = file_manager

    def write_tokenized_code_to_file(self, tokenized_code):
        file_name = str(uuid.uuid4()) + ".json"
        self.file_manager.write_json_to_file(file_name, tokenized_code)
