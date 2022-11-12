### Changelog

All notable changes to this project will be documented in this file. Dates are displayed in UTC.

#### [v0.7.6](https://github.com/kube-core/kube-core/compare/v0.7.5...v0.7.6)

- core/releases: Removed default secrets for mongodb atlas operator [`ea025a0`](https://github.com/kube-core/kube-core/commit/ea025a067aefb1e832a909aeff0fff8d79d6d16b)

#### [v0.7.5](https://github.com/kube-core/kube-core/compare/v0.7.4...v0.7.5)

> 11 November 2022

- core/templates: Reworked helmfiles, fixed local paths for dev [`b5433a0`](https://github.com/kube-core/kube-core/commit/b5433a05047eea620eb8ccaeece56e3418c368e9)
- release: v0.7.5 [`81ed907`](https://github.com/kube-core/kube-core/commit/81ed907df66bc4315d70d61e87cb52ed44c82bb4)
- cli/commands: Added flag to toggle color output on diff [`5950cdb`](https://github.com/kube-core/kube-core/commit/5950cdbc4856b72f76b1d7a54ef11f3322e892ff)
- cli/docs: Fixed some wrong examples [`94e1d35`](https://github.com/kube-core/kube-core/commit/94e1d359d38090abb5cd5157d9d96f2642f9fd1b)
- cli/commands: Fixed inverted diff result on gitops:config:diff [`d068696`](https://github.com/kube-core/kube-core/commit/d068696cbdedac5a4b5e4eaf88c31c065d4890a8)

#### [v0.7.4](https://github.com/kube-core/kube-core/compare/v0.7.3...v0.7.4)

> 10 November 2022

- releases/tekton: Upgraded app-hooks EventListener [`d89e9a4`](https://github.com/kube-core/kube-core/commit/d89e9a418ff6fa835b27a3959a2fde60d6150e9a)
- release: v0.7.4 [`fa0bd58`](https://github.com/kube-core/kube-core/commit/fa0bd58aaacfab3353e6a7949551a18d56ff9523)

#### [v0.7.3](https://github.com/kube-core/kube-core/compare/v0.7.2...v0.7.3)

> 10 November 2022

- cli/commands: Moved logic to parse stdin from base command class to a dedicated one [`5d6f452`](https://github.com/kube-core/kube-core/commit/5d6f4526e0fcd1717e30e91a8ad41ac52f14f1e2)
- release: v0.7.3 [`73f535f`](https://github.com/kube-core/kube-core/commit/73f535f031f28919797d34cd2edefee68f5c2228)

#### [v0.7.2](https://github.com/kube-core/kube-core/compare/v0.7.1...v0.7.2)

> 10 November 2022

- core/releases: Reworked oauth2-proxy to permit multiple deployment as a service [`c079598`](https://github.com/kube-core/kube-core/commit/c079598b2baac639d1dd578fc3ad906f169520f8)
- releases: Added trivy [`1650b18`](https://github.com/kube-core/kube-core/commit/1650b18c269cb8716dcf8fc97345a0a07e95e09f)
- cli/commands: Removed some outdated files [`3c99611`](https://github.com/kube-core/kube-core/commit/3c99611cd44268405eee835a8596e22e800e335a)
- releases: Rebuilt all releases [`660863a`](https://github.com/kube-core/kube-core/commit/660863a526efe3f2135fe6260c9085ac11f84b44)
- releases/tekton-catalog: Adds garden deploy projects pipeline [`d074952`](https://github.com/kube-core/kube-core/commit/d07495201df3b7ad4bc361161173c362ca0abcda)
- core/templates: Added option to inject namespaced oauth2-proxy on ingress [`25718fe`](https://github.com/kube-core/kube-core/commit/25718feb73411a84501298ed8e6b3d0b6ea027c4)
- cli/commands: Added absorb command [`d05de7a`](https://github.com/kube-core/kube-core/commit/d05de7a2ff069c16a4704cdaa1b6ec4d70661384)
- releases/tekton-catalog: Adds new pipeline to deploy keycloak themes [`d4194dc`](https://github.com/kube-core/kube-core/commit/d4194dcd632d59ba111c0e4e029d07bd001631bf)
- release: v0.7.2 [`ee159b9`](https://github.com/kube-core/kube-core/commit/ee159b996c7fb5afb7f2f24a06772b2ba62385ff)
- cli/lib: Added some functions in utils to wrap kubectl [`460d8b3`](https://github.com/kube-core/kube-core/commit/460d8b329407c5fb10cbb656e6c918d4a8f3f8ba)
- cli/commands: Added stdin piping capabilities for all commands [`3676a88`](https://github.com/kube-core/kube-core/commit/3676a881fe2cd7281e809bc74f1f4f4a8b3fcb9b)
- core/releases: Enabled storage as k8s crd for dex [`2450b6f`](https://github.com/kube-core/kube-core/commit/2450b6f1868966da638dae24ff947a5c159768cf)
- releases/tekton-catalog: Added configuration keys for trivy [`1e89544`](https://github.com/kube-core/kube-core/commit/1e89544f3e4931148a6021ac7b178a4eb6f35865)
- core/values: Enabled certificate owner ref by default for cert-manager [`e963e24`](https://github.com/kube-core/kube-core/commit/e963e2449f97fb20cd5e26816228f08b148c03cb)
- releases/container-registry-operator: Updated deployment [`3bc0bcf`](https://github.com/kube-core/kube-core/commit/3bc0bcff92a55ad5d826c2933822c143c4bd2717)

#### [v0.7.1](https://github.com/kube-core/kube-core/compare/v0.7.0...v0.7.1)

> 7 November 2022

- cli/commads: Added some generation capabilities for values and local folders [`361d320`](https://github.com/kube-core/kube-core/commit/361d320a83294711be6f740adbc7d257285f4469)
- core/templates: Added checks to only generate namespaces from enabled core releases [`f766ea8`](https://github.com/kube-core/kube-core/commit/f766ea8cbb6fd7ce229516fc4b4ce000a46331cb)
- cli/docs: Updated docs [`bedaa9c`](https://github.com/kube-core/kube-core/commit/bedaa9c13a906f324ab7845c92f591b237bddcb4)
- release: v0.7.1 [`55374e6`](https://github.com/kube-core/kube-core/commit/55374e69aaea07156125886b7f07c2123b4f5326)
- cli/commands: Fixed gitops:config:diff checks on filtered data [`ed281eb`](https://github.com/kube-core/kube-core/commit/ed281ebb9cf9aff989d62946c9c94b6ec06e26ba)
- core/layers: Changed default config of ingress-access-operator [`761da4a`](https://github.com/kube-core/kube-core/commit/761da4aa431eb284176564d9a57d0ea8c2208163)

#### [v0.7.0](https://github.com/kube-core/kube-core/compare/v0.6.8...v0.7.0)

> 7 November 2022

- cli/commands: Introduced formatting [`c53aad8`](https://github.com/kube-core/kube-core/commit/c53aad820d52a5913b76517980432825b5d99ba4)
- cli/docs: Updated docs generation [`3acd3c6`](https://github.com/kube-core/kube-core/commit/3acd3c68700d79d84f9a7a2cc520e140d0a2667e)
- core/layers: Reworked all layers [`08ce5c9`](https://github.com/kube-core/kube-core/commit/08ce5c95fb37197b872aa81e37e4c34823be1d05)
- cli/package: Added some libs [`499fe7a`](https://github.com/kube-core/kube-core/commit/499fe7a400d9df8f5fe75d888f9c22fa49482d48)
- cli/commands: Reworked generate:helmfiles [`411e082`](https://github.com/kube-core/kube-core/commit/411e08213b074725b23e2e38f53aeadd04f24775)
- core/templates: Reworked templates [`be3aba0`](https://github.com/kube-core/kube-core/commit/be3aba09c1edf93ff454b6e665a84996de63f604)
- core/templates: Added templates for generate command [`63bebbc`](https://github.com/kube-core/kube-core/commit/63bebbc3da4b4ab070dfb9c23a3804711a833d16)
- core/templates: Added templates lib in core [`c6dd929`](https://github.com/kube-core/kube-core/commit/c6dd929b8c61d95c124dce801dad0539c009689d)
- cli/commands: Added commands: gitops config find|read|search [`b70dbfe`](https://github.com/kube-core/kube-core/commit/b70dbfeb96fde4d5c7d7521c03521f91693baa56)
- cli: Preparing release [`7c836ae`](https://github.com/kube-core/kube-core/commit/7c836aeb8e1316c1575baea659b74cb081230fb8)
- cli/commands: Removed some unused files [`6d218e6`](https://github.com/kube-core/kube-core/commit/6d218e6ea9fef9ac111aa5dc6e928b58322e66ea)
- cli/commands: Added experimental hot-reload command [`c99a95a`](https://github.com/kube-core/kube-core/commit/c99a95a9830795578fdfff5e76fede388d260a0f)
- cli/utils: Added some functions to utils [`686b735`](https://github.com/kube-core/kube-core/commit/686b7354e98b6fe20ddfbb45e5fef15b9dd03ca0)
- cli/commands: Added kube-core gitops config diff [`42b3b71`](https://github.com/kube-core/kube-core/commit/42b3b71f891fc7c7d7e83104c7b0459e9bf0042a)
- cli/scripts: Removed gitops/process.sh [`f7d3206`](https://github.com/kube-core/kube-core/commit/f7d32068fc5b803dd3f4cf1b7e4e2702564ad532)
- cli/commands: Updated config search to use index if available [`188a0e4`](https://github.com/kube-core/kube-core/commit/188a0e43bfad0258387232ed4c567eda1f048cb6)
- cli/scripts: Removed slicing and added code from removed gitops/process.sh in cluster/process.sh [`e6886f5`](https://github.com/kube-core/kube-core/commit/e6886f53d987d5a34c4f1bfcfc6360c93a503476)
- cli/scripts: Reworked build workflow to start by local config first and then proceed with helmfile templating [`fd89cf6`](https://github.com/kube-core/kube-core/commit/fd89cf69d729ec066555ed6ec8b9688dd466637e)
- cli/commands: Added kube-core gitops config index [`e346a1f`](https://github.com/kube-core/kube-core/commit/e346a1f05c4dbbc771f15f90c3d71a94ddeac0b5)
- cli/commands: Updated some docs [`98308f2`](https://github.com/kube-core/kube-core/commit/98308f2c8fac523af8653527b8f404bfe5b95a73)
- cli/commands: Added command generate helmfiles [`cc3e9f7`](https://github.com/kube-core/kube-core/commit/cc3e9f77a887c292a68656e28893e0819f31aa05)
- cli/commands: Updated generate values to allow merge from core over local [`7257809`](https://github.com/kube-core/kube-core/commit/7257809cd7278bc23b02a65001ec1732e575f827)
- release: v0.7.0 [`48c8ede`](https://github.com/kube-core/kube-core/commit/48c8ede3680318e2d718a611453c7dc1c1cc7708)
- cli/base: Migrated some common logic in base command class [`ff63f05`](https://github.com/kube-core/kube-core/commit/ff63f05c17ea39e055712ba297b1a45f7ecfce17)
- cli/scripts: Moved slicing to cluster/build.sh [`87c1042`](https://github.com/kube-core/kube-core/commit/87c1042f06320b49788f531f63f1739d700f2444)
- cli/commands: Added properties to get current cluster resources [`d37dd2f`](https://github.com/kube-core/kube-core/commit/d37dd2f63478edbb50be056889a224a84b98bece)
- core/releases: Added startupProbe to secret-generator release [`b067c08`](https://github.com/kube-core/kube-core/commit/b067c085f776e9e52e1519ad533d7b3b721db5f8)
- cli/scripts: Added original secret metadata on sealed version [`e9bd8e5`](https://github.com/kube-core/kube-core/commit/e9bd8e57b923ed7ffa812b3714685d62ab5772f8)
- cli/commands: Added comments and logs on generate values [`8adca4d`](https://github.com/kube-core/kube-core/commit/8adca4d83ebacbecbff2940e10bfa235062707e7)
- cli/lib: Replaced js-yaml by yaml [`bec9983`](https://github.com/kube-core/kube-core/commit/bec998306b9892eb3b44ff4e4f104f631dd4686c)
- core/templates: Added clusterRepositories support [`6b5e25a`](https://github.com/kube-core/kube-core/commit/6b5e25ab40158ab339c77664708607df54cf19e1)
- cli/commands: Removed color output on gitops config read as it breaks post-processing [`1053068`](https://github.com/kube-core/kube-core/commit/1053068ee181b8792fbd4067002b324aadb144dc)
- cli/libs: Added loadash [`61566cb`](https://github.com/kube-core/kube-core/commit/61566cb194d4a4b5f927581a20fe8684b1628c4c)
- core/templates: Fixed helmfileName value for lib templates [`050b289`](https://github.com/kube-core/kube-core/commit/050b289e242873389eba22f57a5f062ff7cd68d4)
- cli/scripts: Fixed kube-core build all --filter [`88a38fd`](https://github.com/kube-core/kube-core/commit/88a38fd35cf96ff135d8d5dcb078d7d03212ef4f)
- docker: Added gron v0.7.1 [`cedb4e0`](https://github.com/kube-core/kube-core/commit/cedb4e05a4dabef7fc860e49d4a43ddcac2597ad)
- releases/n9-api: Removed kubeVersion constraint [`2f1cde0`](https://github.com/kube-core/kube-core/commit/2f1cde0645a9270487b9c7a5c565dfffcf6ac70d)
- cli/scripts: Added toggle in cluster-config to  autoseal secrets [`c074391`](https://github.com/kube-core/kube-core/commit/c0743919be7d9309cd7b6499458be00d6d87043b)

#### [v0.6.8](https://github.com/kube-core/kube-core/compare/v0.6.7...v0.6.8)

> 21 October 2022

- release: v0.6.8 [`5a5a722`](https://github.com/kube-core/kube-core/commit/5a5a7225134a35135c8dca49c3a066b92bbdd7f3)
- core/templates: Added chartVersion support in release template [`db58c5b`](https://github.com/kube-core/kube-core/commit/db58c5b4ae4249a31ead6c94ef0775fed117feb1)

#### [v0.6.7](https://github.com/kube-core/kube-core/compare/v0.6.6...v0.6.7)

> 21 October 2022

- core/envs: Added forceVisitorGroups and forceNamespaceVisitorGroup options [`0212b2d`](https://github.com/kube-core/kube-core/commit/0212b2deb08094bf5fa42d9d793d5b1ef418dffa)
- release: v0.6.7 [`40bfe03`](https://github.com/kube-core/kube-core/commit/40bfe038e7f1b3792d445413365f1f4167c3a0e8)

#### [v0.6.6](https://github.com/kube-core/kube-core/compare/v0.6.5...v0.6.6)

> 21 October 2022

- core/envs: Added forceNamespaceIngressClass option [`0589dbf`](https://github.com/kube-core/kube-core/commit/0589dbfcb59f60ae23f82345f0b4a9a87a596e87)
- core/values: Updated n9-api values template [`1814c16`](https://github.com/kube-core/kube-core/commit/1814c1612eb5fe5191f2ea147a748ae420376499)
- release: v0.6.6 [`a914928`](https://github.com/kube-core/kube-core/commit/a9149285c90868dd79871e3a093a61b7b4bec332)

#### [v0.6.5](https://github.com/kube-core/kube-core/compare/v0.6.4...v0.6.5)

> 20 October 2022

- core/templates: Fixed missing if in some templates [`4d2b5fb`](https://github.com/kube-core/kube-core/commit/4d2b5fb5e22ae6b7fbb46223ab1e465b4593e98f)
- release: v0.6.5 [`1fd3654`](https://github.com/kube-core/kube-core/commit/1fd36543b1650528801a6c4780910ab369f5921e)

#### [v0.6.4](https://github.com/kube-core/kube-core/compare/v0.6.3...v0.6.4)

> 20 October 2022

- release: v0.6.4 [`8b887a8`](https://github.com/kube-core/kube-core/commit/8b887a8bcba2fa6723f7e183691ee1a399f51b95)
- core/templates: Fixed missing if in node-affinity template [`008fca2`](https://github.com/kube-core/kube-core/commit/008fca2d4724e1112b0700b445a9b3a3285c382b)

#### [v0.6.3](https://github.com/kube-core/kube-core/compare/v0.6.2...v0.6.3)

> 20 October 2022

- core/templates: Added forceNamespaceNodeSelector and forceNamespaceNodeAffinity options for all releases [`2258f1a`](https://github.com/kube-core/kube-core/commit/2258f1a7908cdf2fb2c152115ee7f38c8e205bf4)
- cli/dev: Added test kubectl apply on file events [`d662c14`](https://github.com/kube-core/kube-core/commit/d662c148de44928d9cdf7a0333468106e9f10278)
- release: v0.6.3 [`284eae6`](https://github.com/kube-core/kube-core/commit/284eae61b741755b30bde087f43602739772dfde)
- cli/package: Added upath for better cross-platform path capabilities [`79ed2c3`](https://github.com/kube-core/kube-core/commit/79ed2c350a935f63fc86e5218e70ab7fa020a2bc)

#### [v0.6.2](https://github.com/kube-core/kube-core/compare/v0.6.1...v0.6.2)

> 19 October 2022

- releases: Rebuilt all releases [`5475dac`](https://github.com/kube-core/kube-core/commit/5475dac556138612bfec87447ad30c3711b444d0)
- core/values: Simplified templating of nginx-ingress-controller values [`ba07d91`](https://github.com/kube-core/kube-core/commit/ba07d91efca1adc3e02b688fb412eb9c93caed2a)
- release: v0.6.2 [`0c5579b`](https://github.com/kube-core/kube-core/commit/0c5579b3ebb5ee32c68f3041c450299902b24693)
- core/envs: Added some label injections [`208ce5b`](https://github.com/kube-core/kube-core/commit/208ce5b35e26d9b6c23d398b1fb4e44f9cbf7cb4)
- cli/scripts: Fixed wrong path for auto-generated releases input folders [`7f76d0f`](https://github.com/kube-core/kube-core/commit/7f76d0f107aa1b21897415311349a4b62e24d501)
- core/templates: Fixed namespaces generation [`c9da6b5`](https://github.com/kube-core/kube-core/commit/c9da6b5155baf2e9e58c64c4b7b670ecf2aa4139)
- cli/scripts: Changed slicing template to use release.kube-core.io/namespace instead of .metadata.namespace [`a06cc43`](https://github.com/kube-core/kube-core/commit/a06cc4349b3cd22ff793f1ac37b7a2fb5b7f89bd)

#### [v0.6.1](https://github.com/kube-core/kube-core/compare/v0.6.0...v0.6.1)

> 19 October 2022

- core/releases: Added the possibility to manage namespaces as releases [`b1ba3b9`](https://github.com/kube-core/kube-core/commit/b1ba3b9855414e7f0ae8d238c9b6e0d5614e775a)
- cli/scripts: Complete rework of build logic [`c01c70f`](https://github.com/kube-core/kube-core/commit/c01c70f4ceddbed6c5f37e154d1059ad2901bf57)
- core/templates: Standardized and improved a few templates [`8f5ca98`](https://github.com/kube-core/kube-core/commit/8f5ca98f0bd0309ae23771a74bcbefa9ce00cc69)
- core/releases: Added gitops.enabled on releases to generate a flux Kustomization [`850cd59`](https://github.com/kube-core/kube-core/commit/850cd59c02cd10357468ed293ea3ed98c4907e39)
- release: v0.6.1 [`53d702c`](https://github.com/kube-core/kube-core/commit/53d702c553c591e96784dafd94135e05430738bc)
- cli/scripts: Changed test config files path in default-cluster-config.yaml [`ece1893`](https://github.com/kube-core/kube-core/commit/ece1893ca71254a63c8b30c9f3b734a30a5b863a)

#### [v0.6.0](https://github.com/kube-core/kube-core/compare/v0.5.7...v0.6.0)

> 16 October 2022

- core/templates: Added forceNamespace, templatedValues & Various fixes/improvements in core templates [`3957f14`](https://github.com/kube-core/kube-core/commit/3957f14020e41f55895e85c2c949f59c0b6015b4)
- cli/scripts: Reworked build to use a single helmfile template process instead of one for each release [`01c3f77`](https://github.com/kube-core/kube-core/commit/01c3f773721343f912a8a9b8a38823ebeb04ec96)
- core/helmfiles: Added cluster helmfile and clusterReleases [`2553995`](https://github.com/kube-core/kube-core/commit/2553995e8a71de34e944daed626a08d0b962336c)
- release: v0.6.0 [`b5fe2fa`](https://github.com/kube-core/kube-core/commit/b5fe2fa8b279ca68eb2aeffc6d4bdcbd2f4eb758)
- cli/scripts: Fixed namespace generation to work with the new templating workflow [`c2de423`](https://github.com/kube-core/kube-core/commit/c2de42372ed20f1474aff3ca4cf8b43860ee9aa7)
- cli/scripts: Improved detection of secrets to seal/restore [`a0e64dc`](https://github.com/kube-core/kube-core/commit/a0e64dc5ec8e6755b360385c03b09dedf4537a4d)
- cli/scripts: Moved namespace generation to the end, just before post-process [`054d6b2`](https://github.com/kube-core/kube-core/commit/054d6b25e8445608c55cd6934ef41bfc0fac7d80)
- cli/scripts: Reduced verbosity of build while looping over helmfiles [`ccfb3af`](https://github.com/kube-core/kube-core/commit/ccfb3af071a0b5ff8ec20b288e7c59868680e900)

#### [v0.5.7](https://github.com/kube-core/kube-core/compare/v0.5.6...v0.5.7)

> 14 October 2022

- release: v0.5.7 [`ceaa0c2`](https://github.com/kube-core/kube-core/commit/ceaa0c23ed3dea657bb538f83f9c556bb8c47ee4)
- docker: Upgraded helmfile to v0.147.0 [`5ff4989`](https://github.com/kube-core/kube-core/commit/5ff49899369187315b3793a7e63bc70a3bb05678)

#### [v0.5.6](https://github.com/kube-core/kube-core/compare/v0.5.5...v0.5.6)

> 14 October 2022

- release: v0.5.6 [`4179943`](https://github.com/kube-core/kube-core/commit/41799431d9487873def2bf910ae9867a94da852a)
- cli/scripts: Updated helmfile-template.sh logic to improve performance when looping over all helmfiles and releases [`022b01e`](https://github.com/kube-core/kube-core/commit/022b01e81eb609c82f385ccdb1739a63ff89e118)
- core/templates: Removed release-helm-metadata template [`a2758e0`](https://github.com/kube-core/kube-core/commit/a2758e0436a73c549b48a0cff272f04581f57a29)
- core/templates: Merged helm labels/annotation patches with existing ones to improve performance [`edc6896`](https://github.com/kube-core/kube-core/commit/edc6896aa6d8416cd381801a4c4a43f250528d69)
- core/envs: Fixed duplicate keys in some layers [`9a72b08`](https://github.com/kube-core/kube-core/commit/9a72b08be1b72b20008b5a122c1e889415016f65)

#### [v0.5.5](https://github.com/kube-core/kube-core/compare/v0.5.4...v0.5.5)

> 14 October 2022

- core/releases: Added dex & rework oauth2-proxy [`4c64a2a`](https://github.com/kube-core/kube-core/commit/4c64a2a09b443d848d7d82035d317c99ba077bae)
- release: v0.5.5 [`74cae92`](https://github.com/kube-core/kube-core/commit/74cae92194aee43a59dcf25a102cca7c8d379d79)
- core/envs: Added new options to enable Oauth2 on ingress & to disable ingress access operator [`e28b9e3`](https://github.com/kube-core/kube-core/commit/e28b9e38dccc07edc7a5e316e0a47689d152ab34)
- core/envs: Added possibility to generate dynamically secrets for each releases [`d435c5b`](https://github.com/kube-core/kube-core/commit/d435c5b37c54c49b62b2f6a21edbe8b6697a6e3d)
- core/values: Homogenized values format to set ingressClass [`c68f1b7`](https://github.com/kube-core/kube-core/commit/c68f1b7c87b6866f86fa8c2de2f08bfff8d76d5b)
- core/envs: Force quote on metadata values in release secrets [`834c964`](https://github.com/kube-core/kube-core/commit/834c9646eaa449fea7ef8cb7df32e0dd87eb8fb1)

#### [v0.5.4](https://github.com/kube-core/kube-core/compare/v0.5.3...v0.5.4)

> 13 October 2022

- releases/flux-repository: Updated values templates and release [`a06daea`](https://github.com/kube-core/kube-core/commit/a06daea2b9c47dad8051c49105c30bc7e3423973)
- releases: Added flux-repository [`6d174f1`](https://github.com/kube-core/kube-core/commit/6d174f1af95c5254355d6155bfaec940c45492c2)
- releases/crossplane-buckets: Updated version to v0.3.1 [`a4ca494`](https://github.com/kube-core/kube-core/commit/a4ca4944ad90c77abf9098825d1f5fe5588cda2f)
- releases/kyverno-policies: Set failurePolicy to Ignore by default & Rebuilt chart [`02bb7e0`](https://github.com/kube-core/kube-core/commit/02bb7e0985b54c448bc51dc736b6d2efb773960c)
- core/releases: Cleaned up releases definitions [`5d292d5`](https://github.com/kube-core/kube-core/commit/5d292d519ae32f497ea0f82868e46658544bc677)
- core/envs: Added core.globalHelmMetadataEnabled to force rendering Helm labels/annotations on manifests [`1869165`](https://github.com/kube-core/kube-core/commit/1869165d8f54b118120ce5ef89893ccef7705fdc)
- release: v0.5.4 [`5a0325c`](https://github.com/kube-core/kube-core/commit/5a0325c84557b419f8a875eb7e8eb265a1e35546)
- core/envs: Added secret for flux-repository in release-secrets [`44743a4`](https://github.com/kube-core/kube-core/commit/44743a4da2b6e60ecff640ee1e103e3e027fecd3)
- core/values: Added condition to handle using raw as a service [`71852f4`](https://github.com/kube-core/kube-core/commit/71852f4e3d96eab8f01d1be315ed5f309237576f)
- cli/scripts: Activated ytt overlays by default, with toggle via cluster-config [`8229f50`](https://github.com/kube-core/kube-core/commit/8229f5000ffd340f2b8689c504b0342307cb60cb)
- core/templates: Improved kube-core chart and values layering over applications/services and added toggles [`2cd1fc0`](https://github.com/kube-core/kube-core/commit/2cd1fc0342f092695373b0b71b00299690a922c8)
- core/values: Improved n9-api default values template [`9400dcf`](https://github.com/kube-core/kube-core/commit/9400dcf20c187bf5b3a64c977b92912969d9a697)
- cli/scripts: Moved overlays at the end of kube-core build [`e360e05`](https://github.com/kube-core/kube-core/commit/e360e054ed133be9a81f87e51fbd4f759848d295)
- cli/scripts: Improved logging on gitops_overlay [`1407c0f`](https://github.com/kube-core/kube-core/commit/1407c0ffdc344b877a94d750ea51787e74b114a2)
- cli/scripts: Added some extra cleanup after building kube-core charts [`df5abd6`](https://github.com/kube-core/kube-core/commit/df5abd6a17753c80b92ae4c2ce985d1348e7a694)
- cli/scripts: Fixed overlays applied on actual config instead of staging area [`bb08a66`](https://github.com/kube-core/kube-core/commit/bb08a66bd1222646458a7d2d97fa0104b0e000dd)
- core/templates: Improved support of applications and services with injectClusterLoggingLabel [`7954ad8`](https://github.com/kube-core/kube-core/commit/7954ad8fcf78c77cc25b49c3ce1825b204373e97)

#### [v0.5.3](https://github.com/kube-core/kube-core/compare/v0.5.2...v0.5.3)

> 11 October 2022

- core/templates: Removed label injection on custom releases [`3a56333`](https://github.com/kube-core/kube-core/commit/3a5633340f6c5ed97c91f0693bcbcd3b569b0d47)
- release: v0.5.3 [`8ccc3c6`](https://github.com/kube-core/kube-core/commit/8ccc3c6b1b53d5ee32f87ff08318235093626e1a)

#### [v0.5.2](https://github.com/kube-core/kube-core/compare/v0.5.1...v0.5.2)

> 11 October 2022

- core/envs: Added integrations between Core, Applications and Services for mongodb-managed and rabbitmq-managed [`125e3a5`](https://github.com/kube-core/kube-core/commit/125e3a5bdb22b0694c4f504c26c9b4705f715fbc)
- cli/scripts: Reimplemented ytt Overlays [`25b9251`](https://github.com/kube-core/kube-core/commit/25b9251f4dba2c0df21e789e23437a2b224ca73f)
- release: v0.5.2 [`d9e497a`](https://github.com/kube-core/kube-core/commit/d9e497aaba759bf53161dfef761ed3636c3f8ac0)

#### [v0.5.1](https://github.com/kube-core/kube-core/compare/v0.5.0...v0.5.1)

> 7 October 2022

- core/templates: Added release-labels template to easily inject global labels in any relase [`15fbd77`](https://github.com/kube-core/kube-core/commit/15fbd770b5d5166fa116fecfdc4708e6e0b69e75)
- release: v0.5.1 [`7fa2fe9`](https://github.com/kube-core/kube-core/commit/7fa2fe95ba3afc04d689bb9248f3413869e3a321)

#### [v0.5.0](https://github.com/kube-core/kube-core/compare/v0.4.5...v0.5.0)

> 7 October 2022

- core/templates: Reworked templates to allow for environments, applications and services generation [`885f236`](https://github.com/kube-core/kube-core/commit/885f236595b589aec1d1a65276f22c130cef2440)
- releases: Added node-problem-detector [`123cbda`](https://github.com/kube-core/kube-core/commit/123cbda06add2057dbee0c4705ffa39f595015a0)
- core/envs: Reworked core values to allow for environments, applications and services generation [`64d7b0f`](https://github.com/kube-core/kube-core/commit/64d7b0fcc473b3ced26fe7acefd5d134180e018c)
- core/values: Reworked values templates to allow for environments, applications and services generation [`d354b8b`](https://github.com/kube-core/kube-core/commit/d354b8bcc5354f8d0529a51fefdcd0e0dbf0b4a0)
- releases/n9-api: Updated to v1.3.2 [`67d179b`](https://github.com/kube-core/kube-core/commit/67d179bced31c6dfe6dc647a015642df4386154f)
- core: Reworked core helmfiles to allow for environments, applications and services generation [`03d2812`](https://github.com/kube-core/kube-core/commit/03d281246b0d7ad451e39b9daac1842825f5b66b)
- release: v0.5.0 [`e693153`](https://github.com/kube-core/kube-core/commit/e6931531f61a0802aa6a8b69952b643300f344bb)
- cli/workspace: Updated open command documentation [`55e2399`](https://github.com/kube-core/kube-core/commit/55e239954fa9a098c1127626c8831597d0051aae)

#### [v0.4.5](https://github.com/kube-core/kube-core/compare/v0.4.4...v0.4.5)

> 4 October 2022

- cli: Added workspace:open command [`0a9ad75`](https://github.com/kube-core/kube-core/commit/0a9ad7581d57b48b8007962c8b3196cf666d380c)
- release: v0.4.5 [`3010a72`](https://github.com/kube-core/kube-core/commit/3010a728e6d1211ebe62d0a134478c1962bf3e59)

#### [v0.4.4](https://github.com/kube-core/kube-core/compare/v0.4.3...v0.4.4)

> 3 October 2022

- releases: Rebuilt all releases [`521714f`](https://github.com/kube-core/kube-core/commit/521714fc9fafa546fa1fd7b93bc21bc75a14b27f)
- releases/mongodb-operator: Removed local chart and migrated to official one [`2870bdd`](https://github.com/kube-core/kube-core/commit/2870bddfbc1ba598bd390e3ddc26dcd878f5f3c8)
- releases/cluster-policies: Disabeled fail safe mode by default & Updated some policies [`60e4457`](https://github.com/kube-core/kube-core/commit/60e4457be5cf572cdea15e0bd2ec257692012dc8)
- releases/rabbitmq-operator: Removed hooks and improved resource naming [`1815197`](https://github.com/kube-core/kube-core/commit/1815197d0c9f8fb325a957d68d9b4f5d398d1178)
- release: v0.4.4 [`bfee444`](https://github.com/kube-core/kube-core/commit/bfee44417e3ef07fee3e57f7761c2f516b82a3c8)
- releases/logging-stack: Changed fluentd minReplicaCount to 3 [`78fe75c`](https://github.com/kube-core/kube-core/commit/78fe75ceaf9da688c92586f8f68bd95a7b974d44)

#### [v0.4.3](https://github.com/kube-core/kube-core/compare/v0.4.2...v0.4.3)

> 30 September 2022

- releases/cluster-policies: Disabled all mutations by default [`45700df`](https://github.com/kube-core/kube-core/commit/45700dfe2015354ba3e605eec2d3fb0bc5bdf3fe)
- release: v0.4.3 [`4a853c1`](https://github.com/kube-core/kube-core/commit/4a853c1a221497f2a1ff60f84ea03d2bdf5bb3cb)

#### [v0.4.2](https://github.com/kube-core/kube-core/compare/v0.4.1...v0.4.2)

> 30 September 2022

- releases/cluster-policies: Reworked default configuration [`81c75aa`](https://github.com/kube-core/kube-core/commit/81c75aac6a69fb220b4db7cbb8c6c4d8df0481d7)
- release: v0.4.2 [`5d13be1`](https://github.com/kube-core/kube-core/commit/5d13be10442d6e10f5d0cf2c43011a1f71d2e378)
- core/releases: Removed ingress upgrade options for tekton [`7f04f1e`](https://github.com/kube-core/kube-core/commit/7f04f1e18426785c882930962f5782ea727bc8d5)

#### [v0.4.1](https://github.com/kube-core/kube-core/compare/v0.4.0...v0.4.1)

> 29 September 2022

- releases/tekton: Updated Ingress resources to v1 [`77484a4`](https://github.com/kube-core/kube-core/commit/77484a4ab5731f378addd436de5ac7eb9ce2d7e0)
- releases/cluster-policies: Fixed default values [`fe7045d`](https://github.com/kube-core/kube-core/commit/fe7045d53c58ecb9a821ef64fef00a08446cd3a0)
- release: v0.4.1 [`6098683`](https://github.com/kube-core/kube-core/commit/60986835f4afac19b40e575b4b9c11e6ec447e37)

#### [v0.4.0](https://github.com/kube-core/kube-core/compare/v0.3.27...v0.4.0)

> 29 September 2022

- releases: Rebuilt dist folder [`cee24b9`](https://github.com/kube-core/kube-core/commit/cee24b9be316989bd3fc4cfb98e141d349dfe8b4)
- releases/policies: Added kube-core base policies [`8708970`](https://github.com/kube-core/kube-core/commit/8708970de8f518c3caacc65c373a6cbfa1001dca)
- core/releases: Reworked layers and some defaults [`094d608`](https://github.com/kube-core/kube-core/commit/094d60869081e449537a016fa1f824a1e5aa208b)
- releases/kyverno-policies: Added kyverno-policies with default values [`7f16950`](https://github.com/kube-core/kube-core/commit/7f16950ee8d08fb16fb3d13fdf410831285e173c)
- releases/kube-cleanup-operator: Updated values and switched source from local chart to remote [`0bac3ad`](https://github.com/kube-core/kube-core/commit/0bac3ad7193566b109b95d5181c993a6d529e4dd)
- releases: Added cluster-rbac [`1455f13`](https://github.com/kube-core/kube-core/commit/1455f137f4f9bf82c58ec98e738e9269011dff88)
- cli/releases: Added script to generate a local release [`00852e5`](https://github.com/kube-core/kube-core/commit/00852e58bc02e9d804c86275299baf28f8180be3)
- releases/logging-stack: Reworked logging-stack Ingress [`23a065b`](https://github.com/kube-core/kube-core/commit/23a065b6b97148f19ffeb44086f7a1e166fb0728)
- release: v0.4.0 [`9e3ccbb`](https://github.com/kube-core/kube-core/commit/9e3ccbb30169b0990cecfc14b6ebc680588ff225)
- releases/kyverno: Switched to HA and increased resource limits for kyverno [`127fe7d`](https://github.com/kube-core/kube-core/commit/127fe7d51cd4e82b88b0d46e7a8728f75a709a82)
- releases/logging-stack: Updated app and events dashboard [`50c0f8c`](https://github.com/kube-core/kube-core/commit/50c0f8c64eebc0f0b1f50d1f585a9bae8df09f35)

#### [v0.3.27](https://github.com/kube-core/kube-core/compare/v0.3.26...v0.3.27)

> 23 September 2022

- releases: Added kyverno [`f24be2d`](https://github.com/kube-core/kube-core/commit/f24be2db9024a24ec77e71edcad9c85441445273)
- release: v0.3.27 [`1d4f519`](https://github.com/kube-core/kube-core/commit/1d4f519f2360021df1fc0350e85734fe8ff11eb3)

#### [v0.3.26](https://github.com/kube-core/kube-core/compare/v0.3.25...v0.3.26)

> 22 September 2022

- cli/scripts: Cleaned up some scripts and regenerated scripts-config with more docs [`96fc8dd`](https://github.com/kube-core/kube-core/commit/96fc8ddf18f446bc1f45a4f03e7a4637acb46cc6)
- release: v0.3.26 [`577bd97`](https://github.com/kube-core/kube-core/commit/577bd975b065cd250a2677013e6cc8f2cdb0f4ad)
- core/releases: Adds the possibility to inject labels for logging in core releases [`ca1cc5b`](https://github.com/kube-core/kube-core/commit/ca1cc5b122b87a4a1251ed2985bebbfeee5e8b69)
- releases/kps: Fixed wrong URL for mongodb_percona dashboard [`94d54f7`](https://github.com/kube-core/kube-core/commit/94d54f764979f6f4e05585b27e44d6e278d410ca)
- core/releases: Added logging on nginx-ingress releases by default [`c8d78ae`](https://github.com/kube-core/kube-core/commit/c8d78ae1457a94faf8d086aa5b8e8fb183a68ef0)
- releases/tekton: Sets default SA for triggers to tekton [`3816685`](https://github.com/kube-core/kube-core/commit/381668585efa3ef2773771067c0d02ff45364189)
- core/releases: Fixed typo on logging LabelTransformer [`0a37c9e`](https://github.com/kube-core/kube-core/commit/0a37c9e2a494c66d1c76a29ded7622a8c2b3aa31)
- cli/scripts: Fixed typo in cloud_gcp_setup_tekton_sf [`d630f44`](https://github.com/kube-core/kube-core/commit/d630f44dd344c4f88a7165c344598b72a4a62b9b)

#### [v0.3.25](https://github.com/kube-core/kube-core/compare/v0.3.24...v0.3.25)

> 20 September 2022

- releases/chaos: Removed litmus-chaos and introduced chaos-mesh [`99cf697`](https://github.com/kube-core/kube-core/commit/99cf69787c46758abf730c882977641bbf963097)
- releases: Updated releases/dist [`3924687`](https://github.com/kube-core/kube-core/commit/392468769f8ca3a16021ff27232202263e971975)
- releases/mongodb-atlas-operator: Added mongodb-atlas-operator release [`205a0fa`](https://github.com/kube-core/kube-core/commit/205a0fa8a468531f64a5ed55c45b3ce599018580)
- cli/generators: Adds terraform generator [`634be32`](https://github.com/kube-core/kube-core/commit/634be32e26a493cc5d30e427e695f35423bf5dcb)
- releases/logging: Improved logging-stack and cluster-logging default configuration, scaling and performance [`1ffe458`](https://github.com/kube-core/kube-core/commit/1ffe45864b66f2cd2fbe15e0a89acab99fa3e375)
- core/config: Reformatted some files [`9939020`](https://github.com/kube-core/kube-core/commit/9939020732a12312a5b9cedc2cf526e723de0cb0)
- releases/kps: Added some Grafana dashbords and reorganized some folders [`3f642c3`](https://github.com/kube-core/kube-core/commit/3f642c3caa169352d6cd58fc036be932e3441290)
- cli/generators: Fixes path in cli plopfile [`410cc42`](https://github.com/kube-core/kube-core/commit/410cc42057bc9faae9443bd8251a3fe7be30fe10)
- release: v0.3.25 [`b0e6d23`](https://github.com/kube-core/kube-core/commit/b0e6d234167ade3403429a3a45c94a6ceb46991c)
- releases/kps: Updated mongodb and external-dns dashboards [`8ba275f`](https://github.com/kube-core/kube-core/commit/8ba275fc0d3d501500a18682d750b09f61267b0c)

#### [v0.3.24](https://github.com/kube-core/kube-core/compare/v0.3.23...v0.3.24)

> 16 September 2022

- releases/logging-stack: Added Kibana dashboard auto-provisionning [`2090eff`](https://github.com/kube-core/kube-core/commit/2090eff48ebde084d3bf3f299d228496c455cb3f)
- releases/cluster-logging: Allows to inject extra shared filters for all flows [`f9bc6c0`](https://github.com/kube-core/kube-core/commit/f9bc6c085c50e9c4558f2b5b69cba486632e87a9)
- releases/cluster-logging: Added output integrations on tekton default flow [`3adc4cf`](https://github.com/kube-core/kube-core/commit/3adc4cff319f15b8a90d683ab16999aa2c3850a8)
- release: v0.3.24 [`c600301`](https://github.com/kube-core/kube-core/commit/c6003017d1d92b214de7df08a30c05cb5ec3f3f6)
- core/releases: Added kube-core logging labels on nginx-ingress-controller [`915ab7b`](https://github.com/kube-core/kube-core/commit/915ab7b73b898b855084a10409f7c6d308c712f9)
- releases/logging-stack: Changed min fluentd replicas to 1 by default [`4ac2fc1`](https://github.com/kube-core/kube-core/commit/4ac2fc186aaf4812a73580824564b35e31e1d9d5)

#### [v0.3.23](https://github.com/kube-core/kube-core/compare/v0.3.22...v0.3.23)

> 15 September 2022

- releases/kps: Adds multiple dashboards [`a093aef`](https://github.com/kube-core/kube-core/commit/a093aef821c904d9c6c75fcd82f01c829e768839)
- releases/logging-stack: Added possibility to control min/max fluentd replicas [`6e7912d`](https://github.com/kube-core/kube-core/commit/6e7912dd22764c68d1caf7a5db252286ac3dcd94)
- release: v0.3.23 [`c37ead5`](https://github.com/kube-core/kube-core/commit/c37ead5cd5f4938ac91d66bebae84c47a7049623)
- core/cluster: Removed some namespaces that were included in log streams by default [`cb2a849`](https://github.com/kube-core/kube-core/commit/cb2a849912b5c8cf5e78740b0ce9c364b2da30ae)

#### [v0.3.22](https://github.com/kube-core/kube-core/compare/v0.3.21...v0.3.22)

> 15 September 2022

- releases/cluster-logging: Changed default buffer parameters to have better AWS S3 support [`188785e`](https://github.com/kube-core/kube-core/commit/188785e3ddc1dc0dd237e29d859134cb0cc6ad67)
- release: v0.3.22 [`4b45f9e`](https://github.com/kube-core/kube-core/commit/4b45f9e971acb1e93683be8c5d0b1570a4c1e8cf)

#### [v0.3.21](https://github.com/kube-core/kube-core/compare/v0.3.20...v0.3.21)

> 15 September 2022

- releases/cluster-logging: Fixed some unsafe conditions [`d610537`](https://github.com/kube-core/kube-core/commit/d61053700e1b142301e4f1312a0b5cc5729d76b4)
- release: v0.3.21 [`069f0d8`](https://github.com/kube-core/kube-core/commit/069f0d83b1da1d0f6a160a7d6df07f38d6f7d961)

#### [v0.3.20](https://github.com/kube-core/kube-core/compare/v0.3.19...v0.3.20)

> 15 September 2022

- release: v0.3.20 [`294eed3`](https://github.com/kube-core/kube-core/commit/294eed340eb6771af086c433b04e9a9c6880b465)
- releases/cluster-logging: Disabled events integration by default [`0123f9d`](https://github.com/kube-core/kube-core/commit/0123f9d913ae5afabd80937be157e598a7a3d869)

#### [v0.3.19](https://github.com/kube-core/kube-core/compare/v0.3.18...v0.3.19)

> 14 September 2022

- releases/eck-operator: Upgrades to v2.4.0 and adds logic for autoscaling [`f9a9e61`](https://github.com/kube-core/kube-core/commit/f9a9e6143566762dfea097be53214bdc7865a252)
- releases: Rebuilt releases [`6bc80c5`](https://github.com/kube-core/kube-core/commit/6bc80c5a417eca2a4ed11d12d9d991b6f6994175)
- releases/logging: Improved default values [`e0bfbe4`](https://github.com/kube-core/kube-core/commit/e0bfbe474c414c92e38f9e72d39191665dc30c71)
- core/packages: Fixed test-logging package [`6f4a7f5`](https://github.com/kube-core/kube-core/commit/6f4a7f5571e2d28f2f21a50733e1da5377565ee9)
- release: v0.3.19 [`9d52a62`](https://github.com/kube-core/kube-core/commit/9d52a62619b6d2426e771cc08e2e0a610a01d199)
- releases/logging-stack: Improved fluentbit default configuration [`b65a538`](https://github.com/kube-core/kube-core/commit/b65a5389d46d9434de16741b5c0e7ce849a3972c)

#### [v0.3.18](https://github.com/kube-core/kube-core/compare/v0.3.17...v0.3.18)

> 12 September 2022

- releases: Added test-logging package [`9b68b3b`](https://github.com/kube-core/kube-core/commit/9b68b3bfcb1d74037fb550635b66756aaa19c430)
- release: v0.3.18 [`b8013db`](https://github.com/kube-core/kube-core/commit/b8013dbf0f0ca4799d7943586fb82a1a28e91f18)

#### [v0.3.17](https://github.com/kube-core/kube-core/compare/v0.3.16...v0.3.17)

> 11 September 2022

- releases: Added prometheus-adapter & KEDA [`72c189d`](https://github.com/kube-core/kube-core/commit/72c189dba7398b58de8f3fa609fc7a7743c912a5)
- releases: Rebuilt releases [`7b2425e`](https://github.com/kube-core/kube-core/commit/7b2425ed375ef3763fd0d18ede29f75deb61ecb8)
- releases/cluster-logging: Added events integration that allows to parse and forward Kubernetes Events [`9af087b`](https://github.com/kube-core/kube-core/commit/9af087b50195ba3280d59da9fa05fafff9112d09)
- releases/cluster-logging: Improved buffer and flush configuration to have more resilient and scalable event streams [`98868d0`](https://github.com/kube-core/kube-core/commit/98868d04a1dc1e803057d7dbe1c27d4ee01c75a3)
- releases/logging-stack: Improved scalability, observability and resiliency of fluentd and fluentbit [`db49b9b`](https://github.com/kube-core/kube-core/commit/db49b9b04390c37f917bed2e368a9581abb6e340)
- core/config: Cleaned up some default values from core env as they are now in the underlying logging charts [`7c940b9`](https://github.com/kube-core/kube-core/commit/7c940b9ddc12f578d48d11c0daaddd738f25412e)
- release: v0.3.17 [`1cc3fc2`](https://github.com/kube-core/kube-core/commit/1cc3fc2bb0ee8a6b6beb70a34dd5dcaac8bcedfd)
- releases/logging-stack: Added EventTailer resource to the stack [`a582d64`](https://github.com/kube-core/kube-core/commit/a582d64a65c4787208d36629ee0597f2eb33695d)
- releases/system-jobs: Removes excessive logging in all system-jobs containers [`e392cfb`](https://github.com/kube-core/kube-core/commit/e392cfbcf47ddacef196b09874d2d56fa37ed0a5)
- cli/generators: Updated release template for add release command [`654bfdc`](https://github.com/kube-core/kube-core/commit/654bfdcea4062344c4af9116fdebb38699880282)

#### [v0.3.16](https://github.com/kube-core/kube-core/compare/v0.3.15...v0.3.16)

> 6 September 2022

- cli/scripts: Adds more checks in branch detection before applying in auto-pr [`d5b78d0`](https://github.com/kube-core/kube-core/commit/d5b78d0dd8929c56c82e778d218391d63ca277c8)
- release: v0.3.16 [`3c38e66`](https://github.com/kube-core/kube-core/commit/3c38e665d9391301393ec6a771200379921e2348)

#### [v0.3.15](https://github.com/kube-core/kube-core/compare/v0.3.14...v0.3.15)

> 6 September 2022

- releases/tekton: Fixes apply & auto-merge logic in core-tag and cluster-push [`be92e9c`](https://github.com/kube-core/kube-core/commit/be92e9c18023891fd8847ba74240ea25cd753eaa)
- release: v0.3.15 [`05729a1`](https://github.com/kube-core/kube-core/commit/05729a19b804b039b88c60144c751e95dfa4ab9b)

#### [v0.3.14](https://github.com/kube-core/kube-core/compare/v0.3.13...v0.3.14)

> 6 September 2022

- releases/tekton: Makes kube-core image in CI variable [`4547792`](https://github.com/kube-core/kube-core/commit/4547792de17170979e3871ec2ec40664d752f059)
- release: v0.3.14 [`a81758b`](https://github.com/kube-core/kube-core/commit/a81758bd1bddfae3ba45ea76714fef096539c706)

#### [v0.3.13](https://github.com/kube-core/kube-core/compare/v0.3.12...v0.3.13)

> 6 September 2022

- policies: Adds possibility to toggle kube-core policies and cluster policies [`2bc8d98`](https://github.com/kube-core/kube-core/commit/2bc8d98f01ba5831eb5a38d79c15a267b47b6aa2)
- release: v0.3.13 [`89e28b6`](https://github.com/kube-core/kube-core/commit/89e28b687b355c996090e9978009176e6e2c24cf)

#### [v0.3.12](https://github.com/kube-core/kube-core/compare/v0.3.11...v0.3.12)

> 5 September 2022

- gitops: Adds apply logic on gitops pipelines [`0877856`](https://github.com/kube-core/kube-core/commit/087785610b332446053fd120282e2ea71d83f36a)
- release: v0.3.12 [`00f4e85`](https://github.com/kube-core/kube-core/commit/00f4e85d0b8086ade6569e1055350ca32bb0cf5b)

#### [v0.3.11](https://github.com/kube-core/kube-core/compare/v0.3.10...v0.3.11)

> 5 September 2022

- release: v0.3.11 [`e032152`](https://github.com/kube-core/kube-core/commit/e032152e4785def8eb137148054d024adfaf4474)
- cli/scripts: Fixes detection of changes in auto-pr if all files are targeted instead of gitops config only [`227cb3b`](https://github.com/kube-core/kube-core/commit/227cb3b37d66bc02f7b9bb6b53d7960b8fb2965e)

#### [v0.3.10](https://github.com/kube-core/kube-core/compare/v0.3.9...v0.3.10)

> 5 September 2022

- cli/scripts: Forced secrets namespace generation to avoid CI builds deleting it [`a1e58cb`](https://github.com/kube-core/kube-core/commit/a1e58cb5b99a9b82f553d1a9d6f8d89adb232ab5)
- release: v0.3.10 [`106579e`](https://github.com/kube-core/kube-core/commit/106579ee75b1b549a5cc04e5fadda5aee096c44a)

#### [v0.3.9](https://github.com/kube-core/kube-core/compare/v0.3.8...v0.3.9)

> 5 September 2022

- releases: Removed base folder as it is not used anymore [`94b44ed`](https://github.com/kube-core/kube-core/commit/94b44ed66262e52049a221caede64b8a6f466642)
- cli/scripts: Updates flux install & Various fixes and improvements [`a8939bc`](https://github.com/kube-core/kube-core/commit/a8939bc0170bae1423e219e279fc353c68c9a078)
- releases: Adds flux-config to manage default flux resources [`eb5846d`](https://github.com/kube-core/kube-core/commit/eb5846dfb4987217f4f8f23c0ec0d6b8767db84e)
- core/templates: Moved namespace field on the kube-core release wrapper [`9d6bdd8`](https://github.com/kube-core/kube-core/commit/9d6bdd8c78cdc9ab7bd9d03591db194b11116024)
- releases/flux: Adds podmonitor config to monitor all flux controllers [`1cb7dc7`](https://github.com/kube-core/kube-core/commit/1cb7dc7f3bc08dc79b0af2680060f7b7469ee8ad)
- release: v0.3.9 [`660fc5f`](https://github.com/kube-core/kube-core/commit/660fc5f4b433aa86318af14d240f8988118f2b30)
- releases/schema: Updated schema to include new releases [`abba1c6`](https://github.com/kube-core/kube-core/commit/abba1c6bfd4b5d171c223723b3647bbee8557be4)

#### [v0.3.8](https://github.com/kube-core/kube-core/compare/v0.3.7...v0.3.8)

> 3 September 2022

- releases/tekton: Updates core-tag & PR workflow [`b52c328`](https://github.com/kube-core/kube-core/commit/b52c3285dedfe87442ea2053df956e0a31dceb3b)
- release: v0.3.8 [`a786f00`](https://github.com/kube-core/kube-core/commit/a786f00a6d271553f68b47b7a03e4bbd5e109606)

#### [v0.3.7](https://github.com/kube-core/kube-core/compare/v0.3.6...v0.3.7)

> 3 September 2022

- releases: Adds container-registry-config to allow easy use of GCR in the cluster [`182cb37`](https://github.com/kube-core/kube-core/commit/182cb37bd521cf6f3f7aab7453e8f4a9c7d25ade)
- releases/tekton: Fixes core-tag pipeline & Makes kube-core image variable [`b492d96`](https://github.com/kube-core/kube-core/commit/b492d967341091dc7b47ed59143d9fb2dc3575ed)
- release: v0.3.7 [`4121154`](https://github.com/kube-core/kube-core/commit/4121154e9a140455f0118f9de781cda26c371c96)

#### [v0.3.6](https://github.com/kube-core/kube-core/compare/v0.3.5...v0.3.6)

> 2 September 2022

- releases/tekton: Updates core-tag pipeline to use kube-core [`460b2e3`](https://github.com/kube-core/kube-core/commit/460b2e38779fea36acbc4b6ec8f61becf6777834)
- release: v0.3.6 [`0d7cdb4`](https://github.com/kube-core/kube-core/commit/0d7cdb4bcbe34fc0905808dba08ec48d19b328c9)

#### [v0.3.5](https://github.com/kube-core/kube-core/compare/v0.3.4...v0.3.5)

> 2 September 2022

- releases/tekton: Improves secret configuration [`b745bcc`](https://github.com/kube-core/kube-core/commit/b745bcc1897add4e981984b0b0e7f07ec55e57cc)
- cli/scripts: Adds tekton & SF setup script [`7be3816`](https://github.com/kube-core/kube-core/commit/7be3816404beff8e0120ea6552af475d452d9143)
- cli/scripts: Adds option to delete PR source branch by default on cluster auto PR [`450454a`](https://github.com/kube-core/kube-core/commit/450454ae2d02ee0c6e9dc385bca3b788352dbd66)
- cli/scripts: Adds variable for local keys path [`75fd5b5`](https://github.com/kube-core/kube-core/commit/75fd5b5d7991c3dff146c6273a2a3f5a744a33f6)
- release: v0.3.5 [`0f823e9`](https://github.com/kube-core/kube-core/commit/0f823e9e1054edc8d74a6e180bcd50f6587b3ad6)

#### [v0.3.4](https://github.com/kube-core/kube-core/compare/v0.3.3...v0.3.4)

> 1 September 2022

- releases/tekton: Changes default run timeout and makes it configurable [`43261b6`](https://github.com/kube-core/kube-core/commit/43261b6fe639d715e6f5c27f3187558cdd257153)
- release: v0.3.4 [`d902266`](https://github.com/kube-core/kube-core/commit/d90226601c8088df4b8df24e4db9aa93b37c82dd)

#### [v0.3.3](https://github.com/kube-core/kube-core/compare/v0.3.2...v0.3.3)

> 1 September 2022

- releases/tekton: Renamed and removed some resources [`23cf029`](https://github.com/kube-core/kube-core/commit/23cf029d2715131febfdc7c799ab085eb508b2e6)
- release: v0.3.3 [`3df8d5a`](https://github.com/kube-core/kube-core/commit/3df8d5a6623370b03408ecac179dfd4d933e7e21)

#### [v0.3.2](https://github.com/kube-core/kube-core/compare/v0.3.1...v0.3.2)

> 1 September 2022

- releases/tekton: Reintroduces core-tag pipeline [`b5110e4`](https://github.com/kube-core/kube-core/commit/b5110e48db0b3ebb31dc1af3a2aaa81288279dd6)
- releases/tekton: Improves resource name templating and brings more variables in hooks [`b67847e`](https://github.com/kube-core/kube-core/commit/b67847e75b53b3f4914bb2731129711ae7584a19)
- release: v0.3.2 [`2fac095`](https://github.com/kube-core/kube-core/commit/2fac0957119744065c2031462361d23ef6d98573)
- cli/scripts: Updated bump script to automatically patch cli version [`52a8349`](https://github.com/kube-core/kube-core/commit/52a8349cf3bdb7dd6661c91411dfd7a216da2489)
- releases/tekton: Fixes app-hooks git-webhooks-token reference missing [`7b395ed`](https://github.com/kube-core/kube-core/commit/7b395ed88b6ec5fbbc004935389a6427813561f0)

#### [v0.3.1](https://github.com/kube-core/kube-core/compare/v0.3.0...v0.3.1)

> 30 August 2022

- release: v0.3.1 [`142ad91`](https://github.com/kube-core/kube-core/commit/142ad91bfee476ca8ed56f9c038abc90a15328a8)
- cli: Fixes corePath in scripts [`b0b5791`](https://github.com/kube-core/kube-core/commit/b0b5791191b5554b481d2832c44320d4b1ece44d)
- scripts: Moved scripts in cli folder to package them together [`77d78bd`](https://github.com/kube-core/kube-core/commit/77d78bd9fddcf24ec61502a4e175a332ba34e3e8)
- repo: Fixes .gitignore ignoring some files that should not be ignored [`f6b6ab0`](https://github.com/kube-core/kube-core/commit/f6b6ab0d7e788bc5dcae1b3105925ace73052959)
- cli: Reintroduced .helmignore files in releases/dist [`3a24223`](https://github.com/kube-core/kube-core/commit/3a24223d3744eaba62d3bab01f1fb5c6277dd208)
- ci: Updated GitHub Actions Workflows [`9de80b9`](https://github.com/kube-core/kube-core/commit/9de80b9e871bedf076878207d812ca79097f7b6c)
- cli: Adds basic install instructions in README [`684b232`](https://github.com/kube-core/kube-core/commit/684b23204e80a260b39323cf4814fed4f9d01212)
- repo: Fixes scripts line endings for npm release packaging [`70a43f6`](https://github.com/kube-core/kube-core/commit/70a43f6b7b7045de1514bd68a2ffc469db63730f)
- cli: Bumps version to v0.1.6 [`ecf11e9`](https://github.com/kube-core/kube-core/commit/ecf11e9ee10ef564dde949691eeaaaa52823f843)
- release-it: Fixes changelog generation [`e89adf0`](https://github.com/kube-core/kube-core/commit/e89adf0cc69c1e195aaf0e6bbb04c66d653b5e28)
- cli: Adds proper chmod on scripts [`948b260`](https://github.com/kube-core/kube-core/commit/948b2609896126ebb96741c18ce4d4d1f1202aac)

#### [v0.3.0](https://github.com/kube-core/kube-core/compare/v0.2.1...v0.3.0)

> 30 August 2022

- release: v0.3.0 [`a89d9be`](https://github.com/kube-core/kube-core/commit/a89d9be59f973ba52a2611eedf11bee7cf4220de)

#### [v0.2.1](https://github.com/kube-core/kube-core/compare/v0.2.0...v0.2.1)

> 23 August 2022

- core: Added the possibility to deploy Patches with .release.patches [`49c80c3`](https://github.com/kube-core/kube-core/commit/49c80c3eba8c1f6f740f80b2cca92949b3afdf33)
- release: v0.2.1 [`a4e18dc`](https://github.com/kube-core/kube-core/commit/a4e18dc4f1edc37a5aab94dd26a4b0bfa8e8fe72)
- scripts: Fixes kube-core apply & template commands [`b51fe42`](https://github.com/kube-core/kube-core/commit/b51fe42d23c781613f591b259a3e2eec72647ff9)
- cli: Fixed .gitignore breaking dev cli [`21f82ef`](https://github.com/kube-core/kube-core/commit/21f82ef1f80929798213bc256c4187cd19456f15)

#### [v0.2.0](https://github.com/kube-core/kube-core/compare/v0.1.0...v0.2.0)

> 23 August 2022

- release: v0.2.0 [`421cc82`](https://github.com/kube-core/kube-core/commit/421cc825f06309e9ad6389ff77d829b9e6a3f899)

#### v0.1.0

> 23 August 2022

- release: v0.1.0 [`8862e2c`](https://github.com/kube-core/kube-core/commit/8862e2c81c6ee6f18756ba1a087be606cc189fc1)
- Initial commit [`bfc6c11`](https://github.com/kube-core/kube-core/commit/bfc6c11ea874ad383701688895fd57455fbe3050)
