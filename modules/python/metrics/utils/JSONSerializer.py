import json


class JSONSerializer:
    @staticmethod
    def serialize(metrics, user_id, file_name):
        json_data = {
            "user_id": user_id,
            "file_name": file_name,
            "metrics": metrics
        }
        return json.dumps(json_data)