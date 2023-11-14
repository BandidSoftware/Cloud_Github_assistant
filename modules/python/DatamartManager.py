

class DatamartManager:
    def __init__(self, file_manager, code_writer):
        self.file_manager = file_manager
        self.code_writer = code_writer

    def save_tokenized_code(self, tokenized_code):
        self.file_manager.create_folder()
        self.code_writer.write_tokenized_code_to_file(tokenized_code)
