import tokenize
from io import BytesIO

class JSONTokenizer:
    def __init__(self, metadata, code):
        self.metadata = metadata
        self.code = code

    def get_token_type(self, token):
        if token in ['def']:
            return 'function'
        elif token in ['import', 'from']:
            return 'module'
        elif token in ['return', 'if', 'else', 'for', 'while', 'print', 'and', 'or']:
            return 'keyword'
        else:
            return 'variable'  # Assuming it's a variable if none of the above matches

    def is_valid_variable(self, name):
        # Add any additional filtering logic for variables if needed
        return not name.startswith('utf-8')

    def tokenize_code(self):
        tokens = []
        code_bytes = self.code.encode('utf-8')
        code_stream = BytesIO(code_bytes)

        for tok in tokenize.tokenize(code_stream.readline):
            token_type = self.get_token_type(tok.string)
            if token_type in ['function', 'module', 'keyword', 'variable']:
                if token_type == 'variable' and not self.is_valid_variable(tok.string):
                    continue  # Skip unwanted variable tokens
                tokens.append({
                    "token": tok.string,
                    "name": tok.string,
                    "type": token_type,
                    "start": tok.start,
                    "end": tok.end
                })

            if token_type == 'variable':
                # Additional check for variable names
                tokens[-1]["name"] = tok.string

        return tokens

    def tokenize_json(self):
        if self.metadata is None or self.code is None:
            raise ValueError("Metadata and code must be set before tokenizing.")

        code_tokens = self.tokenize_code()
        json_tokens = {
            "metadata": self.metadata,
            "tokenizer": code_tokens
        }
        return json_tokens
