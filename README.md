# go-dependency-check

This is a simple dependency checker for arbitrary HTTP endpoints written in Go.

## Assumptions

The project assumes the following:

- A basic understanding of [Go](https://go.dev). 
- Go version `>= 1.19.4`.
- A basic understanding of [Git](https://git-scm.com/).
- Git version `>= 2.33.0`.
- Credentials to publish to the Docker Registry of your liking. This project defaults to the [GitHub Container Registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry).
- (Optional - for local testing) A basic understanding of [Make](https://www.gnu.org/software/make/manual/make.html#Introduction).
  - Make version `>= GNU Make 3.81`.
  - **Important Note**: This project includes a [Makefile](https://github.com/tarpanpathak/go-dependency-check/blob/main/Makefile) to speed up local development in Terraform. The `make` targets act as a wrapper around Terraform commands. As such, `make` has only been tested/verified on **Linux/Mac OS**. Though, it is possible to [install make using Chocolatey](https://community.chocolatey.org/packages/make), we **do not** guarantee this approach as it has not been tested/verified. You may use the commands in the [Makefile](https://github.com/tarpanpathak/go-dependency-check/blob/main/Makefile) as a guide to run each Terraform command locally on Windows.

## Contributions

Contributions are always welcome. As such, this project uses the `main` branch as the source of truth to track changes.

**Step 1**. Clone this project.
```sh
# Using Git
$ git clone git@github.com:tarpanpathak/go-dependency-check.git

# Using HTTPS
$ git clone https://github.com/tarpanpathak/go-dependency-check.git
```

**Step 2**. Checkout a feature branch: `git checkout -b feature/abc`.

**Step 3**. Validate the change/s locally by executing the steps defined under [Test](#test).

**Step 4**. If testing is successful, commit and push the new change/s to the remote.
```sh
$ git add file1 file2 ...

$ git commit -m "Adding some change"

$ git push --set-upstream origin feature/abc
```

**Step 5**. Once pushed, create a [PR](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request) and assign it to a member for review.
- **Important Note**: It can be helpful to attach the GitHub Actions output in the PR.

**Step 6**. A team member reviews/approves/merges the change/s.

**Step 7**. Once merged, a GitHub Action builds and publishes a new Docker image.

**Step 8**. Once deployed, verify that the changes have been deployed.

## Test

**Important Note**: This project includes a [Makefile](https://github.com/tarpanpathak/go-dependency-check/blob/main/Makefile) to speed up local development in Terraform. The `make` targets act as a wrapper around Terraform commands. As such, `make` has only been tested/verified on **Linux/Mac OS**. Though, it is possible to [install make using Chocolatey](https://community.chocolatey.org/packages/make), we **do not** guarantee this approach as it has not been tested/verified. You may use the commands in the [Makefile](https://github.com/tarpanpathak/go-dependency-check/blob/main/Makefile) as a guide to run each Terraform command locally on Windows.

```sh
# Export the required environment variables 
$ export DKR_REGISTRY_USER=<some_user>
$ export DKR_REGISTRY_TOKEN=<some_token>
# Compile the application in Docker
$ make build-docker # OR make build-local to compile natively
# Run the application in Docker
$ make run-docker # OR make run-local to run natively
```