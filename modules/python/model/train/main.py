import argparse
from trainingDataGenerator import trainingDataGenerator


class Main():

    def __init__(self, file_path):
        self.file_path = file_path

    def main(self):
        training_data_generator = trainingDataGenerator(self.file_path)
        training_data = training_data_generator.training_data_generator()
        #return training_data



if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    
    parser.add_argument('file_path', type=str)

    args = parser.parse_args()

    if args.file_path is None:
        print("you must provide the correct parameters.")
    else:
        main_instance = Main(args.file_path)
        print(main_instance.main())
