#!/usr/bin/env bash
set -euo pipefail

PROJECTS_CONFIG_HOME="$(pwd)"
PROFILE_FILE="${HOME}/.bashrc"
VAR_NAME="PROJECTS_CONFIG_HOME"

if ! command -v ansible-vault >/dev/null 2>&1; then
    echo "Installing ansible-vault (cross-platform Python package)..."
    if command -v pip3 >/dev/null 2>&1; then
        pip3 install ansible-vault
    elif command -v pip >/dev/null 2>&1; then
        pip install ansible-vault
    else
        echo "No pip found. Install python3-pip first." >&2
        exit 1
    fi
else
    echo "ansible-vault is already installed."
fi

if ! grep -q "export ${VAR_NAME}=" "${PROFILE_FILE}" 2>/dev/null; then
    echo "" >> "${PROFILE_FILE}"
    echo "# Projects config home path" >> "${PROFILE_FILE}"
    echo "export ${VAR_NAME}=\"${PROJECTS_CONFIG_HOME}\"" >> "${PROFILE_FILE}"
    echo "Added global variable ${VAR_NAME} to ${PROFILE_FILE}"
else
    echo "Variable ${VAR_NAME} already set in ${PROFILE_FILE}"
fi

CONFIG_FILE="${PROJECTS_CONFIG_HOME}/config.yaml"
if [[ ! -f "${CONFIG_FILE}" ]]; then
    cat > "${CONFIG_FILE}" <<EOF
# Ansible Vault password configuration
# Replace the placeholder below with your actual vault password
vault_password: "CHANGE_ME"
EOF
    echo "Created config file: ${CONFIG_FILE}"
else
    echo "Config file already exists: ${CONFIG_FILE}"
fi

echo "Installation complete."
echo "Run: source ${PROFILE_FILE}"
echo "${VAR_NAME}: ${PROJECTS_CONFIG_HOME}"
echo "Set your vault password in: ${CONFIG_FILE}"
