import json


class EventParser:
    @staticmethod
    def parse_event(event):
        event_dict = json.loads(event)
        user_id, file_name = event_dict.get('user-id'), event_dict.get('file-name')
        return user_id, file_name

