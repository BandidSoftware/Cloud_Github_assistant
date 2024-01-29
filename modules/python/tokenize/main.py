from modules.python.tokenize.python_tokenizer.PyTokenizer import PyTokenizer
from modules.python.tokenize.utils.JSONDeserializer import JSONDeserializer
from modules.python.tokenize.utils.JSONSerializer import JSONSerializer

if __name__ == "__main__":
    source_code = "{\"name\": \"code.py\", \"code\": \"import math\\nimport numpy as np\\n\\ndef calcular_distancia(x, y):\\n    return math.sqrt(x**2 + y**2)\\n\\npunto_a = (3, 4)\\nresultado = calcular_distancia(*punto_a)\\n\\nprint(resultado)\\n\" , \"id\": \"r3tfgcv\"}"
    josn_data = JSONDeserializer().deserialize(source_code)
    tokens = PyTokenizer().tokenize(josn_data.code)
    serialized_json = JSONSerializer().serialize(tokens, josn_data.user_id, josn_data.name)
    print(serialized_json)
