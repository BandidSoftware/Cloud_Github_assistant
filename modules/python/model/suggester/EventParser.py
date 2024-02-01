import json

class EventParser():

    @staticmethod
    def event_parser(json_data):
        data = json.loads(json_data)
        id_user = data.get('id_user', None)
        new_data = data.get('new_data', None)
        return id_user, new_data