data_dir   = "/opt/nomad/data"
bind_addr  = "0.0.0.0"
datacenter = "dc1"

server {
  license_path = "/etc/nomad.d/license.hclic"
  enabled          = true
  bootstrap_expect = 3
  server_join {
    retry_join = ["provider=aws tag_key=NomadType tag_value=server"]
  }
}

client {
  enabled = false
}

acl {
  enabled = false
}

telemetry {
  collection_interval = "1s"
  disable_hostname = true
  prometheus_metrics = true
  publish_allocation_metrics = true
  publish_node_metrics = true
}
