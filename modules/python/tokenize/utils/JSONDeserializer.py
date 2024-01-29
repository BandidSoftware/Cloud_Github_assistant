import json
from modules.python.tokenize.utils.JSONData import JSONData


class JSONDeserializer:
    @staticmethod
    def deserialize(json_string):
        try:
            data = json.loads(json_string)
            if "name" in data and "code" in data and "id" in data:
                return JSONData(data["name"], data["code"], data["id"])
            else:
                raise ValueError("Missing 'name', 'code', or 'id' key in JSON.")
        except json.JSONDecodeError as e:
            raise ValueError("Invalid JSON format.") from e

