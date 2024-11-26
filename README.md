# Infra Management

## Intro

This project allows management of a simple and complete AWS cloud platform to run cloud services and data pipelines.

Here is a common scenario: when organizations start their journey on the cloud, they are small and scrappy - they are
time and budget constrained. So they cobble something together quickly to meet these constraints. This solution grows
hackily and untidily until eventually... it doesn't. Major issues with evolvability or scalability occur and the project
must be restarted "properly" from scratch.

Another, rarer, scenario is when organization similarly start with a hacky and scrappy cloud hosting solution, but wise
managers realise that it's time to invest in a proper solution before that solution breaks down, thus avoiding any
disruption for customers or stressful crunch-time for engineers.

This project is aimed at helping young organizations avoid both these scenarios. It allows them to start "properly" from
the beginning while still being quick and easy to start without a big investment. So, any reinvestment or jarring
transition is not necessary, and the initial project can smoothly transition into something more complex as required.

Young organizations are not usually ready to hire a full-time infrastructure/platform/SRE team, and can only rely on one
or two full-time engineers - or even a part-time engineer - to manage the cloud platform.

Thus, simplicity is the project's main guiding principle. It intends to be a platform that is easy to learn and manage
by non-specialists. It can, however, be extended by specialists who can be hired when the time is right.

When the time is right and organization is ready to hire a larger infrastructure team, this project can be used as the
foundations of a more sophisticated and complex solution.

The platform is fully tied to AWS. Tie-in is not an issue as it is so simple that it is fairly easy to reimplement on
another cloud provider to allow more vendor-neutrality.

## Usage

### Set up

#### Tool installation

`opentofu` and `terragrunt` can be installed any way - for example by downloading the precompiled binaries from GitHub.
Scripts are also provided in `bin/bootstrap` intended to be used for building container images.

##### Mac specific

On Macs, install the IaC tools via `brew`:

```shell
brew install terragrunt opentofu
```

### Running

The directory structure is designed for Terragrunt, and requires changing into each component directory before running
the `terragrunt` command.

The `bin/tg` script (tg being short for Terragrunt) is a wrapper that changes into the component directory and runs
`terragrunt`. For example, say we have an environment "prod" with a component "base":

```
$ ls live/prod/base/
terragrunt.hcl

$ bin/tg prod base plan -json
<tofu plan output with JSON logging>
```

Another shortcut is provided for those using `--terragrunt-source` against a local opentofu project - if the component
directory contains a symlink called `local`, it is resolved and passed to `terragrunt` with the `--terragrunt-source`
flag. e.g.:

```
$ ls -F live/prod/base/
terragrunt.hcl
local@   <-- symlink to /home/user/base_proj

$ bin/tg prod base plan
<cd to live/prod/base and run 'terragrunt --terragrunt-source=/home/user/base_proj plan'>
```

## Run order of components

Terragrunt can figure this out if run-all is used but that is not officially supported for now. The manual run order is:
* base
* base_eks
* apps

These modules can be found in these repositories:
* https://github.com/cloudership/infra_tf_base
* https://github.com/cloudership/infra_tf_apps

Then the kubectl command must be configured: (see [doc/kubernetes.md](doc/kubernetes.md))

Finally, Kubernetes manifests can be  applied. [The project containing the Kubernetes manifests](https://github.com/cloudership/infra_k8s_svc)
