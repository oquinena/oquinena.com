---
title: "Using GitHub Actions to deploy Hugo site"
date: 2022-06-12T15:59:20+02:00
draft: true
author: Daniel de Oquiñena
---

I've had my eye on the [Hugo](https://github.com/gohugoio/hugo) project for quite some time and been meaning to setup oquinena.com as a Hugo site. Hugo is a static site generator written in Go and is extremly fast and simple to use. The entire site is generated from markdown files and pretty much everything is managed via the hugo cli app.

This makes it an excellent candidate for a gitops-workflow project as I wanted something easy to use and auto-deployed by a simple git commit. Also a great project to give GitHub Actions a test which I've not had the chance to try out yet ;) This entire site is available at [github](https://github.com/oquinena/oquinena.com) but I'll run down most of the steps taken here.

Having created the basic directory structure using the command `hugo new site sitename` I chose the theme "hello-friend". The theme is imported as a git submodule to the themes directory and enabled in hugo's [config.toml](https://github.com/oquinena/oquinena.com/blob/main/config.toml) in the root of the project directory. That's pretty much it for creating the basic site outline. 

