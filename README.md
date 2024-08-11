<h1 align="center"> ⚙️⚙️ DOTFILES REPOSITORY ⚙️⚙️</h1>

This repository contains my own dotfiles configuration used to customize the working environment on different OS.

By sharing my configuration, I hope to provide a starting point for other users who wish to customize their
configuration and improve their productivity.


# 🌱 Getting Started

The goal of this repository is to enable quick system configuration after a clean installation.

To achieve this, you will need to install the neccessary tools to clone the repository, clone it, and run a script that
will "copy" all the configuration files you want from this repository into their specific locations.

Using symbolic links instead of copying files is advantageous because it eliminates the need to manage two versions of
each file (the actual configuration file and the one stored in the repository). This simplifies the configuration
process and makes it easier to maintain your settings over time.

## 📁 Structure

The repository is organized into the following directories:

```
.
├── assets     # contains external resource files, such as profile images or wallpapers
├── config     # contains configuration files for other programs
├── modules    # contains external git submodules used by this repository (dotbot)
├── scripts    # contains personal scripts and utilities
├── shell      # contains configuration files for different shells
├── symlinks   # contains relevant files to use dotbot (which automates the creation of symbolic links)
├── templates  # contains templates used by other scripts or utilities
└── windows    # contains configuration files specific to Windows OS
```

## ❓ How to use it

Install the required tools to be able to use the repository into your system and execute the script mentioned above:

```bash
sudo apt update
sudo apt install git curl python3
git clone https://github.com/kyrex23/dotfiles.git ~/dotfiles
```


## 🐳 Try out using docker

You can safely try out the functionality of this repository from Docker by running the following commands:
```bash
# Define the name and version for your docker image
docker_image="dotfiles-sandbox:latest"
# Create a new docker image using the `Dockerfile` file
docker build . --tag "$docker_image"
# Run a new container using the recently created image and remove it when finished
docker run -it --rm "$docker_image"
```

The required tools `git`, `curl` and `python3` are already installed in the Docker image. Therefore, after starting the
container, you just need to run `symlinks/install` and verify the behavior of the repository.

**TIP**: If you created multiple images, you can easily remove untagged images by running:
```bash
docker rmi $(docker images --filter dangling=true --format="{{.ID}}")
```
