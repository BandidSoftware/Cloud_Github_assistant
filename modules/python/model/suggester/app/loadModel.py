from joblib import load
from predict import predict

class loadModel():

    def __init__(self, model, new_data):
        self.model = model
        self.new_data = new_data

    def load_model(self):
        loaded_model = load(self.model)
        prediction = predict(loaded_model, self.new_data)
        prediction = prediction.predict()
        return prediction
