---
title: "Simple Uptime Robot"
date: 2022-12-26T07:58:02+01:00
draft: false
cover: "upptime_logo.png"
useRelativeCover: true
author: Daniel de Oquiñena
---

[Upptime](https://upptime.js.org/) is a dead simple uptime robot based entirely on GitHub Actions. It's open-source and free to use for everyone, the only setup required is generating a a repo from https://github.com/upptime/upptime, generate an access token and modifying .upptimerc.yml to point to the sites you wish to monitor. 

The template will generate a basic uptime page that can be published on GitHub pages or to a custom url.

![Screenshot of upptime from status.oquinena.com](upptime_oquinena_com.png)

The default workflow settings will run every five minutes and will commit response time, graphs and status to the same repo it's run from. As long as the repo is public GitHub will allow the actions to be run free of charge.

To use your own domain simple update the repo settings for upptime under Pages/Custom domain, update your .upptimerc.yml and add the CNAME to your dns provider.
