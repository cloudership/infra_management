# Decisions

## Intro

All major decisions are listed here, with the most recent at the top.

Each decision is given a unique ID. These IDs are referred to when marking a decision as overriding another one, or when
a decision depends on another one. The unique ID comes at the front of the decision title, prefixed with "DIF-" (IF is
for "infra_management" and differentiates IDs for this project from others). Its format is YYYYMMDDNN - YYYY is the
4-digit year, MM is the 2-digit month, DD is the 2-digit day, and NN is a number that should be incremented for every
decision made on a day (starting at 01).

## List of Decisions

### DIF-2024091001 More granular break-up of IaC components

Resources are now broken into different components along certain divisions: platform engineer/app developer, and
AWS/Kubernetes.

The platform engineer/app developer division is required so app developers can self-manage infrastructure without the
risk of breaking the whole platform.

The AWS/Kubernetes division is required as each have their own sets of tools and configurations.

Also, this allows easily deleting resources when not in use to save cost (only a concern as this is a showcase project
that does not run production workloads).

So we have 3 types of components:
* base AWS components (platform engineers manage AWS resources)
* app AWS components (app developers manage their apps own AWS resources) - `apps` is in this category.
* app k8s components (app developers manage their own k8s resources). `apps_k8s` is in this category - it manages the
  'glue' between the AWS world and the k8s world, e.g. by creating k8s secrets or ConfigMaps with AWS configuration
  values, or attaching IAM roles to k8s ServiceAccounts.

All components are currently monorepos for simplicity - they can be broken up into more granular components as required.

### DIF-2024070601 Switch to OpenTofu

Terragrunt will now support OpenTofu, switch to that. For now it means no changes to the IaC but going forward there
will be changes which this project will be tailored for, and will lose Terraform compatibility eventually.

### DIF-2023030501 Minimize Terragrunt boilerplate

The following use-case is required: The component Terragrunt file should include the environment Terragrunt file. The
environment Terragrunt file should include the project Terragrunt file. But Terragrunt can only include 1 level of files
- includes cannot be embedded this way.

This is a very limiting and leads to lots of boilerplate. Start using Terraform variable files instead. When in JSON
format, these can be passed to Terraform while also being parsed and used by Terragrunt. So the environment and project
JSON variable files are read for every component's Terragrunt configuration as well as being read for the IaC
configuration.

### DIF-2023021905 Hardcode the role that Terraform uses in each environment's AWS account

Assume a hardcoded role before running Terraform in each account. Each account must have a role of the same name that
can be assumed by the caller. In the future, this can be made more elaborate with layers of access and more granular
authorized roles but is sufficient for now.

### DIF-2023021904 Temporary security credentials for the pipeline

No permanent AWS security credentials live in GitHub Actions. Instead, a set of assumed role credentials are uploaded
from the user's laptop. These are set to expire after a short time (15 minutes to 12 hours). It is quite easy to replace
these with a permanent set of credentials in the future when the project is more developed, but for now, this is a more
secure solution than leaving credentials in GitHub for long periods of time.

### DIF-2023021903 Pipeline

The pipeline runs in GitHub Actions. Creating a branch shows the plan, and merging it applies the changes. No plan file
is used for the sake of simplicity. As only one person is expected to work on one change at a time, this is not expected
to cause any problems.

Not using a plan file and applying changes directly is, however, used by the Ministry of Justice's platform team, who
support a platform scaling hundreds of services, so is quite practical.

[More here.](pipeline.md)

### DIF-2023021902 Managing deployed versions

The simplest solution, which is the one adopted, is that all deployment occurs from this project. Deploying any changes
to infrastructure or applications requires running GitHub Actions with an argument giving the name of the module.

Git refs will point to a branch by default, typically master. The action will run Terragrunt in a pristine state, thus
avoiding the issue where Terragrunt caches the git ref for a branch and pushing new changes to the branch do not get
picked up.

The project does not need to be checked out to change the branch or ref that a module points to - the relevant file can
be edited directly in GitHub, which automatically creates a PR.

### DIF-2023021901 Support per-application infra/ directory

Keeping each application's specific Terraform in its own infra/ directory is supported - just update the source
attribute - but that facility will not be used for any Showcase projects.

This is for simplicity - it is a monolithic design which is the preferred solution for smaller, simpler projects. This
keeps ToC lower and productivity higher due to less cognitive load from having to keep track of several projects and a
simpler CI/CD pipeline.

### DIF-2023020902 Expensive resource deletion

A standard flag, if supported by modules, can delete expensive resources during periods when they are not being used
without taking down the whole infrastructure. This optimizes cost savings from the start, which also helps broke people
trying to improve their cloud skills.

### DIF-2023020901 Use Terragrunt

Perhaps it goes against the concept of simplicity to use Terragrunt, but I believe the pros outweigh the cons in this
case as the ability to create generic, shared blocks of Terraform code and cut out the boilerplate amongst lots of
Terraform projects stops a lot of code repeat.

### DIF-2022110101 Decision format (do not use ADRs)

This is a hobby project / showcase of skills, and as such we will copy some of the features of ADRs but keep the
formalities out, so we can be a little agile. We may switch to ADRs in the future if things get more "serious" but in
the meantime, the ability to see a list of decisions in a single doc, over a few pages, is better than too many
formalities.

The principles of ADRs (title, statue, context, decision, consequences) will still be used as a guiding force.
