import os
import subprocess

def run_terraform_command(command):
    result = subprocess.run(
        command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True
    )
    print(result.stdout)
    print(result.stderr)

if __name__ == "__main__":
    script_directory = os.path.dirname(os.path.abspath(__file__))
    root_directory = os.path.abspath(os.path.join(script_directory, ".."))

    os.chdir(root_directory)
    
    # Set the AWS_PROFILE environment variable
    os.environ["AWS_PROFILE"] = "saml"

    run_terraform_command("terraform init")
    run_terraform_command("terraform validate")
    run_terraform_command("terraform plan")
    run_terraform_command("terraform apply -auto-approve")
