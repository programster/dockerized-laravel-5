# ABANDONED NOTICE
This repository is abandoned/dead/deprecated. Please do not use it directly. I am just leaving this here in case it proves useful in future for creating another Dockerized Laravel version in the future if I ever need to.

This is because Laravel 5 is not supported anymore, and there are known security issues with using it. Please refer to the [release schedule](https://laravel.com/docs/master/releases) for which Laravel version you should consider using.


Dockerized Laravel 5
==================

This a version of the Laravel 5.0 framework with additions to allow it to be run using Docker. This removes the hassle of deploying your webserver in a way the Laravel framework needs.

## Getting Started.
* Navigate within the project folder and run `composer update`.
* Now navigate into the `docker` directory (inside /project) and then run `bash build.sh` to build the container.
* Run the container with the command `bash run-container.sh`

## Licensing
The Laravel framework already uses the MIT licence, and all of my contributions are under the MIT licence as well.

Enjoy!
