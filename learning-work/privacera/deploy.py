import os
import subprocess

def run_terraform_command(command, working_directory=None):
    process = subprocess.Popen(
        command,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        cwd=working_directory
    )
    stdout, stderr = process.communicate()

    if process.returncode != 0:
        print(f"Error: {stderr.decode('utf-8')}")
        exit(1)

    return stdout.decode('utf-8')

def main():
    profile_name = "saml"
    os.environ["TF_VAR_AWS_PROFILE"] = profile_name

    # Get the root directory
    root_directory = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))

    # Initialize and apply Terraform
    run_terraform_command(["terraform", "init"], working_directory=root_directory)
    run_terraform_command(["terraform", "apply", "-auto-approve"], working_directory=root_directory)

if __name__ == "__main__":
    main()
