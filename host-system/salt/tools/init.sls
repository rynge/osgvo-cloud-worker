/usr/bin/osgvo-start-docker-instance:
  file.managed:
    - source: salt://tools/osgvo-start-docker-instance
    - mode: 755

/usr/bin/osgvo-shutdown-check:
  file.managed:
    - source: salt://tools/osgvo-shutdown-check
    - mode: 755

/usr/bin/osgvo-prepare-image:
  file.managed:
    - source: salt://tools/osgvo-prepare-image
    - mode: 755

/etc/cron.d/osgvo-cloud-worker:
  file.managed:
    - source: salt://tools/cron.osgvo

