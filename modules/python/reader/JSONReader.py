# json_reader.py

import json
import os


class JSONReader:
    def __init__(self, folder):
        self.base_path = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", folder))  # Modificación aquí

    def read_json(self, file_name):
        file_path = os.path.join(self.base_path, file_name)
        with open(file_path, "r") as file:
            data = json.load(file)
            metadata = data.get("metadata", {})
            content = data.get("text", "")
            return metadata, content
