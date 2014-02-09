{% if grains['os'] in ['CentOS', 'RedHat'] %}
httpd:
{% elif grains['os'] == 'Ubuntu' %}
apache2:
{% endif %}
  pkg:
    - installed
  service:
    - running
    {% if grains['os'] in ['CentOS', 'RedHat'] %}
    - file: /etc/httpd/conf/httpd.conf
    {% endif %}
    - require:
      {% if grains['os'] in ['CentOS', 'RedHat'] %}
      - pkg: httpd
      {% elif grains['os'] == 'Ubuntu' %}
      - pkg: apache2
      {% endif %}

{% if grains['os'] in ['CentOS', 'RedHat'] %}
/etc/httpd/conf/httpd.conf:
  file.managed:
    - source: salt://minion-state-tree/httpd.conf
    - user: root
    - group: root
    - mode: 644
{% endif %}
