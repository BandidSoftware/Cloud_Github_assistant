import json


class JSONSerializer:
    @staticmethod
    def serialize(tokens, user_id, file_name):
        json_data = {
            "id": user_id,
            "name": file_name,
            "tokens": tokens
        }
        return json.dumps(json_data)