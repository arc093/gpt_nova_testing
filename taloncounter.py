import yaml
import argparse

def main():
    parser = argparse.ArgumentParser(description="Process a YAML file.")
    parser.add_argument('file_path', type=str, help='Path to the YAML file to be processed')
    args = parser.parse_args()
    file_path = args.file_path

    with open(file_path, 'r') as file:
        yaml_data = yaml.safe_load(file)

    # Load YAML data ignoring comments
    yaml_data = "\n".join(line for line in yaml_data.split("\n") if not line.strip().startswith("#"))

    # Load YAML content
    data = yaml.safe_load(yaml_data)

    def count_key_value_pairs(data):
        if isinstance(data, dict):
            count = len(data)
            for key, value in data.items():
                count += count_key_value_pairs(value)
            return count
        elif isinstance(data, list):
            return sum(count_key_value_pairs(item) for item in data)
        else:
            return 0

    count = count_key_value_pairs(data)
    print(f"Number of key-value pairs: {count}")

if __name__ == "__main__":
    main()