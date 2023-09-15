# Provision Ubuntu with Ansible

Used to configure a new Ubuntu installation to a daily working state with Ansible.

- Install core apt packages
- Generate new SSH key and add to GitHub account
- Install workflow tools, zsh, tmux, neovim, vscode, etc.
- Install Go, Rust, Node and tooling
- Clone and configure dotfiles
- Install and configure Docker
- Add JetBrains nerd fonts

A fine-grained GitHub access token is used to add the SSH key through the GitHub API.
The token is stored in an encrypted file using Ansible Vault.
For running the `env_secrets.yml` playbook, the ansible-vault password must be supplied

- `env_secrets.yml` playbook is used to decrypt and save the `secrets.yml`
- `main.yml` runs all the other playbooks

## Usage

```bash
make
```

Or:

```bash
ansible-playbook env_secrets.yml --ask-vault-pass
source ~/.zshenv
ansible-playbook main.yml -i inventory.ini

# specific tags
ansible-playbook main.yml -i inventory.ini --ask-become-pass --tags terraform
```

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

## Refs:

- Get GitHub access token: [Creating a fine-grained personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-fine-grained-personal-access-token)
- [GitHub API - Create a public SSH key to authenticated user](https://docs.github.com/en/rest/users/keys?apiVersion=2022-11-28#create-a-public-ssh-key-for-the-authenticated-user)
- [Error handling in playbooks](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_error_handling.html)
