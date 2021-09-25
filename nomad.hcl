data_dir = "/opt/nomad/data"
bind_addr = "#IP#"

server {
  enabled          = true
  bootstrap_expect = 3

  # This is the IP address of the first server provisioned
  server_join {
    retry_join = ["192.168.50.4", "192.168.50.5", "192.168.50.6"]
  }
}

client {
  enabled = true
  servers = ["192.168.50.4", "192.168.50.5", "192.168.50.6"]
}