Clipped from: [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)

### Install Compose on Linux systems[🔗](https://docs.docker.com/#install-compose-on-linux-systems)

On Linux, you can download the Docker Compose binary from the [Compose repository release page on GitHub](https://github.com/docker/compose/releases). Follow the instructions from the link, which involve running the curl command in your terminal to download the binaries. These step-by-step instructions are also included below.  
For alpine, the following dependency packages are needed: py-pip, python3-dev, libffi-dev, openssl-dev, gcc, libc-dev, rust, cargo and make.

1. ==Run this command to download the current stable release of Docker Compose:==

==$ sudo curl -L "====https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname== ==-s)-$(uname -m)" -o /usr/local/bin/docker-compose====￼==  
==To install a different version of Compose, substitute== ==1.29.2== ==with the version of Compose you want to use.==  
==If you have problems installing with== ==curl====, see== ==Alternative Install Options== ==tab above.==

3. ==Apply executable permissions to the binary:==

==$ sudo chmod +x /usr/local/bin/docker-compose====￼==

**Note**: If the command docker-compose fails after installation, check your path. You can also create a symbolic link to /usr/bin or any other directory in your path.  
For example:  
$ sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose￼

1. Optionally, install [command completion](https://docs.docker.com/compose/completion/) for the bash and zsh shell.
2. ==Test the installation.==

==$ docker-compose --version====￼====docker-compose version 1.29.2, build 1110ad01====￼==

### Alternative install options[🔗](https://docs.docker.com/#alternative-install-options)

- [Install using pip](https://docs.docker.com/#install-using-pip)
- [Install as a container](https://docs.docker.com/#install-as-a-container)

_Install using pip_

For alpine, the following dependency packages are needed: py-pip, python3-dev, libffi-dev, openssl-dev, gcc, libc-dev, rust, cargo, and make.  
Compose can be installed from [pypi](https://pypi.python.org/pypi/docker-compose) using pip. If you install using pip, we recommend that you use a [virtualenv](https://virtualenv.pypa.io/en/latest/) because many operating systems have python system packages that conflict with docker-compose dependencies. See the [virtualenv tutorial](https://docs.python-guide.org/dev/virtualenvs/) to get started.  
$ pip install docker-compose￼  
If you are not using virtualenv,  
$ sudo pip install docker-compose￼  
pip version 6.0 or greater is required.

_Install as a container_

Compose can also be run inside a container, from a small bash script wrapper. To install compose as a container run this command:  
$ sudo curl -L --fail [https://github.com/docker/compose/releases/download/1.29.2/run.sh](https://github.com/docker/compose/releases/download/1.29.2/run.sh) -o /usr/local/bin/docker-compose￼$ sudo chmod +x /usr/local/bin/docker-compose￼

### Install pre-release builds[🔗](https://docs.docker.com/#install-pre-release-builds)

If you’re interested in trying out a pre-release build, you can download release candidates from the [Compose repository release page on GitHub](https://github.com/docker/compose/releases). Follow the instructions from the link, which involves running the curl command in your terminal to download the binaries.  
Pre-releases built from the “master” branch are also available for download at [https://dl.bintray.com/docker-compose/master/](https://dl.bintray.com/docker-compose/master/).  
Pre-release builds allow you to try out new features before they are released, but may be less stable.

## Upgrading[🔗](https://docs.docker.com/#upgrading)

If you’re upgrading from Compose 1.2 or earlier, remove or migrate your existing containers after upgrading Compose. This is because, as of version 1.3, Compose uses Docker labels to keep track of containers, and your containers need to be recreated to add the labels.  
If Compose detects containers that were created without labels, it refuses to run, so that you don’t end up with two sets of them. If you want to keep using your existing containers (for example, because they have data volumes you want to preserve), you can use Compose 1.5.x to migrate them with the following command:  
$ docker-compose migrate-to-labels￼  
Alternatively, if you’re not worried about keeping them, you can remove them. Compose just creates new ones.  
$ docker container rm -f -v myapp_web_1 myapp_db_1 ...￼

## Uninstallation[🔗](https://docs.docker.com/#uninstallation)

==To uninstall Docker Compose if you installed using== ==curl====:==  
==$ sudo rm /usr/local/bin/docker-compose====￼==  
To uninstall Docker Compose if you installed using pip:  
$ pip uninstall docker-compose￼  
Got a “Permission denied” error?  
If you get a “Permission denied” error using either of the above methods, you probably do not have the proper permissions to remove docker-compose. To force the removal, prepend sudo to either of the above commands and run again.