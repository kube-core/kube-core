### Changelog

All notable changes to this project will be documented in this file. Dates are displayed in UTC.

#### [v0.3.15](https://github.com/neo9/kube-core/compare/v0.3.15...v0.3.15)

- releases/tekton: Fixes apply & auto-merge logic in core-tag and cluster-push [`be92e9c`](https://github.com/neo9/kube-core/commit/be92e9c18023891fd8847ba74240ea25cd753eaa)

#### [v0.3.15](https://github.com/neo9/kube-core/compare/v0.3.14...v0.3.15)

> 6 September 2022

- releases/tekton: Fixes apply & auto-merge logic in core-tag and cluster-push [`b66c0f9`](https://github.com/neo9/kube-core/commit/b66c0f97b5301ae15857826ce31498e47a70b1f8)
- release: v0.3.15 [`a8337c1`](https://github.com/neo9/kube-core/commit/a8337c17d6889728837bec3b3fce25fd8aa908bf)

#### [v0.3.14](https://github.com/neo9/kube-core/compare/v0.3.13...v0.3.14)

> 6 September 2022

- releases/tekton: Makes kube-core image in CI variable [`4547792`](https://github.com/neo9/kube-core/commit/4547792de17170979e3871ec2ec40664d752f059)
- release: v0.3.14 [`a81758b`](https://github.com/neo9/kube-core/commit/a81758bd1bddfae3ba45ea76714fef096539c706)

#### [v0.3.13](https://github.com/neo9/kube-core/compare/v0.3.12...v0.3.13)

> 6 September 2022

- policies: Adds possibility to toggle kube-core policies and cluster policies [`2bc8d98`](https://github.com/neo9/kube-core/commit/2bc8d98f01ba5831eb5a38d79c15a267b47b6aa2)
- release: v0.3.13 [`89e28b6`](https://github.com/neo9/kube-core/commit/89e28b687b355c996090e9978009176e6e2c24cf)

#### [v0.3.12](https://github.com/neo9/kube-core/compare/v0.3.11...v0.3.12)

> 5 September 2022

- gitops: Adds apply logic on gitops pipelines [`0877856`](https://github.com/neo9/kube-core/commit/087785610b332446053fd120282e2ea71d83f36a)
- release: v0.3.12 [`00f4e85`](https://github.com/neo9/kube-core/commit/00f4e85d0b8086ade6569e1055350ca32bb0cf5b)

#### [v0.3.11](https://github.com/neo9/kube-core/compare/v0.3.10...v0.3.11)

> 5 September 2022

- release: v0.3.11 [`e032152`](https://github.com/neo9/kube-core/commit/e032152e4785def8eb137148054d024adfaf4474)
- cli/scripts: Fixes detection of changes in auto-pr if all files are targeted instead of gitops config only [`227cb3b`](https://github.com/neo9/kube-core/commit/227cb3b37d66bc02f7b9bb6b53d7960b8fb2965e)

#### [v0.3.10](https://github.com/neo9/kube-core/compare/v0.3.9...v0.3.10)

> 5 September 2022

- cli/scripts: Forced secrets namespace generation to avoid CI builds deleting it [`a1e58cb`](https://github.com/neo9/kube-core/commit/a1e58cb5b99a9b82f553d1a9d6f8d89adb232ab5)
- release: v0.3.10 [`106579e`](https://github.com/neo9/kube-core/commit/106579ee75b1b549a5cc04e5fadda5aee096c44a)

#### [v0.3.9](https://github.com/neo9/kube-core/compare/v0.3.8...v0.3.9)

> 5 September 2022

- releases: Removed base folder as it is not used anymore [`94b44ed`](https://github.com/neo9/kube-core/commit/94b44ed66262e52049a221caede64b8a6f466642)
- cli/scripts: Updates flux install & Various fixes and improvements [`a8939bc`](https://github.com/neo9/kube-core/commit/a8939bc0170bae1423e219e279fc353c68c9a078)
- releases: Adds flux-config to manage default flux resources [`eb5846d`](https://github.com/neo9/kube-core/commit/eb5846dfb4987217f4f8f23c0ec0d6b8767db84e)
- core/templates: Moved namespace field on the kube-core release wrapper [`9d6bdd8`](https://github.com/neo9/kube-core/commit/9d6bdd8c78cdc9ab7bd9d03591db194b11116024)
- releases/flux: Adds podmonitor config to monitor all flux controllers [`1cb7dc7`](https://github.com/neo9/kube-core/commit/1cb7dc7f3bc08dc79b0af2680060f7b7469ee8ad)
- release: v0.3.9 [`660fc5f`](https://github.com/neo9/kube-core/commit/660fc5f4b433aa86318af14d240f8988118f2b30)
- releases/schema: Updated schema to include new releases [`abba1c6`](https://github.com/neo9/kube-core/commit/abba1c6bfd4b5d171c223723b3647bbee8557be4)

#### [v0.3.8](https://github.com/neo9/kube-core/compare/v0.3.7...v0.3.8)

> 3 September 2022

- releases/tekton: Updates core-tag & PR workflow [`b52c328`](https://github.com/neo9/kube-core/commit/b52c3285dedfe87442ea2053df956e0a31dceb3b)
- release: v0.3.8 [`a786f00`](https://github.com/neo9/kube-core/commit/a786f00a6d271553f68b47b7a03e4bbd5e109606)

#### [v0.3.7](https://github.com/neo9/kube-core/compare/v0.3.6...v0.3.7)

> 3 September 2022

- releases: Adds container-registry-config to allow easy use of GCR in the cluster [`182cb37`](https://github.com/neo9/kube-core/commit/182cb37bd521cf6f3f7aab7453e8f4a9c7d25ade)
- releases/tekton: Fixes core-tag pipeline & Makes kube-core image variable [`b492d96`](https://github.com/neo9/kube-core/commit/b492d967341091dc7b47ed59143d9fb2dc3575ed)
- release: v0.3.7 [`4121154`](https://github.com/neo9/kube-core/commit/4121154e9a140455f0118f9de781cda26c371c96)

#### [v0.3.6](https://github.com/neo9/kube-core/compare/v0.3.5...v0.3.6)

> 2 September 2022

- releases/tekton: Updates core-tag pipeline to use kube-core [`460b2e3`](https://github.com/neo9/kube-core/commit/460b2e38779fea36acbc4b6ec8f61becf6777834)
- release: v0.3.6 [`0d7cdb4`](https://github.com/neo9/kube-core/commit/0d7cdb4bcbe34fc0905808dba08ec48d19b328c9)

#### [v0.3.5](https://github.com/neo9/kube-core/compare/v0.3.4...v0.3.5)

> 2 September 2022

- releases/tekton: Improves secret configuration [`b745bcc`](https://github.com/neo9/kube-core/commit/b745bcc1897add4e981984b0b0e7f07ec55e57cc)
- cli/scripts: Adds tekton & SF setup script [`7be3816`](https://github.com/neo9/kube-core/commit/7be3816404beff8e0120ea6552af475d452d9143)
- cli/scripts: Adds option to delete PR source branch by default on cluster auto PR [`450454a`](https://github.com/neo9/kube-core/commit/450454ae2d02ee0c6e9dc385bca3b788352dbd66)
- cli/scripts: Adds variable for local keys path [`75fd5b5`](https://github.com/neo9/kube-core/commit/75fd5b5d7991c3dff146c6273a2a3f5a744a33f6)
- release: v0.3.5 [`0f823e9`](https://github.com/neo9/kube-core/commit/0f823e9e1054edc8d74a6e180bcd50f6587b3ad6)

#### [v0.3.4](https://github.com/neo9/kube-core/compare/v0.3.3...v0.3.4)

> 1 September 2022

- releases/tekton: Changes default run timeout and makes it configurable [`43261b6`](https://github.com/neo9/kube-core/commit/43261b6fe639d715e6f5c27f3187558cdd257153)
- release: v0.3.4 [`d902266`](https://github.com/neo9/kube-core/commit/d90226601c8088df4b8df24e4db9aa93b37c82dd)

#### [v0.3.3](https://github.com/neo9/kube-core/compare/v0.3.2...v0.3.3)

> 1 September 2022

- releases/tekton: Renamed and removed some resources [`23cf029`](https://github.com/neo9/kube-core/commit/23cf029d2715131febfdc7c799ab085eb508b2e6)
- release: v0.3.3 [`3df8d5a`](https://github.com/neo9/kube-core/commit/3df8d5a6623370b03408ecac179dfd4d933e7e21)

#### [v0.3.2](https://github.com/neo9/kube-core/compare/v0.3.1...v0.3.2)

> 1 September 2022

- releases/tekton: Reintroduces core-tag pipeline [`b5110e4`](https://github.com/neo9/kube-core/commit/b5110e48db0b3ebb31dc1af3a2aaa81288279dd6)
- releases/tekton: Improves resource name templating and brings more variables in hooks [`b67847e`](https://github.com/neo9/kube-core/commit/b67847e75b53b3f4914bb2731129711ae7584a19)
- release: v0.3.2 [`2fac095`](https://github.com/neo9/kube-core/commit/2fac0957119744065c2031462361d23ef6d98573)
- cli/scripts: Updated bump script to automatically patch cli version [`52a8349`](https://github.com/neo9/kube-core/commit/52a8349cf3bdb7dd6661c91411dfd7a216da2489)
- releases/tekton: Fixes app-hooks git-webhooks-token reference missing [`7b395ed`](https://github.com/neo9/kube-core/commit/7b395ed88b6ec5fbbc004935389a6427813561f0)

#### [v0.3.1](https://github.com/neo9/kube-core/compare/v0.3.0...v0.3.1)

> 30 August 2022

- release: v0.3.1 [`142ad91`](https://github.com/neo9/kube-core/commit/142ad91bfee476ca8ed56f9c038abc90a15328a8)
- cli: Fixes corePath in scripts [`b0b5791`](https://github.com/neo9/kube-core/commit/b0b5791191b5554b481d2832c44320d4b1ece44d)
- scripts: Moved scripts in cli folder to package them together [`77d78bd`](https://github.com/neo9/kube-core/commit/77d78bd9fddcf24ec61502a4e175a332ba34e3e8)
- repo: Fixes .gitignore ignoring some files that should not be ignored [`f6b6ab0`](https://github.com/neo9/kube-core/commit/f6b6ab0d7e788bc5dcae1b3105925ace73052959)
- cli: Reintroduced .helmignore files in releases/dist [`3a24223`](https://github.com/neo9/kube-core/commit/3a24223d3744eaba62d3bab01f1fb5c6277dd208)
- ci: Updated GitHub Actions Workflows [`9de80b9`](https://github.com/neo9/kube-core/commit/9de80b9e871bedf076878207d812ca79097f7b6c)
- cli: Adds basic install instructions in README [`684b232`](https://github.com/neo9/kube-core/commit/684b23204e80a260b39323cf4814fed4f9d01212)
- repo: Fixes scripts line endings for npm release packaging [`70a43f6`](https://github.com/neo9/kube-core/commit/70a43f6b7b7045de1514bd68a2ffc469db63730f)
- cli: Bumps version to v0.1.6 [`ecf11e9`](https://github.com/neo9/kube-core/commit/ecf11e9ee10ef564dde949691eeaaaa52823f843)
- release-it: Fixes changelog generation [`e89adf0`](https://github.com/neo9/kube-core/commit/e89adf0cc69c1e195aaf0e6bbb04c66d653b5e28)
- cli: Adds proper chmod on scripts [`948b260`](https://github.com/neo9/kube-core/commit/948b2609896126ebb96741c18ce4d4d1f1202aac)

#### [v0.3.0](https://github.com/neo9/kube-core/compare/v0.2.1...v0.3.0)

> 30 August 2022

- release: v0.3.0 [`a89d9be`](https://github.com/neo9/kube-core/commit/a89d9be59f973ba52a2611eedf11bee7cf4220de)

#### [v0.2.1](https://github.com/neo9/kube-core/compare/v0.2.0...v0.2.1)

> 23 August 2022

- core: Added the possibility to deploy Patches with .release.patches [`49c80c3`](https://github.com/neo9/kube-core/commit/49c80c3eba8c1f6f740f80b2cca92949b3afdf33)
- release: v0.2.1 [`a4e18dc`](https://github.com/neo9/kube-core/commit/a4e18dc4f1edc37a5aab94dd26a4b0bfa8e8fe72)
- scripts: Fixes kube-core apply & template commands [`b51fe42`](https://github.com/neo9/kube-core/commit/b51fe42d23c781613f591b259a3e2eec72647ff9)
- cli: Fixed .gitignore breaking dev cli [`21f82ef`](https://github.com/neo9/kube-core/commit/21f82ef1f80929798213bc256c4187cd19456f15)

#### [v0.2.0](https://github.com/neo9/kube-core/compare/v0.1.0...v0.2.0)

> 23 August 2022

- release: v0.2.0 [`421cc82`](https://github.com/neo9/kube-core/commit/421cc825f06309e9ad6389ff77d829b9e6a3f899)

#### v0.1.0

> 23 August 2022

- release: v0.1.0 [`8862e2c`](https://github.com/neo9/kube-core/commit/8862e2c81c6ee6f18756ba1a087be606cc189fc1)
- Initial commit [`bfc6c11`](https://github.com/neo9/kube-core/commit/bfc6c11ea874ad383701688895fd57455fbe3050)
