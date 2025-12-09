# githookframe
A plug-and-play extensible framework for defining global client-side githooks, complete with easy extension capabilities, via `hooklets`, a setup script, and ability to also run repo-specific (local) githooks alongside global ones. Basically your ready-to-go githook central.

## setup
### 1. Clone the repo
Clone the repo somewhere. I'd recommend somewhere like `~/.githooks`, but really it doesn't matter, the setup works from anywhere.
```bash
git clone git@github.com:madradev/githookframe.git ~/.githooks
```

### 2. Run the setup script
In the repo root directory, run:
```bash
./setup.sh
```
This script changes your git config to use the `./hooks` dir in this repo as your githooks dir. But don't worry, the githooks defined here are designed to also run your repo-local githooks too! To allow easy contributions to this framework, these githooks exist as `.dist` files (e.g. `pre-commit.dist`), but the setup script copies them into ACTUAL hooks (e.g. `pre-commit`).

### 3. Start adding hooklets
This framework installs global hooks that are initially just pass-through hooks for all your repo-local githooks. Basically, the global hooks it provides scan for any local hooks you might have in the repo you're running the git commands in, and runs those. You can now extend these with any global hooks you might want/already have. Just follow the example line given in the desired hook script to link to any hooklets you want. A `hooklets` directory is provided for your convenience, with a structure that allows you to organize your various hooklets. But you don't have to use it - you can run scripts from anywhere!


### 4. Detach from repo (optional)
A `detach.sh` script is provided for your convenience to remove all associations and files related to this repo in particular. This makes it easy for you to initialize your own git repo for all your custom behaviour based on this framework. Note that this action is not (easily) reversible.