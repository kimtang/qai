d)lib qai.docker 
 Library for working with the lib docker
 q).import.module`docker 
 q).import.module`qai.docker
 q).import.module"%qai%/qlib/docker/docker.q"

.import.require`reQ

.bt.add[`.import.init;`.docker.init]{.docker.init[]}

.docker.conf:1!enlist `uid`host`port!(`default.dc;`localhost;1111)

.docker.init:{
 if[`docker in key .import.config;.docker.conf:`uid xkey key[conf] {[x;y]update uid:x from y}' value conf:.import.config`docker ];
 .docker.proc:first exec uid from .docker.conf;
 }

.docker.summary0:{[proc] .req.g .bt.print["http://%host%:%port%/version"] .docker.conf proc }

.docker.summary:{.docker.summary0 .docker.proc} 
d)fnc docker.docker.summary 
 Give a summary of this function
 q) .docker.summary[] 

.docker.containers0:{[proc] .req.g .bt.print["http://%host%:%port%/containers/json"] .docker.conf proc}
.docker.containers:{.docker.containers0 .docker.proc} 


d)fnc docker.docker.containers 
 Give a containers of this function
 q) .docker.containers[]