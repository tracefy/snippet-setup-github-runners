# Self-Hosted GitHub Actions Runner Setup

This script helps you set up multiple self-hosted GitHub Actions runners on a Linux ARM64 machine. It automates the process of downloading and configuring the runners, allowing you to easily create a pool of runners for your organization.

## Prerequisites

- Linux ARM64 machine (e.g., Raspberry Pi with ARM64 architecture) if you want to use others you have to update the setup lines.
- Bash shell (version 4.0 or later)
- Internet connectivity

## Getting Started

1. Clone or download the script to your Linux ARM64 machine.
2. Open a terminal and navigate to the directory where the script is located.
3. Make the script executable by running the following command:

   ```bash
   chmod +x setup-runners.sh
   ```

4. Open the script file in a text editor and make the following modifications:

   - Replace the placeholder values `"TOKEN"` and `"NAME"` in the `get_runner_token` function with your GitHub Personal Access Token and organization name, respectively. The token should have the necessary permissions to register and configure runners.
   - Optionally, you can modify other variables such as the runner version and URL in the main loop section of the script (`for` loop).

5. Save the modifications and close the text editor.

## Usage

To set up the self-hosted GitHub Actions runners, follow these steps:

1. Open a terminal and navigate to the directory where the script is located.
2. Run the script using the following command:

   ```bash
   ./setup-runners.sh
   ```

3. The script will prompt you to enter the start number and end number for the runner IDs. These numbers will be used to create separate directories for each runner. Enter valid numbers and press Enter.
4. The script will display the start and end numbers you provided.
5. The script will start setting up the runners one by one. It will download the necessary runner package, verify its integrity, and configure each runner with the specified parameters.
6. Once the runners are set up, the script will display the crontab and current command that you can use to schedule the runners to start on system boot or start them manually.
7. You can find each runner's directory in the current working directory, named `actions-runner-<number>`.

## Customization

You can customize the script according to your specific requirements:

- Runner Version and URL: In the main loop section of the script, you can modify the `runner_version` and `runner_url` variables to specify the desired runner version and download URL. Make sure the runner package is compatible with your Linux ARM64 machine.

- Runner Configuration: If you need to modify the configuration parameters for each runner, you can do so in the `./config.sh` command within the main loop section. Adjust the `--url`, `--token`, `--name`, `--runnergroup`, `--work`, and `--labels` flags to match your organization's requirements.

## Security Considerations

- Make sure to keep your Personal Access Token (`PAT`) secure and do not share it with others. The token should have the necessary permissions to register and configure runners within your GitHub organization.

- It is recommended to run this script on a trusted machine with restricted access to prevent unauthorized access to your GitHub organization's resources.

## Troubleshooting

If you encounter any issues or errors during the setup process, consider the following troubleshooting steps:

- Verify that the Personal Access Token (`PAT`) used in the script has the necessary permissions to register and configure runners within your GitHub organization.

- Double-check the modified variables, such

 as the runner version and URL, to ensure they are correct and compatible with your Linux ARM64 machine.

- Review any error messages or output displayed in the terminal for more specific details on the encountered issue.

If the issue persists, you can consult the GitHub Actions documentation or seek support from the GitHub community for further assistance.

## License

This script is provided under the [MIT License](LICENSE).

## Disclaimer

This script is provided as-is without any warranty. Use it at your own risk. The authors and contributors are not responsible for any damages or losses caused by the use of this script.

