---
slug: github-pullhomeip
title: 'pullhomeip: Bash Script to Resolve WAN IP Using Public DNS and Fallbacks'
repo: justin-napolitano/pullhomeip
githubUrl: https://github.com/justin-napolitano/pullhomeip
generatedAt: '2025-11-23T09:28:15.105379Z'
source: github-auto
summary: >-
  Bash script that resolves the current WAN IP via multiple public DNS resolvers with fallback
  methods, exporting it as an environment variable with logging.
tags:
  - bash
  - dns
  - wan-ip
  - home-network
  - shell-script
seoPrimaryKeyword: wan ip resolution
seoSecondaryKeywords:
  - public dns
  - bash script
  - dynamic ip
  - dns fallback
seoOptimized: true
topicFamily: automation
topicFamilyConfidence: 0.95
topicFamilyNotes: >-
  The post describes a Bash script automating the resolution and export of WAN IP addresses for home
  network automation. This fits well under Automation, which includes scripts for automating
  workflows and system tasks. Other families like devtools or personal are less fitting because the
  core focus is on automating a technical network-related task.
---

# pullhomeip: Resolving WAN IP via Public DNS

## Motivation

Many home network setups rely on dynamic IP addresses assigned by ISPs. For remote access or automation, knowing the current WAN IP is essential. Dynamic DNS services help, but programmatically retrieving and exporting this IP for scripts or environment variables remains a common need.

## Problem

The challenge is to reliably resolve the current external IP address associated with a dynamic DNS hostname (`jayburd.duckdns.org` in this case) using public DNS resolvers. The solution must handle resolver failures gracefully, fallback to system methods, and provide a consistent environment variable for downstream use.

## How It's Built

The project is a single Bash script (`pull_home_ip.sh`) that:

- Queries multiple public DNS servers (`1.1.1.1`, `8.8.8.8`, `9.9.9.9`) using `dig` to resolve the hostname.
- Takes the first valid IP address returned.
- If all public resolvers fail, it falls back to system DNS resolution utilities in order: `host`, `getent`, then `ping`.
- Writes the resolved IP to an environment file (`~/.home_ip.env`) as an exported variable `HOME_WAN_IP`.
- Logs each resolution attempt with timestamps to `~/.local/share/duckdns/pull_ip.log`.

The script uses strict error handling (`set -euo pipefail`) to avoid silent failures.

## Implementation Details

- **Multiple Resolver Queries:** The script cycles through a hardcoded list of reliable public DNS servers. Using `dig +short` queries each server directly, avoiding reliance on the system's default resolver which might be cached or unreliable.

- **Fallback Mechanism:** If all public DNS queries fail to return an IP, the script attempts to use `host`, then `getent`, then `ping` to extract the IP. This layered fallback increases robustness in diverse environments.

- **Atomic Update of Env File:** The IP is written to a temporary file and then moved to the target environment file to avoid partial writes.

- **Logging:** Each attempt is logged with a timestamp and outcome, facilitating troubleshooting and historical tracking.

- **Assumptions:** The hostname is hardcoded. The script assumes availability of standard Unix networking tools.

## Practical Notes

- The script is designed for periodic execution, e.g., via cron, to keep the environment variable current.

- The environment file can be sourced by other scripts or shell sessions to access the latest WAN IP.

- The log directory and file are created under the user's home directory, avoiding the need for elevated permissions.

- The script does not handle IPv6 addresses.

## Summary

This project provides a minimal, reliable method to resolve and export a dynamic WAN IP address using multiple DNS resolvers with fallback strategies. It is practical for home network automation where knowing the current external IP is necessary. The approach balances simplicity with robustness by leveraging standard Unix tools and clear logging.

When returning to this project, focus on the resolver sequence, fallback logic, and environment file update mechanism as the core functional components.

