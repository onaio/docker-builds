Tsung load tests for Ona Servers (Zebra and API)

* `onadata-small.xml` - Runs load tests on the `api/v1/user` endpoint.
* `onadata.xml` - Runs load tests on:
	- `api/v1/profiles`
	- `api/v1/projects`
	- `api/v1/forms` 
	- `api/v1/submissions`
* `zebra.xml` - Runs load tests on:
    - `/login`

To build the docker image use:
```
$ docker build -t zebra-load-test .
```

To run a container that will run the all load tests:
```
$ docker run -t -i load-test sh start
```