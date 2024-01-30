class predict():

    def __init__(self, model, new_data):
        self.model = model
        self.new_data = new_data

    def predict(self):
        predictions = self.model.predict([self.new_data])
        return predictions