LoadPlugin write_graphite

<Plugin write_graphite>
  <Node "onalabs">
    Host "{{ GRAPHITE_SERVER_HOST }}"
    Port "{{ GRAPHITE_SERVER_PORT }}"
    Protocol "{{ GRAPHITE_SERVER_PROTOCOL }}"
    LogSendErrors true
    Prefix "collectd"
    Postfix "collectd"
    StoreRates true
    AlwaysAppendDS false
    EscapeCharacter "_"
  </Node>
</Plugin>
