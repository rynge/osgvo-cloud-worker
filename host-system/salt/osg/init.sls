
/etc/yum.repos.d/osg.repo:
  file:
    - managed
    - source: salt://osg/osg.repo
    - require:
      - pkg: epel-release

osg-oasis:
  pkg:
    - installed
    - require:
      - file: /etc/yum.repos.d/osg.repo

/cvmfs:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/etc/cvmfs:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/etc/cvmfs/default.local:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://osg/cvmfs/default.local

/etc/auto.master.d/cvmfs.autofs:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://osg/cvmfs/cvmfs.autofs


