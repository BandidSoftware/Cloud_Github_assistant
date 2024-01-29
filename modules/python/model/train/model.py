from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.svm import SVC
from sklearn.pipeline import make_pipeline
from sklearn import metrics
from joblib import dump

class model():

    def __init__(self, data, model_name):
        self.data = data
        self.model_name = model_name

    def x_y_train(self):
        self.X = [func[1] for func in self.data]
        self.y = [func[0] for func in self.data]
        self.X_train, self.X_test, self.y_train, self.y_test = train_test_split(self.X, self.y, test_size=0.2, random_state=42)

    def training(self):
        model = make_pipeline(TfidfVectorizer(), SVC(kernel='linear'))
        model.fit(self.X_train, self.y_train)
        predictions = model.predict(self.X_test)
        accuracy = metrics.accuracy_score(self.y_test, predictions)
        print(f'Accuracy: {accuracy}')
        dump(model, f'{self.model_name}.joblib')
