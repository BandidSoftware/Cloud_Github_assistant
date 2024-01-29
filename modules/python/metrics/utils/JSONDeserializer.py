import json

from modules.python.metrics.utils.TokenizedData import TokenizedData


class JSONDeserializer:

    @staticmethod
    def deserialize(json_string):
        data = json.loads(json_string)
        name = data.get('name')
        tokens = data.get('tokens')
        user_id = data.get('id')
        return TokenizedData(name, tokens, user_id)