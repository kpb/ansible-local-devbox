# Repository Guidelines

## Project Structure & Module Organization
This repository provisions a personal Ubuntu/Xubuntu dev machine with Ansible.

- `ansible/devbox.yml`: main entrypoint playbook.
- `ansible/roles/`: role-based automation such as `basics`, `devtools`, `docker`, `dotfiles`, `ruby`, and `xfce`.
- `ansible/roles/*/tasks/main.yml`: primary task definitions for each role.
- `ansible/roles/*/defaults/main.yml`: role defaults.
- `ansible/roles/*/files/` and `templates/`: static assets and Jinja templates.
- `bootstrap/bootstrap.sh`: minimal installer for `python3`, `pipx`, and `ansible-core`.
- `image/`: documentation assets only.

## Build, Test, and Development Commands
- `bash bootstrap/bootstrap.sh`: install the minimum tooling needed to run the playbook.
- `ansible-playbook -K ansible/devbox.yml`: apply the full workstation configuration.
- `ansible-playbook -K ansible/devbox.yml --tags upgrade`: run tasks intended to be safe for repeat upgrades.
- `ansible-playbook --syntax-check ansible/devbox.yml`: validate playbook syntax before committing.
- `git diff` and `git status --short`: review local changes before opening a PR.

## Coding Style & Naming Conventions
Use YAML with two-space indentation and keep task files readable and idempotent. Prefer fully qualified Ansible module names such as `ansible.builtin.apt`. Name roles and files with lowercase, descriptive paths; keep task names imperative, for example `install Firefox from Mozilla apt repository`. Store reusable variables in role defaults instead of hardcoding paths repeatedly.

## Testing Guidelines
There is no formal automated test suite in this repository today. At minimum, run `ansible-playbook --syntax-check ansible/devbox.yml` after changes. For task changes, verify idempotence by rerunning the relevant play or tag and confirming the second run does not report unexpected changes.

## Commit & Pull Request Guidelines
Recent history uses Conventional Commits, for example `fix(ansible): preserve Firefox profile during snap migration` and `feat: manage firefox via mozilla apt repo`. Follow that format with a clear type and optional scope. Keep PRs focused, describe the machine impact, note any manual verification you performed, and include before/after context when changing user-facing desktop behavior.

## Security & Configuration Tips
Assume this playbook can reconfigure a real workstation. Avoid destructive tasks unless they are clearly guarded by checks and safe migration steps. Keep secrets, personal tokens, and host-specific values out of tracked files unless they are intentionally shared defaults.
