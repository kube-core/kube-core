# kube-core CLI
## Stability
>:warning: The CLI is currently in beta
## Getting Started
First, install all the requirements.
Then you can install the CLI with:

```bash
sudo apt install curl 
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.bashrc
nvm install v18.8.0
nvm use v18.8.0
npm install -g @kube-core/cli
sudo chown -R $USER: $HOME/.nvm/versions/node/v18.8.0/lib/node_modules/
sudo chmod -R a+x $HOME/.nvm/versions/node/v18.8.0/lib/node_modules/
kube-core version
```

To upgrade it, you have to run: 

```bash
npm install -g @kube-core/cli
sudo chown -R $USER: $HOME/.nvm/versions/node/v18.8.0/lib/node_modules/
sudo chmod -R a+x $HOME/.nvm/versions/node/v18.8.0/lib/node_modules/
kube-core version
```

