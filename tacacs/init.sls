# Install tac_plus
tac_plus-pkg:
  pkg.installed:
    - sources:
      # tac_plus: salt://path/to/rpm/package/on/master
      - tac_plus: salt://software/tacacs/tac_plus-4.0.4.26-1.el7.nux.x86_64.rpm
# Move conf file into place
/etc/tac_plus.conf:
  file.managed:
    - source: salt://tacacs/tac_plus.conf
    - user: root
    - group: adm
    - mode: 664

# Run Service tac_plus at startup
tac_plus:
  service.running:
    - enable: True

# creates tacacs folder in etc if doesn't exist
mkdir -p /etc/tacacs:
  cmd.run:
    - user: root
    - shell: /bin/bash

# Puts shell script to setup firewall and restart services
/etc/tacacs/firewalld.sh:
  file.managed:
    - source: salt://tacacs/firewalld.sh
    - user: root
    - group: adm
    - mode: 774

# Allow tacacs traffic through firewall-cmd
# bash script to add firewall rules/reload firewall and restart tac_plus
sh /etc/tacacs/firewalld.sh:
  cmd.run:
    - user: root
    - shell: /bin/bash
    - require:
      - file: /etc/tac_plus.conf
      - file: /etc/tacacs/firewalld.sh
      - pkg: tac_plus-pkg
