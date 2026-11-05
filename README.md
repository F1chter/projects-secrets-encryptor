# projects-config
A private repository with project's config

## Installation

1. Make the script executable:
   ```bash
   chmod +x install.sh
   ```

2. Run the installer from the repository root:
   ```bash
   bash install.sh
   ```

3. Apply the environment variable:
   ```bash
   source ~/.bashrc
   ```

This installs the cross-platform `ansible-vault` Python package and sets the `PROJECTS_CONFIG_HOME` global path variable to the current directory (`$(pwd)`).

## Configure Vault Password

1. Edit the generated `config.yaml` file:
   ```yaml
   vault_password: "your-actual-vault-password"
   ```
3. Replace `your-actual-vault-password` with your real Ansible Vault password.
4. The file is gitignored and will not be committed.

## Encrypt a File

1. Copy the example and edit it:
   ```bash
   cp encrypt.sh.example encrypt.sh
   chmod +x encrypt.sh
   ```
2. Set `PROJECT_NAME` and `FILE_TO_ENCRYPT` at the top of `encrypt.sh`.
3. Run it:
   ```bash
   ./encrypt.sh
   ```
4. The encrypted file is saved to `${PROJECTS_CONFIG_HOME}/${PROJECT_NAME}/<file>.vault`.

## Decrypt a File

1. Copy the example and edit it:
   ```bash
   cp decrypt.sh.example decrypt.sh
   chmod +x decrypt.sh
   ```
2. Set `PROJECT_NAME`, `ENCRYPTED_FILE`, and `OUTPUT_FILE` at the top of `decrypt.sh`.
3. Run it:
   ```bash
   ./decrypt.sh
   ```
4. The decrypted file is saved to `${OUTPUT_FILE}`.
