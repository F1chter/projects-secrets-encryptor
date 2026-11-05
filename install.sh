#!/usr/bin/env bash
set -euo pipefail

# Directory where this script lives (current folder, not ${HOME})
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 1. Check openssl version
if ! command -v openssl >/dev/null 2>&1; then
  echo "Error: openssl is not installed or not on PATH."
  echo "Install it first (see README.md 'Installing OpenSSL')."
  exit 1
fi

echo "OpenSSL found: $(openssl version)"

# 2. Create openssl.config with placeholder for password
CONFIG_FILE="$SCRIPT_DIR/openssl.config"
if [[ ! -f "$CONFIG_FILE" ]]; then
  cat > "$CONFIG_FILE" <<'EOF'
# OpenSSL configuration
# Replace the placeholder password below with your actual password.

[req]
distinguished_name = req_distinguished_name
prompt = no

[req_distinguished_name]
CN = projects-config

[ca]
default_ca = CA_default

[CA_default]
password = PLACEHOLDER_PASSWORD
EOF
  echo "Created $CONFIG_FILE (edit PLACEHOLDER_PASSWORD)."
else
  echo "$CONFIG_FILE already exists, skipping."
fi

# 3. Set PROJECTS_CONFIG_HOME to current folder (not ${HOME})
export PROJECTS_CONFIG_HOME="$SCRIPT_DIR"
echo "PROJECTS_CONFIG_HOME=$PROJECTS_CONFIG_HOME"

echo ""
echo "To persist PROJECTS_CONFIG_HOME, add to your shell profile:"
echo "  export PROJECTS_CONFIG_HOME=\"$PROJECTS_CONFIG_HOME\""
