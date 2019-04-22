# Ansible Local Devbox

![jealous](image/automate-jealous.jpeg)

[Ansible][ansible] playbook to provision my/kenneth's main laptop. The layout follows [Ansible best
practices][ansible-best-practices].

If you run these plays on your machine __YOUR BOX WILL BE RECONFIGURED AND YOU MIGHT NOT LIKE IT!__

I/kenneth am currently using [Xubuntu][xubuntu], so many of the [Ansible][ansible] tasks use apt(itude). You could easily adapt this for other
[Debian][debian] releases or fork/modify it for rpm based distros.

## Prerequisites

Install prerequisites. The `pip` release in the current [Xubuntu][xubuntu] release (18.04) is broken, so I install using
[get-pip.py][get-pip].

    $ sudo apt-get install -y aptitude
    $ sudo aptitude install -y python3 curl
    $ mkdir ~/bin && cd ~/bin && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    $ sudo python3 get-pip.py

## Running

    $ ansible-playbook -K devbox.yml

## Manual Set Up

Manual task. Writing these down so I don't forget.

- SSH Keys. Need these for GitHub, deploying, etc.


### Firefox Add Ons

I'm current using:

- Asciidoctor.js Live Preview
- ColorZilla
- Feedbro
- Mardown Viewer
- Momentum
- Pwdhash
- uBlock Origin

## TODO/in-progress

- document initial manual setup
- dotfiles
- multimedia installs
  - vlc
  - xmms

<!-- refs-->
[ansible]: https://ansible.com "Ansible Home Page"
[xubuntu]: https://xubuntu.org "xubuntu home page"
[debian]: https://www.debian.org "debian home page"

[get-pip]: https://pip.pypa.io/en/stable/installing/ "installing pip"

[ansible-best-practices]: https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html "ansible best practices"
