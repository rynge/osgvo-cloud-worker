
/etc/auto.master:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://autofs/auto.master
  require:
      - pkg: autofs

/etc/auto.master.d:
  file.directory:
    - user: root
    - group: root
    - mode: 755

autofs:
  pkg:
    - installed
    - name: autofs
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /etc/auto.master
      - file: /etc/auto.master.d/*

