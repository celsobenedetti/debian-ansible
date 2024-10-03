# Provision Debian with Ansible

Personal Ansible scripts to configure a new Debian based installation to a daily working state

- Install core apt packages
- Generate new SSH key and add to GitHub account
- Install workflow tools, zsh, tmux, neovim, vscode, etc.
- Install Go, Rust, Node and tooling
- Clone and configure dotfiles
- Install and configure Docker, K8s, Terraform, Ollamareadm
- Install [nerd fonts](./fonts/)

A fine-grained GitHub access token is used to add the SSH key through the GitHub API.
The token is stored in an encrypted file using Ansible Vault.
For running the `env_secrets.yml` playbook, the ansible-vault password must be supplied

- `env_secrets.yml` playbook is used to decrypt and save the `secrets.yml`
- `main.yml` runs all the other playbooks

## Steps

```bash
# 1. Update system and install basic requirements
sudo apt update \
 && sudo apt upgrade -y \
 && sudo apt install git curl python3 python3-pip python3.12-venv

# 2. Clone Ansible s cripts repo
git clone https://github.com/celsobenedetti/debian-ansible.git ~/local/debian-ansible

# 3. Create python venv and add python bins to $PATH
python3 -venv ~/.local/venv
export PATH=~/.local/venv/bin:$PATH

# 4. Install Ansible
pip install ansible

# 5. Decrypt env secrets
ansible-playbook env_secrets.yml --ask-vault-pass
source ~/.zshenv

# 6. Run main playbook
ansible-playbook main.yml --ask-become-pass

# 7. (Optional) Extras
ansible-playbook extra.yml --ask-become-pass --tags vscode
```

## Scan repo for secrets with Gitleaks

```bash
docker run -v $(pwd):/path ghcr.io/gitleaks/gitleaks:latest detect --source "/path" -v
```

## Refs

- Get GitHub access token: [Creating a fine-grained personal access token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-fine-grained-personal-access-token)
- [GitHub API - Create a public SSH key to authenticated user](https://docs.github.com/en/rest/users/keys?apiVersion=2022-11-28#create-a-public-ssh-key-for-the-authenticated-user)
- [Error handling in playbooks](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_error_handling.html)
