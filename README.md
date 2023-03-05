# Infra Management

This repo allows management of a simple and complete AWS cloud platform to which services can be deployed.

The target user is an organization that needs to move past the simple, quick and rough deployment and hosting solutions
it built to allow fast iteration at the young startup phase and now needs to build a solution that will allow it to make
best use of the cloud.

Such an organization is not usually ready to hire a full-time infrastructure/platform/SRE team,
and can only rely on one or two full-time engineers - or even a part-time engineer - to manage the cloud platform.

When the organization is ready to hire a larger infrastructure team, the infrastructure built here can be used as a
basis for the more sophisticated and complex solutions they may want to build.

Simplicity is its main guiding principle. For example, the design shuns concepts like microservices or
functions-as-a-service, and unnecessary technologies like Kubernetes, to deliver a platform that is easy to learn and
manage by non-specialists while being extensible by specialists who can be hired when the time is right.

The platform is fully tied to AWS. Tie-in is not an issue as it is so simple that it is fairly easy to reimplement on
another cloud provider or add Kubernetes onto it to allow more vendor-neutrality.

# Usage

## CI/CD credentials

User AWS keys are not permanently stored in GitHub Actions secrets. Instead, session credentials are generated from a
role (using aws sts assume-role) and uploaded to GitHub secrets. These have a maximum duration after which they expire.

First download the GitHub CLI, then ensure it is configured correctly. The GitHub token used must have permissions to
create repository secrets in this repository.

Run this to upload creds:
```
AWS_PROFILE=current-user-credentials bin/add-session-to-github-actions RoleToAssumeForGitHubActionsName
```

To configure the duration in seconds, set the DURATION_SECONDS env var in the current shell or in the .env file (see
.env.example for an example).
