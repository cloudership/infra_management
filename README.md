# Infra Management

This repo allows management of a simple and complete AWS cloud platform to which services can be deployed.

The target user is an organization that needs to move past the simple, quick and rough deployment and hosting solutions
it built to allow fast iteration at the young startup phase and now needs to build a solution that will allow it to make
best use of the cloud.

Such an organization is not usually ready to hire a full-time infrastructure/platform/SRE team,
and can only rely on one or two full-time engineers - or even a part-time engineer - to manage the cloud platform.

When the organization is ready to hire a larger infrastructure team, the infrastructure built here can be used as a
basis for the more sophisticated and complex solutions they may want to build.

Simplicity is its main guiding principle, and it intends to be a platform that is easy to learn and manage by
non-specialists. It can, however, be extended by specialists who can be hired when the time is right.

The platform is fully tied to AWS. Tie-in is not an issue as it is so simple that it is fairly easy to reimplement on
another cloud provider to allow more vendor-neutrality.

# Usage

## Tools

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

---

## Build Docker container

The CI pipeline builds a Docker container and uses that to run commands. Here is how to test the build manually:

```shell
docker buildx build -t infra_management:local .
```

## CI/CD credentials

User AWS keys are not permanently stored in GitHub Actions secrets. Instead, session credentials are generated from a
role (using aws sts assume-role) and uploaded to GitHub secrets. These have a maximum duration after which they expire.

First download the GitHub CLI, then ensure it is configured correctly. The GitHub token used must have permissions to
create repository secrets in this repository.

Run this to upload creds:
```
AWS_PROFILE=current-user-credentials bin/add-session-to-github-actions RoleToAssumeForGitHubActionsName
```

(The role has to be created before-hand. A superuser role CAN be used but is not recommended for production systems.)

To configure the duration in seconds, set the DURATION_SECONDS env var in the current shell or in the .env file (see
.env.example for an example).
