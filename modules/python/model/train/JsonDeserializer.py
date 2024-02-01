import json

class JsonDeserializer():

    @staticmethod
    def deserializer(json_content):
        data = json.loads(json_content)
        return data["id"], data["name"], data["code"]