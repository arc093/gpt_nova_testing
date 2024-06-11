import yaml
import matplotlib.pyplot as plt
import argparse
import re
import numpy as np

def calculate_percentage(test_results):
    percentages = {}
    for test_name, commands in test_results.items():
        run_number = extract_run_number(test_name)
        test_base_name = extract_base_name(test_name)
        
        if test_base_name not in percentages:
            percentages[test_base_name] = {}

        if run_number not in percentages[test_base_name]:
            percentages[test_base_name][run_number] = []
        
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
        percentages[test_base_name][run_number].append(percentage)
    return percentages

def extract_run_number(test_name):
    match = re.search(r'run(\d+)', test_name)
    if match:
        return int(match.group(1))
    else:
        return None

def extract_base_name(test_name):
    base_name = re.sub(r'_run\d+', '', test_name)
    return base_name

def calculate_aggregate_percentages_and_std(percentages):
    aggregate_percentages = {}
    std_devs = {}
    for test_base_name, runs in percentages.items():
        all_percentages = []
        for run_number, percent_list in runs.items():
            all_percentages.extend(percent_list)
        
        mean_percentage = np.mean(all_percentages)
        std_devs[test_base_name] = np.std(all_percentages)
        aggregate_percentages[test_base_name] = mean_percentage
    return aggregate_percentages, std_devs

def extract_test_numbers(test_names):
    numbers = []
    for name in test_names:
        match = re.search(r'(\d+)', name)
        if match:
            numbers.append(int(match.group(1)))
    return numbers

def plot_percentages_with_std(aggregate_percentages, std_devs):
    plt.style.use('bmh')  # Apply the fivethirtyeight style sheet

    test_names = list(aggregate_percentages.keys())
    percent_correct = [aggregate_percentages[test] * 100 for test in test_names]
    error_bars = [std_devs[test] * 100 for test in test_names]
    test_numbers = extract_test_numbers(test_names)
    
    # Sort the data points by test_numbers
    sorted_indices = np.argsort(test_numbers)
    test_numbers = np.array(test_numbers)[sorted_indices]
    percent_correct = np.array(percent_correct)[sorted_indices]
    error_bars = np.array(error_bars)[sorted_indices]
    
    plt.figure(figsize=(10, 6))
    plt.errorbar(test_numbers, percent_correct, yerr=error_bars, fmt='-o', capsize=5)
    plt.xlabel('Number of Commands')
    plt.ylabel('Percent Correctly Guessed')
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
    print("Percentages by run:", percentages)
    
    # Calculate aggregate percentages and standard deviations
    aggregate_percentages, std_devs = calculate_aggregate_percentages_and_std(percentages)
    print("Aggregate Percentages:", aggregate_percentages)
    print("Standard Deviations:", std_devs)
    
    # Plot the aggregate percentages with standard deviation error bars and test numbers on the x-axis
    plot_percentages_with_std(aggregate_percentages, std_devs)

if __name__ == "__main__":
    main()
