tac_plus-pkg:
  pkg.installed:
    - sources:
      - tac_plus: salt://software/tacacs/tac_plus-4.0.4.26-1.el7.nux.x86_64.rpm
/etc/tac_plus.conf:
  file.managed:
    - source: salt://tacacs/tac_plus.conf
    - user: root
    - group: adm
    - mode: 664
/etc/yum.repos.d/nux-misc.repo
  file.managed:
    - source: salt://tacacs/nux-misc.repo
    - user: root
    - group: adm
    - mode: 664
    service.running:
        - watch:
            - pkg: tac_plus
            - file: etc/tac_plus.conf
            - user: system
