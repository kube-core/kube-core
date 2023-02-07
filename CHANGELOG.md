### Changelog

All notable changes to this project will be documented in this file. Dates are displayed in UTC.

#### [v0.11.14](https://github.com/kube-core/kube-core/compare/v0.11.13...v0.11.14)

- releases: Rebuilt releases [`64740bc`](https://github.com/kube-core/kube-core/commit/64740bc6a0d9e9d62873366ce7fbca8200138618)
- releases/crds: Fixed namespaces in CRDs to default [`2e56c62`](https://github.com/kube-core/kube-core/commit/2e56c626a80a86b1237cae25eae55020e86a76cb)

#### [v0.11.13](https://github.com/kube-core/kube-core/compare/v0.11.12...v0.11.13)

> 7 February 2023

- core/templates: Added release integrations for scaling, monitoring, chaos, and slos [`270292c`](https://github.com/kube-core/kube-core/commit/270292c0aa238083ab0183cc9ea4a41e35bd97e5)
- releases: Removed oauth2-proxy from local releases [`45b6949`](https://github.com/kube-core/kube-core/commit/45b69491c3cd71f76c5eae0ac3e1c42e1206f69c)
- releases/app-extensions: Improved main template loop and reworked resources [`fdf029c`](https://github.com/kube-core/kube-core/commit/fdf029cca5a826187998e42e0ff211fa8d47b98e)
- releases: Added scaling & SRE resources to app-extensions [`0df84f2`](https://github.com/kube-core/kube-core/commit/0df84f2104e7adab17e34ec247eb22d272be4cf0)
- core/templates: Added more integrations with app-extensions [`ce46b06`](https://github.com/kube-core/kube-core/commit/ce46b06c4aa0db72ad78930635c1fc19b94fa4cf)
- release: v0.11.13 [`b7f9101`](https://github.com/kube-core/kube-core/commit/b7f9101e21083c97b2da16de133223be922b1747)

#### [v0.11.12](https://github.com/kube-core/kube-core/compare/v0.11.11...v0.11.12)

> 2 February 2023

- core/layers: Fixed kps secrets [`ec71a86`](https://github.com/kube-core/kube-core/commit/ec71a86aae9aec1ceb14846ea102b092f16bf4d6)
- release: v0.11.12 [`64b657f`](https://github.com/kube-core/kube-core/commit/64b657f991a93d78ba0751f14d4cee0654d1ace5)

#### [v0.11.11](https://github.com/kube-core/kube-core/compare/v0.11.10...v0.11.11)

> 1 February 2023

- release: v0.11.11 [`dc65ceb`](https://github.com/kube-core/kube-core/commit/dc65ceb391ef8b3bcb0da69dbc11e53c304b6be5)
- releases/tekton-catalog: Regenerated release files [`93daa01`](https://github.com/kube-core/kube-core/commit/93daa01a356bdc917f19507712759e2226db2f5f)

#### [v0.11.10](https://github.com/kube-core/kube-core/compare/v0.11.9...v0.11.10)

> 1 February 2023

- releases/tekton-catalog: Upgraded kube-core pipeline [`83d6d6c`](https://github.com/kube-core/kube-core/commit/83d6d6c4a6ae5dcf426b94e978cde1b1985d4cee)
- release: v0.11.10 [`e52af28`](https://github.com/kube-core/kube-core/commit/e52af28a4e74febaf086b403dcef3e28ecf34a6c)

#### [v0.11.9](https://github.com/kube-core/kube-core/compare/v0.11.8...v0.11.9)

> 1 February 2023

- releases: Fixed cluster-logging, tekton and tekton-logging integration [`eadffe5`](https://github.com/kube-core/kube-core/commit/eadffe5b6319e40adb300bcae621b6116898364d)
- releases/nginx-ingress-controller: Upgraded chart to v9.3.26 [`540bc30`](https://github.com/kube-core/kube-core/commit/540bc305adbff3eaa20e46f2c4612faf13b52e9f)
- releases/tekton: Fixed secrets not being injected on SAs [`1ec8743`](https://github.com/kube-core/kube-core/commit/1ec874381900ead72e5f4737f96450c7146322a9)
- release: v0.11.9 [`f8606c9`](https://github.com/kube-core/kube-core/commit/f8606c91e41f88a4535446c19b251e092f6e53b9)

#### [v0.11.8](https://github.com/kube-core/kube-core/compare/v0.11.7...v0.11.8)

> 31 January 2023

- release: v0.11.8 [`cebb918`](https://github.com/kube-core/kube-core/commit/cebb9180044ab1ffeb726eda74aa34ebcf9a6252)
- core/values: Updated secrets references for dex & oauth2-proxy [`4d3eada`](https://github.com/kube-core/kube-core/commit/4d3eada797587dfc40c68cbef99507133d6ae49f)

#### [v0.11.7](https://github.com/kube-core/kube-core/compare/v0.11.6...v0.11.7)

> 30 January 2023

- releases: Rebuilt releases [`e81540e`](https://github.com/kube-core/kube-core/commit/e81540e02ccf6373f567f6f2b9c9224a30615102)
- releases: Upgraded some tekton resources [`ba7c900`](https://github.com/kube-core/kube-core/commit/ba7c9006dd4ad111fd9116a70414ad6b83790447)
- core/values: Upgraded external-secrets template to use release metadata [`03aff13`](https://github.com/kube-core/kube-core/commit/03aff138a5a03a5d9bcaa5a0abf819e0814d5e29)
- core/templates: Reworked clusterReleases to use same template as other release types [`8e6516e`](https://github.com/kube-core/kube-core/commit/8e6516eedae1fe7b138e485686de5a28a498d14b)
- release: v0.11.7 [`c58234a`](https://github.com/kube-core/kube-core/commit/c58234aaec9e84d6e1d9407655099aadf1317289)
- core/values: Changed default goldilocks requests/limits [`41ce4f3`](https://github.com/kube-core/kube-core/commit/41ce4f3533ea5a95903b0e29e2855a5c8757e0a3)
- core/layers: Fixed kps external-secrets [`7bd7ab4`](https://github.com/kube-core/kube-core/commit/7bd7ab45a8e18e5c7e0208ca74724b964e5262ae)
- core/layers: Fixed dynamicSecrets config for dex & oauth2proxy [`26e122f`](https://github.com/kube-core/kube-core/commit/26e122f0e4a8c99e344613f470236a6a7645bcde)
- core/templates: Fixed release.hooks not working since options rework [`f981150`](https://github.com/kube-core/kube-core/commit/f9811507c4d8c896394aad6ba74daddb0b5be8d7)
- core/templates: Added upgradeIngressPortIsHttp option [`1ab9c46`](https://github.com/kube-core/kube-core/commit/1ab9c4627fc917084c7674163f5d1af598003b22)
- core/layers: Fixed chaos-mesh ingress version [`6e3cddf`](https://github.com/kube-core/kube-core/commit/6e3cddfe88f7a36eda08f08fb5f5fffecd2af620)

#### [v0.11.6](https://github.com/kube-core/kube-core/compare/v0.11.5...v0.11.6)

> 29 January 2023

- release: v0.11.6 [`f356da8`](https://github.com/kube-core/kube-core/commit/f356da87b8a16bda54db8f84d1f571c99bf543c1)
- core/releases: Homogenized variables used in cloud releases [`310b8ae`](https://github.com/kube-core/kube-core/commit/310b8ae1e1de5cc1847774785fb0bd83e0169a27)
- core/releases: Activated options by default to patch sloop ingress [`a7e10af`](https://github.com/kube-core/kube-core/commit/a7e10afa1add359ac5f2f9c7211cd5e19581d601)
- core/layers: Removed common defaultIngressAnnotations which is not useful to any release [`03758fb`](https://github.com/kube-core/kube-core/commit/03758fb1fb50059c51a3ef18d49a4fb682b78da4)
- core/layers: Added a default ingressclass for defaultService expose-annotations [`1c0ac21`](https://github.com/kube-core/kube-core/commit/1c0ac21da06c6839a55ca1815debca9d93123e47)

#### [v0.11.5](https://github.com/kube-core/kube-core/compare/v0.11.4...v0.11.5)

> 23 January 2023

- core/templates: Integrated cluster & tetkton logging with release-cloud [`7a5d584`](https://github.com/kube-core/kube-core/commit/7a5d5847b25579291dbeb01d92bd53b316b7afef)
- release: v0.11.5 [`f906f30`](https://github.com/kube-core/kube-core/commit/f906f306a339957e52872de2eba242148728bc49)
- core/values: Fixed postgresql resource naming issues [`a835efd`](https://github.com/kube-core/kube-core/commit/a835efd3ea9ad658eae0886f09035301c18cf189)
- core/releases: Added condition to recordset generated by cloud releases [`657b263`](https://github.com/kube-core/kube-core/commit/657b2638cee68e57fddaff08d3f449fac78a35f3)
- releases/goldilocks: Updated default options [`681fd34`](https://github.com/kube-core/kube-core/commit/681fd34510811df3b9b42df58be9a8b30d24bbcc)
- releases/nginx-ingress-controller: Added controllerClass [`0d3a341`](https://github.com/kube-core/kube-core/commit/0d3a34110ac860349439d978b8cb39f8f29da0c7)
- core/templates: Fixed release-cloud bad condition on backendBucket [`e6c3093`](https://github.com/kube-core/kube-core/commit/e6c30932ba05d4ad483116e93f6b7df7ad8149a1)

#### [v0.11.4](https://github.com/kube-core/kube-core/compare/v0.11.3...v0.11.4)

> 21 January 2023

- release: v0.11.4 [`b286298`](https://github.com/kube-core/kube-core/commit/b28629881ac370e6dc8b6a8e941a9b584639a1e5)
- core/values: Fixed serviceAccount adminReference for bucketPolicy in cloud releases [`9e10702`](https://github.com/kube-core/kube-core/commit/9e10702cec4db0df31263b05db72dfb54e6eaf4f)

#### [v0.11.3](https://github.com/kube-core/kube-core/compare/v0.11.2...v0.11.3)

> 21 January 2023

- core/templates: Reworked release-variables and optimized values merge on releases [`9ef01e8`](https://github.com/kube-core/kube-core/commit/9ef01e864a075f5ce5de9b9cfe4ab019ab67a2eb)
- core/templates: Moved naming metadata to release variables [`ec2ffdc`](https://github.com/kube-core/kube-core/commit/ec2ffdcf3633271c7cac359f489d3f5c0564ea75)
- core/values: Updated velero to use cloud naming [`b1207ae`](https://github.com/kube-core/kube-core/commit/b1207ae2899e0e3da33dad142c1611d89137f44f)
- core/templates: Reworked release template [`5ea8a13`](https://github.com/kube-core/kube-core/commit/5ea8a13b1d6c58e9b3815f27c3264bf4d9480c0f)
- release: v0.11.3 [`fa72fee`](https://github.com/kube-core/kube-core/commit/fa72fee57f0e09950edbd3fba28b891a2956ccaa)
- core/templates: Fixed transformers not being applied on local-secrets [`2d56b3e`](https://github.com/kube-core/kube-core/commit/2d56b3e44fed557d1e5286d6d1c05112457c9fbf)

#### [v0.11.2](https://github.com/kube-core/kube-core/compare/v0.11.1...v0.11.2)

> 20 January 2023

- core/layers: Changed all patches for applications and services options to false by default [`0e40825`](https://github.com/kube-core/kube-core/commit/0e40825fb5c459d5e59ef546ea66d530e68f22ec)
- release: v0.11.2 [`04aa351`](https://github.com/kube-core/kube-core/commit/04aa351b3ccb69230d2de5e8d0d149b582ecea9b)
- core/templates: Fixed merge behavior for default application and services options [`926af4c`](https://github.com/kube-core/kube-core/commit/926af4c6457d100942654bdd7b2db9b35dda9b74)
- core/templates: Added app & services options injection specific to an env [`53e725c`](https://github.com/kube-core/kube-core/commit/53e725c98c432ba113f289bf961a49cd70b9f721)
- core/templates: Disabled injectIngressHost/Tls,forceNamespaceIngressClass by default for applications & services [`87ccee3`](https://github.com/kube-core/kube-core/commit/87ccee3020403f528e7cfac1c1cb5bbf5d3a4f33)

#### [v0.11.1](https://github.com/kube-core/kube-core/compare/v0.11.0...v0.11.1)

> 19 January 2023

- release: v0.11.1 [`317cc60`](https://github.com/kube-core/kube-core/commit/317cc6000ffbeaebc37a4ed58bcd7df9c382045e)
- cli/scripts: Added helmfile.concurrency parameter to mitigate concurrent I/O issues [`be67be6`](https://github.com/kube-core/kube-core/commit/be67be6209d6be1099170c5179bc3a5b9d507131)

#### [v0.11.0](https://github.com/kube-core/kube-core/compare/v0.10.0...v0.11.0)

> 19 January 2023

- releases: Upgrades & Regeneration [`c8ea7e0`](https://github.com/kube-core/kube-core/commit/c8ea7e05dd276d68fd3adf71f01ab73fa91271d7)
- core/layers: Removed generate folder [`ef93fcd`](https://github.com/kube-core/kube-core/commit/ef93fcdf1005511ae6793bdcc14cd41705cb2a0f)
- releases: Added goldilocks [`bd8deb4`](https://github.com/kube-core/kube-core/commit/bd8deb496c4a0890811153e316a91dace6e5086a)
- releases: Reworked postgres & Added integrations with releases [`2ecc0ff`](https://github.com/kube-core/kube-core/commit/2ecc0ff3d405574b97feba6898f55c78b967a595)
- releases: Various linting fixes & Regeneration [`5b16249`](https://github.com/kube-core/kube-core/commit/5b162499877b3f8c6c3ed4d8fa0b14358d6e699b)
- releases: Removed some useless releases [`562a8a1`](https://github.com/kube-core/kube-core/commit/562a8a11aca11c39e760946fc47e4939ab422dfb)
- core: Reworked releases, applications & services [`511afcf`](https://github.com/kube-core/kube-core/commit/511afcf69eea75f4b4e4104cbe27d211a9f7d6a3)
- releases/tekton: Added logs persistance [`339eac9`](https://github.com/kube-core/kube-core/commit/339eac967a0d3f12745e312e34b964d0fc9d0768)
- releases: Added opencost [`5d6fc81`](https://github.com/kube-core/kube-core/commit/5d6fc8149a3179d3d6f941ce418ea7f7171c997e)
- cli/build: Replaced local build outputs with releases by default [`4fb73aa`](https://github.com/kube-core/kube-core/commit/4fb73aac661c7955874e8a4731d5c02711424226)
- core/layers: Migrated tekton values to config [`f760c75`](https://github.com/kube-core/kube-core/commit/f760c75ab5776679ca9259fe569e0de14885d2da)
- release: v0.11.0 [`b8e199e`](https://github.com/kube-core/kube-core/commit/b8e199e3e4b0e04ea1e6896bc480f45d3b99568b)
- core/values: Fixed tekton values template [`6169f7b`](https://github.com/kube-core/kube-core/commit/6169f7b99f93f4bcbcc35ac64e065c4416b43e78)
- core/values: Removed kps namespace for rabbitmq-operator service monitor [`8a5147c`](https://github.com/kube-core/kube-core/commit/8a5147ce89a657ca315aaae8de1efd5c246a10da)

#### [v0.10.0](https://github.com/kube-core/kube-core/compare/v0.9.3...v0.10.0)

> 12 January 2023

- core/templates: Removed releasesCustom feature completely [`c73d298`](https://github.com/kube-core/kube-core/commit/c73d2985daf6b600112cc2a29ee127e1e3fe1740)
- core/templates: Removed some unused template [`15378d8`](https://github.com/kube-core/kube-core/commit/15378d858d57c950e4f4a0a626417925aeb84a15)
- core/templates: Updated raw releases to include release-options template [`55cb1a2`](https://github.com/kube-core/kube-core/commit/55cb1a27f13de5a973c277e1b826728e67ce34c4)
- core/templates: Updated namespace releases to include release-options template [`c8c523b`](https://github.com/kube-core/kube-core/commit/c8c523bc54357f071f2cc6c3ea8097aa154e01b9)
- release: v0.10.0 [`7d3aba6`](https://github.com/kube-core/kube-core/commit/7d3aba6e599b1cd3f9a0589e54ed7e1f4b121691)

#### [v0.9.3](https://github.com/kube-core/kube-core/compare/v0.9.2...v0.9.3)

> 10 January 2023

- release: v0.9.3 [`b50a72e`](https://github.com/kube-core/kube-core/commit/b50a72ec92ab072ef1a5e676449b489a7e68a7d9)
- core/templates: Fixed broken condition & Added extraValues for applications [`055c9af`](https://github.com/kube-core/kube-core/commit/055c9af69fc14a83ce91151834fa2f9250de9913)

#### [v0.9.2](https://github.com/kube-core/kube-core/compare/v0.9.1...v0.9.2)

> 7 January 2023

- releases: Added app-extensions chart [`289b639`](https://github.com/kube-core/kube-core/commit/289b639618ac2ed1461509bb8273988aa2f15de1)
- core/templates: Reworked extensions and options [`574c7a5`](https://github.com/kube-core/kube-core/commit/574c7a5a23c76ef42d35ccde2ff54cb9225787d2)
- core/values: Improved app integration with extensions and services [`a7802a1`](https://github.com/kube-core/kube-core/commit/a7802a10b1f8f7af99b2e7c1693870b72dc1f27a)
- core/templates: Added rabbitmq extension [`522d045`](https://github.com/kube-core/kube-core/commit/522d0458d0228ea7aa5eb2c563c5980f0485aa8f)
- core/layers: Updated some default release options [`ffb6e75`](https://github.com/kube-core/kube-core/commit/ffb6e7522228cc4660ff21c54fd4a5deba9233c6)
- core/releases: Added possibility to specify serviceaccountkeyname for cloud releases [`7694ccb`](https://github.com/kube-core/kube-core/commit/7694ccb0a86cee5565dcd5ad4183ba71283022a7)
- core/templates: Added env options injection on applications and services [`33527a0`](https://github.com/kube-core/kube-core/commit/33527a03aa97d9901efc4b9591dafe2f2d676001)
- release: v0.9.2 [`21b119e`](https://github.com/kube-core/kube-core/commit/21b119eac9c5dbb4d7554e55485a83a9a260eabb)

#### [v0.9.1](https://github.com/kube-core/kube-core/compare/v0.9.0...v0.9.1)

> 2 January 2023

- releases: Upgraded nginx-ingress-controller to v9.3.24 [`61d43e5`](https://github.com/kube-core/kube-core/commit/61d43e52eb65787b23e19d3b065b57d3ec03e570)
- release: v0.9.1 [`d9e3ec8`](https://github.com/kube-core/kube-core/commit/d9e3ec84ab48bac7fb56c78fb1fa972c3fe4968c)
- core/values: Fixed rabbitmq conditions in n9-api templates [`ea94965`](https://github.com/kube-core/kube-core/commit/ea949658ff98c3d60fd922215dc6b39256dd3964)
- cli: Fixed version bump in scripts:exec dev_utils_bump [`c1e327f`](https://github.com/kube-core/kube-core/commit/c1e327fc80d9a2c34e49368a2a06fba49e23a656)
- core/values: Added fullnameOverride including namespace for NIC deployments [`031170a`](https://github.com/kube-core/kube-core/commit/031170a470f9207bdef003b69dd2b4dfa5297a07)

#### [v0.9.0](https://github.com/kube-core/kube-core/compare/v0.8.0...v0.9.0)

> 2 January 2023

- release: v0.9.0 [`d7b47c1`](https://github.com/kube-core/kube-core/commit/d7b47c1f750c2fdf4a123e138ec8cd47911c26e5)
- core/layers: Refactored core layers [`961c27e`](https://github.com/kube-core/kube-core/commit/961c27ee1d7da6514e9d2ab502202624b39f3c48)
- core/releases: Updated crossplane-cloud local chart [`65e05dc`](https://github.com/kube-core/kube-core/commit/65e05dc9472c5348ce6f3794793fb192674bde66)
- core/templates: Added some extensions & Improved n9-api release extensions integration [`430cdcd`](https://github.com/kube-core/kube-core/commit/430cdcd81691ed85abf23b09ec335e78aeaa772f)
- releases: Upgraded some releases [`f49f1ed`](https://github.com/kube-core/kube-core/commit/f49f1ed103111ccd884a2dfe6330a3583c9b5f79)
- core/releases: Added cdn as a ressource for releases-cloud & updated releases-cloud with a default naming convention [`e38cc63`](https://github.com/kube-core/kube-core/commit/e38cc632729bdb626f503c5c40cd760bfc568d29)
- core/layers: Removed some unused layers [`41135b7`](https://github.com/kube-core/kube-core/commit/41135b7dfaedd4250b7b4fbd372b75a5024b09d4)
- releases/logging-stack: Added support to provision any Kibana objects through config [`384f162`](https://github.com/kube-core/kube-core/commit/384f162d25b53bd5515fb569af6f811c6ce8ebec)
- core/layers: Added short names for every release and namespace [`5d38d6c`](https://github.com/kube-core/kube-core/commit/5d38d6c12d56fc23010ca9217d541acffcbc1172)
- cli/commands: Updated generate:values to work with reworked layers [`667208a`](https://github.com/kube-core/kube-core/commit/667208a3b83212a5630b7449953499cbe67e77ca)
- core/templates: Added release-variables to inject metadata in releases [`df04eea`](https://github.com/kube-core/kube-core/commit/df04eea00d7c34f51b202ba17cf1a307135093ba)
- releases: Rebuilt all releases [`e96e1c3`](https://github.com/kube-core/kube-core/commit/e96e1c39081c4c0246369c0d741e157476871c49)
- core/releases: Updated releases cloud variable in use for naming template [`40da754`](https://github.com/kube-core/kube-core/commit/40da754360849dd32f9855c0f4206c753cbdfd7d)
- core/values: Reworked release-cloud template [`419d777`](https://github.com/kube-core/kube-core/commit/419d77793feb0aefdbc74bda7cd8961a84034ef5)
- core/templates: Changed extensions release annotations [`6907c29`](https://github.com/kube-core/kube-core/commit/6907c29dad6a9ea27f257ee33fda38e1475c7498)
- core/releases: Added naming config to extensions [`96491d1`](https://github.com/kube-core/kube-core/commit/96491d18447c7358b514c3bf7c0f589099d4f888)
- core/layers: Added cloud.naming configuration [`0f9ec46`](https://github.com/kube-core/kube-core/commit/0f9ec46fb2d3ced2f1f4a1226e630cc1f30b68b1)
- release: v0.9.0 [`369bf37`](https://github.com/kube-core/kube-core/commit/369bf37833c9e07b61e0e14af4a37541e3f7c6ad)
- core/values: Added integration between release-patches and release-cloud [`0de3ee3`](https://github.com/kube-core/kube-core/commit/0de3ee34747247281ff4c6338e2d9b033fcada4c)
- core/templates: Added cloud naming integration on core releases [`ecc0136`](https://github.com/kube-core/kube-core/commit/ecc0136d1961b3471d590131c4d3242f64e92ec3)
- cli/scripts: Fixed broken path in some dev commands [`f20fb6c`](https://github.com/kube-core/kube-core/commit/f20fb6c1117809163a0318e3422750b1faec6222)
- core/releases: Updated releases-cloud recordset usage and naming [`7c9ec16`](https://github.com/kube-core/kube-core/commit/7c9ec16d3532f5d1bd9772d14aba282eb8e9c02b)
- core/templates: Added release-cloud integration on services [`8f355a1`](https://github.com/kube-core/kube-core/commit/8f355a11c214228655e23db7e734fcaba1c00ef9)
- core/templates: Reworked application template & Added release-variables [`8d084e1`](https://github.com/kube-core/kube-core/commit/8d084e16eb1a48b762868a09be8d6a43df7f0a46)
- core/releases: Fixed crossplane-cloud chart & few naming typo [`ec62534`](https://github.com/kube-core/kube-core/commit/ec625342178a3c8b5387aa9b5195978557b12ad9)
- core/templates: Added dedicated templating for cloud resource with specific naming requirement [`657f799`](https://github.com/kube-core/kube-core/commit/657f7994bd3898217b82f256d7293c903e689a01)
- core/templates: Added more options for naming in variables template [`b77a967`](https://github.com/kube-core/kube-core/commit/b77a967bcc521be5f5e0ff6aa1c3e3977385004b)
- core/values: Fixed some templating issues in release-cloud [`d646c72`](https://github.com/kube-core/kube-core/commit/d646c72db9f861b9184187e9732f099ae2380ae2)
- core/templates: Reworked application release template [`8a4a3fd`](https://github.com/kube-core/kube-core/commit/8a4a3fd32efee75b93dc35c3f63a778cefd50570)
- core/releases: Reworked application & service release template [`834fb26`](https://github.com/kube-core/kube-core/commit/834fb260fa6e7b191d1f10bfceddffac226c4306)
- core/layers: Added crossplane cloud integration for container-registry-operator [`137cd14`](https://github.com/kube-core/kube-core/commit/137cd147a2c543cb89321ae22ad833307017063e)
- core/layers: Added some default values in otherwise empty files [`03ed29a`](https://github.com/kube-core/kube-core/commit/03ed29a28607e6e535fccc713a8e7c45482ff49b)
- core/values: Fixed wrong condition on release-cloud BucketPolicies [`6df9566`](https://github.com/kube-core/kube-core/commit/6df956601978bfbd1893870d8aabe7e91712a778)
- core/values: Fixed mongodb-operator watchNamespace default value [`db76d18`](https://github.com/kube-core/kube-core/commit/db76d18a762e9099a15485f5616d98cbdbeab16a)
- core/layers: Fixed some default permissions in release-cloud [`f9554d6`](https://github.com/kube-core/kube-core/commit/f9554d6b75e3cf42e869b58fcf38fb138330af5c)
- core/layers: Added global option to enable cloud naming debug [`83515f0`](https://github.com/kube-core/kube-core/commit/83515f01ce4dc08d82cb108ab5a982ae5a508baf)

#### [v0.8.0](https://github.com/kube-core/kube-core/compare/v0.7.9...v0.8.0)

> 22 November 2022

- core/releases: Added crossplane-cloud chart and releases [`26a9227`](https://github.com/kube-core/kube-core/commit/26a92276f77300640d4cf179ac1272745efb2b90)
- cli/scripts: Updated cloud setup script to use crossplane [`34276a7`](https://github.com/kube-core/kube-core/commit/34276a7f68a84a323762c5d982d3fdbaf73d706a)
- core/releases: Upgraded prometheus-adapter [`76d2083`](https://github.com/kube-core/kube-core/commit/76d2083d99ff21632ad79e5053b866b21aab0d41)
- release: v0.8.0 [`a0df9a9`](https://github.com/kube-core/kube-core/commit/a0df9a9b29c73454655b53fa04431edff1d119c9)
- cli/commands: Fixed typo in gitops:config:index docs [`054aa91`](https://github.com/kube-core/kube-core/commit/054aa91181c7a91ec7e90ee3b4182745759d4a99)

#### [v0.7.9](https://github.com/kube-core/kube-core/compare/v0.7.8...v0.7.9)

> 17 November 2022

- release: v0.7.9 [`3cb6e59`](https://github.com/kube-core/kube-core/commit/3cb6e59f0fa7a7183c23d1bf55aa80449dea8490)
- core/options: Added options.forceNamespaceByKind [`590611f`](https://github.com/kube-core/kube-core/commit/590611f5e9e51bd7f7ca956e83e5541a49ce69c1)
- core/templates: Fixed empty clusterReleases merge behavior [`6ed9623`](https://github.com/kube-core/kube-core/commit/6ed962354af7e00873d18081451d76ce3c567ac2)
- core/values: Changed cert-manager leaderElection namespace [`30a3f5e`](https://github.com/kube-core/kube-core/commit/30a3f5e2921ffc7e65362ed968d8072a8da8f70a)
- core/globals: Disabled namespaces by default [`ead87de`](https://github.com/kube-core/kube-core/commit/ead87de9ecbaacf9ecade3d20e3b416ec7e5d85f)

#### [v0.7.8](https://github.com/kube-core/kube-core/compare/v0.7.7...v0.7.8)

> 14 November 2022

- release: v0.7.8 [`c1c576d`](https://github.com/kube-core/kube-core/commit/c1c576d2d2cc51d669759c3bd900d3efa2d50ee4)
- cli/commands: Fixed wrong path for generated helmfiles [`2355713`](https://github.com/kube-core/kube-core/commit/2355713ff6a63a3624f4a684cee02b7e1c713b9f)

#### [v0.7.7](https://github.com/kube-core/kube-core/compare/v0.7.6...v0.7.7)

> 14 November 2022

- cli/commands: Added import:manifests command [`1509347`](https://github.com/kube-core/kube-core/commit/1509347354b8ffb6813da702eb35f7316f544903)
- release: v0.7.7 [`f28bce8`](https://github.com/kube-core/kube-core/commit/f28bce83cc357b765f1b97f6b196f7e87ca412ab)
- core/templates: Fixed issues with local releases generation [`182520c`](https://github.com/kube-core/kube-core/commit/182520c5e586c525798804a2331aa93ed9fd2a2b)
- github/actions: Added automatic release on tag [`998dca0`](https://github.com/kube-core/kube-core/commit/998dca0ec0b962f814c915a0041a7190b21eef66)
- core/values: Added nameOverride on raw values template [`b436b2a`](https://github.com/kube-core/kube-core/commit/b436b2a3385fe725d2e234ce7ea37e0f2d98dee6)

#### [v0.7.6](https://github.com/kube-core/kube-core/compare/v0.7.5...v0.7.6)

> 12 November 2022

- release: v0.7.6 [`f394cb4`](https://github.com/kube-core/kube-core/commit/f394cb4e0b735e533026816e96aac7957ff4a063)
- core/releases: Removed default secrets for mongodb atlas operator [`0bc4851`](https://github.com/kube-core/kube-core/commit/0bc485124359dc835adcf30e9ad399865d47b262)

#### [v0.7.5](https://github.com/kube-core/kube-core/compare/v0.7.4...v0.7.5)

> 11 November 2022

- core/templates: Reworked helmfiles, fixed local paths for dev [`aad7f95`](https://github.com/kube-core/kube-core/commit/aad7f9556982a529481ba96655d6354dff6c8e52)
- release: v0.7.5 [`7e96090`](https://github.com/kube-core/kube-core/commit/7e96090b97338cfb4740de882c15e56beba0f7b1)
- cli/commands: Added flag to toggle color output on diff [`a6d481d`](https://github.com/kube-core/kube-core/commit/a6d481d4ad4481fdd308d56102ce28641c5cb87d)
- cli/docs: Fixed some wrong examples [`9e65279`](https://github.com/kube-core/kube-core/commit/9e652798c8fd67731595a556e4d7b3f9df5d18c4)
- cli/commands: Fixed inverted diff result on gitops:config:diff [`caf36bd`](https://github.com/kube-core/kube-core/commit/caf36bdee8080f3bbe76a31d830c69ec55b2ef1d)

#### [v0.7.4](https://github.com/kube-core/kube-core/compare/v0.7.3...v0.7.4)

> 10 November 2022

- releases/tekton: Upgraded app-hooks EventListener [`0db8c08`](https://github.com/kube-core/kube-core/commit/0db8c086d618ecc1569df8bbad49f8605bb29357)
- release: v0.7.4 [`da1ca7b`](https://github.com/kube-core/kube-core/commit/da1ca7b883051656f4a167e8c882ec7e0e277378)

#### [v0.7.3](https://github.com/kube-core/kube-core/compare/v0.7.2...v0.7.3)

> 10 November 2022

- cli/commands: Moved logic to parse stdin from base command class to a dedicated one [`a5f55d0`](https://github.com/kube-core/kube-core/commit/a5f55d0925fd136a1c13e54c1e526ebb3565a533)
- release: v0.7.3 [`ab68d79`](https://github.com/kube-core/kube-core/commit/ab68d79236046478b2bd4fc59161b1280e1700ab)

#### [v0.7.2](https://github.com/kube-core/kube-core/compare/v0.7.1...v0.7.2)

> 10 November 2022

- core/releases: Reworked oauth2-proxy to permit multiple deployment as a service [`374783e`](https://github.com/kube-core/kube-core/commit/374783e2a2d5501f704de2285c1bbeb1ad20aae3)
- releases: Added trivy [`288fe0f`](https://github.com/kube-core/kube-core/commit/288fe0f58ef83fcadf2a0d678991ca928f1a8192)
- cli/commands: Removed some outdated files [`17523ac`](https://github.com/kube-core/kube-core/commit/17523ac8fa4aca25051379067c73aa75bc9475e0)
- releases: Rebuilt all releases [`87c0c8b`](https://github.com/kube-core/kube-core/commit/87c0c8becc684e753e29068d55b36fd21f49bafe)
- releases/tekton-catalog: Adds garden deploy projects pipeline [`22e33db`](https://github.com/kube-core/kube-core/commit/22e33dbd08b6a3473f89df8db6fae3b84091cf0f)
- core/templates: Added option to inject namespaced oauth2-proxy on ingress [`355bd41`](https://github.com/kube-core/kube-core/commit/355bd41d0ed14a953bc166e95aba7a841d6f53f3)
- cli/commands: Added absorb command [`1a984e8`](https://github.com/kube-core/kube-core/commit/1a984e866c866df00c534c8c2d7a9dc8f67a9cec)
- releases/tekton-catalog: Adds new pipeline to deploy keycloak themes [`a21e241`](https://github.com/kube-core/kube-core/commit/a21e2417df7c4a56690c955bf47c74cdb8e8ae29)
- release: v0.7.2 [`085e833`](https://github.com/kube-core/kube-core/commit/085e833c8a4eaf49e30ef8087f0634826b5a1a50)
- cli/lib: Added some functions in utils to wrap kubectl [`a970a7f`](https://github.com/kube-core/kube-core/commit/a970a7f95b7ac0837e56e3e3c67d2dd34dbabe7c)
- cli/commands: Added stdin piping capabilities for all commands [`0ccc8b7`](https://github.com/kube-core/kube-core/commit/0ccc8b7d825a0c4c4e363561a71ced0b8efd964b)
- core/releases: Enabled storage as k8s crd for dex [`0313ff3`](https://github.com/kube-core/kube-core/commit/0313ff36e964859da7e1e7dfe7348f939d9cf7d7)
- releases/tekton-catalog: Added configuration keys for trivy [`58b6a6b`](https://github.com/kube-core/kube-core/commit/58b6a6bc8fd8ca6623f12718009aa38c3f32bd49)
- core/values: Enabled certificate owner ref by default for cert-manager [`ce79dfa`](https://github.com/kube-core/kube-core/commit/ce79dfa076ae1b767dcddd2a2929d2eb0e135d36)
- releases/container-registry-operator: Updated deployment [`fed7cf8`](https://github.com/kube-core/kube-core/commit/fed7cf80b08445d331b017a28030760b1a12cbb4)

#### [v0.7.1](https://github.com/kube-core/kube-core/compare/v0.7.0...v0.7.1)

> 7 November 2022

- cli/commads: Added some generation capabilities for values and local folders [`1c79283`](https://github.com/kube-core/kube-core/commit/1c79283578d9fe2e06903787b28ac1d70bd2ab9c)
- core/templates: Added checks to only generate namespaces from enabled core releases [`1e59bdf`](https://github.com/kube-core/kube-core/commit/1e59bdffd3994b66589c27eebbe32334bb8ef15f)
- cli/docs: Updated docs [`cc1c9d4`](https://github.com/kube-core/kube-core/commit/cc1c9d45c5caff6a49d3b9086858e30a842e6874)
- release: v0.7.1 [`9727703`](https://github.com/kube-core/kube-core/commit/9727703449e1c27cba705022922b284ab9281b56)
- cli/commands: Fixed gitops:config:diff checks on filtered data [`33d085e`](https://github.com/kube-core/kube-core/commit/33d085ee1c70b10d0aab46ac7bcfa23f7d269fa2)
- core/layers: Changed default config of ingress-access-operator [`0baa13b`](https://github.com/kube-core/kube-core/commit/0baa13b204ff8d5bfd9af2e82a3fc47f7b82fa9e)

#### [v0.7.0](https://github.com/kube-core/kube-core/compare/v0.6.8...v0.7.0)

> 7 November 2022

- cli/commands: Introduced formatting [`0012a7e`](https://github.com/kube-core/kube-core/commit/0012a7e079e901c3567df8e2d4120441c495cc8b)
- cli/docs: Updated docs generation [`41d9cfa`](https://github.com/kube-core/kube-core/commit/41d9cfa67019c7b62af3eea86a05301661530639)
- core/layers: Reworked all layers [`a6426b2`](https://github.com/kube-core/kube-core/commit/a6426b2e76fdc4c9e93fb5643aa4ec9c0ead808d)
- cli/package: Added some libs [`6ca7569`](https://github.com/kube-core/kube-core/commit/6ca756979bca1ec4bddbf9e32cf093ae39aeff05)
- cli/commands: Reworked generate:helmfiles [`2f5f9b0`](https://github.com/kube-core/kube-core/commit/2f5f9b090ed7e6682e5cc2c24464aa204c7ab9e5)
- core/templates: Reworked templates [`28f30c2`](https://github.com/kube-core/kube-core/commit/28f30c271d3960d1ef8aadd29ac01925416843e4)
- core/templates: Added templates for generate command [`771603c`](https://github.com/kube-core/kube-core/commit/771603c86175a8bd35570a1a67f45c73746a6049)
- core/templates: Added templates lib in core [`f4e2c79`](https://github.com/kube-core/kube-core/commit/f4e2c7982f7b9e307493f6a71680194cf636a91d)
- cli/commands: Added commands: gitops config find|read|search [`56688cc`](https://github.com/kube-core/kube-core/commit/56688cc1ce7796e8943f26e8233c031740db4044)
- cli: Preparing release [`476623b`](https://github.com/kube-core/kube-core/commit/476623b9bc146520d88d930104009f208a2ac6a5)
- cli/commands: Removed some unused files [`96efa4b`](https://github.com/kube-core/kube-core/commit/96efa4bbb39a1e1950d15cbf50247a6071ab5d58)
- cli/commands: Added experimental hot-reload command [`0c953cd`](https://github.com/kube-core/kube-core/commit/0c953cdc1ceb4b9169733b98090c6f80d0355d35)
- cli/utils: Added some functions to utils [`36a203c`](https://github.com/kube-core/kube-core/commit/36a203c3f4f697f071d59812cd5a15b8b62f5c60)
- cli/commands: Added kube-core gitops config diff [`6df216a`](https://github.com/kube-core/kube-core/commit/6df216a9cbdaedfbb2687c14355376c9bc6c346b)
- cli/scripts: Removed gitops/process.sh [`ad7ecfd`](https://github.com/kube-core/kube-core/commit/ad7ecfd7234e3dfcba532a4c12651a1e2c5e156a)
- cli/commands: Updated config search to use index if available [`d8364df`](https://github.com/kube-core/kube-core/commit/d8364dfe0a1267fa985da90a89c5b4c611ca5a89)
- cli/scripts: Removed slicing and added code from removed gitops/process.sh in cluster/process.sh [`ee9f64d`](https://github.com/kube-core/kube-core/commit/ee9f64d277a4494ac8a55a6b84af654f3f910b7f)
- cli/scripts: Reworked build workflow to start by local config first and then proceed with helmfile templating [`055d9a9`](https://github.com/kube-core/kube-core/commit/055d9a90970d8fed08baefc261310daebbd4c9fd)
- cli/commands: Added kube-core gitops config index [`2d60b6e`](https://github.com/kube-core/kube-core/commit/2d60b6e06f46a8683e51eaa91527d8785b0a2243)
- cli/commands: Updated some docs [`c85423b`](https://github.com/kube-core/kube-core/commit/c85423bd3c3849c00c6c9068054b474f6039a362)
- cli/commands: Added command generate helmfiles [`941baed`](https://github.com/kube-core/kube-core/commit/941baed01d4f070ba7ec71fe944d3ed6fc04090c)
- cli/commands: Updated generate values to allow merge from core over local [`248637f`](https://github.com/kube-core/kube-core/commit/248637fb924e372026a34e9a85660b4acca587b6)
- release: v0.7.0 [`c20ab9f`](https://github.com/kube-core/kube-core/commit/c20ab9f06e0282efdadbf707e6afb22a5634ee32)
- cli/base: Migrated some common logic in base command class [`0c95c04`](https://github.com/kube-core/kube-core/commit/0c95c048f799905ffa99bb7583f7ac8358ce2f94)
- cli/scripts: Moved slicing to cluster/build.sh [`e052004`](https://github.com/kube-core/kube-core/commit/e0520042b916a300df0af683607ae2e9cebf5de3)
- cli/commands: Added properties to get current cluster resources [`583d0ac`](https://github.com/kube-core/kube-core/commit/583d0ac45c689bbc4e0f0d75452a7716dd7b97d6)
- core/releases: Added startupProbe to secret-generator release [`534aedd`](https://github.com/kube-core/kube-core/commit/534aedd8514245a649203b941f0dd01bb7f4f78a)
- cli/scripts: Added original secret metadata on sealed version [`b58b5c2`](https://github.com/kube-core/kube-core/commit/b58b5c2a833b8d79abfee31660997fc6ede18ef5)
- cli/commands: Added comments and logs on generate values [`f952093`](https://github.com/kube-core/kube-core/commit/f952093a2f5258090a3a8e1503c00d6cc8d0f288)
- cli/lib: Replaced js-yaml by yaml [`a59aeed`](https://github.com/kube-core/kube-core/commit/a59aeed3a650453610f996c3434bb8d580d3a85b)
- core/templates: Added clusterRepositories support [`a3b9f6b`](https://github.com/kube-core/kube-core/commit/a3b9f6bf9bdd114e3142aefb5a24deec5714d7ed)
- cli/commands: Removed color output on gitops config read as it breaks post-processing [`71bf0b4`](https://github.com/kube-core/kube-core/commit/71bf0b455d47f938eec63ea46008a327fce31326)
- cli/libs: Added loadash [`9db674f`](https://github.com/kube-core/kube-core/commit/9db674f6ae298fddddbbf73a7120eab2e18bc298)
- core/templates: Fixed helmfileName value for lib templates [`ec7f841`](https://github.com/kube-core/kube-core/commit/ec7f841404af68ce7318af82b84d46146fb1379e)
- cli/scripts: Fixed kube-core build all --filter [`81588e6`](https://github.com/kube-core/kube-core/commit/81588e638e9a8574d2bcb5b1b926e8e14c557978)
- docker: Added gron v0.7.1 [`33ab2df`](https://github.com/kube-core/kube-core/commit/33ab2dfba3d5e7673ea371f6145bdb6bdeb52b47)
- releases/n9-api: Removed kubeVersion constraint [`2bd05f1`](https://github.com/kube-core/kube-core/commit/2bd05f1397cf0bbeabfcf31a3a6ddf044b61c2b0)
- cli/scripts: Added toggle in cluster-config to  autoseal secrets [`6fbf026`](https://github.com/kube-core/kube-core/commit/6fbf0269a59afc1f7cc58bded997bd6dcf571442)

#### [v0.6.8](https://github.com/kube-core/kube-core/compare/v0.6.7...v0.6.8)

> 21 October 2022

- release: v0.6.8 [`e87f465`](https://github.com/kube-core/kube-core/commit/e87f4653a32be8d170e823615f4384ef749ccc27)
- core/templates: Added chartVersion support in release template [`2f87b47`](https://github.com/kube-core/kube-core/commit/2f87b47014ed03ccb37da0c4234777616f0e0726)

#### [v0.6.7](https://github.com/kube-core/kube-core/compare/v0.6.6...v0.6.7)

> 21 October 2022

- core/envs: Added forceVisitorGroups and forceNamespaceVisitorGroup options [`a1dc2b2`](https://github.com/kube-core/kube-core/commit/a1dc2b25267df2d39e134d7e4f7a03155c772cd6)
- release: v0.6.7 [`9765e4f`](https://github.com/kube-core/kube-core/commit/9765e4f0f3836c70a12b896f5cbf68490dd45772)

#### [v0.6.6](https://github.com/kube-core/kube-core/compare/v0.6.5...v0.6.6)

> 21 October 2022

- core/envs: Added forceNamespaceIngressClass option [`833db4e`](https://github.com/kube-core/kube-core/commit/833db4e83408b29cb6ba197f4563966f39cb5787)
- core/values: Updated n9-api values template [`d1fee55`](https://github.com/kube-core/kube-core/commit/d1fee554ac893e0b492cd190f61f6aad40eb797e)
- release: v0.6.6 [`9f59967`](https://github.com/kube-core/kube-core/commit/9f5996780611161416fba64c88d892d83b493031)

#### [v0.6.5](https://github.com/kube-core/kube-core/compare/v0.6.4...v0.6.5)

> 20 October 2022

- core/templates: Fixed missing if in some templates [`176708c`](https://github.com/kube-core/kube-core/commit/176708c7c97d9af9c8d298e5c273f1f48e85539d)
- release: v0.6.5 [`06fc623`](https://github.com/kube-core/kube-core/commit/06fc6239fd3b794443ff8606542511928510a602)

#### [v0.6.4](https://github.com/kube-core/kube-core/compare/v0.6.3...v0.6.4)

> 20 October 2022

- release: v0.6.4 [`a4174df`](https://github.com/kube-core/kube-core/commit/a4174dfe6ccf9217ba06ebe00175a100aeebb442)
- core/templates: Fixed missing if in node-affinity template [`7bd8645`](https://github.com/kube-core/kube-core/commit/7bd8645ff580a010f116e67e5ebf2f7f7251ac35)

#### [v0.6.3](https://github.com/kube-core/kube-core/compare/v0.6.2...v0.6.3)

> 20 October 2022

- core/templates: Added forceNamespaceNodeSelector and forceNamespaceNodeAffinity options for all releases [`2084a3e`](https://github.com/kube-core/kube-core/commit/2084a3e1718c5446d9d24781636d2f59aba92ea3)
- cli/dev: Added test kubectl apply on file events [`88c4d75`](https://github.com/kube-core/kube-core/commit/88c4d75b5dff54c8311f6a7044e3711ddc10cfe1)
- release: v0.6.3 [`45310a1`](https://github.com/kube-core/kube-core/commit/45310a108b09e92a58b9f2c3d5c333f836ecf801)
- cli/package: Added upath for better cross-platform path capabilities [`53e2c44`](https://github.com/kube-core/kube-core/commit/53e2c4403399350870024a0f4083746247c18616)

#### [v0.6.2](https://github.com/kube-core/kube-core/compare/v0.6.1...v0.6.2)

> 19 October 2022

- releases: Rebuilt all releases [`741715f`](https://github.com/kube-core/kube-core/commit/741715ff382844ed641f97437a5ca7bfb9227b56)
- core/values: Simplified templating of nginx-ingress-controller values [`3f24ce7`](https://github.com/kube-core/kube-core/commit/3f24ce7ec9af8ad0323d95ca6974d193564dc532)
- release: v0.6.2 [`896f0c0`](https://github.com/kube-core/kube-core/commit/896f0c0c4f0323e01005a98c64bfd3237e75fe08)
- core/envs: Added some label injections [`6171bd7`](https://github.com/kube-core/kube-core/commit/6171bd77001bed7ca93813e3359e7a20dbc80c77)
- cli/scripts: Fixed wrong path for auto-generated releases input folders [`328ec32`](https://github.com/kube-core/kube-core/commit/328ec32599becff135b7506f6604c142a95076b6)
- core/templates: Fixed namespaces generation [`1560496`](https://github.com/kube-core/kube-core/commit/156049689402489a56987334e450d069df648a8c)
- cli/scripts: Changed slicing template to use release.kube-core.io/namespace instead of .metadata.namespace [`5b412c2`](https://github.com/kube-core/kube-core/commit/5b412c2812f7ae8199f51db27b104c16a34e1142)

#### [v0.6.1](https://github.com/kube-core/kube-core/compare/v0.6.0...v0.6.1)

> 19 October 2022

- core/releases: Added the possibility to manage namespaces as releases [`80a3353`](https://github.com/kube-core/kube-core/commit/80a3353b8ea601d0ae238d65513790653a42dde5)
- cli/scripts: Complete rework of build logic [`5c2d6dd`](https://github.com/kube-core/kube-core/commit/5c2d6dd77b296f9906aace3dd5a8ab11a36e5d7f)
- core/templates: Standardized and improved a few templates [`6099a28`](https://github.com/kube-core/kube-core/commit/6099a28d17375e10d6445e8f7cbb5a90d2fa056f)
- core/releases: Added gitops.enabled on releases to generate a flux Kustomization [`815132b`](https://github.com/kube-core/kube-core/commit/815132b71ada0f0a04422ea51d71852d77da1e56)
- release: v0.6.1 [`6697a77`](https://github.com/kube-core/kube-core/commit/6697a7732efde5d1396a258b53447ab55d41c200)
- cli/scripts: Changed test config files path in default-cluster-config.yaml [`ef6d4f9`](https://github.com/kube-core/kube-core/commit/ef6d4f96cc56ccd1529f4c10aff969101f5ca07e)

#### [v0.6.0](https://github.com/kube-core/kube-core/compare/v0.5.7...v0.6.0)

> 16 October 2022

- core/templates: Added forceNamespace, templatedValues & Various fixes/improvements in core templates [`26bf03a`](https://github.com/kube-core/kube-core/commit/26bf03aabcbd7a3ba8fce24b4b410cb916fd9947)
- cli/scripts: Reworked build to use a single helmfile template process instead of one for each release [`cbf0f39`](https://github.com/kube-core/kube-core/commit/cbf0f39456ac706e233e3521490037b81c21fa75)
- core/helmfiles: Added cluster helmfile and clusterReleases [`82c126b`](https://github.com/kube-core/kube-core/commit/82c126b8802d577becd739e477c39ba0edbc18a8)
- release: v0.6.0 [`aa9ab8c`](https://github.com/kube-core/kube-core/commit/aa9ab8caf31609355facd6677f708dc97d0facb5)
- cli/scripts: Fixed namespace generation to work with the new templating workflow [`7f45c7e`](https://github.com/kube-core/kube-core/commit/7f45c7ed7fdb8ed75909facf31c4204f98cf5ea3)
- cli/scripts: Improved detection of secrets to seal/restore [`a805919`](https://github.com/kube-core/kube-core/commit/a805919c7853bcbef7a924f4cd66ec8f9e7c0a64)
- cli/scripts: Moved namespace generation to the end, just before post-process [`523e5e4`](https://github.com/kube-core/kube-core/commit/523e5e48cf14c443dbe12381fe1e93de99f1d2d0)
- cli/scripts: Reduced verbosity of build while looping over helmfiles [`b867eea`](https://github.com/kube-core/kube-core/commit/b867eea11a3f84fe8baaa66ea7cd63a5b3d7c19e)

#### [v0.5.7](https://github.com/kube-core/kube-core/compare/v0.5.6...v0.5.7)

> 14 October 2022

- release: v0.5.7 [`0ab7bbe`](https://github.com/kube-core/kube-core/commit/0ab7bbe764f041dfdc877b824a7df6c4775227fb)
- docker: Upgraded helmfile to v0.147.0 [`ffefbd1`](https://github.com/kube-core/kube-core/commit/ffefbd104ae9ab340e8d9ca84240af05fc515046)

#### [v0.5.6](https://github.com/kube-core/kube-core/compare/v0.5.5...v0.5.6)

> 14 October 2022

- release: v0.5.6 [`1adeae3`](https://github.com/kube-core/kube-core/commit/1adeae31e60c3089546b11f2fc97c61707643970)
- cli/scripts: Updated helmfile-template.sh logic to improve performance when looping over all helmfiles and releases [`bc4433d`](https://github.com/kube-core/kube-core/commit/bc4433d97c319819f1dd361ebea0e41525efc867)
- core/templates: Removed release-helm-metadata template [`7c2f1ee`](https://github.com/kube-core/kube-core/commit/7c2f1ee7d0fa94898e22d0073567927d10efcdfa)
- core/templates: Merged helm labels/annotation patches with existing ones to improve performance [`fc006e6`](https://github.com/kube-core/kube-core/commit/fc006e6fa2dea702024a68f9451f7539fe62551a)
- core/envs: Fixed duplicate keys in some layers [`80b9b32`](https://github.com/kube-core/kube-core/commit/80b9b32b3d1930729e3836a52e7f36580f106583)

#### [v0.5.5](https://github.com/kube-core/kube-core/compare/v0.5.4...v0.5.5)

> 14 October 2022

- core/releases: Added dex & rework oauth2-proxy [`c6d5ad3`](https://github.com/kube-core/kube-core/commit/c6d5ad3f9820d4cc55ae1e29103b709e572c90ba)
- release: v0.5.5 [`6858061`](https://github.com/kube-core/kube-core/commit/68580618a8b6037bb5ad925649ece01fc2fb07f4)
- core/envs: Added new options to enable Oauth2 on ingress & to disable ingress access operator [`5bfb689`](https://github.com/kube-core/kube-core/commit/5bfb6894190be98f824a3b7f741b5c480a24e904)
- core/envs: Added possibility to generate dynamically secrets for each releases [`68e4925`](https://github.com/kube-core/kube-core/commit/68e492515c59a55d2b9f77d99ba725c14d79074b)
- core/values: Homogenized values format to set ingressClass [`bec6421`](https://github.com/kube-core/kube-core/commit/bec642113220361e1ec7ff5e4dc0deaa794d9df2)
- core/envs: Force quote on metadata values in release secrets [`1dc847c`](https://github.com/kube-core/kube-core/commit/1dc847c089d490a096988f0c66eb20bf69b40e60)

#### [v0.5.4](https://github.com/kube-core/kube-core/compare/v0.5.3...v0.5.4)

> 13 October 2022

- releases/flux-repository: Updated values templates and release [`451e21f`](https://github.com/kube-core/kube-core/commit/451e21f320dcae9ce8974004aa1998312862cf1a)
- releases: Added flux-repository [`9f5ac2d`](https://github.com/kube-core/kube-core/commit/9f5ac2daf99ba152a47bcd3240400cbe192cb535)
- releases/crossplane-buckets: Updated version to v0.3.1 [`4a1fde5`](https://github.com/kube-core/kube-core/commit/4a1fde5cd069dbc8bf2c25757ba26dcf46719c68)
- releases/kyverno-policies: Set failurePolicy to Ignore by default & Rebuilt chart [`2d33159`](https://github.com/kube-core/kube-core/commit/2d331599d5c44b26ddad099930548011a072702c)
- core/releases: Cleaned up releases definitions [`b3a61c1`](https://github.com/kube-core/kube-core/commit/b3a61c13cc059960cee6598388b52fa0ec070ac8)
- core/envs: Added core.globalHelmMetadataEnabled to force rendering Helm labels/annotations on manifests [`1119ec7`](https://github.com/kube-core/kube-core/commit/1119ec7786d788fa4d2586dd5806ab72ded9c4df)
- release: v0.5.4 [`670a4cf`](https://github.com/kube-core/kube-core/commit/670a4cf05df71e459ac3993610bd73e7f389b3ca)
- core/envs: Added secret for flux-repository in release-secrets [`4334138`](https://github.com/kube-core/kube-core/commit/433413815b006b52b1dfb084f8fbecb8f2f073c5)
- core/values: Added condition to handle using raw as a service [`51e152d`](https://github.com/kube-core/kube-core/commit/51e152d59c91c8b701a57c1aa1beeaeb0ba4bbfe)
- cli/scripts: Activated ytt overlays by default, with toggle via cluster-config [`4088d79`](https://github.com/kube-core/kube-core/commit/4088d79796e5effc40b7918aacb347f68bdbe716)
- core/templates: Improved kube-core chart and values layering over applications/services and added toggles [`fabd046`](https://github.com/kube-core/kube-core/commit/fabd0465453163caaad423c3ae657f3933fc35d0)
- core/values: Improved n9-api default values template [`2e07e58`](https://github.com/kube-core/kube-core/commit/2e07e58462e4bc744d4bcb3cac6582afcb5bda39)
- cli/scripts: Moved overlays at the end of kube-core build [`2aa4c6c`](https://github.com/kube-core/kube-core/commit/2aa4c6cddf999c9f7899e8f5a9ef68979efd60e7)
- cli/scripts: Improved logging on gitops_overlay [`e1a6ea3`](https://github.com/kube-core/kube-core/commit/e1a6ea31b34fce6ba5081c843414e3ee49b477b3)
- cli/scripts: Added some extra cleanup after building kube-core charts [`132dd78`](https://github.com/kube-core/kube-core/commit/132dd7818d4a1e7d82f17a39ee63fb76c1fc5ee8)
- cli/scripts: Fixed overlays applied on actual config instead of staging area [`bdb4050`](https://github.com/kube-core/kube-core/commit/bdb40503d8c7540a8dce77586f115864c78cfc2e)
- core/templates: Improved support of applications and services with injectClusterLoggingLabel [`fea6dc0`](https://github.com/kube-core/kube-core/commit/fea6dc03cd0b89c979050d168cc60c5b958b1ca7)

#### [v0.5.3](https://github.com/kube-core/kube-core/compare/v0.5.2...v0.5.3)

> 11 October 2022

- core/templates: Removed label injection on custom releases [`457a373`](https://github.com/kube-core/kube-core/commit/457a373ecb8ff1c8f37634cf1d37b3e21faddd00)
- release: v0.5.3 [`c835425`](https://github.com/kube-core/kube-core/commit/c83542533a9fe15d08b0b3e053eb091119654f10)

#### [v0.5.2](https://github.com/kube-core/kube-core/compare/v0.5.1...v0.5.2)

> 11 October 2022

- core/envs: Added integrations between Core, Applications and Services for mongodb-managed and rabbitmq-managed [`9c122e5`](https://github.com/kube-core/kube-core/commit/9c122e5d77f12d56961e2e3645a0fe21efc44820)
- cli/scripts: Reimplemented ytt Overlays [`b146bcb`](https://github.com/kube-core/kube-core/commit/b146bcb673150ceec7d7d4d759c51acff7ca7590)
- release: v0.5.2 [`8831d3b`](https://github.com/kube-core/kube-core/commit/8831d3b13ef6c2f2cd1946b75883143ef9b2fb11)

#### [v0.5.1](https://github.com/kube-core/kube-core/compare/v0.5.0...v0.5.1)

> 7 October 2022

- core/templates: Added release-labels template to easily inject global labels in any relase [`ed2f7cd`](https://github.com/kube-core/kube-core/commit/ed2f7cd592c11b865688921318ff8de323243740)
- release: v0.5.1 [`4e05db9`](https://github.com/kube-core/kube-core/commit/4e05db987935eee98859c7120c80f9be805ebc27)

#### [v0.5.0](https://github.com/kube-core/kube-core/compare/v0.4.5...v0.5.0)

> 7 October 2022

- core/templates: Reworked templates to allow for environments, applications and services generation [`e9880ef`](https://github.com/kube-core/kube-core/commit/e9880ef5f989038c7fbe66922aa5aafc5cec794d)
- releases: Added node-problem-detector [`6712757`](https://github.com/kube-core/kube-core/commit/6712757130732b7efc4536d542de1dd199249c02)
- core/envs: Reworked core values to allow for environments, applications and services generation [`9694041`](https://github.com/kube-core/kube-core/commit/9694041de235041e3691da08104cb3a6bbe82348)
- core/values: Reworked values templates to allow for environments, applications and services generation [`262e926`](https://github.com/kube-core/kube-core/commit/262e92682d47424dede14eb33575404e48d68542)
- releases/n9-api: Updated to v1.3.2 [`ecc4725`](https://github.com/kube-core/kube-core/commit/ecc47254775480a6f9754f764ff0644ef75d8731)
- core: Reworked core helmfiles to allow for environments, applications and services generation [`0185750`](https://github.com/kube-core/kube-core/commit/0185750c26165a51056eee1d33d89412630880a5)
- release: v0.5.0 [`0fb0e17`](https://github.com/kube-core/kube-core/commit/0fb0e176792a4bb9bbb1764dcd67692ab164325a)
- cli/workspace: Updated open command documentation [`cea2e2c`](https://github.com/kube-core/kube-core/commit/cea2e2c675d36e7b252ee0d964f843bc95ba2244)

#### [v0.4.5](https://github.com/kube-core/kube-core/compare/v0.4.4...v0.4.5)

> 4 October 2022

- cli: Added workspace:open command [`1fea9c4`](https://github.com/kube-core/kube-core/commit/1fea9c4d4538f9ec54d97d48c34af663e285bcc0)
- release: v0.4.5 [`fe25d1f`](https://github.com/kube-core/kube-core/commit/fe25d1ff6ef62c86e3bd31c59204098981cc82f0)

#### [v0.4.4](https://github.com/kube-core/kube-core/compare/v0.4.3...v0.4.4)

> 3 October 2022

- releases: Rebuilt all releases [`b1c44f6`](https://github.com/kube-core/kube-core/commit/b1c44f68d12810d93c3cc402974759195e53e6df)
- releases/mongodb-operator: Removed local chart and migrated to official one [`27c969a`](https://github.com/kube-core/kube-core/commit/27c969aad58469147b3e7729aba1c489a15330bc)
- releases/cluster-policies: Disabeled fail safe mode by default & Updated some policies [`66a8aab`](https://github.com/kube-core/kube-core/commit/66a8aab039c923c6996541503a8c8d6641870230)
- releases/rabbitmq-operator: Removed hooks and improved resource naming [`85def91`](https://github.com/kube-core/kube-core/commit/85def915d464e2babe43c49ba85f7ec72f080cd9)
- release: v0.4.4 [`e322f05`](https://github.com/kube-core/kube-core/commit/e322f0534a2c19f0b09e25d30d7678379c0d8350)
- releases/logging-stack: Changed fluentd minReplicaCount to 3 [`facc14e`](https://github.com/kube-core/kube-core/commit/facc14e754864be1b0e20e18d80d53b3c6654aa0)

#### [v0.4.3](https://github.com/kube-core/kube-core/compare/v0.4.2...v0.4.3)

> 30 September 2022

- releases/cluster-policies: Disabled all mutations by default [`a233d75`](https://github.com/kube-core/kube-core/commit/a233d757102dae884a66a777908f6aa9eae73018)
- release: v0.4.3 [`4aa7ec2`](https://github.com/kube-core/kube-core/commit/4aa7ec267a02fd9162ee2fba619939bf53c33ba1)

#### [v0.4.2](https://github.com/kube-core/kube-core/compare/v0.4.1...v0.4.2)

> 30 September 2022

- releases/cluster-policies: Reworked default configuration [`82d8daa`](https://github.com/kube-core/kube-core/commit/82d8daa199d3470a67c1e2c1e645ba48a215dfaf)
- release: v0.4.2 [`0908378`](https://github.com/kube-core/kube-core/commit/0908378626dc3dabc7b26d03ddcdef64d4ba3e9a)
- core/releases: Removed ingress upgrade options for tekton [`ff39a6b`](https://github.com/kube-core/kube-core/commit/ff39a6b80e24b362577121a612d42a32e78227b8)

#### [v0.4.1](https://github.com/kube-core/kube-core/compare/v0.4.0...v0.4.1)

> 29 September 2022

- releases/tekton: Updated Ingress resources to v1 [`79a3dce`](https://github.com/kube-core/kube-core/commit/79a3dceecc6e795ee3b1fda65be42701cfd01a51)
- releases/cluster-policies: Fixed default values [`97968c9`](https://github.com/kube-core/kube-core/commit/97968c961a8b1fb3e4f21973fd44f18e3f250a9e)
- release: v0.4.1 [`24a1716`](https://github.com/kube-core/kube-core/commit/24a17162c9c91437c76f584a28715131ed7672f3)

#### [v0.4.0](https://github.com/kube-core/kube-core/compare/v0.3.27...v0.4.0)

> 29 September 2022

- releases: Rebuilt dist folder [`6d5d818`](https://github.com/kube-core/kube-core/commit/6d5d818ae83ee10967f095832510d1b8ef65c830)
- releases/policies: Added kube-core base policies [`295acb5`](https://github.com/kube-core/kube-core/commit/295acb57db9cbeb552225aff212407e8ac5971b3)
- core/releases: Reworked layers and some defaults [`8b86e74`](https://github.com/kube-core/kube-core/commit/8b86e74cffba08db517ef4116fc1f5cbba160d9e)
- releases/kyverno-policies: Added kyverno-policies with default values [`0e9db60`](https://github.com/kube-core/kube-core/commit/0e9db604e71618a2005d119c568fb11a86ff5ef4)
- releases/kube-cleanup-operator: Updated values and switched source from local chart to remote [`333dfad`](https://github.com/kube-core/kube-core/commit/333dfadffab472d9772e9146aad6eb9c75e258b1)
- releases: Added cluster-rbac [`56bc42d`](https://github.com/kube-core/kube-core/commit/56bc42da32a6469f84a8ebfa5cf88e7b9cb5a2f9)
- cli/releases: Added script to generate a local release [`6f8b9d8`](https://github.com/kube-core/kube-core/commit/6f8b9d8db4bab8695dcd2874bd0d2985416f46ff)
- releases/logging-stack: Reworked logging-stack Ingress [`162fc7b`](https://github.com/kube-core/kube-core/commit/162fc7b6816ef1fffbfe420b6bd1c301502d9c44)
- release: v0.4.0 [`2df2827`](https://github.com/kube-core/kube-core/commit/2df28270653bf85b98390a32dbcdcd4fdc21feb0)
- releases/kyverno: Switched to HA and increased resource limits for kyverno [`c37fdb2`](https://github.com/kube-core/kube-core/commit/c37fdb2a4c5ec2ec057d91fa7edd11db42f01241)
- releases/logging-stack: Updated app and events dashboard [`81b2b24`](https://github.com/kube-core/kube-core/commit/81b2b243b8d82578cb32f26ebdb2a7f4c969ec4d)

#### [v0.3.27](https://github.com/kube-core/kube-core/compare/v0.3.26...v0.3.27)

> 23 September 2022

- releases: Added kyverno [`8a7998d`](https://github.com/kube-core/kube-core/commit/8a7998d038f63b11a411d243dd319313cf9e3bff)
- release: v0.3.27 [`17a5a5d`](https://github.com/kube-core/kube-core/commit/17a5a5d0591b3f9f8c90778cace7f764b294d601)

#### [v0.3.26](https://github.com/kube-core/kube-core/compare/v0.3.25...v0.3.26)

> 22 September 2022

- cli/scripts: Cleaned up some scripts and regenerated scripts-config with more docs [`09f033d`](https://github.com/kube-core/kube-core/commit/09f033de8ab50371e9bc32f0887b648be88e8f26)
- release: v0.3.26 [`972204d`](https://github.com/kube-core/kube-core/commit/972204de4ca136a7e6c623729e25e8e93590afe5)
- core/releases: Adds the possibility to inject labels for logging in core releases [`b2e8c63`](https://github.com/kube-core/kube-core/commit/b2e8c639c17cf409fc2d11705ec14708841fb2d6)
- releases/kps: Fixed wrong URL for mongodb_percona dashboard [`8ee31fa`](https://github.com/kube-core/kube-core/commit/8ee31fa9e301bc7686fa1679e12d828cf9615b4e)
- core/releases: Added logging on nginx-ingress releases by default [`dbd087b`](https://github.com/kube-core/kube-core/commit/dbd087b2026ada5ab9c7a2ccac505971e0a8d429)
- releases/tekton: Sets default SA for triggers to tekton [`ddea2ca`](https://github.com/kube-core/kube-core/commit/ddea2ca11156441c71e95a9838bdddd9a903cfbf)
- core/releases: Fixed typo on logging LabelTransformer [`04607dc`](https://github.com/kube-core/kube-core/commit/04607dc7cd752cfd818684f420f5aef0b176ad87)
- cli/scripts: Fixed typo in cloud_gcp_setup_tekton_sf [`ec11666`](https://github.com/kube-core/kube-core/commit/ec116661cb752171d21ae65f01a80bc6a3eb9e4c)

#### [v0.3.25](https://github.com/kube-core/kube-core/compare/v0.3.24...v0.3.25)

> 20 September 2022

- releases/chaos: Removed litmus-chaos and introduced chaos-mesh [`3163fc4`](https://github.com/kube-core/kube-core/commit/3163fc4f3f44f90b7b4646e9eb6d99309ebb9e1c)
- releases: Updated releases/dist [`b7d4a04`](https://github.com/kube-core/kube-core/commit/b7d4a043f4410f02d4b0b40224d0f7206cec7523)
- releases/mongodb-atlas-operator: Added mongodb-atlas-operator release [`114b6d0`](https://github.com/kube-core/kube-core/commit/114b6d00fa80e75f796b07e5608922864b7e80df)
- cli/generators: Adds terraform generator [`91bdfac`](https://github.com/kube-core/kube-core/commit/91bdfacd1e723fb7ce5dcb1b682f32810a2a467a)
- releases/logging: Improved logging-stack and cluster-logging default configuration, scaling and performance [`f824375`](https://github.com/kube-core/kube-core/commit/f824375bed32e0781ec209a12b004ba648f5d873)
- core/config: Reformatted some files [`093f13d`](https://github.com/kube-core/kube-core/commit/093f13d9c888cf213e8711bd5b1b5ea3a48717ac)
- releases/kps: Added some Grafana dashbords and reorganized some folders [`8a85c41`](https://github.com/kube-core/kube-core/commit/8a85c417306f138d50d56e0663d7e173ff4eb680)
- cli/generators: Fixes path in cli plopfile [`f701e3f`](https://github.com/kube-core/kube-core/commit/f701e3f5ba314f301db88f98df4e15baefecbc70)
- release: v0.3.25 [`3b79e42`](https://github.com/kube-core/kube-core/commit/3b79e428b2bb7c5d541d845da522f806f13031ec)
- releases/kps: Updated mongodb and external-dns dashboards [`8bf3d87`](https://github.com/kube-core/kube-core/commit/8bf3d87d9f89ebbfa1f3d811acf48e8d10c8c461)

#### [v0.3.24](https://github.com/kube-core/kube-core/compare/v0.3.23...v0.3.24)

> 16 September 2022

- releases/logging-stack: Added Kibana dashboard auto-provisionning [`d0de066`](https://github.com/kube-core/kube-core/commit/d0de066646533e94efdd3aee95ff655935ee1c9d)
- releases/cluster-logging: Allows to inject extra shared filters for all flows [`cec64d0`](https://github.com/kube-core/kube-core/commit/cec64d078a79814023aba8400b0587af864d660b)
- releases/cluster-logging: Added output integrations on tekton default flow [`023ad4d`](https://github.com/kube-core/kube-core/commit/023ad4de6a1b5cc0a4eac5eb828f6694a5f8fb73)
- release: v0.3.24 [`8ccfe2c`](https://github.com/kube-core/kube-core/commit/8ccfe2ccabee25a3b8792fa01b1861d062bbd2b0)
- core/releases: Added kube-core logging labels on nginx-ingress-controller [`67d7f4a`](https://github.com/kube-core/kube-core/commit/67d7f4a08a9c57ecdd0ef22f80952fb08986635c)
- releases/logging-stack: Changed min fluentd replicas to 1 by default [`4c033ca`](https://github.com/kube-core/kube-core/commit/4c033ca5ec8c0c0b050aacd51edb4f0ac011faaa)

#### [v0.3.23](https://github.com/kube-core/kube-core/compare/v0.3.22...v0.3.23)

> 15 September 2022

- releases/kps: Adds multiple dashboards [`3c51326`](https://github.com/kube-core/kube-core/commit/3c513261c7fc9811a1ffdc5c7004e31710d78311)
- releases/logging-stack: Added possibility to control min/max fluentd replicas [`3d8bd2c`](https://github.com/kube-core/kube-core/commit/3d8bd2c3c49c5c89cbfff57f353b8ab6fdea2f55)
- release: v0.3.23 [`cbb58a9`](https://github.com/kube-core/kube-core/commit/cbb58a95af96f8ec3ef12b00b767d01c69548c7d)
- core/cluster: Removed some namespaces that were included in log streams by default [`d2a7507`](https://github.com/kube-core/kube-core/commit/d2a7507e16f24d98f79480e709152040ee0f67ef)

#### [v0.3.22](https://github.com/kube-core/kube-core/compare/v0.3.21...v0.3.22)

> 15 September 2022

- releases/cluster-logging: Changed default buffer parameters to have better AWS S3 support [`65a42de`](https://github.com/kube-core/kube-core/commit/65a42de5b878d9a61c6f7aab2c637b142f0fb6f3)
- release: v0.3.22 [`6b9511b`](https://github.com/kube-core/kube-core/commit/6b9511bca9bf52ef88c27b72ec9dcc04958273f4)

#### [v0.3.21](https://github.com/kube-core/kube-core/compare/v0.3.20...v0.3.21)

> 15 September 2022

- releases/cluster-logging: Fixed some unsafe conditions [`f133cd7`](https://github.com/kube-core/kube-core/commit/f133cd733a66dd7b3558c1617ff361d46320da67)
- release: v0.3.21 [`53becf5`](https://github.com/kube-core/kube-core/commit/53becf5466520b96d06366d5de5ca3450b42de5c)

#### [v0.3.20](https://github.com/kube-core/kube-core/compare/v0.3.19...v0.3.20)

> 15 September 2022

- release: v0.3.20 [`04a9814`](https://github.com/kube-core/kube-core/commit/04a9814cea2aa6acc5ec781ab8d709207a7cb60c)
- releases/cluster-logging: Disabled events integration by default [`21e9bd0`](https://github.com/kube-core/kube-core/commit/21e9bd06b70c2c96e9ae62662b9787f370baeaf0)

#### [v0.3.19](https://github.com/kube-core/kube-core/compare/v0.3.18...v0.3.19)

> 14 September 2022

- releases/eck-operator: Upgrades to v2.4.0 and adds logic for autoscaling [`417973f`](https://github.com/kube-core/kube-core/commit/417973f037d594a0ca19d2f011cc4dd9bda81a9e)
- releases: Rebuilt releases [`7c9a844`](https://github.com/kube-core/kube-core/commit/7c9a8441ef3aa2636d6b65615191cb54430f8045)
- releases/logging: Improved default values [`06e7682`](https://github.com/kube-core/kube-core/commit/06e7682a021919c5e32776b916cd63f6bf2b36ec)
- core/packages: Fixed test-logging package [`7cc283d`](https://github.com/kube-core/kube-core/commit/7cc283d7d339734612d9148581246512de2dc6fe)
- release: v0.3.19 [`d8c1865`](https://github.com/kube-core/kube-core/commit/d8c18651b367576c255c485396789ad6f67018be)
- releases/logging-stack: Improved fluentbit default configuration [`29e2dfb`](https://github.com/kube-core/kube-core/commit/29e2dfb8cd7be9a9aedac988a73a2c83a8c398a4)

#### [v0.3.18](https://github.com/kube-core/kube-core/compare/v0.3.17...v0.3.18)

> 12 September 2022

- releases: Added test-logging package [`07ead6c`](https://github.com/kube-core/kube-core/commit/07ead6c22c2560f4218204ff29870a57a1db85fd)
- release: v0.3.18 [`1bf17a7`](https://github.com/kube-core/kube-core/commit/1bf17a7accd8044bedcb99617623836903f25169)

#### [v0.3.17](https://github.com/kube-core/kube-core/compare/v0.3.16...v0.3.17)

> 11 September 2022

- releases: Added prometheus-adapter & KEDA [`b81c30c`](https://github.com/kube-core/kube-core/commit/b81c30c73da4b966fc157c2e1db7df37da67183a)
- releases: Rebuilt releases [`fee0bfb`](https://github.com/kube-core/kube-core/commit/fee0bfbd03bbe30da2ebf1c184625a66c0ae1555)
- releases/cluster-logging: Added events integration that allows to parse and forward Kubernetes Events [`debe60c`](https://github.com/kube-core/kube-core/commit/debe60c9d387d91d78b67d0f9255eafd3334985e)
- releases/cluster-logging: Improved buffer and flush configuration to have more resilient and scalable event streams [`b8d44d1`](https://github.com/kube-core/kube-core/commit/b8d44d1cb844bcd25057d8fe23ba4698ff99746d)
- releases/logging-stack: Improved scalability, observability and resiliency of fluentd and fluentbit [`0b18fab`](https://github.com/kube-core/kube-core/commit/0b18fab847c6a5aa531f6201fa80465b1b2a6b42)
- core/config: Cleaned up some default values from core env as they are now in the underlying logging charts [`a8c20b0`](https://github.com/kube-core/kube-core/commit/a8c20b0d7b82d876dc83d8bacdf72022aa60cf8b)
- release: v0.3.17 [`71c956b`](https://github.com/kube-core/kube-core/commit/71c956b2c850f6d0f7fb28f26a5152d6c4c44437)
- releases/logging-stack: Added EventTailer resource to the stack [`1912156`](https://github.com/kube-core/kube-core/commit/19121567d14988ab7fffcc90b40badb1358356b2)
- releases/system-jobs: Removes excessive logging in all system-jobs containers [`4f5847b`](https://github.com/kube-core/kube-core/commit/4f5847b3023d3df21ab18345ede2134dcec0052d)
- cli/generators: Updated release template for add release command [`2be247f`](https://github.com/kube-core/kube-core/commit/2be247f14c2c1e8bfb7328d9cd2c77260bc2b22e)

#### [v0.3.16](https://github.com/kube-core/kube-core/compare/v0.3.15...v0.3.16)

> 6 September 2022

- cli/scripts: Adds more checks in branch detection before applying in auto-pr [`39b8960`](https://github.com/kube-core/kube-core/commit/39b896047cb0852fafd13476a855da4e70f5e9b2)
- release: v0.3.16 [`7f3aeba`](https://github.com/kube-core/kube-core/commit/7f3aeba2831ba9d68d318880886f6fb3cac1789f)

#### [v0.3.15](https://github.com/kube-core/kube-core/compare/v0.3.14...v0.3.15)

> 6 September 2022

- releases/tekton: Fixes apply & auto-merge logic in core-tag and cluster-push [`696210c`](https://github.com/kube-core/kube-core/commit/696210c8de77ff1381d53c4b8f2128c74477a538)
- release: v0.3.15 [`ea28d5b`](https://github.com/kube-core/kube-core/commit/ea28d5b7fbc4e81e0ae821e8a4b37db1efe072ca)

#### [v0.3.14](https://github.com/kube-core/kube-core/compare/v0.3.13...v0.3.14)

> 6 September 2022

- releases/tekton: Makes kube-core image in CI variable [`c1cad49`](https://github.com/kube-core/kube-core/commit/c1cad4906218ba05c6a438c60acaad840066e583)
- release: v0.3.14 [`2b79f3b`](https://github.com/kube-core/kube-core/commit/2b79f3b9dc88410a36632a931c1ddb8356b656f0)

#### [v0.3.13](https://github.com/kube-core/kube-core/compare/v0.3.12...v0.3.13)

> 6 September 2022

- policies: Adds possibility to toggle kube-core policies and cluster policies [`cb4dad4`](https://github.com/kube-core/kube-core/commit/cb4dad429e06ece9f84959ef405360664d8921ec)
- release: v0.3.13 [`0d8c123`](https://github.com/kube-core/kube-core/commit/0d8c1230697b4e66d5e0d02d72c4cf23d9694c12)

#### [v0.3.12](https://github.com/kube-core/kube-core/compare/v0.3.11...v0.3.12)

> 5 September 2022

- gitops: Adds apply logic on gitops pipelines [`5f0af48`](https://github.com/kube-core/kube-core/commit/5f0af48f6ea5fd8475b7634502321c02bb2e8952)
- release: v0.3.12 [`ffba14f`](https://github.com/kube-core/kube-core/commit/ffba14ff5fcab3f1f87eddfd3a7123f37e23fb77)

#### [v0.3.11](https://github.com/kube-core/kube-core/compare/v0.3.10...v0.3.11)

> 5 September 2022

- release: v0.3.11 [`e4a886b`](https://github.com/kube-core/kube-core/commit/e4a886b19043114ddda14a3213a4e4ce5f27e80a)
- cli/scripts: Fixes detection of changes in auto-pr if all files are targeted instead of gitops config only [`fb85448`](https://github.com/kube-core/kube-core/commit/fb854486238647d1c807a0f6d8198ce163fddb12)

#### [v0.3.10](https://github.com/kube-core/kube-core/compare/v0.3.9...v0.3.10)

> 5 September 2022

- cli/scripts: Forced secrets namespace generation to avoid CI builds deleting it [`f4a4905`](https://github.com/kube-core/kube-core/commit/f4a490583187066a45072e9d0a5482a05f80496f)
- release: v0.3.10 [`98a5c7a`](https://github.com/kube-core/kube-core/commit/98a5c7a9f9d33d02cd3ee315fd44a168a5f4cbe8)

#### [v0.3.9](https://github.com/kube-core/kube-core/compare/v0.3.8...v0.3.9)

> 5 September 2022

- releases: Removed base folder as it is not used anymore [`8713fad`](https://github.com/kube-core/kube-core/commit/8713fadf7ab97ceb0794a205592700bbcdb1a576)
- cli/scripts: Updates flux install & Various fixes and improvements [`396e7e5`](https://github.com/kube-core/kube-core/commit/396e7e56aa2dfc6f253d54ba5fd1554b069b344f)
- releases: Adds flux-config to manage default flux resources [`c710131`](https://github.com/kube-core/kube-core/commit/c71013169f5d13ab8ce3f2816445d9e9faeb04ce)
- core/templates: Moved namespace field on the kube-core release wrapper [`c06541a`](https://github.com/kube-core/kube-core/commit/c06541a9dbaa33afbfd2f0944af4216808cc512d)
- releases/flux: Adds podmonitor config to monitor all flux controllers [`15d9d88`](https://github.com/kube-core/kube-core/commit/15d9d88f4d8c5124d29c15f5721ec016a909fdd9)
- release: v0.3.9 [`1e65f06`](https://github.com/kube-core/kube-core/commit/1e65f06b95bec14d0485551ed2c80c0ad6444d0e)
- releases/schema: Updated schema to include new releases [`2df0dea`](https://github.com/kube-core/kube-core/commit/2df0deae34f7ea901078311274f9535f1804c805)

#### [v0.3.8](https://github.com/kube-core/kube-core/compare/v0.3.7...v0.3.8)

> 3 September 2022

- releases/tekton: Updates core-tag & PR workflow [`3448b1e`](https://github.com/kube-core/kube-core/commit/3448b1e6338f99c3be9ea17bed715b8bd68f258c)
- release: v0.3.8 [`db3442d`](https://github.com/kube-core/kube-core/commit/db3442d77b985884f9ae1210fc09f68f9b5c0ab5)

#### [v0.3.7](https://github.com/kube-core/kube-core/compare/v0.3.6...v0.3.7)

> 3 September 2022

- releases: Adds container-registry-config to allow easy use of GCR in the cluster [`12b527f`](https://github.com/kube-core/kube-core/commit/12b527f8e94adae8bf22ba06c90de9cd5d0ff42c)
- releases/tekton: Fixes core-tag pipeline & Makes kube-core image variable [`47fd50f`](https://github.com/kube-core/kube-core/commit/47fd50f5723a9a0e5a3905b244181a6da3603dd2)
- release: v0.3.7 [`4acfba1`](https://github.com/kube-core/kube-core/commit/4acfba10e436d24572cb7324bafcd79676e37cfb)

#### [v0.3.6](https://github.com/kube-core/kube-core/compare/v0.3.5...v0.3.6)

> 2 September 2022

- releases/tekton: Updates core-tag pipeline to use kube-core [`3ab343a`](https://github.com/kube-core/kube-core/commit/3ab343ac8036951ffa8be797e1fc228567389acd)
- release: v0.3.6 [`d7b1960`](https://github.com/kube-core/kube-core/commit/d7b1960ccfafa436235f2da95e6c008e0c4751a3)

#### [v0.3.5](https://github.com/kube-core/kube-core/compare/v0.3.4...v0.3.5)

> 2 September 2022

- releases/tekton: Improves secret configuration [`94724e4`](https://github.com/kube-core/kube-core/commit/94724e472bab651e5ef9dc3c523e8303f8773131)
- cli/scripts: Adds tekton & SF setup script [`dfd4435`](https://github.com/kube-core/kube-core/commit/dfd443571888d02aa25eb97809eb103cd31c6fe2)
- cli/scripts: Adds option to delete PR source branch by default on cluster auto PR [`eaf159e`](https://github.com/kube-core/kube-core/commit/eaf159eb91bff24b45058ec9c241342109178cb8)
- cli/scripts: Adds variable for local keys path [`d46277f`](https://github.com/kube-core/kube-core/commit/d46277ff0ab302f9c84e8c416c96c72db5e91f3b)
- release: v0.3.5 [`c98a1d2`](https://github.com/kube-core/kube-core/commit/c98a1d248b3bdd8849232d1c3c1e28bceb830b62)

#### [v0.3.4](https://github.com/kube-core/kube-core/compare/v0.3.3...v0.3.4)

> 1 September 2022

- releases/tekton: Changes default run timeout and makes it configurable [`8671825`](https://github.com/kube-core/kube-core/commit/86718250db19ba9d4804575c8bc83c6820bf093e)
- release: v0.3.4 [`3a43101`](https://github.com/kube-core/kube-core/commit/3a431017105c3b7049b8ae31c1e1267cc51e42d2)

#### [v0.3.3](https://github.com/kube-core/kube-core/compare/v0.3.2...v0.3.3)

> 1 September 2022

- releases/tekton: Renamed and removed some resources [`c1e16b6`](https://github.com/kube-core/kube-core/commit/c1e16b608fee6b2b51e39decc3b1d5aeab976d43)
- release: v0.3.3 [`0fa958c`](https://github.com/kube-core/kube-core/commit/0fa958c76a90a531e8b84e0ce1db0f9c8ce0c1eb)

#### [v0.3.2](https://github.com/kube-core/kube-core/compare/v0.3.1...v0.3.2)

> 1 September 2022

- releases/tekton: Reintroduces core-tag pipeline [`72f18e0`](https://github.com/kube-core/kube-core/commit/72f18e044c0bf7999a9d8e9de2c8ba2c25a335b4)
- releases/tekton: Improves resource name templating and brings more variables in hooks [`23c718a`](https://github.com/kube-core/kube-core/commit/23c718af68caba98aaf96832909f8d13d295f5a5)
- release: v0.3.2 [`0e4aab4`](https://github.com/kube-core/kube-core/commit/0e4aab4bd3bb0ae3ce457f0300b4734fd0f34149)
- cli/scripts: Updated bump script to automatically patch cli version [`50008bc`](https://github.com/kube-core/kube-core/commit/50008bcac37186d71f3b01960cfc20e57f0ed97e)
- releases/tekton: Fixes app-hooks git-webhooks-token reference missing [`4043d41`](https://github.com/kube-core/kube-core/commit/4043d41bb31f9b04ab0a7be3293271d4b7c098e5)

#### [v0.3.1](https://github.com/kube-core/kube-core/compare/v0.3.0...v0.3.1)

> 30 August 2022

- release: v0.3.1 [`58f4d99`](https://github.com/kube-core/kube-core/commit/58f4d99c6195e1aaee7b55018cee25e1dca3c808)
- cli: Fixes corePath in scripts [`e44ce5a`](https://github.com/kube-core/kube-core/commit/e44ce5a20987f1b2ae8172bf9d153dd3b9adbd68)
- scripts: Moved scripts in cli folder to package them together [`013e61f`](https://github.com/kube-core/kube-core/commit/013e61fd716e36fdd865c1e61fc5c530e83723a2)
- repo: Fixes .gitignore ignoring some files that should not be ignored [`7a5a62e`](https://github.com/kube-core/kube-core/commit/7a5a62e9696597bec4e40171b1572ef99812363a)
- cli: Reintroduced .helmignore files in releases/dist [`5d8a385`](https://github.com/kube-core/kube-core/commit/5d8a385d52c6722273653e48a89ff7fe4e0690d1)
- ci: Updated GitHub Actions Workflows [`435de98`](https://github.com/kube-core/kube-core/commit/435de9875aed3b42b333aac1a2e26bc75240628c)
- cli: Adds basic install instructions in README [`4fe45f0`](https://github.com/kube-core/kube-core/commit/4fe45f0118097fb8a0c8847c228f21e634886188)
- repo: Fixes scripts line endings for npm release packaging [`461e59a`](https://github.com/kube-core/kube-core/commit/461e59a003b346c1d75d34813ca11239404fa575)
- cli: Bumps version to v0.1.6 [`a5e51f0`](https://github.com/kube-core/kube-core/commit/a5e51f0cc3fac89d814f404866946614176ca692)
- release-it: Fixes changelog generation [`568a4c8`](https://github.com/kube-core/kube-core/commit/568a4c81a491492b296fbef3fd20321511390f2c)
- cli: Adds proper chmod on scripts [`4e48a2e`](https://github.com/kube-core/kube-core/commit/4e48a2eeeaf3393b3be59518e4d08245ffbd873e)

#### [v0.3.0](https://github.com/kube-core/kube-core/compare/v0.2.1...v0.3.0)

> 30 August 2022

- release: v0.3.0 [`4bb93cc`](https://github.com/kube-core/kube-core/commit/4bb93ccdec08884763cc7458153cdd1940054c70)

#### [v0.2.1](https://github.com/kube-core/kube-core/compare/v0.2.0...v0.2.1)

> 23 August 2022

- core: Added the possibility to deploy Patches with .release.patches [`186bb4d`](https://github.com/kube-core/kube-core/commit/186bb4dac26eee3b7d5e0663f8364c3fde91741e)
- release: v0.2.1 [`c72fd9a`](https://github.com/kube-core/kube-core/commit/c72fd9aede7e4eb235f7e28e6a024c866bc5e23c)
- scripts: Fixes kube-core apply & template commands [`d42c41f`](https://github.com/kube-core/kube-core/commit/d42c41fe2d44e9d2ffb1827e479404939a8c5f73)
- cli: Fixed .gitignore breaking dev cli [`5b5980d`](https://github.com/kube-core/kube-core/commit/5b5980d8bfbcd2ab03a7c1b87a6df57dd49c459e)

#### [v0.2.0](https://github.com/kube-core/kube-core/compare/v0.1.0...v0.2.0)

> 23 August 2022

- release: v0.2.0 [`15d4b88`](https://github.com/kube-core/kube-core/commit/15d4b88f822ce5b1f0aa747475322cc64baeef11)

#### v0.1.0

> 23 August 2022

- release: v0.1.0 [`a3d3d5b`](https://github.com/kube-core/kube-core/commit/a3d3d5b5b0efbda94741b42df98a80284b39b5f8)
- Initial commit [`ba3977a`](https://github.com/kube-core/kube-core/commit/ba3977a0c9d8bf8817a58b32213fe906b33b0da1)
