# file_manager.py

import os
import json


class FileManager:
    def __init__(self, folder_name):
        self.folder_path = os.path.join(os.getcwd(), folder_name)

    def create_folder(self):
        if not os.path.exists(self.folder_path):
            os.makedirs(self.folder_path)

    def write_json_to_file(self, file_name, data):
        file_path = os.path.join(self.folder_path, file_name)
        with open(file_path, 'w') as file:
            json.dump(data, file, indent=2)
