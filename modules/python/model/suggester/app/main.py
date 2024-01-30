from loadModel import loadModel

class Main:

    def __init__(self, model, new_data):
        self.model = model
        self.new_data = new_data

    def main(self):
        load_model = loadModel(self.model, self.new_data)
        loaded_model = load_model.load_model()
        return loaded_model
