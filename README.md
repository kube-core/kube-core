
<div id="top"></div>

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <img src="images/logo.svg" alt="Logo" width="168px" height="168px">

  <h3 align="center">kube-core</h3>

  <p align="center">
    Configure once, deploy anywhere, for Kubernetes.
  </p>
</div>
<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>

- [kube-core](#kube-core)
  - [About](#about)
  - [Overview](#overview)
  - [Documentation](#documentation)
</details>

<!-- ABOUT THE PROJECT -->
# kube-core
Configure once, deploy anywhere, for Kubernetes.
<!-- Shields -->

## About
kube-core is a framework to manage Cloud Platforms with Kubernetes. \
It is designed for individuals or teams that manage multiple Kubernetes clusters on a daily basis. Prior knowledge of Helm, Helmfile, Kubernetes, and other industry standard and CNCF tools is recommended.

kube-core can be used to:
- Deploy commonly used softwares that work together
- Standardize Kubernetes cluster configuration management across your organisation
- Share envrionment values between Helm Releases to avoid repetition
- Ease the upgrade process of releases that we use everywhere
- Provide sensitive defaults to get started quickly on a new cluster
- Avoid repetition and edition of thousands of lines of YAML

The default configuration is somewhat opinionated, but everything can be tweaked easily to your needs through clever use of Helm and Helmfile layering capabilities.

This allows us to rapidly deploy and easily maintain Kubernetes clusters, to reduce cognitive overload of managing multiple environments and tons of YAML files, and hopefully to achieve a DRY Kubernetes Operations experience.

## Overview
kube-core currently has 4 major components:
- releases: A collection of post-processed and optimized Helm Charts
- core: A library of Helmfiles, Templates and Values; the foundation for your platform
- scripts: A library of scripts to automate cluster management
- cli: A CLI that wraps up everything for a better user experience


These components can be used independently. \
Used together, they unleash all their power, and give us the kube-core framework.

<!-- DOCUMENTATION -->
## Documentation
>:warning: The documentation is being rewritten completely and will be available soon.
