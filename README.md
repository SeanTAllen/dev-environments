# dev-environments

Containerized development environments for my personal usage.

## Why?

I've been using WSL2 has my primary development environment for quite some time. It's an excellent tool for folks like me who do almost all their development in a Unix-like environment.

My take on WSL environments is a little different from many folks. I create mine by defining what I want in a Dockerfile and then building an image from that Dockerfile. Once I've built an image, I can export the filesystem as a tarball and import it into WSL. I started doing this because it made it easy for me to spin up new environments that that already had a lot of my configuration done. Over time, I found myself spinning up new environments less and less. More and more often, I end up doing an `apt install` in my main environment to get a new tool. This was never my intent. I like to [keep thing hygienic](https://www.youtube.com/watch?v=eCDm2AZEe38). While setting up a new WSL environment is fairly easy, it's not as easy as setting up and running a container.

I started looking around for possible alternatives. My plan is to continue to have multiple WSL environments, but those environments will largely be purely about operating system updates. As you can tell, by reading this, I settled on using Docker containers for my development environments. I looked at a variety of options including [Vagrant](https://www.vagrantup.com/), [Multipass](https://canonical.com/multipass), and [devcontainers](https://containers.dev/).

Devcontainers was the closest to what I want. I gave it a go but ran into one large problem. Devcontainers is designed to store the "development environment information" within a project. This is great for teams to give a baseline environment. I, however, want environments that are tailored to me. I don't want to have to remember to copy a `.devcontainer` directory into every project I work on. I want to be able to spin up an environment that has all my tools and configuration ready to go. After learning what I liked and didn't like about devcontainers, I decided to roll my own. What devcontainers does it pretty straightforward and I can get everything I want directly from containers.

The key differences I aimed for were the aforementioned issues with devcontainers storing configuration within a project and how I like to interact with my terminal. The best devcontainers experience is with Visual Studio Code. When you fire up a devcontainer from VS Code, it opens a terminal in container. This is great in many ways except, I don't want to use my terminal in VS Code. I like to maximize all my windows and switch from one to another. I want a full screen of terminal and a full screen of editor. The IDE-like experience of VS Code's terminal isn't for me.

The bit of tooling that exists in this repo solves both. I can start up a development container via a terminal. I can attach to that running container from VS Code to edit code within it. And if I want to get additional shells in that environment, I can `docker exec` into it to get additional shells. This ends up being very much like the experience I have with WSL2, except, now with more hygiene; which is what I set out to achieve.

## Workflow

< coming soon >

## What Goes Where?

There's certain aspects of my workflow that I do not want to have to recreate for each containerized development environment. For these, I bind mount into each container the files and directories as needed.

At the moment, I bind mount the following:

- fish shell configuration
- git configuration
- gpg configuration and keys
- ssh configuration and keys
- [starship](https://starship.rs/) configuration
- vim configuration

## Caveats

### User ID

Using containerized tools that mount folders from the host can be a pain. If you create files in the container that end up in a bind mounted folder, you are going to want to make sure that your host and container user ids match. All my WSL2 environments have my user `sean` with a user id of `1000`. I've set the user id in the Dockerfile to `1000` to match. The same applies to the `sean` group. If you don't do this, you are going to end up with permissions issues.

### Docker in Docker

If you need to run Docker within a development container, you need to mount the Docker socket into the container. For this to work, you need to make sure that whatever group is set on your host for the `docker.sock` is also available in the container and that your user in the container is a member of that group.

If you install docker in most containers, it will create a `docker` group that has some "random" group id. This is going to cause you problems. You need to make sure that the `docker` group in the container has the same group id as the `docker` group on the host. This synchronization is left to the user to work out.

To save yourself a lot of pain, make sure you create the `docker` group with the id that you want in your container before you install Docker in the container.

### GNU Privacy Guard

I use GnuPG to sign my git commits. This means that I need to have my GPG key available in the container. I've done this by mounting my `.gnupg` directory into the container. However, I discovered that it wouldn't work as it needed a tty to prompt me for my passphrase. If you decide to learn from what I've done here, note that your `gpg.conf` file has to include `pinentry-mode loopback`.
