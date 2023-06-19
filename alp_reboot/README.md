markdown

# Ansible Role: alp_reboot

## Overview

The `alp_reboot` role is designed to manage system reboots in an Ansible-controlled environment. It checks for the existence of a specific systemd service unit file, removes it if it does exist, and then recreates it based on a specific template. This role also manages the lingering settings for a specific user and initiates a system reboot when necessary.


## Role Variables

The main variable used in this role is `ansible_user`, which specifies the user account to enable lingering for and to execute tasks that require elevated privileges. Additionally, `playbook_path`, `ansible_playbook_basename`, and `reboot_mode` are also defined in this role.

## Tasks Included in This Role

Here's an overview of the tasks executed by this role:

1. Enable lingering for the `ansible_user`.
2. Check if the service unit file `/etc/systemd/system/myplaybook.service` exists. If it does, remove it.
3. Create a systemd service unit file from the template `myplaybook.service.j2` only if it did not exist previously.
4. Enable and start the `myplaybook` service, only if the service unit file did not previously exist.
5. Reboot the system if the service unit file did not previously exist.
6. Remove the `myplaybook.service` service file.
7. Reload the systemd daemon.
8. Conditionally end the playbook execution.

## Templates

This role uses the `myplaybook.service.j2` template to create a systemd service unit file. The file has the following structure:

```ini
[Unit]
Description=My Ansible Playbook
After=network.target

[Service]
Type=oneshot
WorkingDirectory={{ playbook_path }}
ExecStart=ansible-playbook {{ ansible_playbook_basename }}  -e 'playbook_path={{ playbook_path }}' -e 'ansible_user={{ ansible_user }}' -e 'reboot_mode=auto'
User={{ ansible_user }}

[Install]
WantedBy=multi-user.target

Usage

You can include this role in your Ansible playbook to manage system reboots.

For instance, you can add the alp_reboot role to your playbook as shown:

yaml

- hosts: alphost
  roles:
    - alp_reboot
  vars:
    ansible_user: your_user
    playbook_path: /path/to/your/playbook
    ansible_playbook_basename: your_playbook.yml
    reboot_mode: auto

Replace your_user, /path/to/your/playbook, and your_playbook.yml with the appropriate values. This playbook runs the alp_reboot role on the hosts defined under alphost.

Alternatively, you can use this role directly from the command line:

bash

ansible-playbook setup_libvirt_host.yml -e "playbook_path=$(pwd)" -e "ansible_user=$(whoami)" -e "reboot_mode=auto"



