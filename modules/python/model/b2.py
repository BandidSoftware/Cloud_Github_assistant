from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.svm import SVC
from sklearn.pipeline import make_pipeline
from sklearn import metrics
from joblib import dump, load

# Ejemplo de datos
data = [('add_numbers', 'def add_numbers(a, b):\n\treturn a + b'),
        ('multiply_numbers', 'def multiply_numbers(a, b):\n\treturn a * b'),
        ('divide_numbers', 'def divide_numbers(a, b):\n\treturn a / b')]

# Separar datos en características (X) y etiquetas (y)
X = [func[1] for func in data]
y = [func[0] for func in data]

# Dividir los datos en conjuntos de entrenamiento y prueba
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Crear un modelo basado en SVM y un pipeline que incluya la vectorización de texto
model = make_pipeline(TfidfVectorizer(), SVC(kernel='linear'))

# Entrenar el modelo
model.fit(X_train, y_train)

# Realizar predicciones en el conjunto de prueba
predictions = model.predict(X_test)

# Evaluar el rendimiento del modelo
accuracy = metrics.accuracy_score(y_test, predictions)
print(f'Accuracy: {accuracy}')

# Guardar el modelo entrenado para su uso futuro
dump(model, 'function_name_classifier.joblib')          # NOMBRE DEL MODELO ES ID USUARIO
