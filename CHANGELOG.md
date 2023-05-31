### Changelog

All notable changes to this project will be documented in this file. Dates are displayed in UTC.

#### [v0.13.3](https://github.com/kube-core/kube-core/compare/v0.13.2...v0.13.3)

- cli: Fixed a few bugs [`f4dae54`](https://github.com/kube-core/kube-core/commit/f4dae54df985edf93f0cf1f536b0c286f7ab4905)
- releases/env-config: Disabled env-config injection by default [`e30dbb9`](https://github.com/kube-core/kube-core/commit/e30dbb9bc4084539e7298a572d755285bff8da2b)
- values/n9-api: Fixed env injection from release named secret [`33dafca`](https://github.com/kube-core/kube-core/commit/33dafca6a305b66137ef1c6cec9198ddbd6571d3)

#### [v0.13.2](https://github.com/kube-core/kube-core/compare/v0.13.1...v0.13.2)

> 16 May 2023

- core/layers: Reworked default layers [`7e66dd1`](https://github.com/kube-core/kube-core/commit/7e66dd153957d184a7acbbac275962c3fd5da581)
- core/templates: Added support for local/values input [`f76cde2`](https://github.com/kube-core/kube-core/commit/f76cde255727fa5e3b5bbb9b3a40a0a9ebb30d20)
- release: v0.13.2 [`3715eed`](https://github.com/kube-core/kube-core/commit/3715eedc1991cbd9a5a7c5e19ef23783caeb7195)
- docker: Updated some dependencies versions [`49e3838`](https://github.com/kube-core/kube-core/commit/49e38388d46e0008c3a19da8983b1e2ddbb813f3)

#### [v0.13.1](https://github.com/kube-core/kube-core/compare/v0.13.0...v0.13.1)

> 12 May 2023

- cli/docs: Added missing file [`5fb21a9`](https://github.com/kube-core/kube-core/commit/5fb21a9c4b8d0b7e8aefbe0e6a402abc3bc6146a)
- release: v0.13.1 [`265b2be`](https://github.com/kube-core/kube-core/commit/265b2be8879a3c8e57a84a863f5826ce1c6216a1)
- cli/scripts: Fixed permissions on new scripts [`59b30e5`](https://github.com/kube-core/kube-core/commit/59b30e5f60b158b07ed38f153f37e5ca67e3e9d3)

#### [v0.13.0](https://github.com/kube-core/kube-core/compare/v0.12.2...v0.13.0)

> 12 May 2023

- core: Reworked all templates and decoupled kube-core state processing from templates [`e080aa9`](https://github.com/kube-core/kube-core/commit/e080aa95b2014517c5730a573f7f12cafeddd85d)
- releases: Rebuilt releases [`440a30f`](https://github.com/kube-core/kube-core/commit/440a30f2d52d9dcd7e8e59a0407df4ffc0942695)
- cli/commands: Added command to reshape values [`00381a1`](https://github.com/kube-core/kube-core/commit/00381a1df5c17c4e5e1a70c7a30b8b25ea1ec158)
- core/layers: Updated various layers [`73c56e5`](https://github.com/kube-core/kube-core/commit/73c56e54504825b10976a19d4de47bbb6e7d298d)
- cli/commands: Added command to generate cluster webhooks [`f72d585`](https://github.com/kube-core/kube-core/commit/f72d58533f6ea3228b47228b871d5e46f9283f4a)
- release: v0.13.0 [`75e7ade`](https://github.com/kube-core/kube-core/commit/75e7adef7610c7d96bd6dc974cb1fabdbb46f5ee)
- cli/scripts: Reworked some generation scripts [`cbf9aa6`](https://github.com/kube-core/kube-core/commit/cbf9aa690b0b05c9774c007cda4fa6e1dc282732)
- core/releases: Upgraded tekton-logging to v0.1.1 [`f274afc`](https://github.com/kube-core/kube-core/commit/f274afc52b9a904d70b83ea9ae05010c25b4e159)
- cli/scripts: Removed useless condition in add-webhooks [`888759a`](https://github.com/kube-core/kube-core/commit/888759a7836278278e2b0f0022c4470bad5c5eb5)
- cli/base: Added valuesList and git status in base command [`de77449`](https://github.com/kube-core/kube-core/commit/de77449176cd895b8a457d8528ff7c26b56d1c1e)
- cli/commands: Added command to update releases [`344b6a2`](https://github.com/kube-core/kube-core/commit/344b6a24bbbaf673d810569eb916ad8549c51da2)
- core/values: Fixed velero credentials configuration [`72a0f7a`](https://github.com/kube-core/kube-core/commit/72a0f7a9ffe964b1c44608e1016d06ccc2fb4079)

#### [v0.12.2](https://github.com/kube-core/kube-core/compare/v0.12.1...v0.12.2)

> 29 April 2023

- releases: Rebuilt releases [`44cd3a5`](https://github.com/kube-core/kube-core/commit/44cd3a57af8f1f5caf08b4473da6139c4b587ff3)
- cli/scripts: Completely reworked cluster setup scripts & Added CLI commands for that [`d90c989`](https://github.com/kube-core/kube-core/commit/d90c989d4354d24afcb7b8ba3292c0667f13acdd)
- core/values: Updated velero configuration [`cf28518`](https://github.com/kube-core/kube-core/commit/cf28518a32cfa9dc4b2aabe986bb873561b2127f)
- release: v0.12.2 [`1e36bce`](https://github.com/kube-core/kube-core/commit/1e36bce1c747ea196405c01b4d8f24619e816dec)
- cli/commands: Added dev/prod/local commands for faster development [`ba3ae7d`](https://github.com/kube-core/kube-core/commit/ba3ae7de460e3142d55a57b50f8e422bb3f869e8)
- cli/scripts: Improved update-releases script [`d1b696a`](https://github.com/kube-core/kube-core/commit/d1b696a240ce5d0a83f8d7c291c84eea2b008f08)
- core/layers: Shortened CRO naming config [`0a8e2e0`](https://github.com/kube-core/kube-core/commit/0a8e2e0f62e7e367dfd664daf1c96a8726c27d4e)
- core/layers: Added cluster network configuration in values [`8707bb9`](https://github.com/kube-core/kube-core/commit/8707bb91c58be2795a3ec9c132faab995583818c)
- cli/commands: Added gitops:overlays:apply to apply overlays on gitops config [`905924f`](https://github.com/kube-core/kube-core/commit/905924fc5c769b634d3c6ec5804acedbd35fc6e4)
- core/layers: Added more options for gitops config [`0c924f4`](https://github.com/kube-core/kube-core/commit/0c924f44ce774c903254e25770a712da3a67a9f7)
- core/releases: Added default alertmanager inhibitrules for gke clusters [`5b85c4d`](https://github.com/kube-core/kube-core/commit/5b85c4ded7013a7a6ef2f70c6f91417411619956)
- core/releases: Improved oauth2 proxy default cookie configuration [`338528f`](https://github.com/kube-core/kube-core/commit/338528fe8bf05908722e1d571930508f9f26b082)
- core/layers: Added flux-ssh secret replication for flux-repository [`88d0753`](https://github.com/kube-core/kube-core/commit/88d0753a02f087ed6324dc511af46213eb4cd451)
- cli/scripts: Added flux.kube-core.io annotation to rewrite flux imagepolicies after kubectl slice [`e10638d`](https://github.com/kube-core/kube-core/commit/e10638d6a546fd59b88593a3eed6e590155e69d3)
- core/layers: Removed useless secret on CRO [`866cfea`](https://github.com/kube-core/kube-core/commit/866cfea322a3adcdbedf59b9723930d03c52bba5)
- core/values: Fixed some templating bugs [`1c3bd12`](https://github.com/kube-core/kube-core/commit/1c3bd1263d23e951a9049c95511f297a92fa11f7)
- core/values: Added some values injection in flux-repository [`fbdf6cf`](https://github.com/kube-core/kube-core/commit/fbdf6cfc976cb22473a066ee0daca864467760a4)
- core/layers: Fixed GCP IAM for tekton and CRO [`3741a1d`](https://github.com/kube-core/kube-core/commit/3741a1dd70a0b1e3f1df58d254f4826f746d5c92)

#### [v0.12.1](https://github.com/kube-core/kube-core/compare/v0.12.0...v0.12.1)

> 24 April 2023

- cli/scripts: Updated some scripts [`0a8e8a1`](https://github.com/kube-core/kube-core/commit/0a8e8a151a4e1503bd4c375a1dba6351f775481a)
- release: v0.12.1 [`8312332`](https://github.com/kube-core/kube-core/commit/831233209ccca47853827aa0f4e7d63f177980b7)
- cli/commands: Fixed generate:values command [`47f14d9`](https://github.com/kube-core/kube-core/commit/47f14d9cb5b0cb804a2246bf3dd2b1380a707975)
- core/values: Specify default index template in cluster-logging [`75a1290`](https://github.com/kube-core/kube-core/commit/75a12906306cc1834aa3f4909f97be8a0d51f667)
- core/templates: Disabled ServiceAccount name length validation for release-cloud [`cf20b8d`](https://github.com/kube-core/kube-core/commit/cf20b8d9fccd734e12842719d2bacba2e10380cf)
- workflows/sync-dist: Fixed wrong synced path for dist-manifests [`290edf3`](https://github.com/kube-core/kube-core/commit/290edf3feb4d29ec1775559f697bfdaffa395928)
- repo: Added releases/local to .gitignore [`a4ef169`](https://github.com/kube-core/kube-core/commit/a4ef1699d5429f9db2805f99575a7df6068819c0)

#### [v0.12.0](https://github.com/kube-core/kube-core/compare/v0.11.24...v0.12.0)

> 23 April 2023

- releases: Updated all core dependencies [`00915a5`](https://github.com/kube-core/kube-core/commit/00915a55e71e3e9267a8d872b0895d4474aefdb1)
- releases: Removed all local releases [`15b5f3d`](https://github.com/kube-core/kube-core/commit/15b5f3ddd892d8a4d15f3d813fb208922f8778c5)
- cli/scripts: Updated terraform cluster generation [`287b08f`](https://github.com/kube-core/kube-core/commit/287b08f8659984b664144a68adfc26a3301805a1)
- cli/scripts: Added update-releases script to upgrade all core dependencies [`abc11e1`](https://github.com/kube-core/kube-core/commit/abc11e1fb4a119152b167dc824135efad6318d14)
- cli/scripts: Updated prod mode script [`c2ba05a`](https://github.com/kube-core/kube-core/commit/c2ba05a84c6db42027dbb7c807cc23a12ed5cb1f)
- workflows/sync-dist: Added dist-manifest repo to sync [`464c00a`](https://github.com/kube-core/kube-core/commit/464c00ad1509f5c35fe7de199c75028429d68ab6)
- releases: Updated some releases [`80aa769`](https://github.com/kube-core/kube-core/commit/80aa769ee876541d974071b923bd8c57d23326b4)
- release: v0.12.0 [`968b337`](https://github.com/kube-core/kube-core/commit/968b3375adb986b7d64341fb83050ba3fed7237d)
- repo/actions: Renamed crds-charts repo to dist-crds [`46cc525`](https://github.com/kube-core/kube-core/commit/46cc525b56559d0de595d7a6cb3f1ef7a307596e)
- dockerfile: Updated arkade cli install [`f543dd4`](https://github.com/kube-core/kube-core/commit/f543dd40bd85ccaa15a57f21fe034bd31fd037f7)

#### [v0.11.24](https://github.com/kube-core/kube-core/compare/v0.11.23...v0.11.24)

> 18 April 2023

- release: v0.11.24 [`4a5962a`](https://github.com/kube-core/kube-core/commit/4a5962a4790ce612c938c9c6145599649650173f)
- core/layers: Fixed sidecar-cleaner not in schema [`0ed27e3`](https://github.com/kube-core/kube-core/commit/0ed27e36335997ed403fe274af16e5a26072178b)

#### [v0.11.23](https://github.com/kube-core/kube-core/compare/v0.11.22...v0.11.23)

> 18 April 2023

- releases/cluster-logging: Added custom default ILM policy [`df995a3`](https://github.com/kube-core/kube-core/commit/df995a38e9fee680f99d09e6a4a4dff9966bf3ac)
- release: v0.11.23 [`418e182`](https://github.com/kube-core/kube-core/commit/418e1826009add44b0ead3b8cecb89bd1d6a124d)

#### [v0.11.22](https://github.com/kube-core/kube-core/compare/v0.11.21...v0.11.22)

> 18 April 2023

- releases: Upgraded istio integration [`9c5fd00`](https://github.com/kube-core/kube-core/commit/9c5fd005e159a6eae66af52c8bd73bc32898bb57)
- releases/istio: Fixed istio releases [`55c7c94`](https://github.com/kube-core/kube-core/commit/55c7c94b68c74bf7272af502618b9fbe6b3975be)
- releases/app-extensions: Added ingress integration & Upgraded some resources [`96801c0`](https://github.com/kube-core/kube-core/commit/96801c0338a001f02174e8b71523fe5ff873111f)
- core/layers: Updated layers to improve istio integration [`09ba9ab`](https://github.com/kube-core/kube-core/commit/09ba9ab49a059068ad0e96743cd5b0af825f2ab2)
- core/releases: Updated and added cloud integration for chartmuseum [`ff4b18e`](https://github.com/kube-core/kube-core/commit/ff4b18e6dddf8b23c2e0199b18e504b710549f48)
- cli/scripts: Added some utility scripts [`4ddb2bb`](https://github.com/kube-core/kube-core/commit/4ddb2bba5163f7eaf189baee2294df62cc66d34a)
- core/templates: Reworked scaling extension integration [`d4fa0cd`](https://github.com/kube-core/kube-core/commit/d4fa0cda78af2ef3c87f0ca640abb340a6f54c9c)
- releases/kps: Fixed some templating issues [`9716954`](https://github.com/kube-core/kube-core/commit/9716954e0d1972daa1640bdcdb3857dc7ed75f9f)
- release: v0.11.22 [`82a678f`](https://github.com/kube-core/kube-core/commit/82a678f893840e83c2c2ce98e306859826864b4f)
- releases/app-extensions: Added extraPrometheusTriggers on ScaledObject [`76aad2a`](https://github.com/kube-core/kube-core/commit/76aad2a0c6e14e21e4b2ba7c8efdc85c17d105d5)
- core/releases: Added chartmuseum dashboard to monitoring grafana [`5cba3e4`](https://github.com/kube-core/kube-core/commit/5cba3e4cb1d0de6fc397d5781aca5d1db1e47cc5)
- core/releases: Added config key for nginx-ingress LB IP & default resources requests [`8210aff`](https://github.com/kube-core/kube-core/commit/8210aff52115f2e5b273988b83664b3f9f60fc31)
- releases/app-extensions: Added SlackChannel [`e6fd4e3`](https://github.com/kube-core/kube-core/commit/e6fd4e310844b0ef9510baa8da5441a6afc35363)
- cli/scripts: Allowed files folder in charts dist build [`8033c2e`](https://github.com/kube-core/kube-core/commit/8033c2eca56536ccd26deb10cf1e74fedd9a0379)

#### [v0.11.21](https://github.com/kube-core/kube-core/compare/v0.11.20...v0.11.21)

> 7 April 2023

- releases/nginx-ingress-controller: Upgraded chart to v9.5.1 [`059b2fe`](https://github.com/kube-core/kube-core/commit/059b2fecd7db29393e79fd1a63be8a4db1ad9aa8)
- release: v0.11.21 [`16599c1`](https://github.com/kube-core/kube-core/commit/16599c14e21805ba861328e0cbd178ffeeb5f3b8)

#### [v0.11.20](https://github.com/kube-core/kube-core/compare/v0.11.19...v0.11.20)

> 27 March 2023

- core/templates: Reworked values injection to allow remote sources [`79f83d4`](https://github.com/kube-core/kube-core/commit/79f83d43481f45abb03fbfadb5998754690c3222)
- release: v0.11.20 [`cf7c1ad`](https://github.com/kube-core/kube-core/commit/cf7c1ad52e8003216dc035c41a2ab232ef0d9940)
- releases/logging-stack: Fixed some wrong default values [`e8d9bf3`](https://github.com/kube-core/kube-core/commit/e8d9bf39b67d2f7a44d9b410e487ccb495bfe052)
- releases/cluster-logging: Changed default log key to message for containerd runtime [`7cc21b6`](https://github.com/kube-core/kube-core/commit/7cc21b6bb29165fb34fba8c0e7a9de614cdef747)
- core/values: Fixed GCP permissions for estafette releases [`5e0d5cf`](https://github.com/kube-core/kube-core/commit/5e0d5cf861087d1f99070b439844a7d8cebcba81)
- cli/scripts: Added helmfile key to kube-core generate cluster-config [`cbcab75`](https://github.com/kube-core/kube-core/commit/cbcab75498d8c232b64093403c31d0bc9912eaf1)

#### [v0.11.19](https://github.com/kube-core/kube-core/compare/v0.11.18...v0.11.19)

> 22 February 2023

- releases/kps: Upgraded to v1.1.1 [`2ecdc28`](https://github.com/kube-core/kube-core/commit/2ecdc28288546b3719ac61f85b35250bc22d31f0)
- core/templates: Added metricsIngress and implemented it in values templates [`14fb480`](https://github.com/kube-core/kube-core/commit/14fb480c7860aef3b0e049a04e43cd9698e0104e)
- core/values: Upgraded release-scaling to use dynamic metricsEndpoint [`1d68269`](https://github.com/kube-core/kube-core/commit/1d682699b668fceff544d1b4fbb9d6256dcdd8a0)
- core/templates: Added monitoring.metricsEndpoint in release.metadata.config [`cf82149`](https://github.com/kube-core/kube-core/commit/cf821499d54a750ebe00ea9f328c19f153929ad9)
- release: v0.11.19 [`1790381`](https://github.com/kube-core/kube-core/commit/17903819871b82ba68e66d1bab33c7b5ed45d983)
- core/layers: Changed thanos ingresses subdomain [`edfd31f`](https://github.com/kube-core/kube-core/commit/edfd31f11be0fa1bbe24d976d5ec835d3fff6557)
- core/layers: Disabled default SLOs on nginx-ingress-controller [`e29e455`](https://github.com/kube-core/kube-core/commit/e29e4554d0c0458655b2eccb1b748f5160d6d5f9)
- core/values: Added support for ContainerStatusUnknown cleanup in system-jobs [`8629051`](https://github.com/kube-core/kube-core/commit/8629051d302f8fe0ac0df057c11cb6c618fdda1b)
- core/layers: Added thanosQueryEndpoint and thanosQueryFrontendEndpoint in cluster.monitoring [`2fd3789`](https://github.com/kube-core/kube-core/commit/2fd37896b8a3f3af02145f5b0fceb98b3241e2b9)
- core/values: Made sure queryFrontend is enabled by default on kps [`7a70921`](https://github.com/kube-core/kube-core/commit/7a709219088eb1f06ac7b0824763418b4c2e2bf9)

#### [v0.11.18](https://github.com/kube-core/kube-core/compare/v0.11.17...v0.11.18)

> 16 February 2023

- releases/kps: Upgraded to v1.1.0 [`7a67a66`](https://github.com/kube-core/kube-core/commit/7a67a669f8da1c2270c2c89a74163474d691527a)
- releases: Added slack-operator [`7693a18`](https://github.com/kube-core/kube-core/commit/7693a18b7830ba9c15d4b44941718df6ffad1555)
- core/layers: Improved default monitoring configuration [`1bce943`](https://github.com/kube-core/kube-core/commit/1bce943f3b6754094112e9aea1b089850bac9819)
- core/templates: Reworked robusta and slack-operator integration [`65ff7f0`](https://github.com/kube-core/kube-core/commit/65ff7f0d016d337b6064990ff631ad94291521ad)
- release: v0.11.18 [`48388dc`](https://github.com/kube-core/kube-core/commit/48388dc756cbeba190f1c729ffb6d8f119d88422)
- core/layers: Changed pyrra endpoint to thanos-query by default [`f5ced65`](https://github.com/kube-core/kube-core/commit/f5ced657fa18da81c4f7dc03004d9260d8973132)

#### [v0.11.17](https://github.com/kube-core/kube-core/compare/v0.11.16...v0.11.17)

> 12 February 2023

- releases: Migrated crossplane-cloud to app-extensions [`50a992d`](https://github.com/kube-core/kube-core/commit/50a992dc9883a63363b870e40635d8eee151100d)
- release: v0.11.17 [`7b4a40d`](https://github.com/kube-core/kube-core/commit/7b4a40df8b785148e62268457e20be5adbe0070f)
- releases: Rebuilt releases [`9adf73f`](https://github.com/kube-core/kube-core/commit/9adf73fc4f6970759a864b7f5632654247e48d94)
- core/templates: Fixed wrong .release.enabled conditions [`c9ebc34`](https://github.com/kube-core/kube-core/commit/c9ebc34a59e1991af2dc96b75ba42c8d0ead65af)

#### [v0.11.16](https://github.com/kube-core/kube-core/compare/v0.11.15...v0.11.16)

> 10 February 2023

- core/templates: Improved stability of some releases with default core values [`d5570ce`](https://github.com/kube-core/kube-core/commit/d5570ce03ece0e66de130e7f1eee14ab9c067461)
- release: v0.11.16 [`c7ad4e7`](https://github.com/kube-core/kube-core/commit/c7ad4e7b602f205d4b9a860d3c2d26b3615bbc40)

#### [v0.11.15](https://github.com/kube-core/kube-core/compare/v0.11.14...v0.11.15)

> 10 February 2023

- releases: Added linkerd2 [`fb7612a`](https://github.com/kube-core/kube-core/commit/fb7612a03aed88e4a0a5a1d3bcf0b954f07b2ed6)
- core/templates: Refactored release variables [`50c15ea`](https://github.com/kube-core/kube-core/commit/50c15ea7e8ec6f66ab1d05588154f9b558ded1fe)
- core/values: Refactored some templates [`47acfae`](https://github.com/kube-core/kube-core/commit/47acfae01d48960cb6446898346084d6501037d1)
- core/layers: Improved default configuration for cloud releases [`d6e417e`](https://github.com/kube-core/kube-core/commit/d6e417eaec20fc6ed3669bd488aa1b1726fe629c)
- release: v0.11.15 [`177840a`](https://github.com/kube-core/kube-core/commit/177840a21c7cd90d2749f477303d5928499ddb97)
- core/values: Added replicator annotations on external-secrets [`4d701de`](https://github.com/kube-core/kube-core/commit/4d701de7a1e926306a1b43ea2703cbce484343ca)
- core/releases: Restrained default roles for kps & velero cloud service accounts [`0e43bba`](https://github.com/kube-core/kube-core/commit/0e43bba83fa0295b41c6c7205a878fe325f9b815)
- core/releases: Remapped bucket adminRef for releases cloud [`e11aad7`](https://github.com/kube-core/kube-core/commit/e11aad73ea0cccb5120577b45c29baa269d2a449)

#### [v0.11.14](https://github.com/kube-core/kube-core/compare/v0.11.13...v0.11.14)

> 7 February 2023

- releases: Rebuilt releases [`64d85ad`](https://github.com/kube-core/kube-core/commit/64d85adbe06f22796f75811e6785fbb556fcafb2)
- release: v0.11.14 [`325a387`](https://github.com/kube-core/kube-core/commit/325a387b969c3b40bdae40d7f9aa940f51864538)
- releases/crds: Fixed namespaces in CRDs to default [`a2acdd7`](https://github.com/kube-core/kube-core/commit/a2acdd7ace2c63680cd8df0d392e490adac0d8b3)
- release: v0.11.14 [`eb5c00e`](https://github.com/kube-core/kube-core/commit/eb5c00e3775b86ce380fc031b24900df577ce856)
- core/releases: Updated default admin roles for crossplane-cloud bucketpolicy [`07b1f59`](https://github.com/kube-core/kube-core/commit/07b1f596e90352bd87d851ce161f5f250e2fd9e0)

#### [v0.11.13](https://github.com/kube-core/kube-core/compare/v0.11.12...v0.11.13)

> 7 February 2023

- core/templates: Added release integrations for scaling, monitoring, chaos, and slos [`7795221`](https://github.com/kube-core/kube-core/commit/7795221b73eda0f4500f20e0630312b62e195c27)
- releases: Removed oauth2-proxy from local releases [`9abcf84`](https://github.com/kube-core/kube-core/commit/9abcf84bad5be41850a15b36c21b6e5657674663)
- releases/app-extensions: Improved main template loop and reworked resources [`6d9e91a`](https://github.com/kube-core/kube-core/commit/6d9e91a803fb49fafc8649e29d477598acf2c44c)
- releases: Added scaling & SRE resources to app-extensions [`561c0be`](https://github.com/kube-core/kube-core/commit/561c0bef120acb1cee2c0e1e55c8c32eb7aaf8f0)
- core/templates: Added more integrations with app-extensions [`e9d60ad`](https://github.com/kube-core/kube-core/commit/e9d60add500d8c4b424dbca094dcc08ff0e7d914)
- release: v0.11.13 [`4763999`](https://github.com/kube-core/kube-core/commit/476399997fb81f5bb4b9153c6c6c0492e791afbf)

#### [v0.11.12](https://github.com/kube-core/kube-core/compare/v0.11.11...v0.11.12)

> 2 February 2023

- core/layers: Fixed kps secrets [`3458fc9`](https://github.com/kube-core/kube-core/commit/3458fc9954bd3eacbca8b4202502bd33679ecda9)
- release: v0.11.12 [`756e4df`](https://github.com/kube-core/kube-core/commit/756e4dfc49f7e5e6644d793e347c11230bbd5158)

#### [v0.11.11](https://github.com/kube-core/kube-core/compare/v0.11.10...v0.11.11)

> 1 February 2023

- release: v0.11.11 [`ff31cf9`](https://github.com/kube-core/kube-core/commit/ff31cf9b984081123bf8ef05ef370090e7ba991e)
- releases/tekton-catalog: Regenerated release files [`b5f01d5`](https://github.com/kube-core/kube-core/commit/b5f01d5b6fda61376aa048a48a3882ba2dc9f4bb)

#### [v0.11.10](https://github.com/kube-core/kube-core/compare/v0.11.9...v0.11.10)

> 1 February 2023

- releases/tekton-catalog: Upgraded kube-core pipeline [`ceb7bf6`](https://github.com/kube-core/kube-core/commit/ceb7bf6f945fc12d088c948ef625d92ab502d897)
- release: v0.11.10 [`8faded5`](https://github.com/kube-core/kube-core/commit/8faded519ef5cb151e1899360974d28d1813b574)

#### [v0.11.9](https://github.com/kube-core/kube-core/compare/v0.11.8...v0.11.9)

> 1 February 2023

- releases: Fixed cluster-logging, tekton and tekton-logging integration [`956e533`](https://github.com/kube-core/kube-core/commit/956e533aa8cc7eb980f1b4e3041382d318c5ffcc)
- releases/nginx-ingress-controller: Upgraded chart to v9.3.26 [`cce3500`](https://github.com/kube-core/kube-core/commit/cce35005ca73a97dd826031d65cc89617c4d12ee)
- releases/tekton: Fixed secrets not being injected on SAs [`1e4157d`](https://github.com/kube-core/kube-core/commit/1e4157d9c5df6eda7a004a009fb39095f726304a)
- release: v0.11.9 [`9c0ce88`](https://github.com/kube-core/kube-core/commit/9c0ce889242cb1694805c534081f1d490ed2bf42)

#### [v0.11.8](https://github.com/kube-core/kube-core/compare/v0.11.7...v0.11.8)

> 31 January 2023

- release: v0.11.8 [`ac1d621`](https://github.com/kube-core/kube-core/commit/ac1d62159f576dc3cb9b5b57a43bf9fb5d69e5df)
- core/values: Updated secrets references for dex & oauth2-proxy [`686489d`](https://github.com/kube-core/kube-core/commit/686489d41bffcc9fb6da506a49c048ea67943039)

#### [v0.11.7](https://github.com/kube-core/kube-core/compare/v0.11.6...v0.11.7)

> 30 January 2023

- releases: Rebuilt releases [`d34a703`](https://github.com/kube-core/kube-core/commit/d34a703ee47296653acc1d1a0f9f3990632ac963)
- releases: Upgraded some tekton resources [`825b674`](https://github.com/kube-core/kube-core/commit/825b6745639369e3831b137d16bf1196b0bbc8bb)
- core/values: Upgraded external-secrets template to use release metadata [`de89379`](https://github.com/kube-core/kube-core/commit/de893791aa819ad68c0edf5e7d2e3de56a2e98ff)
- core/templates: Reworked clusterReleases to use same template as other release types [`5564cbf`](https://github.com/kube-core/kube-core/commit/5564cbf7d9d279958cd19b196665e66bc1bb86cb)
- release: v0.11.7 [`64e2d78`](https://github.com/kube-core/kube-core/commit/64e2d7897b822bef59e685986b571fa8e961f6a4)
- core/values: Changed default goldilocks requests/limits [`0460b53`](https://github.com/kube-core/kube-core/commit/0460b53f56c6051ba5b60fcc222b2359377d838d)
- core/layers: Fixed kps external-secrets [`ab53851`](https://github.com/kube-core/kube-core/commit/ab538516bae6a416e3e6f003183897306d0ad212)
- core/layers: Fixed dynamicSecrets config for dex & oauth2proxy [`8879089`](https://github.com/kube-core/kube-core/commit/88790895921a201fb0678acfaf92f3c4ec88686b)
- core/templates: Fixed release.hooks not working since options rework [`29fb465`](https://github.com/kube-core/kube-core/commit/29fb46507cbf9d714d79231c1b631da9d0e17491)
- core/templates: Added upgradeIngressPortIsHttp option [`40341f0`](https://github.com/kube-core/kube-core/commit/40341f0ad379ead70919fe844f26777c6b5ec8ce)
- core/layers: Fixed chaos-mesh ingress version [`273129f`](https://github.com/kube-core/kube-core/commit/273129fe1935552d5318946ebb15b97983db1234)

#### [v0.11.6](https://github.com/kube-core/kube-core/compare/v0.11.5...v0.11.6)

> 29 January 2023

- release: v0.11.6 [`19a867a`](https://github.com/kube-core/kube-core/commit/19a867a0628ab8f4d50de81ccd9098171d1f0cf0)
- core/releases: Homogenized variables used in cloud releases [`f5ed37e`](https://github.com/kube-core/kube-core/commit/f5ed37e73f0f8988ce911306a61d632047bfde6c)
- core/releases: Activated options by default to patch sloop ingress [`8698ac1`](https://github.com/kube-core/kube-core/commit/8698ac1fb6cc71410989110fd5021b30f8fa4a01)
- core/layers: Removed common defaultIngressAnnotations which is not useful to any release [`2213495`](https://github.com/kube-core/kube-core/commit/221349519c95498dd6841fe1851aff699e24761f)
- core/layers: Added a default ingressclass for defaultService expose-annotations [`72e3e2b`](https://github.com/kube-core/kube-core/commit/72e3e2b518f3af90d9d91f5ad66210e02412d0be)

#### [v0.11.5](https://github.com/kube-core/kube-core/compare/v0.11.4...v0.11.5)

> 23 January 2023

- core/templates: Integrated cluster & tetkton logging with release-cloud [`9a58e49`](https://github.com/kube-core/kube-core/commit/9a58e498f07c29d92e9e16b9a3fd8d4ca5652d76)
- release: v0.11.5 [`da4d3cc`](https://github.com/kube-core/kube-core/commit/da4d3cc1a6214107bfb0d4699fda801037039c3a)
- core/values: Fixed postgresql resource naming issues [`e2ce907`](https://github.com/kube-core/kube-core/commit/e2ce907dc3ee28f20e5e4db4464e889fedde2827)
- core/releases: Added condition to recordset generated by cloud releases [`187389a`](https://github.com/kube-core/kube-core/commit/187389a04060ae5c98b05aca182c536054371250)
- releases/goldilocks: Updated default options [`6492115`](https://github.com/kube-core/kube-core/commit/6492115bb314296c39b6487ab31cb7edc516124a)
- releases/nginx-ingress-controller: Added controllerClass [`7a1ba0a`](https://github.com/kube-core/kube-core/commit/7a1ba0ac517695b638cd02a7ae05fa254dff561c)
- core/templates: Fixed release-cloud bad condition on backendBucket [`19e8ef2`](https://github.com/kube-core/kube-core/commit/19e8ef24e78f768454350d8ddcbd37e52fb763f9)

#### [v0.11.4](https://github.com/kube-core/kube-core/compare/v0.11.3...v0.11.4)

> 21 January 2023

- release: v0.11.4 [`8abc4e6`](https://github.com/kube-core/kube-core/commit/8abc4e6931e0f7ecfc90b1094f7a60c4e960392e)
- core/values: Fixed serviceAccount adminReference for bucketPolicy in cloud releases [`9ed3abb`](https://github.com/kube-core/kube-core/commit/9ed3abb8836e06d6979873e4a0a9872e1aeb084c)

#### [v0.11.3](https://github.com/kube-core/kube-core/compare/v0.11.2...v0.11.3)

> 21 January 2023

- core/templates: Reworked release-variables and optimized values merge on releases [`b4c2c49`](https://github.com/kube-core/kube-core/commit/b4c2c49fd6fdbd95734bd2dfd36708092ce46002)
- core/templates: Moved naming metadata to release variables [`95618f4`](https://github.com/kube-core/kube-core/commit/95618f460243016fafa54dcf249f5604252b7866)
- core/values: Updated velero to use cloud naming [`4937083`](https://github.com/kube-core/kube-core/commit/4937083113d9668e611b7f14a246a904356683a6)
- core/templates: Reworked release template [`140a6cc`](https://github.com/kube-core/kube-core/commit/140a6cc86a174aebf3b78152779fcdad97caafdd)
- release: v0.11.3 [`62de68b`](https://github.com/kube-core/kube-core/commit/62de68b282436fb8274931684356c8d7be855157)
- core/templates: Fixed transformers not being applied on local-secrets [`56bd889`](https://github.com/kube-core/kube-core/commit/56bd8897ae61dfe40fdafeff4337aac2c7c3b587)

#### [v0.11.2](https://github.com/kube-core/kube-core/compare/v0.11.1...v0.11.2)

> 20 January 2023

- core/layers: Changed all patches for applications and services options to false by default [`66e8b8c`](https://github.com/kube-core/kube-core/commit/66e8b8c036aa6c467f1ec0c930d54cc54dd09d1b)
- release: v0.11.2 [`4b21636`](https://github.com/kube-core/kube-core/commit/4b21636c6a1edc5de37839d58f36e288664d2fce)
- core/templates: Fixed merge behavior for default application and services options [`d89eeaf`](https://github.com/kube-core/kube-core/commit/d89eeafea69558caaebc73e2c410bfe7f1d30c50)
- core/templates: Added app & services options injection specific to an env [`af97044`](https://github.com/kube-core/kube-core/commit/af97044571ec1ab3c5c08aa78d660b1d4737a8df)
- core/templates: Disabled injectIngressHost/Tls,forceNamespaceIngressClass by default for applications & services [`9c3c6a2`](https://github.com/kube-core/kube-core/commit/9c3c6a25f4dc1c6cabe84e79d25e6ab879c4fb78)

#### [v0.11.1](https://github.com/kube-core/kube-core/compare/v0.11.0...v0.11.1)

> 19 January 2023

- release: v0.11.1 [`a2de29c`](https://github.com/kube-core/kube-core/commit/a2de29c22e7de30245e34b3447f293d47aa963e9)
- cli/scripts: Added helmfile.concurrency parameter to mitigate concurrent I/O issues [`81bf76b`](https://github.com/kube-core/kube-core/commit/81bf76b9e278420c6385651141f67e1264f5eee2)

#### [v0.11.0](https://github.com/kube-core/kube-core/compare/v0.10.0...v0.11.0)

> 19 January 2023

- releases: Upgrades & Regeneration [`370c8df`](https://github.com/kube-core/kube-core/commit/370c8dfccb826b42920cd6687aa069daa5bf416e)
- core/layers: Removed generate folder [`909ba3d`](https://github.com/kube-core/kube-core/commit/909ba3dbe7fab4a2aea3347ef2fbd309e8f10ebb)
- releases: Added goldilocks [`a283841`](https://github.com/kube-core/kube-core/commit/a283841967c3e69d61828d74b551adb6d300a6cb)
- releases: Reworked postgres & Added integrations with releases [`ab9d1e7`](https://github.com/kube-core/kube-core/commit/ab9d1e7964c4f987a4edca59c422f042f290b8cc)
- releases: Various linting fixes & Regeneration [`0609958`](https://github.com/kube-core/kube-core/commit/0609958e412a4dd76bf4cd079413f744248b4744)
- releases: Removed some useless releases [`80b0926`](https://github.com/kube-core/kube-core/commit/80b0926506c518cafe47fea0b8e96b63a67b527f)
- core: Reworked releases, applications & services [`0b32857`](https://github.com/kube-core/kube-core/commit/0b32857065e841f2ec9ef4937dda8615e2a5dfd5)
- releases/tekton: Added logs persistance [`1e35ca2`](https://github.com/kube-core/kube-core/commit/1e35ca2e0aa59a2cfa247685a782a0cd354fd83a)
- releases: Added opencost [`9f61c5a`](https://github.com/kube-core/kube-core/commit/9f61c5a943cb4969b280fbc636dd2366e3462e05)
- cli/build: Replaced local build outputs with releases by default [`2d49433`](https://github.com/kube-core/kube-core/commit/2d49433e9b29dbc890fd7d840cedeae6664cdf79)
- core/layers: Migrated tekton values to config [`0e1e777`](https://github.com/kube-core/kube-core/commit/0e1e77753bbf1b3420cc5311b1f02a92ea1c047f)
- release: v0.11.0 [`4b97f21`](https://github.com/kube-core/kube-core/commit/4b97f2119f97fb69d0d4f9e70f7e26bff58e1bbb)
- core/values: Fixed tekton values template [`b9b3f47`](https://github.com/kube-core/kube-core/commit/b9b3f470d099ad82912cef642d6d647c37db0615)
- core/values: Removed kps namespace for rabbitmq-operator service monitor [`7b8d434`](https://github.com/kube-core/kube-core/commit/7b8d43437d0d5fa8fa65a42a0286fc8ed36d3ade)

#### [v0.10.0](https://github.com/kube-core/kube-core/compare/v0.9.3...v0.10.0)

> 12 January 2023

- core/templates: Removed releasesCustom feature completely [`5e166a8`](https://github.com/kube-core/kube-core/commit/5e166a8268a52a95496b631a0c0e438fd3247d89)
- core/templates: Removed some unused template [`db4dc4c`](https://github.com/kube-core/kube-core/commit/db4dc4c915284acb24a808a4ecc3370d0d65befa)
- core/templates: Updated raw releases to include release-options template [`1fb20c3`](https://github.com/kube-core/kube-core/commit/1fb20c3ab1d3d9a3326fb7a28140554e98f9aaf0)
- core/templates: Updated namespace releases to include release-options template [`a24df8a`](https://github.com/kube-core/kube-core/commit/a24df8ae325b2b098abff8584478e0f8be1f048b)
- release: v0.10.0 [`e4affc4`](https://github.com/kube-core/kube-core/commit/e4affc41e2a4c1884f56873435d5fd895a3ec386)

#### [v0.9.3](https://github.com/kube-core/kube-core/compare/v0.9.2...v0.9.3)

> 10 January 2023

- release: v0.9.3 [`c4b9296`](https://github.com/kube-core/kube-core/commit/c4b929655af76388efdb94888ec706593b0652e7)
- core/templates: Fixed broken condition & Added extraValues for applications [`b348442`](https://github.com/kube-core/kube-core/commit/b3484425c3af3dc77017105633ddca3ad1a568a9)

#### [v0.9.2](https://github.com/kube-core/kube-core/compare/v0.9.1...v0.9.2)

> 7 January 2023

- releases: Added app-extensions chart [`099d613`](https://github.com/kube-core/kube-core/commit/099d613f70127d50adadddbda0ea713617f4f411)
- core/templates: Reworked extensions and options [`279fd54`](https://github.com/kube-core/kube-core/commit/279fd5463e195ca2b13895baa39ae81ddb2e7715)
- core/values: Improved app integration with extensions and services [`e654963`](https://github.com/kube-core/kube-core/commit/e6549638bdae5fd4594befb828f32f066b25318b)
- core/templates: Added rabbitmq extension [`ab3c68f`](https://github.com/kube-core/kube-core/commit/ab3c68ff724e1f97a9f550d017bb9bda6c3c8384)
- core/layers: Updated some default release options [`8f49dc4`](https://github.com/kube-core/kube-core/commit/8f49dc4ee7fca11dcfe2af5565066b49b5fcef28)
- core/releases: Added possibility to specify serviceaccountkeyname for cloud releases [`191aa60`](https://github.com/kube-core/kube-core/commit/191aa6077cdc82d69058dbb823b9c948c6eaa234)
- core/templates: Added env options injection on applications and services [`53d4034`](https://github.com/kube-core/kube-core/commit/53d4034a9d8a98edbc48a255916c1942414ca98b)
- release: v0.9.2 [`afcb5fe`](https://github.com/kube-core/kube-core/commit/afcb5fe82f2a51655a89db811fd3c06152711c2c)

#### [v0.9.1](https://github.com/kube-core/kube-core/compare/v0.9.0...v0.9.1)

> 2 January 2023

- releases: Upgraded nginx-ingress-controller to v9.3.24 [`b14a451`](https://github.com/kube-core/kube-core/commit/b14a4518b62c82b5720b6572f6b52c6cededb573)
- release: v0.9.1 [`18d5ffc`](https://github.com/kube-core/kube-core/commit/18d5ffcea138c719ec5445ab2bbd59055f73c9f6)
- core/values: Fixed rabbitmq conditions in n9-api templates [`3fd6acb`](https://github.com/kube-core/kube-core/commit/3fd6acbad0f824b7d5bb120ce5599438a16ca213)
- cli: Fixed version bump in scripts:exec dev_utils_bump [`e3a9770`](https://github.com/kube-core/kube-core/commit/e3a977037358f9134c5fb437bd7872ef2ff3ec35)
- core/values: Added fullnameOverride including namespace for NIC deployments [`dd0c5dd`](https://github.com/kube-core/kube-core/commit/dd0c5ddfb8f1e44a4271e2c9f100a103919f619a)

#### [v0.9.0](https://github.com/kube-core/kube-core/compare/v0.8.0...v0.9.0)

> 2 January 2023

- release: v0.9.0 [`a5a0aeb`](https://github.com/kube-core/kube-core/commit/a5a0aeba601ba58f0d0d8dd4abf025535c5eaab6)
- core/layers: Refactored core layers [`2b7bdc5`](https://github.com/kube-core/kube-core/commit/2b7bdc53f65576de45582720ee42957f69c7e3c6)
- core/releases: Updated crossplane-cloud local chart [`9d6b84e`](https://github.com/kube-core/kube-core/commit/9d6b84ee6178c73951bbc3eea26ab38eab04e9c9)
- core/templates: Added some extensions & Improved n9-api release extensions integration [`2c1d00e`](https://github.com/kube-core/kube-core/commit/2c1d00e508bc247d93375baaa201ec5948124507)
- releases: Upgraded some releases [`e2d1d09`](https://github.com/kube-core/kube-core/commit/e2d1d09408065d9b2f367626138f2ffc8826c4e7)
- core/releases: Added cdn as a ressource for releases-cloud & updated releases-cloud with a default naming convention [`08a5b1f`](https://github.com/kube-core/kube-core/commit/08a5b1f9429d9f3e9aa93d3066776bc17437ccdc)
- core/layers: Removed some unused layers [`05f6b55`](https://github.com/kube-core/kube-core/commit/05f6b558e883262473112fdaf2cde4aea8cf5020)
- releases/logging-stack: Added support to provision any Kibana objects through config [`50beebf`](https://github.com/kube-core/kube-core/commit/50beebf56cd62fe7fb78420a1d1da8a13dba3452)
- core/layers: Added short names for every release and namespace [`229ba04`](https://github.com/kube-core/kube-core/commit/229ba04ebac89ec4d076340ad1057704f9bf5d17)
- cli/commands: Updated generate:values to work with reworked layers [`003a40f`](https://github.com/kube-core/kube-core/commit/003a40f35434df485ae5576ee605d6e2483e24e2)
- core/templates: Added release-variables to inject metadata in releases [`56b39c9`](https://github.com/kube-core/kube-core/commit/56b39c93c87b665a00682f85af7156083c8e773f)
- releases: Rebuilt all releases [`af995d7`](https://github.com/kube-core/kube-core/commit/af995d77240b160614ccceacf9733a12722f5f28)
- core/releases: Updated releases cloud variable in use for naming template [`83c7b52`](https://github.com/kube-core/kube-core/commit/83c7b526893996a86b0edb79318b2e4efac3f252)
- core/values: Reworked release-cloud template [`56007ec`](https://github.com/kube-core/kube-core/commit/56007ec538ae41e42d7268d7ee7eaf250f77d50c)
- core/templates: Changed extensions release annotations [`30c4628`](https://github.com/kube-core/kube-core/commit/30c4628bea5dc2770c4b43a73af4c68ff7fc8120)
- core/releases: Added naming config to extensions [`96953c5`](https://github.com/kube-core/kube-core/commit/96953c51bcb99a26c5e7e0f88c423e79f6296e09)
- core/layers: Added cloud.naming configuration [`11f236e`](https://github.com/kube-core/kube-core/commit/11f236e954e59ba2243bbef661a419f2ec00216b)
- release: v0.9.0 [`09df79a`](https://github.com/kube-core/kube-core/commit/09df79ad3968f35aeef9b27861042d360737892e)
- core/values: Added integration between release-patches and release-cloud [`974b529`](https://github.com/kube-core/kube-core/commit/974b5293507f5c8e89339f3b1480028ce82e6177)
- core/templates: Added cloud naming integration on core releases [`3537a7b`](https://github.com/kube-core/kube-core/commit/3537a7b6062bcfba9f4553664a067d95e1244492)
- cli/scripts: Fixed broken path in some dev commands [`19882bc`](https://github.com/kube-core/kube-core/commit/19882bcdc6593f5ce7a79d53d77cda50eb9ebc5a)
- core/releases: Updated releases-cloud recordset usage and naming [`2b1b7e2`](https://github.com/kube-core/kube-core/commit/2b1b7e21e483c1bc9a54ad6e7449e947c9a56a2b)
- core/templates: Added release-cloud integration on services [`8a63636`](https://github.com/kube-core/kube-core/commit/8a636368178f9942c3a44e5d7649748bbcc741eb)
- core/templates: Reworked application template & Added release-variables [`c974268`](https://github.com/kube-core/kube-core/commit/c97426850617b5c0b4a96b41154fa2b0e66d283a)
- core/releases: Fixed crossplane-cloud chart & few naming typo [`d2c7eda`](https://github.com/kube-core/kube-core/commit/d2c7eda53d771b6d6d5d1c446445cfb5e236f7d9)
- core/templates: Added dedicated templating for cloud resource with specific naming requirement [`dce3f34`](https://github.com/kube-core/kube-core/commit/dce3f340eb8d4986a1d2d14a45f4ada6efacb8d1)
- core/templates: Added more options for naming in variables template [`31da093`](https://github.com/kube-core/kube-core/commit/31da093d00ab3def31e23abf2d68f92142785bbe)
- core/values: Fixed some templating issues in release-cloud [`aaea2a8`](https://github.com/kube-core/kube-core/commit/aaea2a8a8274c962681e410e9ecff8f866447fbe)
- core/templates: Reworked application release template [`e3ad468`](https://github.com/kube-core/kube-core/commit/e3ad4684a2872f2c063293e2f70e069a478a25e8)
- core/releases: Reworked application & service release template [`da49c16`](https://github.com/kube-core/kube-core/commit/da49c1643fee59d551a2d5949a4d293be04931f2)
- core/layers: Added crossplane cloud integration for container-registry-operator [`7e9ca2e`](https://github.com/kube-core/kube-core/commit/7e9ca2e0e6534184b54305946a82a1af2bbfcd6d)
- core/layers: Added some default values in otherwise empty files [`4afb548`](https://github.com/kube-core/kube-core/commit/4afb54852935afd237b3534eeeb86fcc00a5a894)
- core/values: Fixed wrong condition on release-cloud BucketPolicies [`378f3bc`](https://github.com/kube-core/kube-core/commit/378f3bcb2f7ded27a01517746e01d167a9d873f5)
- core/values: Fixed mongodb-operator watchNamespace default value [`d482e92`](https://github.com/kube-core/kube-core/commit/d482e92f7fa1ca98f49b14967bd8699d6fb9ebcf)
- core/layers: Fixed some default permissions in release-cloud [`3c3acca`](https://github.com/kube-core/kube-core/commit/3c3acca719701dff49fea5b80f55be228bc49bf0)
- core/layers: Added global option to enable cloud naming debug [`2c9c95f`](https://github.com/kube-core/kube-core/commit/2c9c95ff6b9055026e31d8bd7fd443d7566fd516)

#### [v0.8.0](https://github.com/kube-core/kube-core/compare/v0.7.9...v0.8.0)

> 22 November 2022

- core/releases: Added crossplane-cloud chart and releases [`8507060`](https://github.com/kube-core/kube-core/commit/85070609b616348029160435a07a6a75f5b64370)
- cli/scripts: Updated cloud setup script to use crossplane [`ef11812`](https://github.com/kube-core/kube-core/commit/ef11812e87b85e1ba209ac838e0d48a6728b423d)
- core/releases: Upgraded prometheus-adapter [`934a2e5`](https://github.com/kube-core/kube-core/commit/934a2e52f05798e5297a44978a2c45b11540b791)
- release: v0.8.0 [`d326f76`](https://github.com/kube-core/kube-core/commit/d326f768a7d73d200b864a045bed33c19a56f6ea)
- cli/commands: Fixed typo in gitops:config:index docs [`4471db7`](https://github.com/kube-core/kube-core/commit/4471db7aa8fec477dddbf41acfec4b77837d1d53)

#### [v0.7.9](https://github.com/kube-core/kube-core/compare/v0.7.8...v0.7.9)

> 17 November 2022

- release: v0.7.9 [`6cf791e`](https://github.com/kube-core/kube-core/commit/6cf791ef4b32e866334e09cf6033b6057b98b3af)
- core/options: Added options.forceNamespaceByKind [`4317b70`](https://github.com/kube-core/kube-core/commit/4317b709bac78b8df00645c2b4279f6b748e4e18)
- core/templates: Fixed empty clusterReleases merge behavior [`b2ed4e2`](https://github.com/kube-core/kube-core/commit/b2ed4e28660b762adf22dd8c506219e599db7fbf)
- core/values: Changed cert-manager leaderElection namespace [`f5386b7`](https://github.com/kube-core/kube-core/commit/f5386b7b6e4ddbf43c2c820b6154ef7746becf6b)
- core/globals: Disabled namespaces by default [`8212e4e`](https://github.com/kube-core/kube-core/commit/8212e4eaa72c2232c634e119b1db6dbb0ba0ced4)

#### [v0.7.8](https://github.com/kube-core/kube-core/compare/v0.7.7...v0.7.8)

> 14 November 2022

- release: v0.7.8 [`e633b65`](https://github.com/kube-core/kube-core/commit/e633b6514c6a3109cef10d0519637f4590307a89)
- cli/commands: Fixed wrong path for generated helmfiles [`a2a58d8`](https://github.com/kube-core/kube-core/commit/a2a58d8a4ad92f097d6e814f6699a869c38ac117)

#### [v0.7.7](https://github.com/kube-core/kube-core/compare/v0.7.6...v0.7.7)

> 14 November 2022

- cli/commands: Added import:manifests command [`9060f8c`](https://github.com/kube-core/kube-core/commit/9060f8cff86cbdc23969a30240ce59297768c318)
- release: v0.7.7 [`9ab8b2d`](https://github.com/kube-core/kube-core/commit/9ab8b2dcdfe92ad7458f10544c5532742c6d71a8)
- core/templates: Fixed issues with local releases generation [`27c7652`](https://github.com/kube-core/kube-core/commit/27c765230467776d9246af447eb91f8d7ec2d044)
- github/actions: Added automatic release on tag [`cc5967e`](https://github.com/kube-core/kube-core/commit/cc5967ecd892084a9ea753e3255e9e1755a84c81)
- core/values: Added nameOverride on raw values template [`69feb55`](https://github.com/kube-core/kube-core/commit/69feb55eeb84c98e5ae76610cd7f63a458c1c3c0)

#### [v0.7.6](https://github.com/kube-core/kube-core/compare/v0.7.5...v0.7.6)

> 12 November 2022

- release: v0.7.6 [`a566708`](https://github.com/kube-core/kube-core/commit/a56670887a38c43a2cbd87e04439a385d8d33317)
- core/releases: Removed default secrets for mongodb atlas operator [`d81c65b`](https://github.com/kube-core/kube-core/commit/d81c65b01eb4729e9f48b70af1321535c005d234)

#### [v0.7.5](https://github.com/kube-core/kube-core/compare/v0.7.4...v0.7.5)

> 11 November 2022

- core/templates: Reworked helmfiles, fixed local paths for dev [`647d521`](https://github.com/kube-core/kube-core/commit/647d521fe72efeffcf4199d56a410ae8e6e11f4a)
- release: v0.7.5 [`af9e14d`](https://github.com/kube-core/kube-core/commit/af9e14d145dbddaf59fc0569cfc2015948e98cf4)
- cli/commands: Added flag to toggle color output on diff [`7d5f945`](https://github.com/kube-core/kube-core/commit/7d5f9453c36d8c9f4405331545868c62ea971c5d)
- cli/docs: Fixed some wrong examples [`b2c73e1`](https://github.com/kube-core/kube-core/commit/b2c73e17d51fa2dfb11b49041824b7eebaa9e9fa)
- cli/commands: Fixed inverted diff result on gitops:config:diff [`b9239aa`](https://github.com/kube-core/kube-core/commit/b9239aa311792a0cfda39b0540d7aed655d3bbad)

#### [v0.7.4](https://github.com/kube-core/kube-core/compare/v0.7.3...v0.7.4)

> 10 November 2022

- releases/tekton: Upgraded app-hooks EventListener [`411b618`](https://github.com/kube-core/kube-core/commit/411b618c02e94e918348845be5bf36f708ad1fcf)
- release: v0.7.4 [`d0ee353`](https://github.com/kube-core/kube-core/commit/d0ee353c42006ec8c4e2742c08ec5cd5a5004394)

#### [v0.7.3](https://github.com/kube-core/kube-core/compare/v0.7.2...v0.7.3)

> 10 November 2022

- cli/commands: Moved logic to parse stdin from base command class to a dedicated one [`2d5de31`](https://github.com/kube-core/kube-core/commit/2d5de310de9a1ccf3eac789b8f17878e979d01d4)
- release: v0.7.3 [`90c5d92`](https://github.com/kube-core/kube-core/commit/90c5d929a7bb6bdcc899ceac8d6fcce1318d92fd)

#### [v0.7.2](https://github.com/kube-core/kube-core/compare/v0.7.1...v0.7.2)

> 10 November 2022

- core/releases: Reworked oauth2-proxy to permit multiple deployment as a service [`1f50929`](https://github.com/kube-core/kube-core/commit/1f50929a69e37f65d3d80c02e99945f0b9164e94)
- releases: Added trivy [`4df960e`](https://github.com/kube-core/kube-core/commit/4df960e5d24c485769a21c9eacbdac02b1739b92)
- cli/commands: Removed some outdated files [`70eaacc`](https://github.com/kube-core/kube-core/commit/70eaacc5945e6ba9c606510a8dbd6e749f5bfd41)
- releases: Rebuilt all releases [`84f0681`](https://github.com/kube-core/kube-core/commit/84f0681a16749b98619fd2e9c78a72113826dd45)
- releases/tekton-catalog: Adds garden deploy projects pipeline [`c3919f1`](https://github.com/kube-core/kube-core/commit/c3919f1fddf413f0f6fda092aa2f869ea6d13bc0)
- core/templates: Added option to inject namespaced oauth2-proxy on ingress [`c26a910`](https://github.com/kube-core/kube-core/commit/c26a910fcb29503f7fc0bde89360688accb47bbd)
- cli/commands: Added absorb command [`80c800b`](https://github.com/kube-core/kube-core/commit/80c800bd326bb5ef65a03da90525d15a30771bc8)
- releases/tekton-catalog: Adds new pipeline to deploy keycloak themes [`89b8fae`](https://github.com/kube-core/kube-core/commit/89b8faee63f19c730dbac720914fb561f1cabc93)
- release: v0.7.2 [`272c5a9`](https://github.com/kube-core/kube-core/commit/272c5a96882b188c6ef77e661ff209ce1fa44d3c)
- cli/lib: Added some functions in utils to wrap kubectl [`cff4859`](https://github.com/kube-core/kube-core/commit/cff485925b4a366f92b9a12c304c0b6cac93827b)
- cli/commands: Added stdin piping capabilities for all commands [`93fbc24`](https://github.com/kube-core/kube-core/commit/93fbc2419a38ce22196b3be8c55b49076cf949fd)
- core/releases: Enabled storage as k8s crd for dex [`d22b1aa`](https://github.com/kube-core/kube-core/commit/d22b1aa298a56c5a33ef9c083279559b3b3e26fa)
- releases/tekton-catalog: Added configuration keys for trivy [`5d7fea8`](https://github.com/kube-core/kube-core/commit/5d7fea8ace7c74cb14dc614efa40716dc7284d30)
- core/values: Enabled certificate owner ref by default for cert-manager [`682ac69`](https://github.com/kube-core/kube-core/commit/682ac699398bfa76a761844453fef8e197eba311)
- releases/container-registry-operator: Updated deployment [`53c1200`](https://github.com/kube-core/kube-core/commit/53c12008ecb40d640c0002107f0ddf3703673cf7)

#### [v0.7.1](https://github.com/kube-core/kube-core/compare/v0.7.0...v0.7.1)

> 7 November 2022

- cli/commads: Added some generation capabilities for values and local folders [`9748f3a`](https://github.com/kube-core/kube-core/commit/9748f3aba4d448b75c4ecd3289a630566d00f6a2)
- core/templates: Added checks to only generate namespaces from enabled core releases [`098ba6a`](https://github.com/kube-core/kube-core/commit/098ba6a605b5565a635312a2fd0080a126516b5a)
- cli/docs: Updated docs [`b6a85a1`](https://github.com/kube-core/kube-core/commit/b6a85a10746e711117ac76f2bc2447cc8c2844f6)
- release: v0.7.1 [`4dad634`](https://github.com/kube-core/kube-core/commit/4dad6349cf18dc0fbd0e42ea389df79bef648181)
- cli/commands: Fixed gitops:config:diff checks on filtered data [`df3ddf0`](https://github.com/kube-core/kube-core/commit/df3ddf09ec9804223a3208606fc2d86ec47f7085)
- core/layers: Changed default config of ingress-access-operator [`aa8b664`](https://github.com/kube-core/kube-core/commit/aa8b6648271a199f4b6391aa25e2dd1abf019eee)

#### [v0.7.0](https://github.com/kube-core/kube-core/compare/v0.6.8...v0.7.0)

> 7 November 2022

- cli/commands: Introduced formatting [`5cf9f47`](https://github.com/kube-core/kube-core/commit/5cf9f4791eacf8fa8c507309f60935401217b731)
- cli/docs: Updated docs generation [`0fd4284`](https://github.com/kube-core/kube-core/commit/0fd428413acebd19ac271d9aae5e4c3abd8c8244)
- core/layers: Reworked all layers [`2d95ba6`](https://github.com/kube-core/kube-core/commit/2d95ba67ae0ebf32d55029e338390afc776cf325)
- cli/package: Added some libs [`d13bb11`](https://github.com/kube-core/kube-core/commit/d13bb11087d8b94ee474a5f921e4017425da8413)
- cli/commands: Reworked generate:helmfiles [`798891d`](https://github.com/kube-core/kube-core/commit/798891dff4cd7bf2210964d66611935234af2a4a)
- core/templates: Reworked templates [`39037f6`](https://github.com/kube-core/kube-core/commit/39037f6842ef895e6bb249ee7c2f794af2d9fce4)
- core/templates: Added templates for generate command [`d06cb47`](https://github.com/kube-core/kube-core/commit/d06cb47822f721ee9bba38c63c32926bf3ff3025)
- core/templates: Added templates lib in core [`7748973`](https://github.com/kube-core/kube-core/commit/77489735d76bc2993dd0eda7db1b4c168955cb86)
- cli/commands: Added commands: gitops config find|read|search [`6d621c0`](https://github.com/kube-core/kube-core/commit/6d621c07ff6b33a694891c26206c0348b4089e1e)
- cli: Preparing release [`50c48e7`](https://github.com/kube-core/kube-core/commit/50c48e73485c6f8fde2d26f1cebdbdef690b4302)
- cli/commands: Removed some unused files [`ed2aba6`](https://github.com/kube-core/kube-core/commit/ed2aba65773bfb5bff735403011f4775f8dcd513)
- cli/commands: Added experimental hot-reload command [`e951642`](https://github.com/kube-core/kube-core/commit/e951642defa7b550ec0ca60c050611845bca62a1)
- cli/utils: Added some functions to utils [`b1f1e39`](https://github.com/kube-core/kube-core/commit/b1f1e39b3fa92e3710d4ecb5d2906d1cb04e87cc)
- cli/commands: Added kube-core gitops config diff [`c3f0bba`](https://github.com/kube-core/kube-core/commit/c3f0bbaeee9a4b8bd0a200553488c4806c8c2522)
- cli/scripts: Removed gitops/process.sh [`f8a0e65`](https://github.com/kube-core/kube-core/commit/f8a0e654689277f285fdea84f843f1d4708d7903)
- cli/commands: Updated config search to use index if available [`9fa6e0d`](https://github.com/kube-core/kube-core/commit/9fa6e0d828eb86cf145ac71f0474839ca25cf5d0)
- cli/scripts: Removed slicing and added code from removed gitops/process.sh in cluster/process.sh [`95bb340`](https://github.com/kube-core/kube-core/commit/95bb3407c166491035847b13f06dd31b059cca3a)
- cli/scripts: Reworked build workflow to start by local config first and then proceed with helmfile templating [`a490960`](https://github.com/kube-core/kube-core/commit/a4909600e1bf5b8aaca53f781d442834a1f4791f)
- cli/commands: Added kube-core gitops config index [`9ee78bf`](https://github.com/kube-core/kube-core/commit/9ee78bfee200dc6f04807501b3c4fb6c745d58d2)
- cli/commands: Updated some docs [`923fc7a`](https://github.com/kube-core/kube-core/commit/923fc7a8165319dd4451cd7c652962cc02ce5180)
- cli/commands: Added command generate helmfiles [`8c5f4e6`](https://github.com/kube-core/kube-core/commit/8c5f4e633ef7cd1da3d5f9dbf1c001360b82c7d2)
- cli/commands: Updated generate values to allow merge from core over local [`ba38899`](https://github.com/kube-core/kube-core/commit/ba3889922a3ea06f0b39d06d2d58e73ef82d17fe)
- release: v0.7.0 [`8d7ca33`](https://github.com/kube-core/kube-core/commit/8d7ca33b650c3a1a39ae63ca764438b1a8cb33e9)
- cli/base: Migrated some common logic in base command class [`7dae391`](https://github.com/kube-core/kube-core/commit/7dae391015cbb30e89bb1a60b444c6cb9c0dae50)
- cli/scripts: Moved slicing to cluster/build.sh [`0ba283f`](https://github.com/kube-core/kube-core/commit/0ba283f22842a727fe58a10bb1f4ac06e73145bf)
- cli/commands: Added properties to get current cluster resources [`16304c4`](https://github.com/kube-core/kube-core/commit/16304c438f66534870c751a04effa99374c31456)
- core/releases: Added startupProbe to secret-generator release [`f95747a`](https://github.com/kube-core/kube-core/commit/f95747aff888e2a5723d31efa794bbb72c546fb7)
- cli/scripts: Added original secret metadata on sealed version [`8492f3f`](https://github.com/kube-core/kube-core/commit/8492f3f117aea78866dae02a824d68b995f5bf5e)
- cli/commands: Added comments and logs on generate values [`67fc638`](https://github.com/kube-core/kube-core/commit/67fc6383673fc238322c3ca5b837176ebc1ae9e8)
- cli/lib: Replaced js-yaml by yaml [`5aa0eec`](https://github.com/kube-core/kube-core/commit/5aa0eece48c5899b49072fcdff3eae7d1faea644)
- core/templates: Added clusterRepositories support [`4b3e9bb`](https://github.com/kube-core/kube-core/commit/4b3e9bb633e54cd94d609819ed4106a1b684417a)
- cli/commands: Removed color output on gitops config read as it breaks post-processing [`06d2707`](https://github.com/kube-core/kube-core/commit/06d2707bacec40964c22f63e7d168122c4fc0677)
- cli/libs: Added loadash [`1c63417`](https://github.com/kube-core/kube-core/commit/1c63417e4ae38feb0593e7160a1c60d68a9e27f4)
- core/templates: Fixed helmfileName value for lib templates [`6eef109`](https://github.com/kube-core/kube-core/commit/6eef109348fc021dfdb2ad387cc76bbc14bb0205)
- cli/scripts: Fixed kube-core build all --filter [`1a65386`](https://github.com/kube-core/kube-core/commit/1a65386e1bc98b5ff558da3d6c4f696e456cc792)
- docker: Added gron v0.7.1 [`f767450`](https://github.com/kube-core/kube-core/commit/f767450d641ca6ceab7fd9cac83dd81234fa048f)
- releases/n9-api: Removed kubeVersion constraint [`51462bb`](https://github.com/kube-core/kube-core/commit/51462bb6ac816637443874b3cbf90bffa8397198)
- cli/scripts: Added toggle in cluster-config to  autoseal secrets [`b2c6148`](https://github.com/kube-core/kube-core/commit/b2c614809ecccca033774708b181b83ef4a7652e)

#### [v0.6.8](https://github.com/kube-core/kube-core/compare/v0.6.7...v0.6.8)

> 21 October 2022

- release: v0.6.8 [`89471ce`](https://github.com/kube-core/kube-core/commit/89471ce010243aa8891837cdfe5523790c04bdac)
- core/templates: Added chartVersion support in release template [`edb37ee`](https://github.com/kube-core/kube-core/commit/edb37ee442fd22711606feac159add74db0fc876)

#### [v0.6.7](https://github.com/kube-core/kube-core/compare/v0.6.6...v0.6.7)

> 21 October 2022

- core/envs: Added forceVisitorGroups and forceNamespaceVisitorGroup options [`8b37d9f`](https://github.com/kube-core/kube-core/commit/8b37d9f01750bf0501071f60d145f0eb8a65d59a)
- release: v0.6.7 [`b3945ca`](https://github.com/kube-core/kube-core/commit/b3945ca405058ee509b94c7e0d60131e22c4b0c7)

#### [v0.6.6](https://github.com/kube-core/kube-core/compare/v0.6.5...v0.6.6)

> 21 October 2022

- core/envs: Added forceNamespaceIngressClass option [`c4e6076`](https://github.com/kube-core/kube-core/commit/c4e6076dc2afa98c9a46346aa6649b98c8849653)
- core/values: Updated n9-api values template [`94449d9`](https://github.com/kube-core/kube-core/commit/94449d93795989e8f561f30df63daabb2f887b4d)
- release: v0.6.6 [`9aa9eed`](https://github.com/kube-core/kube-core/commit/9aa9eedb44bcac8336310ade88115fa93a5d16c7)

#### [v0.6.5](https://github.com/kube-core/kube-core/compare/v0.6.4...v0.6.5)

> 20 October 2022

- core/templates: Fixed missing if in some templates [`f3185cc`](https://github.com/kube-core/kube-core/commit/f3185ccb5b40fb28afd2536e063eb82c19cdb500)
- release: v0.6.5 [`7becc3f`](https://github.com/kube-core/kube-core/commit/7becc3febf2d96c07bf7a825cf3ed26043b56e9c)

#### [v0.6.4](https://github.com/kube-core/kube-core/compare/v0.6.3...v0.6.4)

> 20 October 2022

- release: v0.6.4 [`bb2c553`](https://github.com/kube-core/kube-core/commit/bb2c553a1a73f16494648cb861d318205f23e773)
- core/templates: Fixed missing if in node-affinity template [`64b27b3`](https://github.com/kube-core/kube-core/commit/64b27b34e5d71fecbb0f220011ad2ddbb24bf35f)

#### [v0.6.3](https://github.com/kube-core/kube-core/compare/v0.6.2...v0.6.3)

> 20 October 2022

- core/templates: Added forceNamespaceNodeSelector and forceNamespaceNodeAffinity options for all releases [`b17b376`](https://github.com/kube-core/kube-core/commit/b17b376b078120cb07b3170bed57b1758677caf9)
- cli/dev: Added test kubectl apply on file events [`93293d3`](https://github.com/kube-core/kube-core/commit/93293d341ead23b15ca495b2ca03f47808d1f647)
- release: v0.6.3 [`c52ce68`](https://github.com/kube-core/kube-core/commit/c52ce68ae2e02c285a3f37c6ad39f5f3045655ce)
- cli/package: Added upath for better cross-platform path capabilities [`064c222`](https://github.com/kube-core/kube-core/commit/064c222e11698cb453ef45d5eaafc49e3f45e564)

#### [v0.6.2](https://github.com/kube-core/kube-core/compare/v0.6.1...v0.6.2)

> 19 October 2022

- releases: Rebuilt all releases [`8bbe1fb`](https://github.com/kube-core/kube-core/commit/8bbe1fb1b87568eeb94caec81008704508cb00f9)
- core/values: Simplified templating of nginx-ingress-controller values [`6129267`](https://github.com/kube-core/kube-core/commit/6129267d34eef59917949bfa8a8bb26db50ba998)
- release: v0.6.2 [`a2dc824`](https://github.com/kube-core/kube-core/commit/a2dc82450dda1a43dbfb256c57463d6ac7492d44)
- core/envs: Added some label injections [`2bbd985`](https://github.com/kube-core/kube-core/commit/2bbd9854939c09a1cf92d95b6e0a5d2f8721a588)
- cli/scripts: Fixed wrong path for auto-generated releases input folders [`8be810e`](https://github.com/kube-core/kube-core/commit/8be810e641ebadedc55633746786da8fafd47888)
- core/templates: Fixed namespaces generation [`79e840d`](https://github.com/kube-core/kube-core/commit/79e840dc8e23a41c64182446c9bf330d0cc031a6)
- cli/scripts: Changed slicing template to use release.kube-core.io/namespace instead of .metadata.namespace [`c5c85e9`](https://github.com/kube-core/kube-core/commit/c5c85e9c9a090d29c81bd975a429c7d1449a8d36)

#### [v0.6.1](https://github.com/kube-core/kube-core/compare/v0.6.0...v0.6.1)

> 19 October 2022

- core/releases: Added the possibility to manage namespaces as releases [`d71fa70`](https://github.com/kube-core/kube-core/commit/d71fa7077abff28e1d737ebff3860ed92f51f93e)
- cli/scripts: Complete rework of build logic [`fef5cdd`](https://github.com/kube-core/kube-core/commit/fef5cdd7af36f0f21d67721fd1174ecec965584d)
- core/templates: Standardized and improved a few templates [`7e1dbfd`](https://github.com/kube-core/kube-core/commit/7e1dbfddf8a504819e95b4b9249e4a654a41c55c)
- core/releases: Added gitops.enabled on releases to generate a flux Kustomization [`86681c9`](https://github.com/kube-core/kube-core/commit/86681c991410abf9e42e30b9285ef756c6822990)
- release: v0.6.1 [`71cd0e0`](https://github.com/kube-core/kube-core/commit/71cd0e055aafc76620569a4219e227c15dda1970)
- cli/scripts: Changed test config files path in default-cluster-config.yaml [`41579bd`](https://github.com/kube-core/kube-core/commit/41579bd04637bc4839c692ed5846404b5f5fab94)

#### [v0.6.0](https://github.com/kube-core/kube-core/compare/v0.5.7...v0.6.0)

> 16 October 2022

- core/templates: Added forceNamespace, templatedValues & Various fixes/improvements in core templates [`172c30c`](https://github.com/kube-core/kube-core/commit/172c30c0ed123757c7216922aa337e566d99c203)
- cli/scripts: Reworked build to use a single helmfile template process instead of one for each release [`7fa8622`](https://github.com/kube-core/kube-core/commit/7fa8622947489c2ec1c3eef4e436d4ec800fd3ae)
- core/helmfiles: Added cluster helmfile and clusterReleases [`3fdd8da`](https://github.com/kube-core/kube-core/commit/3fdd8da7771ec9f6a5b79f4890e99f26287a3cc9)
- release: v0.6.0 [`88eb94a`](https://github.com/kube-core/kube-core/commit/88eb94a4225f532d0713fe333a1d0f81365c7141)
- cli/scripts: Fixed namespace generation to work with the new templating workflow [`5577591`](https://github.com/kube-core/kube-core/commit/5577591d983dbcdc36acbe1a309ba70c670e1d96)
- cli/scripts: Improved detection of secrets to seal/restore [`07938a2`](https://github.com/kube-core/kube-core/commit/07938a2c6a5eb7288021b0f58c615db495f83c0f)
- cli/scripts: Moved namespace generation to the end, just before post-process [`8f572ed`](https://github.com/kube-core/kube-core/commit/8f572ed44f3660e63f77cbc2e87e13580b2e17a5)
- cli/scripts: Reduced verbosity of build while looping over helmfiles [`f6ded0f`](https://github.com/kube-core/kube-core/commit/f6ded0f85ac90f49eb2aa9db76ea75121a94c1fd)

#### [v0.5.7](https://github.com/kube-core/kube-core/compare/v0.5.6...v0.5.7)

> 14 October 2022

- release: v0.5.7 [`87446fe`](https://github.com/kube-core/kube-core/commit/87446fea76f8408fac0df20fffd3088fbe3fed0e)
- docker: Upgraded helmfile to v0.147.0 [`946b0da`](https://github.com/kube-core/kube-core/commit/946b0da4fa105645b325d01c7dab6a4cce604e7c)

#### [v0.5.6](https://github.com/kube-core/kube-core/compare/v0.5.5...v0.5.6)

> 14 October 2022

- release: v0.5.6 [`e7f9d85`](https://github.com/kube-core/kube-core/commit/e7f9d852fb0b5c6257766dbd3ac36897d99f6f6e)
- cli/scripts: Updated helmfile-template.sh logic to improve performance when looping over all helmfiles and releases [`2679743`](https://github.com/kube-core/kube-core/commit/2679743a2246db01fdc38d83d0e6f8a7e6259bb9)
- core/templates: Removed release-helm-metadata template [`e436afd`](https://github.com/kube-core/kube-core/commit/e436afdfad9e8f1c7d747d088dfba327f04c7e3a)
- core/templates: Merged helm labels/annotation patches with existing ones to improve performance [`5611bd1`](https://github.com/kube-core/kube-core/commit/5611bd1c63ff6fc8268653f36e6d5b6c929493db)
- core/envs: Fixed duplicate keys in some layers [`74dfe95`](https://github.com/kube-core/kube-core/commit/74dfe95bdb41f5833f842359381f944dc2fd4ce4)

#### [v0.5.5](https://github.com/kube-core/kube-core/compare/v0.5.4...v0.5.5)

> 14 October 2022

- core/releases: Added dex & rework oauth2-proxy [`b56fca4`](https://github.com/kube-core/kube-core/commit/b56fca4bb741dfe9c10097fa60b3ef95c4561a47)
- release: v0.5.5 [`4369d9c`](https://github.com/kube-core/kube-core/commit/4369d9c4b47721d51afea6b195aa538b5be91f89)
- core/envs: Added new options to enable Oauth2 on ingress & to disable ingress access operator [`d5592ed`](https://github.com/kube-core/kube-core/commit/d5592edd04d76cfe8c87e3b39308fdd5afef8227)
- core/envs: Added possibility to generate dynamically secrets for each releases [`2b26885`](https://github.com/kube-core/kube-core/commit/2b26885b254c5895e70736160b5914f6512af525)
- core/values: Homogenized values format to set ingressClass [`0aa6f2e`](https://github.com/kube-core/kube-core/commit/0aa6f2ef9cb3a7739395f90fd0ff1b7648622680)
- core/envs: Force quote on metadata values in release secrets [`752bfb9`](https://github.com/kube-core/kube-core/commit/752bfb9d78777ad56d6d90b9dac67deeeacf29bb)

#### [v0.5.4](https://github.com/kube-core/kube-core/compare/v0.5.3...v0.5.4)

> 13 October 2022

- releases/flux-repository: Updated values templates and release [`8acd329`](https://github.com/kube-core/kube-core/commit/8acd3290a9dc3161fa484cfa867b49ed49981a8d)
- releases: Added flux-repository [`c3ed984`](https://github.com/kube-core/kube-core/commit/c3ed9845dc58b2719696b8e848ea5e6e89582163)
- releases/crossplane-buckets: Updated version to v0.3.1 [`f8ee019`](https://github.com/kube-core/kube-core/commit/f8ee019f8b419b44ea410c236f4546a277c22b80)
- releases/kyverno-policies: Set failurePolicy to Ignore by default & Rebuilt chart [`1376d86`](https://github.com/kube-core/kube-core/commit/1376d86ba1535be1a35b35420fa351127c47a874)
- core/releases: Cleaned up releases definitions [`ae822fa`](https://github.com/kube-core/kube-core/commit/ae822fab18d961498db0ddb9fe4c26cd9b755fb7)
- core/envs: Added core.globalHelmMetadataEnabled to force rendering Helm labels/annotations on manifests [`6948dd6`](https://github.com/kube-core/kube-core/commit/6948dd667ee2ace1406db11649792b80925e691e)
- release: v0.5.4 [`11024f9`](https://github.com/kube-core/kube-core/commit/11024f9a64c7a73a1f589114de53c7520770ca9e)
- core/envs: Added secret for flux-repository in release-secrets [`eceaeb3`](https://github.com/kube-core/kube-core/commit/eceaeb384b2ef603174c6952b72bab3a097395ef)
- core/values: Added condition to handle using raw as a service [`76a305e`](https://github.com/kube-core/kube-core/commit/76a305ee6790a56135085258665880a265fc6dfb)
- cli/scripts: Activated ytt overlays by default, with toggle via cluster-config [`e623fcf`](https://github.com/kube-core/kube-core/commit/e623fcfb575bb6ec3d2af1ea702d45e13b985905)
- core/templates: Improved kube-core chart and values layering over applications/services and added toggles [`b15da33`](https://github.com/kube-core/kube-core/commit/b15da3313f25899d96e88bcbe67b53ee737db5ff)
- core/values: Improved n9-api default values template [`ea44dba`](https://github.com/kube-core/kube-core/commit/ea44dbaa038aee64faa4eada78a6c3de073e0bfe)
- cli/scripts: Moved overlays at the end of kube-core build [`4243f47`](https://github.com/kube-core/kube-core/commit/4243f471cfaeabab9e63a650087cf161d62b8627)
- cli/scripts: Improved logging on gitops_overlay [`901794a`](https://github.com/kube-core/kube-core/commit/901794ac3dfe1e50029ebcea1a055ce2bf1c2661)
- cli/scripts: Added some extra cleanup after building kube-core charts [`aba3c93`](https://github.com/kube-core/kube-core/commit/aba3c93e378c987a12154adc977873d5488721cc)
- cli/scripts: Fixed overlays applied on actual config instead of staging area [`803f245`](https://github.com/kube-core/kube-core/commit/803f24593c67491e977a29e3884579e3bbe85234)
- core/templates: Improved support of applications and services with injectClusterLoggingLabel [`9c15b3e`](https://github.com/kube-core/kube-core/commit/9c15b3ec1c3fa4477808e726807cd6d091eaa83e)

#### [v0.5.3](https://github.com/kube-core/kube-core/compare/v0.5.2...v0.5.3)

> 11 October 2022

- core/templates: Removed label injection on custom releases [`41220d3`](https://github.com/kube-core/kube-core/commit/41220d3351d48b44564c362bb1067f944b821016)
- release: v0.5.3 [`d9c3abb`](https://github.com/kube-core/kube-core/commit/d9c3abbce625dd7a80b31c911ea6e1b17fc25706)

#### [v0.5.2](https://github.com/kube-core/kube-core/compare/v0.5.1...v0.5.2)

> 11 October 2022

- core/envs: Added integrations between Core, Applications and Services for mongodb-managed and rabbitmq-managed [`4358e16`](https://github.com/kube-core/kube-core/commit/4358e16b2a323e25408aa096956d179bc077906c)
- cli/scripts: Reimplemented ytt Overlays [`79b2b03`](https://github.com/kube-core/kube-core/commit/79b2b03ec5c9cd1743c02b9d30e2c9a7be01d5ba)
- release: v0.5.2 [`8bafeef`](https://github.com/kube-core/kube-core/commit/8bafeef1d5e3f491d5ea4c9a9e1e89520028928d)

#### [v0.5.1](https://github.com/kube-core/kube-core/compare/v0.5.0...v0.5.1)

> 7 October 2022

- core/templates: Added release-labels template to easily inject global labels in any relase [`712b79d`](https://github.com/kube-core/kube-core/commit/712b79d300f9d4138ba683ffb9bef0d727229140)
- release: v0.5.1 [`90c1ef2`](https://github.com/kube-core/kube-core/commit/90c1ef2235f578a0d23b091b18e51d1772efa3b9)

#### [v0.5.0](https://github.com/kube-core/kube-core/compare/v0.4.5...v0.5.0)

> 7 October 2022

- core/templates: Reworked templates to allow for environments, applications and services generation [`d62295d`](https://github.com/kube-core/kube-core/commit/d62295ddf8f2b24397e0b8df697155ddb28733f1)
- releases: Added node-problem-detector [`f9fe353`](https://github.com/kube-core/kube-core/commit/f9fe353eb8e4b7237ea434ac5b4142dc61e09e96)
- core/envs: Reworked core values to allow for environments, applications and services generation [`a4e0a3c`](https://github.com/kube-core/kube-core/commit/a4e0a3ceeb524d32106394397575e3aa0552bc9a)
- core/values: Reworked values templates to allow for environments, applications and services generation [`2196952`](https://github.com/kube-core/kube-core/commit/2196952cfea5472232c3953dfdba89f4cec9944e)
- releases/n9-api: Updated to v1.3.2 [`d693fbe`](https://github.com/kube-core/kube-core/commit/d693fbe01b2d7de1169abe2937561cc4b8134f58)
- core: Reworked core helmfiles to allow for environments, applications and services generation [`fabbfd2`](https://github.com/kube-core/kube-core/commit/fabbfd25bdec1d7205e743b3b1ea499e9090539d)
- release: v0.5.0 [`44db325`](https://github.com/kube-core/kube-core/commit/44db325e42ce13b0c6962b1511465520dcc41313)
- cli/workspace: Updated open command documentation [`a78f0f3`](https://github.com/kube-core/kube-core/commit/a78f0f346f0bcffac3358cd0a873aec999b9188e)

#### [v0.4.5](https://github.com/kube-core/kube-core/compare/v0.4.4...v0.4.5)

> 4 October 2022

- cli: Added workspace:open command [`46c50af`](https://github.com/kube-core/kube-core/commit/46c50af952461887079261d33df28f64db770c9b)
- release: v0.4.5 [`e2074b5`](https://github.com/kube-core/kube-core/commit/e2074b548be957795114fcc07a0f30a71ef841af)

#### [v0.4.4](https://github.com/kube-core/kube-core/compare/v0.4.3...v0.4.4)

> 3 October 2022

- releases: Rebuilt all releases [`c3add63`](https://github.com/kube-core/kube-core/commit/c3add63d61f398a5fb4e498142b488164e0bb46d)
- releases/mongodb-operator: Removed local chart and migrated to official one [`9e35c97`](https://github.com/kube-core/kube-core/commit/9e35c974f41acab1c81a1a33b304c166281bc410)
- releases/cluster-policies: Disabeled fail safe mode by default & Updated some policies [`2a375da`](https://github.com/kube-core/kube-core/commit/2a375da230d81df17bd169a5ae9255575e5ecd4f)
- releases/rabbitmq-operator: Removed hooks and improved resource naming [`5d4138f`](https://github.com/kube-core/kube-core/commit/5d4138fb50bff464b975fa4efb658e966df839d6)
- release: v0.4.4 [`cb64517`](https://github.com/kube-core/kube-core/commit/cb645173f485113012b6fc83ae5779988e67419b)
- releases/logging-stack: Changed fluentd minReplicaCount to 3 [`cd1efd3`](https://github.com/kube-core/kube-core/commit/cd1efd3c5258be89121811f849ba355f1f6600b3)

#### [v0.4.3](https://github.com/kube-core/kube-core/compare/v0.4.2...v0.4.3)

> 30 September 2022

- releases/cluster-policies: Disabled all mutations by default [`7b10bfd`](https://github.com/kube-core/kube-core/commit/7b10bfdd55df5bdb7a4341f8e5c4c98bcc2993db)
- release: v0.4.3 [`3c28edb`](https://github.com/kube-core/kube-core/commit/3c28edb5d6dfd396d4e9430cf9926cd2c717ea74)

#### [v0.4.2](https://github.com/kube-core/kube-core/compare/v0.4.1...v0.4.2)

> 30 September 2022

- releases/cluster-policies: Reworked default configuration [`e2d56c1`](https://github.com/kube-core/kube-core/commit/e2d56c156a28702395514a0caabcb37c55ff89b9)
- release: v0.4.2 [`e6f23a3`](https://github.com/kube-core/kube-core/commit/e6f23a348f18f0396cd28cbb1659de684882fdfc)
- core/releases: Removed ingress upgrade options for tekton [`3c88808`](https://github.com/kube-core/kube-core/commit/3c88808b16e83a47cb58be8e8f6fad53d1ce7fe8)

#### [v0.4.1](https://github.com/kube-core/kube-core/compare/v0.4.0...v0.4.1)

> 29 September 2022

- releases/tekton: Updated Ingress resources to v1 [`d3f46bf`](https://github.com/kube-core/kube-core/commit/d3f46bf72f22912d10c07b86310455873b7da00a)
- releases/cluster-policies: Fixed default values [`42879c6`](https://github.com/kube-core/kube-core/commit/42879c6e6a1256689b60627aad89dde1173b65c4)
- release: v0.4.1 [`f7e4065`](https://github.com/kube-core/kube-core/commit/f7e40653cbe66a72ad3d46c7f0e619834a37105f)

#### [v0.4.0](https://github.com/kube-core/kube-core/compare/v0.3.27...v0.4.0)

> 29 September 2022

- releases: Rebuilt dist folder [`1b73b70`](https://github.com/kube-core/kube-core/commit/1b73b70dc6ed647fbbf13b7fdf349b5c1dac2525)
- releases/policies: Added kube-core base policies [`5128123`](https://github.com/kube-core/kube-core/commit/51281233a8786b896291c1f5d794f805185d474a)
- core/releases: Reworked layers and some defaults [`fc14066`](https://github.com/kube-core/kube-core/commit/fc140661adf37b3bcb9d37f02a91204b2d3bf1ee)
- releases/kyverno-policies: Added kyverno-policies with default values [`23ac9da`](https://github.com/kube-core/kube-core/commit/23ac9da7e897ec89c0a98d1eb15c6b51fde97044)
- releases/kube-cleanup-operator: Updated values and switched source from local chart to remote [`c3e6010`](https://github.com/kube-core/kube-core/commit/c3e6010d82eb15441f964ee2b46fa84eaeb2c832)
- releases: Added cluster-rbac [`d4e16cb`](https://github.com/kube-core/kube-core/commit/d4e16cb05e500af9b1b0a0d3cfa4fca97fe04d14)
- cli/releases: Added script to generate a local release [`4d17a02`](https://github.com/kube-core/kube-core/commit/4d17a02c82c94787bde74d3418d1d5f324b23f63)
- releases/logging-stack: Reworked logging-stack Ingress [`8777c3a`](https://github.com/kube-core/kube-core/commit/8777c3ae5422e4bcdaa6327028c48e8e0fc5df1e)
- release: v0.4.0 [`4b78b5d`](https://github.com/kube-core/kube-core/commit/4b78b5d598857eefd9c46a9ecaacea554b8e1a28)
- releases/kyverno: Switched to HA and increased resource limits for kyverno [`234ae22`](https://github.com/kube-core/kube-core/commit/234ae22f97311fce22f0ce44e8f626f06683e27a)
- releases/logging-stack: Updated app and events dashboard [`bb190f8`](https://github.com/kube-core/kube-core/commit/bb190f80c3db2cc57a2526d66890dc266e5ecfbb)

#### [v0.3.27](https://github.com/kube-core/kube-core/compare/v0.3.26...v0.3.27)

> 23 September 2022

- releases: Added kyverno [`581c911`](https://github.com/kube-core/kube-core/commit/581c9117d5faa7fd9e756baa288e8eeee1acd953)
- release: v0.3.27 [`32d73a8`](https://github.com/kube-core/kube-core/commit/32d73a8f7341a780068db973086f7fafb2ffc764)

#### [v0.3.26](https://github.com/kube-core/kube-core/compare/v0.3.25...v0.3.26)

> 22 September 2022

- cli/scripts: Cleaned up some scripts and regenerated scripts-config with more docs [`d9fc28e`](https://github.com/kube-core/kube-core/commit/d9fc28e407dc5e9af58f1047d35efcc62a969799)
- release: v0.3.26 [`8bcac4a`](https://github.com/kube-core/kube-core/commit/8bcac4a9c769866f7fc97d372c9869f213dcc6f8)
- core/releases: Adds the possibility to inject labels for logging in core releases [`1a66aab`](https://github.com/kube-core/kube-core/commit/1a66aab90caa50bb42c7d58decb4e4f264451c91)
- releases/kps: Fixed wrong URL for mongodb_percona dashboard [`bcf5fa3`](https://github.com/kube-core/kube-core/commit/bcf5fa353b4655da49f539ee74a5a6a49b89b8d9)
- core/releases: Added logging on nginx-ingress releases by default [`379c571`](https://github.com/kube-core/kube-core/commit/379c5715096a9f3903eb2bef7768ab8602359c37)
- releases/tekton: Sets default SA for triggers to tekton [`00e57a5`](https://github.com/kube-core/kube-core/commit/00e57a5ae9d862be93d9c90a7a11aecd0882c00f)
- core/releases: Fixed typo on logging LabelTransformer [`5ebc9b7`](https://github.com/kube-core/kube-core/commit/5ebc9b7082a7b3b3be18d677b4ec923ca48ad1d8)
- cli/scripts: Fixed typo in cloud_gcp_setup_tekton_sf [`e6a68d5`](https://github.com/kube-core/kube-core/commit/e6a68d5d8a4052b739aaa949114b9c667afdbfbb)

#### [v0.3.25](https://github.com/kube-core/kube-core/compare/v0.3.24...v0.3.25)

> 20 September 2022

- releases/chaos: Removed litmus-chaos and introduced chaos-mesh [`bb68c95`](https://github.com/kube-core/kube-core/commit/bb68c957c123a7b98a629e790d8f9c8558c2023d)
- releases: Updated releases/dist [`feb8859`](https://github.com/kube-core/kube-core/commit/feb8859428eee322036767eeffa47de8107b1ea0)
- releases/mongodb-atlas-operator: Added mongodb-atlas-operator release [`c708a74`](https://github.com/kube-core/kube-core/commit/c708a74de0f27e97c121385d057730c2af6d5630)
- cli/generators: Adds terraform generator [`7227c56`](https://github.com/kube-core/kube-core/commit/7227c5612e63f770ac97410a42cf7d62cf40d86d)
- releases/logging: Improved logging-stack and cluster-logging default configuration, scaling and performance [`27a93b4`](https://github.com/kube-core/kube-core/commit/27a93b41024453e8f6b5d336199dc2e51af6196d)
- core/config: Reformatted some files [`09c8ded`](https://github.com/kube-core/kube-core/commit/09c8ded322facd1b5a8c9e487aab7db65175cfbf)
- releases/kps: Added some Grafana dashbords and reorganized some folders [`b484d69`](https://github.com/kube-core/kube-core/commit/b484d691f708c573e59a8c5d38ce45b92bc550b3)
- cli/generators: Fixes path in cli plopfile [`b58c7a1`](https://github.com/kube-core/kube-core/commit/b58c7a16c7935a676a135b6b553ba13c813bd645)
- release: v0.3.25 [`d5923cd`](https://github.com/kube-core/kube-core/commit/d5923cdaefa0c521349d6c99106fd51eb052c7b2)
- releases/kps: Updated mongodb and external-dns dashboards [`618716c`](https://github.com/kube-core/kube-core/commit/618716cdfe44dd990de6bb2e7944be42c303b2b8)

#### [v0.3.24](https://github.com/kube-core/kube-core/compare/v0.3.23...v0.3.24)

> 16 September 2022

- releases/logging-stack: Added Kibana dashboard auto-provisionning [`dc6afdf`](https://github.com/kube-core/kube-core/commit/dc6afdf7d7f4f891e875092db17917f19af9f707)
- releases/cluster-logging: Allows to inject extra shared filters for all flows [`11ce7bc`](https://github.com/kube-core/kube-core/commit/11ce7bc3982389392a036b1b1d82c3a785454d6c)
- releases/cluster-logging: Added output integrations on tekton default flow [`1248866`](https://github.com/kube-core/kube-core/commit/1248866a48cd93a04e67fcba40622449891135b6)
- release: v0.3.24 [`c1e2cea`](https://github.com/kube-core/kube-core/commit/c1e2ceaa8805c5fbbba21aa4a27f33249758b65b)
- core/releases: Added kube-core logging labels on nginx-ingress-controller [`a4979c8`](https://github.com/kube-core/kube-core/commit/a4979c8095437641b0a3aa5d191b8085a4527134)
- releases/logging-stack: Changed min fluentd replicas to 1 by default [`c1b5c50`](https://github.com/kube-core/kube-core/commit/c1b5c50a71bc9ec87ee635240b229aab80cfc114)

#### [v0.3.23](https://github.com/kube-core/kube-core/compare/v0.3.22...v0.3.23)

> 15 September 2022

- releases/kps: Adds multiple dashboards [`069bfa8`](https://github.com/kube-core/kube-core/commit/069bfa8c20472c033a8fb3e6bcddd6e63a39d2ba)
- releases/logging-stack: Added possibility to control min/max fluentd replicas [`569ee1c`](https://github.com/kube-core/kube-core/commit/569ee1c4f0b17a20c330ab38507c0e8d3c5c8537)
- release: v0.3.23 [`d3af48c`](https://github.com/kube-core/kube-core/commit/d3af48c6d51129aab8fc5d8c143d1558c661d977)
- core/cluster: Removed some namespaces that were included in log streams by default [`be2dc7e`](https://github.com/kube-core/kube-core/commit/be2dc7e77a281c417d6b7a1dd5370d8075aeac51)

#### [v0.3.22](https://github.com/kube-core/kube-core/compare/v0.3.21...v0.3.22)

> 15 September 2022

- releases/cluster-logging: Changed default buffer parameters to have better AWS S3 support [`e3ea2ec`](https://github.com/kube-core/kube-core/commit/e3ea2ec9f8d1c2c7a0568b2f0b037ddede70f057)
- release: v0.3.22 [`fd4a04f`](https://github.com/kube-core/kube-core/commit/fd4a04f01066e2b2dcdb770a5955507903920960)

#### [v0.3.21](https://github.com/kube-core/kube-core/compare/v0.3.20...v0.3.21)

> 15 September 2022

- releases/cluster-logging: Fixed some unsafe conditions [`5f9a553`](https://github.com/kube-core/kube-core/commit/5f9a5533920ac7dac98cf08c79a4078314bb4261)
- release: v0.3.21 [`8224cd0`](https://github.com/kube-core/kube-core/commit/8224cd0fd43e4948279a000e929c9f75e8c49b18)

#### [v0.3.20](https://github.com/kube-core/kube-core/compare/v0.3.19...v0.3.20)

> 15 September 2022

- release: v0.3.20 [`d12044c`](https://github.com/kube-core/kube-core/commit/d12044c8f32bba42e5f832f5f8fb7543d423981a)
- releases/cluster-logging: Disabled events integration by default [`42c4acc`](https://github.com/kube-core/kube-core/commit/42c4acc498f6b8b3b0d52a23dfc077d589178b49)

#### [v0.3.19](https://github.com/kube-core/kube-core/compare/v0.3.18...v0.3.19)

> 14 September 2022

- releases/eck-operator: Upgrades to v2.4.0 and adds logic for autoscaling [`f76a4f6`](https://github.com/kube-core/kube-core/commit/f76a4f6ac3bc3674597c119fe0ab2c944aa61f8a)
- releases: Rebuilt releases [`f4f9d29`](https://github.com/kube-core/kube-core/commit/f4f9d29df2443e502cfcc539fa77462b453c9dda)
- releases/logging: Improved default values [`ea12ae2`](https://github.com/kube-core/kube-core/commit/ea12ae2612044c3fb1f8d19a3def996e050b6057)
- core/packages: Fixed test-logging package [`88f03c4`](https://github.com/kube-core/kube-core/commit/88f03c4f314111179df12e6e4c7b99759685388d)
- release: v0.3.19 [`25c68cd`](https://github.com/kube-core/kube-core/commit/25c68cd7e980ecba524d3245d5febdabf61ec654)
- releases/logging-stack: Improved fluentbit default configuration [`9e0a5c4`](https://github.com/kube-core/kube-core/commit/9e0a5c4380b403d54755fc086edf13cddeb3b40c)

#### [v0.3.18](https://github.com/kube-core/kube-core/compare/v0.3.17...v0.3.18)

> 12 September 2022

- releases: Added test-logging package [`fd5364d`](https://github.com/kube-core/kube-core/commit/fd5364dba120c5fa2783db47b593aaa7862509c7)
- release: v0.3.18 [`4045d94`](https://github.com/kube-core/kube-core/commit/4045d949e701501da9d352fd26b0fb054c3f2460)

#### [v0.3.17](https://github.com/kube-core/kube-core/compare/v0.3.16...v0.3.17)

> 11 September 2022

- releases: Added prometheus-adapter & KEDA [`5163d79`](https://github.com/kube-core/kube-core/commit/5163d795979a23b7c5df6d07a88597bfb4fad7ac)
- releases: Rebuilt releases [`a57b92b`](https://github.com/kube-core/kube-core/commit/a57b92b6da05bb89c38bacf7116b151bef01fc56)
- releases/cluster-logging: Added events integration that allows to parse and forward Kubernetes Events [`7715774`](https://github.com/kube-core/kube-core/commit/7715774c1530538e86eb8fd0b0fd1dc0dff96d3f)
- releases/cluster-logging: Improved buffer and flush configuration to have more resilient and scalable event streams [`236f0b4`](https://github.com/kube-core/kube-core/commit/236f0b40416d6ef3be465aee7063286cc07822ae)
- releases/logging-stack: Improved scalability, observability and resiliency of fluentd and fluentbit [`b311589`](https://github.com/kube-core/kube-core/commit/b3115897efd74b936df56d7db6c6506f8fd660c0)
- core/config: Cleaned up some default values from core env as they are now in the underlying logging charts [`08f45db`](https://github.com/kube-core/kube-core/commit/08f45db04416513e5227a15dd3dcd38106edd4a7)
- release: v0.3.17 [`0d5973d`](https://github.com/kube-core/kube-core/commit/0d5973dfdcb11a8aa559ea1ed13967179041e5b4)
- releases/logging-stack: Added EventTailer resource to the stack [`00f4201`](https://github.com/kube-core/kube-core/commit/00f4201d0a9293665da3d68e5c293db770d8cc7d)
- releases/system-jobs: Removes excessive logging in all system-jobs containers [`184e57c`](https://github.com/kube-core/kube-core/commit/184e57cb454a97c822ccf3c7711d11b470ba88f0)
- cli/generators: Updated release template for add release command [`1a94aea`](https://github.com/kube-core/kube-core/commit/1a94aea247f9974cfbdba7b649b43f8f64bc8ddd)

#### [v0.3.16](https://github.com/kube-core/kube-core/compare/v0.3.15...v0.3.16)

> 6 September 2022

- cli/scripts: Adds more checks in branch detection before applying in auto-pr [`3dc94b1`](https://github.com/kube-core/kube-core/commit/3dc94b1908814d269d1b692b5f648d791b776012)
- release: v0.3.16 [`7eb556d`](https://github.com/kube-core/kube-core/commit/7eb556daa303daaaeb935d70360635ff1341833d)

#### [v0.3.15](https://github.com/kube-core/kube-core/compare/v0.3.14...v0.3.15)

> 6 September 2022

- releases/tekton: Fixes apply & auto-merge logic in core-tag and cluster-push [`2c203b6`](https://github.com/kube-core/kube-core/commit/2c203b606c7051e6ec674d1c9094cc50b004a54d)
- release: v0.3.15 [`efcfce0`](https://github.com/kube-core/kube-core/commit/efcfce0ceb0bfaaa4e9eed728208f8d3568c5c70)

#### [v0.3.14](https://github.com/kube-core/kube-core/compare/v0.3.13...v0.3.14)

> 6 September 2022

- releases/tekton: Makes kube-core image in CI variable [`67851d4`](https://github.com/kube-core/kube-core/commit/67851d47ff82f776b6792c8422837e92fd90051b)
- release: v0.3.14 [`99f1ba8`](https://github.com/kube-core/kube-core/commit/99f1ba878d39ac7c4c8d55c078683baebab235d9)

#### [v0.3.13](https://github.com/kube-core/kube-core/compare/v0.3.12...v0.3.13)

> 6 September 2022

- policies: Adds possibility to toggle kube-core policies and cluster policies [`31ebf21`](https://github.com/kube-core/kube-core/commit/31ebf21160c78babec3455bc7c273c127a93b344)
- release: v0.3.13 [`1a29e8f`](https://github.com/kube-core/kube-core/commit/1a29e8fd955cabf44e9e70403fc0467a3b9ba1c5)

#### [v0.3.12](https://github.com/kube-core/kube-core/compare/v0.3.11...v0.3.12)

> 5 September 2022

- gitops: Adds apply logic on gitops pipelines [`7138a98`](https://github.com/kube-core/kube-core/commit/7138a98b839468188f3f8395a27aeca71740d612)
- release: v0.3.12 [`9f1cfb4`](https://github.com/kube-core/kube-core/commit/9f1cfb4985dc99b63a7b827f15a704a8e01f56b2)

#### [v0.3.11](https://github.com/kube-core/kube-core/compare/v0.3.10...v0.3.11)

> 5 September 2022

- release: v0.3.11 [`fc55f1b`](https://github.com/kube-core/kube-core/commit/fc55f1b00608e7dd80b4ea109b12ab9f5b7ddaa3)
- cli/scripts: Fixes detection of changes in auto-pr if all files are targeted instead of gitops config only [`901633f`](https://github.com/kube-core/kube-core/commit/901633f5a4ee05ea1a8cd7b7d5817748172bf22d)

#### [v0.3.10](https://github.com/kube-core/kube-core/compare/v0.3.9...v0.3.10)

> 5 September 2022

- cli/scripts: Forced secrets namespace generation to avoid CI builds deleting it [`569ce37`](https://github.com/kube-core/kube-core/commit/569ce37558f8596b5d7242e3acd999ad41d40523)
- release: v0.3.10 [`f36b73f`](https://github.com/kube-core/kube-core/commit/f36b73f65b2adf137a041eaedd0716652e929cf0)

#### [v0.3.9](https://github.com/kube-core/kube-core/compare/v0.3.8...v0.3.9)

> 5 September 2022

- releases: Removed base folder as it is not used anymore [`9d73a04`](https://github.com/kube-core/kube-core/commit/9d73a047c0b0fe8286ddd34134a95e6e47a262c9)
- cli/scripts: Updates flux install & Various fixes and improvements [`8c58ee2`](https://github.com/kube-core/kube-core/commit/8c58ee29b3febe9961214a5390b5c8e423f0f815)
- releases: Adds flux-config to manage default flux resources [`575cda9`](https://github.com/kube-core/kube-core/commit/575cda958c0ccd917ac498a375988c4785998b4b)
- core/templates: Moved namespace field on the kube-core release wrapper [`5971189`](https://github.com/kube-core/kube-core/commit/5971189c8d42ab638428709835b806b298bbe4ab)
- releases/flux: Adds podmonitor config to monitor all flux controllers [`af8c9bd`](https://github.com/kube-core/kube-core/commit/af8c9bdc8a2d30befca8555e6d6d44c6b9f015d4)
- release: v0.3.9 [`9ae4719`](https://github.com/kube-core/kube-core/commit/9ae4719a4bbd1f87b2da43a0559d9d06d8008c40)
- releases/schema: Updated schema to include new releases [`6c05646`](https://github.com/kube-core/kube-core/commit/6c05646dcd2871c7603d2a86eeaa8de5a7f0ed5e)

#### [v0.3.8](https://github.com/kube-core/kube-core/compare/v0.3.7...v0.3.8)

> 3 September 2022

- releases/tekton: Updates core-tag & PR workflow [`2102c25`](https://github.com/kube-core/kube-core/commit/2102c253966b0afad092c61becd3e0548b8a8195)
- release: v0.3.8 [`6f275f0`](https://github.com/kube-core/kube-core/commit/6f275f0c0c0a14ac0b0d004cc2607cae3bd1e9c1)

#### [v0.3.7](https://github.com/kube-core/kube-core/compare/v0.3.6...v0.3.7)

> 3 September 2022

- releases: Adds container-registry-config to allow easy use of GCR in the cluster [`1fa0df9`](https://github.com/kube-core/kube-core/commit/1fa0df96383d252454b6a4ad1e4c3b5d53c02480)
- releases/tekton: Fixes core-tag pipeline & Makes kube-core image variable [`6d69f36`](https://github.com/kube-core/kube-core/commit/6d69f36207dcb7ae1ce452c6f4817e040426ee72)
- release: v0.3.7 [`2e6294c`](https://github.com/kube-core/kube-core/commit/2e6294c9b724d52b52872182050f571897c33190)

#### [v0.3.6](https://github.com/kube-core/kube-core/compare/v0.3.5...v0.3.6)

> 2 September 2022

- releases/tekton: Updates core-tag pipeline to use kube-core [`6e9ea00`](https://github.com/kube-core/kube-core/commit/6e9ea003cb85579f051f7a2fd6efea16171d71bf)
- release: v0.3.6 [`95d0d49`](https://github.com/kube-core/kube-core/commit/95d0d494639b175cedf650088867d68f1a0295ff)

#### [v0.3.5](https://github.com/kube-core/kube-core/compare/v0.3.4...v0.3.5)

> 2 September 2022

- releases/tekton: Improves secret configuration [`f35347c`](https://github.com/kube-core/kube-core/commit/f35347c5a3ade975859c36bd65d9477023af55b6)
- cli/scripts: Adds tekton & SF setup script [`30fe0b1`](https://github.com/kube-core/kube-core/commit/30fe0b1b114c390ffaaf1b5eb21d2a8bcdfa1fee)
- cli/scripts: Adds option to delete PR source branch by default on cluster auto PR [`7c359a3`](https://github.com/kube-core/kube-core/commit/7c359a3173397b0434b74bba2d0986e6896bcf11)
- cli/scripts: Adds variable for local keys path [`12ddfa1`](https://github.com/kube-core/kube-core/commit/12ddfa1345c6fc6efc87dd2e9c8e1c39c94cc982)
- release: v0.3.5 [`03a5484`](https://github.com/kube-core/kube-core/commit/03a548424918a5148f137bc1aa2a30236038dc59)

#### [v0.3.4](https://github.com/kube-core/kube-core/compare/v0.3.3...v0.3.4)

> 1 September 2022

- releases/tekton: Changes default run timeout and makes it configurable [`43eb76c`](https://github.com/kube-core/kube-core/commit/43eb76c2694088b059295cef3e05cfba5aed8c8e)
- release: v0.3.4 [`24ffde8`](https://github.com/kube-core/kube-core/commit/24ffde8683b254941024a46cbb36ddda5c50a211)

#### [v0.3.3](https://github.com/kube-core/kube-core/compare/v0.3.2...v0.3.3)

> 1 September 2022

- releases/tekton: Renamed and removed some resources [`489601c`](https://github.com/kube-core/kube-core/commit/489601c4cb9bea21d8fae20e6bec19a4e3f7ff36)
- release: v0.3.3 [`d396425`](https://github.com/kube-core/kube-core/commit/d396425ca1864a4ef6c297553fe75fbc905e2011)

#### [v0.3.2](https://github.com/kube-core/kube-core/compare/v0.3.1...v0.3.2)

> 1 September 2022

- releases/tekton: Reintroduces core-tag pipeline [`2a48d6f`](https://github.com/kube-core/kube-core/commit/2a48d6fa0d0cf5ae495764f3c17e95a023bef84a)
- releases/tekton: Improves resource name templating and brings more variables in hooks [`15b05f4`](https://github.com/kube-core/kube-core/commit/15b05f47e09ee5f4903a390acaa284453bc6bc70)
- release: v0.3.2 [`fd7f3d7`](https://github.com/kube-core/kube-core/commit/fd7f3d7ca87c6d8d3c8aa53321b691ffdd60845d)
- cli/scripts: Updated bump script to automatically patch cli version [`ce0d14b`](https://github.com/kube-core/kube-core/commit/ce0d14bca2d14632c19248bb6791ece415e9cd05)
- releases/tekton: Fixes app-hooks git-webhooks-token reference missing [`30dc586`](https://github.com/kube-core/kube-core/commit/30dc5869ef0f6e05d0c702d3ff51a2b22f8a50c1)

#### [v0.3.1](https://github.com/kube-core/kube-core/compare/v0.3.0...v0.3.1)

> 30 August 2022

- release: v0.3.1 [`42d34d3`](https://github.com/kube-core/kube-core/commit/42d34d338ddc262adc2dc9b060e3411c33577f80)
- cli: Fixes corePath in scripts [`9f40d5a`](https://github.com/kube-core/kube-core/commit/9f40d5a6588624db3e2de57ddd3d911168c1bdd4)
- scripts: Moved scripts in cli folder to package them together [`71e988d`](https://github.com/kube-core/kube-core/commit/71e988dde54d246a2baa8cfc32540f5e80c979aa)
- repo: Fixes .gitignore ignoring some files that should not be ignored [`890b99b`](https://github.com/kube-core/kube-core/commit/890b99bae2f7fd37942ec7362e02051e888294fe)
- cli: Reintroduced .helmignore files in releases/dist [`82518ff`](https://github.com/kube-core/kube-core/commit/82518ff041391c8d36d7da62f2c403e0428f8d85)
- ci: Updated GitHub Actions Workflows [`337d717`](https://github.com/kube-core/kube-core/commit/337d717a9db717d54b1e7a53c7494034c98034d7)
- cli: Adds basic install instructions in README [`dbf204b`](https://github.com/kube-core/kube-core/commit/dbf204b998fc1c9645e71905f3e7f61322260e33)
- repo: Fixes scripts line endings for npm release packaging [`6a78e71`](https://github.com/kube-core/kube-core/commit/6a78e71cc3ae29abbd2b0b6d0db276a66bd185b6)
- cli: Bumps version to v0.1.6 [`8b60f11`](https://github.com/kube-core/kube-core/commit/8b60f11d86bdfa5dff2d8e3cd57fdab4939cbb63)
- release-it: Fixes changelog generation [`0ae3980`](https://github.com/kube-core/kube-core/commit/0ae3980ec6f565ce9e68883c63780b8c5ce42806)
- cli: Adds proper chmod on scripts [`2fed94b`](https://github.com/kube-core/kube-core/commit/2fed94b12df275027a99c13b56bd2af4d140d493)

#### [v0.3.0](https://github.com/kube-core/kube-core/compare/v0.2.1...v0.3.0)

> 30 August 2022

- release: v0.3.0 [`f6b3ea8`](https://github.com/kube-core/kube-core/commit/f6b3ea8520a461a15e5b39d2c28fac7f6af4bb7d)

#### [v0.2.1](https://github.com/kube-core/kube-core/compare/v0.2.0...v0.2.1)

> 23 August 2022

- core: Added the possibility to deploy Patches with .release.patches [`ba4be28`](https://github.com/kube-core/kube-core/commit/ba4be289fa18f00c4c3e19c61b2f718c505d8d00)
- release: v0.2.1 [`6696bfa`](https://github.com/kube-core/kube-core/commit/6696bfa6d78b655593ddacc0684157fcb2099d2e)
- scripts: Fixes kube-core apply & template commands [`2c7d38e`](https://github.com/kube-core/kube-core/commit/2c7d38e5db982ef3b2682c5047520966bdb6ff02)
- cli: Fixed .gitignore breaking dev cli [`c0612f7`](https://github.com/kube-core/kube-core/commit/c0612f7619097bb59c5b566a1400010618ec07a8)

#### [v0.2.0](https://github.com/kube-core/kube-core/compare/v0.1.0...v0.2.0)

> 23 August 2022

- release: v0.2.0 [`1ebe8a2`](https://github.com/kube-core/kube-core/commit/1ebe8a2ba62520cf7ba3e002065918f481311e83)

#### v0.1.0

> 23 August 2022

- release: v0.1.0 [`a08500b`](https://github.com/kube-core/kube-core/commit/a08500b2a3fd027364d13e7e766efd0111ea1a39)
- Initial commit [`ba3977a`](https://github.com/kube-core/kube-core/commit/ba3977a0c9d8bf8817a58b32213fe906b33b0da1)
