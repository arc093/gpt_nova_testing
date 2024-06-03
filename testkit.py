from typing import Optional, Tuple
import requests
import json
import os
import yaml
import time
from tqdm import tqdm
import argparse

# Types
Headers = dict[str, str]
Data = dict[str, str]
Tool = dict[str, str]

def gpt_query(prompt: str, content: str, model_settings: dict) -> str:
    url = model_settings["model_endpoint"]

    headers, data = generate_payload(prompt, content, model_settings)

    response = requests.post(url, headers=headers, data=json.dumps(data))

    match response.status_code:
        case 200:
            # notify("GPT Task Completed")
            return response.json()["choices"][0]["message"]["content"].strip()
        case _:
            print("GPT Failure: Check the Talon Log")
            raise Exception(response.json())

def generate_payload(prompt: str, content: str, model_settings: dict) -> Tuple[Headers, Data]:
    """Generate the headers and data for the OpenAI API GPT request.
    Does not return the URL given the fact not all openai-compatible endpoints support new features like tools
    """
    # notify("GPT Task Started")

    TOKEN = get_token()

    headers = {
        "Content-Type": "application/json",
        "Authorization": f"Bearer {TOKEN}",
    }

    data = {
        "messages": [
            {
                "role": "system",
                "content": model_settings["model_system_prompt"],
            },
            {"role": "user", "content": f"{prompt}:\n{content}"},
        ],
        "max_tokens": 2024,
        "temperature": model_settings["model_temperature"],
        "n": 1,
        "stop": None,
        "model": model_settings["openai_model"],
    }

    return headers, data

def get_token() -> str:
    """Get the OpenAI API key from the environment"""
    try:
        return os.environ["OPENAI_API_KEY"]
    except KeyError:
        message = "GPT Failure: env var OPENAI_API_KEY is not set."
        print(message)
        raise Exception(message)

def get_command_list(test: dict) -> str:
    command_list = ''
    for talon_path in test['talon_paths']:
        talon_path = os.getcwd() + talon_path
        if os.path.exists(talon_path):
            with open(talon_path, 'r') as talon_file:
                # Read the contents of the talon file
                talon_content = talon_file.read()
                # Concatenate the contents to command_list
                command_list += talon_content + "\n"
        else:
            print(f"Warning: {talon_path} does not exist.")
    return command_list

def main():
    parser = argparse.ArgumentParser(description="Process a YAML file.")
    parser.add_argument('file_path', type=str, help='Path to the YAML file to be processed')
    args = parser.parse_args()
    file_path = args.file_path
    file_name = os.path.basename(file_path)

    # run the tests
    with open(file_path, 'r') as file:
        tests = yaml.safe_load(file)
        total_commands = sum(len(spoken_forms) for test in tests.values() for spoken_forms in test["test_commands"].values())
        print(total_commands)

        with tqdm(total=total_commands, desc="Testing commands! :)") as pbar:
            results = {}
            for test_name, test in tests.items():
                command_list = get_command_list(test)
                model_settings = test["model_settings"]
                prompt = model_settings["model_prompt"] + f"{command_list}"
                results[f"{test_name}_results"] = {}
                for intended_command, spoken_forms in test["test_commands"].items():
                    correctly_guessed = []
                    incorrectly_guessed = []
                    for spoken_form in spoken_forms:
                        time.sleep(2)
                        pbar.update(1)
                        result = gpt_query(prompt, spoken_form, model_settings)
                        if result == intended_command:
                            correctly_guessed.append(spoken_form)
                        else:
                            incorrectly_guessed.append(f"{spoken_form}: {result}")
                    results[f"{test_name}_results"][intended_command] = {
                        "correctly_guessed": correctly_guessed,
                        "incorrectly_guessed": incorrectly_guessed
                    }
            # Write the results to a YAML file
            with open(f'tests/{file_name}_results.yaml', 'w') as outfile:
                yaml.dump(results, outfile, default_flow_style=False)

            print(f"Results have been written to {file_path}_results.yaml")

if __name__ == "__main__":
    main()
