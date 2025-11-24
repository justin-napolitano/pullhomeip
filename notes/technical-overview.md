---
slug: github-pullhomeip-note-technical-overview
id: github-pullhomeip-note-technical-overview
title: pullhomeip
repo: justin-napolitano/pullhomeip
githubUrl: https://github.com/justin-napolitano/pullhomeip
generatedAt: '2025-11-24T18:43:57.675Z'
source: github-auto
summary: >-
  `pullhomeip` is a handy shell script that fetches and exports your home
  network's current WAN IP address. It queries multiple public DNS resolvers,
  like Cloudflare and Google, and logs the results.
tags: []
seoPrimaryKeyword: ''
seoSecondaryKeywords: []
seoOptimized: false
topicFamily: null
topicFamilyConfidence: null
kind: note
entryLayout: note
showInProjects: false
showInNotes: true
showInWriting: false
showInLogs: false
---

`pullhomeip` is a handy shell script that fetches and exports your home network's current WAN IP address. It queries multiple public DNS resolvers, like Cloudflare and Google, and logs the results.

## Key Features

- Resolves `jayburd.duckdns.org` via public DNS resolvers.
- Falls back to system DNS if public resolvers fail.
- Exports the WAN IP to `~/.home_ip.env`.
- Keeps a log of attempts in `~/.local/share/duckdns/pull_ip.log`.

## Quick Start

1. Clone the repo:

    ```bash
    git clone https://github.com/justin-napolitano/pullhomeip.git
    cd pullhomeip
    ```

2. Make it executable:

    ```bash
    chmod +x pull_home_ip.sh
    ```

3. Run it:

    ```bash
    ./pull_home_ip.sh
    ```

4. Load the IP:

    ```bash
    source ~/.home_ip.env
    ```

### Gotchas

Ensure you have `dig` installed. Other utilities are optional but helpful for fallback. 

Future plans include parameterizing the hostname and adding Docker support.
