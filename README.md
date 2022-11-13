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
