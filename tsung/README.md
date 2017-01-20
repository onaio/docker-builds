# Tsung load tests for Ona Services (Zebra and API)

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

####  Steps for running load tests:

1. Build tsung docker image:
```sh
$ docker build -t load-tests .
```

2. Run container that will run the load tests and upload test results:
```sh
$ docker run -t -i load-tests sh start
```
