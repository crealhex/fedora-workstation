# fedora-workstation

Ansible playbook to provision a Fedora Workstation as a headless development machine accessible via SSH and RDP.

## What it sets up

- **Dev tools**: Neovim, GNU Screen 5, Git, Docker, Terraform, Ansible, gh, Azure CLI, AWS CLI, Atlas CLI, Mutagen
- **Languages**: Java (17, 21 via SDKMAN), Gradle, Maven, Quarkus, Node.js (fnm), Bun, Python (uv)
- **AI CLIs**: Claude Code, GPT Codex
- **Networking**: Tailscale, SSH keys from GitHub, password auth disabled
- **Desktop**: GNOME Remote Desktop (RDP), display profiles restored, sleep/suspend disabled
- **System**: 8GB swap, passwordless sudo, Docker group membership, battery conservation mode

## Usage

```bash
curl -fsSL https://raw.githubusercontent.com/crealhex/fedora-workstation/main/setup.sh | bash
```

By default, this installs SSH keys from `github.com/crealhex.keys`. To use your own GitHub keys instead:

```bash
curl -fsSL https://raw.githubusercontent.com/crealhex/fedora-workstation/main/setup.sh | bash -s -- your-github-username
```

## Structure

```
├── setup.sh              # one-liner bootstrap script
└── ansible/
    ├── playbook.yml          # entrypoint (imports system + user)
    ├── system.yml            # root: packages, docker, repos, ssh, sleep, sudo
    ├── user.yml              # warender: sdkman, fnm, bun, claude, dotfiles
    └── files/
        ├── monitors.xml      # GNOME display profiles (RDP)
        └── kali-rdp.service  # socat port forward for Kali VM RDP (backup)
```
