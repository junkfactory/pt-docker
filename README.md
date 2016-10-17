# What is pt-docker?
It is a docker container with percona 5.6.32 server. This is mainly used for developing or running tests for the Percona Toolkit.

# Building the docker image from Dockerfile
1. Go to the pt-docker directory
2. Execute docker build and take note of the build hash
```
docker build --force-rm -t bosyotech/pt-docker:<major>.<minor> .
```
3. Create tag for the build hash
```
docker tag <buld-hash> bosyotech/pt-docker:latest
```
4. Push to docker hun
```
docker push bosyotech/pt-docker
```

# Updating a previous docker image
Follow instructions at [Build your own image](https://docs.docker.com/engine/tutorials/dockerimages/)

# Running tests with Docker
For running regression tests with [Docker](https://www.docker.com). This is a fully setup container environment. All you have to do is install docker and execute a command.
### How to run the tests with docker
Once you have installed docker, there are couple of ways to run the tests.
1. Run all tests
```
docker run -v <path-to-pt-sources>:/home/percona/percona-toolkit bosyotech/pt-docker:latest
```
**path-to-pt-sources** - is the path to your local git clone. This is mounted on the container at */home/percona/percona-toolkit* so your code changes are immediately visible to the docker container for executing tests. This is mostly useful in fully interactive environment. (see below)
2. Run specific test(s)
```
docker run -v <path-to-pt-sources>:/home/percona/percona-toolkit bosyotech/pt-docker:latest t/pt-online-schema-change/rename_fk_constraints.t
```
Note that you cannot interrupt the tests, *^C* will not work in this case. If you want to be able to terminate the tests, add *-it* to the command.
```
docker run -it -v <path-to-pt-sources>:/home/percona/percona-toolkit bosyotech/pt-docker:latest t/pt-online-schema-change/rename_fk_constraints.t
```
For a fully interactive environment, run the following command to get a linux shell
```
docker run -e RUN_TEST=false -it -v <path-to-pt-sources>:/home/percona/percona-toolkit bosyotech/pt-docker:latest bash
```
In this mode, you will have to manually run the tests. All files  are in */home/percona* directory.

Find this tool at [bosyotech/pt-docker](https://hub.docker.com/r/bosyotech/pt-docker/)
