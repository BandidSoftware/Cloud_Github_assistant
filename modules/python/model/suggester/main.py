import argparse
from loadModel import loadModel

class Main:

    def __init__(self, model, new_data):
        self.model = model
        self.new_data = new_data

    def main(self):
        load_model = loadModel(self.model, self.new_data)
        loaded_model = load_model.load_model()
        return loaded_model

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    
    parser.add_argument('model', type=str)
    parser.add_argument('new_data', type=str)

    args = parser.parse_args()

    if args.model is None or args.new_data is None:
        print("you must provide the correct parameters.")
    else:
        main_instance = Main(args.model, args.new_data)
        print(main_instance.main())
