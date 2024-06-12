# Tunnel Server

- This project is a simple tunnel server for port forwarding.

## Run in Docker Environment
### Build Docker Image
```shell
git clone https://github.com/moonpath/tunnel-server.git
cd tunnel-server
sudo docker build -t tunnel-server:latest -f Dockerfile .
```

### Run Docker Container
```shell
sudo docker run -itd -p 2222:22 \
-e SERVER_KEY=$SERVER_KEY \
-e CLIENT_PASSWORD=$CLIENT_PASSWORD \
tunnel-server:latest HostName=example.com \
User=user \
"RemoteForward=0.0.0.0:2222 0.0.0.0:22"
```

## Run in Python Environment
### Install Apt Packages
```shell
git clone https://github.com/moonpath/tunnel-server.git
cd tunnel-server
xargs -a packages.txt sudo apt-get install -y
```

### Run Python Script
```shell
python scripts/start_tunnel_server \
--server-key=$SERVER_KEY \
--client-password=$CLIENT_PASSWORD \
HostName=example.com \
User=user \
"RemoteForward=0.0.0.0:2222 0.0.0.0:22"
```

## Parameter Descriptions
```
usage: start_tunnel_server [-h] [-t TIMES] [-i INTERVAL] [-s SERVER_KEY] [-S SERVER_PASSWORD] [-c CLIENT_KEY]
                           [-C CLIENT_PASSWORD]
                           [options ...]

positional arguments:
  options               ssh options

options:
  -h, --help            show this help message and exit
  -t TIMES, --times TIMES
                        redo times
  -i INTERVAL, --interval INTERVAL
                        redo interval
  -s SERVER_KEY, --server-key SERVER_KEY
                        private key to login server
  -S SERVER_PASSWORD, --server-password SERVER_PASSWORD
                        password to login server, currently not supported
  -c CLIENT_KEY, --client-key CLIENT_KEY
                        public key to login client
  -C CLIENT_PASSWORD, --client-password CLIENT_PASSWORD
                        password to login client
```