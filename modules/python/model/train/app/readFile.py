class readFile():

    def __init__(self, file_path):
        self.file_path = file_path

    def read_file(self):

        with open(self.file_path, 'r') as file:
            code = file.read()
        return code