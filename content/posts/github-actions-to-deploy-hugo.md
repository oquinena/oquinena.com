---
title: "Using GitHub Actions to deploy Hugo site"
date: 2022-06-12T15:59:20+02:00
draft: false
cover: "github-actions-cover.png"
useRelativeCover: true
author: Daniel de Oquiñena
---

I've had my eye on the [Hugo](https://github.com/gohugoio/hugo) project for quite some time and been meaning to setup oquinena.com as a Hugo site. Hugo is a static site generator written in Go and is extremly fast and simple to use. The entire site is generated from markdown files and pretty much everything is managed via the hugo cli app.

This makes it an excellent candidate for a gitops-workflow project as I wanted something easy to use and auto-deployed by a simple git commit. Also a great project to give GitHub Actions a test which I've not had the chance to try out yet :wink: This entire site is available at [github](https://github.com/oquinena/oquinena.com) but I'll run down most of the steps taken here.

Having created the basic directory structure using the command `hugo new site sitename` I chose the theme "hello-friend". The theme is imported as a git submodule to the themes directory and enabled in hugo's [config.toml](https://github.com/oquinena/oquinena.com/blob/main/config.toml) in the root of the project directory. That's pretty much it for creating the basic site outline. 

Now, for setting up a GitHub Workflow with accompanied actions I initially added a Dockerfile to run the hugo command and at the same time deploy the generated files but as it turns out all the actions I needed were already available at GitHub Marketplace. So at the time of writing my [workflow.yaml](https://github.com/oquinena/oquinena.com/blob/main/.github/workflows/main.yml) looks like this:

{{< code language="yaml" title="GitHub Workflow" id="1" expand="Show" collapse="Hide" isCollapsed="false" >}}
name: oquinena.com

on: [push]

jobs:
  Build_and_deploy:
    runs-on: ubuntu-20.04
    concurrency:
      group: ${{ github.workflow }}-${{ github.ref }}
    steps:
      - uses: actions/checkout@v3
        with:
          submodules: true  
          fetch-depth: 0    

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2.4.13

      - name: Build
        run: hugo --minify

      - name: Deploy
        uses: Creepios/sftp-action@v1.0.4
        with:
          host: ${{ secrets.URL }}
          port: 22
          username: ${{ secrets.USERNAME }}
          password: ${{ secrets.PASSWORD }}
          localPath: './public'
          remotePath: './'
{{< /code >}}

Which basically cooks down to four steps:

1. On push-event, check out current state.
2. Setup Hugo using the [peaceiris/actions-hugo](https://github.com/peaceiris/actions-hugo).
3. Run the hugo command in root of the checked out code.
4. Deploy to hosting space using [SFTP SSH Action](https://github.com/marketplace/actions/sftp-ssh-action).

Using sftp to deploy the generated files is not by choice but rather a limitation by my current hosting provider. But for now, it's good enough. The secrets are stored in the repo and were easily created using github-cli, `gh secret set NAME_OF_SECRET`, and are passed to the workflow runner as environment variables. Altogether this took me around two hours to set up (including writing this post) and I could of course have implemented a few more steps to ensure nothing breaks etc, which I might very well do in the future. But for now, that's it :wink: