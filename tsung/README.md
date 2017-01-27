# Tsung load tests for Ona Services (Zebra and API)

## Introduction

We are using [tsung](http://tsung.erlang-projects.org/) for performance testing.

Tsung docker folder structure

`|____start -> Bash script that starts tsung`

`|____Dockerfile -> For building the image`

`|____onadata-small.xml -> Tsung configuration file targeting a single endpoint`

`|____onadata.xml -> Tsung configuration file targeting random endpoints`

`|____tutorial.json -> Used when benchmarking submissions`

## Running the load tests

* `onadata-small.xml` - Runs load tests on the `api/v1/user` endpoint.
* `onadata.xml` - Runs load tests on:
	- `api/v1/profiles`
	- `api/v1/projects`
	- `api/v1/forms` 
	- `api/v1/submissions`
* `zebra.xml` - Runs load tests on:
    - Profile page `/<username>` 
    - Project page `/<username>/<project-id>` 
    - Dataview page `/<username>/<project-id>/<form-id>` 

###  Steps for running load tests

1. Build tsung docker image:
```sh
$ docker build -t load-tests .
```

2. Run container that will run the load tests and upload test results:
```sh
$ docker run -t -i load-tests sh start
```

### Viewing test output

After tsung finishes it will create a folder containing the benchmark results

```
/.tsung/log/<datetime>
```

Inside this folder run the following command to generate the report

```sh
$ /usr/lib/tsung/bin/tsung_stats.pl
```

Once done you can view the report in this file `report.html`

You can also copy the report from the container to your local machine using the below commands

1. Get the container id using `docker ps` command
2. Copy the folder using `docker cp <container id>:/path/to/the/folder ~/destination/folder` 

## Todo

1. Fix the start script to push the generated report to S3
2. Remove the need of running the tsung from inside the container and just run the image
