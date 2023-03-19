import os
import subprocess

def run_terraform_command(command):
    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    stdout, stderr = process.communicate()

    if process.returncode != 0:
        print(f"Error: {stderr.decode('utf-8')}")
        exit(1)

    return stdout.decode('utf-8')

def main():
    profile_name = "saml"
    os.environ["TF_VAR_AWS_PROFILE"] = profile_name

    run_terraform_command(["terraform", "init"])
    run_terraform_command(["terraform", "apply", "-auto-approve"])

if __name__ == "__main__":
    main()
