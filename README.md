# pullhomeip

A simple shell script to resolve and export the current WAN IP address of a home network by querying multiple public DNS resolvers. The script logs results and updates an environment file with the resolved IP.

## Features

- Resolves a predefined hostname (`jayburd.duckdns.org`) via multiple public DNS resolvers (Cloudflare, Google, Quad9).
- Falls back to system DNS resolution methods if public resolvers fail.
- Exports the resolved IP address to an environment file (`~/.home_ip.env`).
- Maintains a log of resolution attempts and outcomes.

## Tech Stack

- Shell scripting (Bash)
- Uses standard Unix utilities: `dig`, `host`, `getent`, `ping`, `awk`

## Getting Started

### Prerequisites

- Bash shell
- `dig` utility (usually from `bind-utils` or `dnsutils` package)
- Optional: `host`, `getent`, `ping` for fallback DNS resolution

### Installation

Clone the repository:

```bash
git clone https://github.com/justin-napolitano/pullhomeip.git
cd pullhomeip
```

Make the script executable:

```bash
chmod +x pull_home_ip.sh
```

### Usage

Run the script directly:

```bash
./pull_home_ip.sh
```

This will update the `~/.home_ip.env` file with the current WAN IP and append logs to `~/.local/share/duckdns/pull_ip.log`.

To load the IP into your shell environment:

```bash
source ~/.home_ip.env
```

## Project Structure

```
pullhomeip/
└── pull_home_ip.sh   # Main script to resolve and export WAN IP
```

- `pull_home_ip.sh`: Bash script that performs DNS resolution and logging.

## Future Work / Roadmap

- Parameterize the hostname instead of hardcoding `jayburd.duckdns.org`.
- Add options to specify output environment file and log location.
- Support IPv6 resolution.
- Add unit tests or integration tests.
- Provide Docker containerization for easier deployment.
- Add cron job installation instructions or automation.

---

This project assumes the user wants a lightweight, reliable way to update their WAN IP environment variable for scripts or other automation that depends on the current external IP address.