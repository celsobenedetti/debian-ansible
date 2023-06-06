# Provision fresh Ubuntu installation with Ansible

## Requirements

1. Update apt cache & upgrade packages

```bash
sudo apt update && sudo apt upgrade -y && sudo apt install -y curl
```

2. Install pip

```bash
python3 --version # check if python3 is installed
python3 -m pip -V # check if pip is installed

# if not installed:
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3 get-pip.py  \
    && rm get-pip.py
```

3. Install Ansible

```bash
pip install ansible
```

## Usage

1. Get GitHub access token: [Creating a fine-grained personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-fine-grained-personal-access-token)

2. Run playbook

```bash
export GH_TK=<token>
ansible-playbook main.yml
```

3. Run encrypted playbook

```bash
ansible-playbook env_secrets.yml --ask-vault-pass
```
