#!/usr/bin/env bash
set -euo pipefail

log() {
  printf '\n==> %s\n' "$*"
}

warn() {
  printf '\nWARNING: %s\n' "$*" >&2
}

die() {
  printf '\nERROR: %s\n' "$*" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || die "Required command not found: $1"
}

is_ubuntu_like() {
  [[ -r /etc/os-release ]] || return 1
  . /etc/os-release
  [[ "${ID:-}" == "ubuntu" ]] || [[ "${ID_LIKE:-}" == *ubuntu* ]]
}

need_sudo() {
  if [[ "${EUID}" -eq 0 ]]; then
    return 1
  fi
  return 0
}

apt_install_if_missing() {
  local missing=()
  local pkg

  for pkg in "$@"; do
    if ! dpkg -s "$pkg" >/dev/null 2>&1; then
      missing+=("$pkg")
    fi
  done

  if (( ${#missing[@]} > 0 )); then
    log "Installing packages: ${missing[*]}"
    sudo apt-get install -y "${missing[@]}"
  else
    log "Required apt packages already installed"
  fi
}

ensure_pipx_path_for_current_shell() {
  local pipx_bin
  pipx_bin="${HOME}/.local/bin"

  if [[ ":${PATH}:" != *":${pipx_bin}:"* ]]; then
    export PATH="${pipx_bin}:${PATH}"
    warn "Added ${pipx_bin} to PATH for this shell session"
  fi
}

install_or_upgrade_ansible_core() {
  if pipx list --short 2>/dev/null | grep -qx 'ansible-core'; then
    log "ansible-core already installed with pipx; upgrading"
    pipx upgrade ansible-core
  else
    log "Installing ansible-core with pipx"
    pipx install ansible-core
  fi
}

main() {
  log "Starting workstation bootstrap"

  is_ubuntu_like || die "This script currently supports Ubuntu/Xubuntu only"

  require_command bash
  require_command dpkg

  if need_sudo; then
    require_command sudo
    log "Checking sudo access"
    sudo -v
  else
    warn "Running as root; installing ansible-core with pipx for root is usually not what you want"
  fi

  log "Updating apt package index"
  sudo apt-get update

  apt_install_if_missing \
    git \
    python3 \
    python3-pip \
    pipx

  log "Ensuring pipx user bin directory is on PATH"
  pipx ensurepath

  ensure_pipx_path_for_current_shell

  install_or_upgrade_ansible_core

  log "Verifying installation"
  require_command git
  require_command python3
  require_command pipx
  require_command ansible

  printf '\nInstalled versions:\n'
  printf '  git:      %s\n' "$(git --version)"
  printf '  python3:  %s\n' "$(python3 --version)"
  printf '  pipx:     %s\n' "$(pipx --version)"
  printf '  ansible:  %s\n' "$(ansible --version | head -n 1)"

  cat <<'EOF'

Bootstrap complete.

If this is your first run, open a new shell so any PATH updates from pipx are guaranteed
to be active in future sessions.
EOF

}

main "$@"
