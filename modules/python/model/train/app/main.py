from trainingDataGenerator import trainingDataGenerator
from model import model

class Main():

    def __init__(self, file_path, model_name):
        self.file_path = file_path
        self.model_name = model_name

    def main(self):
        training_data_generator = trainingDataGenerator(self.file_path)
        training_data = training_data_generator.training_data_generator()
        my_model = model(training_data, self.model_name)
        my_model.x_y_train()
        my_model.training()
