import yaml
import matplotlib.pyplot as plt
import argparse

def calculate_percentage(test_results):
    percentages = {}
    for test_name, commands in test_results.items():
        correctly_guessed = 0
        total_commands = 0
        for command_category, results in commands.items():
            if isinstance(results, dict):  # Ensure we only process dict entries
                correctly_guessed += len(results.get('correctly_guessed', []))
                total_commands += len(results.get('correctly_guessed', [])) + len(results.get('incorrectly_guessed', []))
        if total_commands > 0:
            percentage = correctly_guessed / total_commands
        else:
            percentage = 0
        percentages[test_name] = percentage
    return percentages

def plot_percentages(percentages):
    test_names = list(percentages.keys())
    percent_correct = [percentages[test] * 100 for test in test_names]
    
    # Set the color palette to Pastel1
    colors = plt.cm.Pastel1(range(len(test_names)))
    
    plt.figure(figsize=(10, 6))
    plt.bar(test_names, percent_correct, color=colors)
    plt.xlabel('Test Name')
    plt.ylabel('Percent Correctly Guessed')
    plt.title('Percent Correctly Guessed Commands by Test')
    plt.ylim(0, 100)
    plt.show()

def main():
    parser = argparse.ArgumentParser(description="Process the results YAML file.")
    parser.add_argument('file_path', type=str, help='Path to the YAML file containing the test results')
    args = parser.parse_args()
    file_path = args.file_path

    # Load the results YAML file
    with open(file_path, 'r') as file:
        test_results = yaml.safe_load(file)

    # Calculate percentages for all tests in the results file
    percentages = calculate_percentage(test_results)
    print(percentages)
    # Plot the percentages
    plot_percentages(percentages)

if __name__ == "__main__":
    main()
