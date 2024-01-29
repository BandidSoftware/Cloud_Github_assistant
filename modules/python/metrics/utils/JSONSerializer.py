import json


class JSONSerializer:
    @staticmethod
    def serialize(metrics, user_id, file_name):
        json_data = {
            "id": user_id,
            "name": file_name,
            "metrics": metrics
        }
        return json.dumps(json_data)