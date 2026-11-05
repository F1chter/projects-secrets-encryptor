# projects-config
A private repository with project's config

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

Here is a complete, copy-ready guide in Markdown that you can add directly to your `README.md`.

Написання✓

## How to Create a Private Copy of a Public GitHub Repository

This guide explains how to create an independent private copy of a public GitHub repository while preserving its Git history, branches, and tags. It also explains how to configure the original public repository as an `upstream` remote to receive future updates.

### 1\. Create a New Private GitHub Repository

1. Open [GitHub](<https://github.com>).
2. Click **New repository**.
3. Enter a repository name.
4. Select **Private** under repository visibility.
5. Click **Create repository**.

**Important:** Do not initialize the new repository with a README, `.gitignore`, or license. Keep it empty to avoid conflicts when pushing the original repository's history.

### 2\. Clone the Original Public Repository

Open a terminal and clone the original repository as a bare repository:

bash

```bash
git clone --bare https://github.com/ORIGINAL-USER/PUBLIC-REPO.git
```

Replace:

- `ORIGINAL-USER` with the original repository owner's username.
- `PUBLIC-REPO` with the original repository name.

A bare clone downloads the repository's Git data without creating a regular working directory.

### 3\. Push Everything to Your Private Repository

Navigate into the cloned bare repository:

bash

```bash
cd PUBLIC-REPO.git
```

Push all branches, tags, and Git references to your new private repository:

bash

```bash
git push --mirror https://github.com/YOUR-USERNAME/PRIVATE-REPO.git
```

Replace `YOUR-USERNAME` and `PRIVATE-REPO` with your GitHub username and private repository name.

Your private repository now contains an independent copy of the original repository, including its Git history.

### 4\. Clone Your New Private Repository

Go back to the parent directory:

bash

```bash
cd ..
```

Remove the temporary bare clone if you no longer need it:

bash

```bash
rm -rf PUBLIC-REPO.git
```

Now clone your private repository normally:

bash

```bash
git clone https://github.com/YOUR-USERNAME/PRIVATE-REPO.git
```

Navigate into your project:

bash

```bash
cd PRIVATE-REPO
```

### 5\. Add the Original Public Repository as Upstream

Configure the original public repository as an `upstream` remote:

bash

```bash
git remote add upstream https://github.com/ORIGINAL-USER/PUBLIC-REPO.git
```

Your private repository is already configured as `origin`.

Check your remotes:

bash

```bash
git remote -v
```

Expected output:

text

```text
origin    https://github.com/YOUR-USERNAME/PRIVATE-REPO.git (fetch)
origin    https://github.com/YOUR-USERNAME/PRIVATE-REPO.git (push)

upstream  https://github.com/ORIGINAL-USER/PUBLIC-REPO.git (fetch)
upstream  https://github.com/ORIGINAL-USER/PUBLIC-REPO.git (push)
```

You now have two remotes:

| Remote | Description |
| --- | --- |
| `origin` | Your private GitHub repository |
| `upstream` | The original public GitHub repository |

**Note:** The `upstream` configuration exists only in your local repository. It is not automatically shared with other people who clone your private repository.

### 6\. Get Updates from the Original Public Repository

Whenever you want to synchronize your private repository with the original public project, follow these steps.

#### Step 1: Fetch upstream changes

bash

```bash
git fetch upstream
```

This downloads new commits, branches, and tags from the original repository without changing your working files.

#### Step 2: Switch to your main branch

bash

```bash
git checkout main
```

#### Step 3: Merge upstream changes

bash

```bash
git merge upstream/main
```

This merges the latest changes from the original public repository into your local `main` branch.

If there are merge conflicts, resolve them before completing the merge.

#### Step 4: Push changes to your private repository

bash

```bash
git push origin main
```

Your private GitHub repository now contains the synchronized changes.

### 7\. Regular Synchronization Workflow

Once everything is configured, you only need these commands to synchronize your private repository:

bash

```bash
git fetch upstream
git checkout main
git merge upstream/main
git push origin main
```

You only need to configure the upstream remote once per local clone.

### 8\. Working on Your Own Features

You can freely develop your own features in your private repository.

For example, create a separate feature branch:

bash

```bash
git checkout -b feature/my-custom-feature
```

Make your changes and commit them:

bash

```bash
git add .
git commit -m "Add my custom feature"
```

Push your feature branch to your private repository:

bash

```bash
git push -u origin feature/my-custom-feature
```

Your custom changes remain in your private repository.

When synchronizing with upstream, it is generally easiest to update your `main` branch first and then merge or rebase those updates into your feature branches.

### 9\. Useful Git Commands

| Command | Description |
| --- | --- |
| `git remote -v` | List configured remotes |
| `git remote add upstream URL` | Add the original repository |
| `git fetch upstream` | Download upstream changes |
| `git merge upstream/main` | Merge upstream main into the current branch |
| `git pull origin main` | Pull changes from your private repository |
| `git push origin main` | Push changes to your private repository |
| `git branch -a` | List local and remote branches |
| `git log --oneline --graph --all` | View commit history |

### 10\. Important Considerations

- Your private repository is independent of the original public repository. It is not an official GitHub fork.
- The original public repository remains unchanged.
- Your private repository will not automatically receive upstream updates.
- The upstream remote is configured locally and must be added separately on each new clone.
- The original repository's Git history, branches, and tags are preserved by the mirror operation.
- GitHub issues, pull requests, releases, stars, and other repository metadata are not copied by Git.
- Be careful when using `git push --mirror`: it mirrors remote references and can overwrite or delete references in the destination repository. Use it only when the destination is intended to be an exact Git mirror.

---

### Final Repository Structure

After completing the setup, your workflow looks like this:

text

```text
Original Public Repository
          |
          | upstream
          | git fetch upstream
          v
     Local Repository
          |
          | develop custom features
          | git push origin main
          v
    Your Private Repository
```

**Result:** You have your own private copy of a public GitHub project, can modify it independently, and can periodically synchronize it with the original public repository.