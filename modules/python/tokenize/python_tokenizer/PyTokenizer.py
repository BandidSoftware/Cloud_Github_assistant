import re


class PyTokenizer:
    @staticmethod
    def tokenize(code):
        code = PyTokenizer._remove_line_comments(code)
        code = PyTokenizer._remove_multi_line_comments(code)
        tokens = re.findall(r'\b\w+\b|"[^"]*"|[.,;:()\n]', code)
        # Aplicar transformación a los tokens
        tokens = PyTokenizer._transform_tokens(tokens)
        return tokens

    @staticmethod
    def _transform_tokens(tokens):
        return [token.replace('\n', '\\n') for token in tokens]

    @staticmethod
    def _remove_line_comments(code):
        return re.sub(r'#.*', '', code)

    @staticmethod
    def _remove_multi_line_comments(code):
        return re.sub(r"'''.*?'''", '', code, flags=re.DOTALL)
