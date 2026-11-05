# projects-config
Used for storing encrypted secrets in separate folder(private repo)

## Installing OpenSSL

### Git Bash on Windows

1. Check if OpenSSL is installed:
   ```bash
   openssl version
   ```
   If you see `command not found` or similar, install it:

2. Install via Scoop:
   ```bash
   scoop install openssl
   ```
   Or via Chocolatey:
   ```bash
   choco install openssl
   ```

   After installing, restart Git Bash so the new `bin` is on your PATH.

### macOS (Terminal)

1. Check if OpenSSL is installed:
   ```bash
   openssl version
   ```
   macOS ships LibreSSL by default, so you may need Homebrew's OpenSSL:

2. Install via Homebrew:
   ```bash
   brew install openssl
   ```

### Linux (Terminal)

1. Check if OpenSSL is installed:
   ```bash
   openssl version
   ```

2. Install if missing:
   - Debian/Ubuntu:
     ```bash
     sudo apt-get update
     sudo apt-get install openssl
     ```
   - RHEL/CentOS/Fedora:
     ```bash
     sudo dnf install openssl
     ```
- Arch:
      ```bash
      sudo pacman -S openssl
      ```

## Usage

### 1. Run install.sh

Checks OpenSSL is installed, creates `openssl.config` with a placeholder password, and sets `PROJECTS_CONFIG_HOME` to the current folder:

```bash
bash install.sh
```

Edit `openssl.config` and replace `PLACEHOLDER_PASSWORD` with a real password.

### 2. Use project-config.sh.example

Copy it to `project-config.sh` and edit the top variables:

- `PROJECT_NAME` — your project name
- `ENCRYPT_FILES` — files (relative to current folder) to encrypt

Encrypt config files into `$PROJECTS_CONFIG_HOME/$PROJECT_NAME/`:

```bash
bash project-config.sh.example -encrypt
```

Decrypt and print them to console:

```bash
bash project-config.sh.example -decrypt
```

The password is read from `$PROJECTS_CONFIG_HOME/openssl.config`. Make sure `PROJECTS_CONFIG_HOME` is exported (install.sh prints the export line).
