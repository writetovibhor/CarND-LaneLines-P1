#!/bin/bash
docker run -it --rm -p 8888:8888 -v $(pwd):/src -e http_proxy=$http_proxy -e https_proxy=$http_proxy udacity/carnd-term1-starter-kit

