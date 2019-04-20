# Ansible Local Devbox

![jealous](image/automate-jealous.jpeg)

[Ansible][ansible] playbook to provision my/kenneth's main laptop.

I/kenneth use [Xubuntu][xubuntu], so many of the commands use apt(itude). You could easily adapt this for other
[Debian][debian] releases or for it for rpm base distros.

## Prerequisites

- python3
- pip3
- ansible

## Running

    $ ansible-playbook -K devbox.yml

## TODO/in-progress

- document initial manual setup
- xmodmap
- dotfiles
- firefox mime type for local md files
- multimedia installs
  - vlc
  - gimp (ufraw + printing)
  - xmms
- emacs keybindings
- export editor env var

<!-- refs-->
[ansible]: https://ansible.com "Ansible Home Page"
[xubuntu]: https://xubuntu.org "xubuntu home page"
[debian]: https://www.debian.org "debian home page"
