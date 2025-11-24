---
slug: github-pullhomeip-writing-overview
id: github-pullhomeip-writing-overview
title: 'Pullhomeip: Your Simple WAN IP Resolver'
repo: justin-napolitano/pullhomeip
githubUrl: https://github.com/justin-napolitano/pullhomeip
generatedAt: '2025-11-24T17:51:31.457Z'
source: github-auto
summary: >-
  Ever found yourself needing your home WAN IP address but didn't want to deal
  with complex solutions? That’s how **pullhomeip** was born. It's a
  straightforward shell script that automatically resolves and logs your public
  IP using various DNS resolvers.
tags: []
seoPrimaryKeyword: ''
seoSecondaryKeywords: []
seoOptimized: false
topicFamily: null
topicFamilyConfidence: null
kind: writing
entryLayout: writing
showInProjects: false
showInNotes: false
showInWriting: true
showInLogs: false
---

Ever found yourself needing your home WAN IP address but didn't want to deal with complex solutions? That’s how **pullhomeip** was born. It's a straightforward shell script that automatically resolves and logs your public IP using various DNS resolvers. 

## What is Pullhomeip?

Pullhomeip is a Bash script that targets a specific need: quickly getting and exporting your home network's current WAN IP address. It does this by querying several reliable public DNS resolvers. 

Here's the essence of the tool:

- It queries a predefined hostname (`jayburd.duckdns.org`).
- It tries multiple DNS resolvers: Cloudflare, Google, and Quad9.
- It logs attempts and saves the resolved IP address to an environment file, making it accessible for scripts and automation.

## Why Does It Exist?

There's often a laborious process involved in checking your WAN IP. Many solutions are overly complicated with GUIs or unnecessary dependencies. I wanted something lightweight and straightforward—just a script that does the job without extra fluff.

In many home automation setups, knowing the current WAN IP is crucial. Whether it's for remote access configurations, dynamic DNS updates, or automated scripts, having a quick and reliable way to pull your IP was a gap I noticed. 

## Key Design Decisions

### Scripting Language

I chose to go with Bash for a couple of reasons:

- **Simplicity:** Most systems already have a Bash shell by default.
- **Accessibility:** It keeps the barriers low for users.

### DNS Resolvers

The decision to query multiple public DNS resolvers was intentional:

- **Reliability:** If one fails, the script falls back on another.
- **Diversity:** Different providers can yield varied results, so hitting multiple sources minimizes the chance of stale data.

### Logging

I figured logging is essential for debugging. If something goes wrong, it's easier to trace back through the logs to see what happened. The logs can be found in `~/.local/share/duckdns/pull_ip.log`, giving users a clear record of resolution attempts.

## Tech Stack

Let’s talk about what powers **pullhomeip** under the hood:

- **Shell Scripting:** Pure Bash—all the script magic happens here.
- **Unix Utilities:** The script leverages familiar tools like:
  - `dig`
  - `host`
  - `getent`
  - `ping`
  - `awk`

These utilities are usually already available on Unix-like systems, so it keeps installation overhead to a minimum.

## Getting Started

If you want to give it a shot, here’s how you do it:

### Prerequisites

Before diving in, ensure you have:

- A Bash shell (most likely, you already do)
- The `dig` utility (part of `bind-utils` or `dnsutils` package)
- Optional: additional utilities like `host`, `getent`, and `ping` for fallback DNS resolution

### Installation

Grab the repo and set it up:

```bash
git clone https://github.com/justin-napolitano/pullhomeip.git
cd pullhomeip
chmod +x pull_home_ip.sh
```

### Usage

To run the script, simply execute:

```bash
./pull_home_ip.sh
```

This updates `~/.home_ip.env` with your current WAN IP and logs the results. If you want to load the IP into your current shell, run:

```bash
source ~/.home_ip.env
```

## Future Work / Roadmap

While I’m happy with how it works now, there’s always room for improvement:

- **Parameterization:** Instead of hardcoding `jayburd.duckdns.org`, I want to allow users to specify their own hostname.
- **Output customizations:** Options for specifying the output environment file and log locations would be a nice touch.
- **IPv6 Support:** With IPv6 on the rise, this is a must.
- **Testing:** Adding unit or integration tests would improve reliability.
- **Dockerization:** A containerized version could simplify deployment for many users.
- **Cron Integration:** Providing instructions to set up a cron job for regular updates.

## Final Thoughts

Pullhomeip fills a simple yet necessary gap for those wanting to keep their scripts aware of their external WAN IP without any fuss. I’m eager to expand its capabilities in the future, especially with features like parameterization and support for IPv6.

If you want to stay in the loop about updates or new features, feel free to catch me on [Mastodon](https://mas.to), [Bluesky](https://bsky.app), or [Twitter/X](https://twitter.com). Happy scripting!
