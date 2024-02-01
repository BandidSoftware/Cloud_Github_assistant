class AppendToFile:
    def __init__(self, file_path):
        self.file_path = file_path

    def append_string(self, content):
        with open(self.file_path, 'a') as file:
            file.write('\n\n' + content)