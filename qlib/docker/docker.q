d)lib qai.docker 
 Library for working with the lib docker
 q).import.module`docker 
 q).import.module`qai.docker
 q).import.module"%qai%/qlib/docker/docker.q"

.import.require`reQ

.bt.add[`.import.init;`.docker.init]{.docker.init[]}

.docker.conf:1!enlist `uid`host`port!(`default.dc;`localhost;1111)
.docker.openapi.version:`v1.47

.docker.init:{
 if[`docker in key .import.config;.docker.conf:`uid xkey key[conf] {[x;y]update uid:x from y}' value conf:.import.config`docker ];
 .docker.proc:first exec uid from .docker.conf;
 .docker.openapi.json:.j.k "c"$read1 `$.bt.print[":%qai%/qlib/docker/openapi/%version%.json"] .import.repository.con,.docker.openapi; 
 }


.docker.openapi.summary:{[x]
 if[max x~/:(::;`);:.docker.openapi.json];
 r:.docker.openapi.json x;
 ([] k:key r;v:value r)
 }

d)fnc qai.docker.openapi.summary 
 Function to get openapi summary
 q).docker.openapi.summary []
 q).docker.openapi.summary `paths


.docker.openapi.paths.summary:{
 allPaths:.docker.openapi.summary `paths;
 allPaths0:ungroup select path:k,mode:key @'v,val:value @'v from allPaths;
 allPaths0:update tags:first@' `$val[;`tags] from allPaths0;
 / `tags xasc `tags xcols allPaths0
 allPaths0:update path:{ssr[;"}";"%"] ssr[;"{";"%"] x}@'string path from `tags xasc `tags xcols allPaths0;
 if[max x~/:(::;`);:allPaths0];
 first  select from allPaths0 where path = x
 }

d)fnc qai.docker.openapi.paths.summary
 Function to get openapi summary in pahs
 q).docker.openapi.paths.summary []


/ proc:.docker.proc

.docker.version0:{[proc;data]
 r:.req.g .bt.print["http://%host%:%port%/version"] .docker.conf proc;
 if[max data~/:(::;`);:r];
 r data 
 }

.docker.version:{[data] .docker.version0[.docker.proc;data]}

d)fnc qai.docker.version
 Function to get docker version
 q).docker.version [] 

/ (::)proc:.docker.proc

.docker.containers.json0:{[proc;data]
 r:`uid xkey update uid:`$9#/:Id from .req.g .bt.print["http://%host%:%port%/containers/json"] .docker.conf proc;
 if[max data~/:(::;`);:r];
 r data
 }

.docker.containers.json:{[data] .docker.containers.json0[.docker.proc;data]}

d)fnc qai.docker.containers.json
 Function to get docker json
 q).docker.containers.json [] 

/ id:`5b1e2a8fd


.docker.containers.id.json0:{[proc;id]
 r:update uid:`$9#Id from .req.g .bt.print["http://%host%:%port%/containers/%id%/json"] (.bt.md[`id]id),.docker.conf proc;
 r
 }

.docker.containers.id.json:{[id] .docker.containers.id.json0[.docker.proc;id]}

d)fnc qai.docker.containers.id.json
 Function to get docker json
 q).docker.containers.id.json `5b1e2a8fd 


.docker.containers.id.top0:{[proc;id]
 r:.req.g .bt.print["http://%host%:%port%/containers/%id%/top"] (.bt.md[`id]id),.docker.conf proc;
 (`$r[`Titles])!/:{"SJJJTJT*"$'x}@'r`Processes
 }

.docker.containers.id.top:{[id] .docker.containers.id.top0[.docker.proc;id]}

d)fnc qai.docker.containers.id.top
 Function to get docker top
 q).docker.containers.id.top `5b1e2a8fd 

/ (::)proc:.docker.proc
/ id:"5b1e2a8fd5afc41bd1620a478e4e4896e48cd5ca2a76b85ec9a258264744f5a0"
/ id:`5b1e2a8fd 

.docker.containers.id.logs0:{[proc;id]
 r:.req.g .bt.print["http://%host%:%port%/containers/%id%/stats"] (.bt.md[`id]id),.docker.conf proc;
 (`$r[`Titles])!/:{"SJJJTJT*"$'x}@'r`Processes
 }

.docker.containers.id.logs:{[id] .docker.containers.id.logs0[.docker.proc;id]}

d)fnc qai.docker.containers.id.logs
 Function to get docker top
 q).docker.containers.id.logs `5b1e2a8fd

/ first select from .docker.openapi.paths.summary [] where path= `$"/containers/{id}/logs"


/

.docker.paths.getUrl:{[path;data]
 if[max path ~\:(`;::) ;:.docker.openapi.paths.summary[]];
 if[-11h = type path;path:string path];
 data:(`$lower string key data)!value data;
 path:ssr[;"}";"%"] ssr[;"{";"%"]path;
 path:.bt.print[path] data;
 `$.bt.print["%daemon%%path%"] .docker,data,.bt.md[`path] path 	
 }

.docker.paths.getUrl[]

.docker.paths.get0:{[path;data]
 .j.k .Q.hg `$.bt.print[":http://%0"] .docker.paths.getUrl[path;data]
 }

.docker.paths.get:{[path]
 if[max path~/:(::;`);:.docker.openapi.paths.summary[]];
 .docker.paths.get0[path;()!()]
 }

d)fnc qai.docker.paths.get
 Function to get openapi summary in pahs
 q).docker.paths.get [] 
 q).docker.paths.get "/containers/json"
 q).docker.paths.get `$"/containers/json"

.docker.paths.post0:{[path;data;mime;post] .Q.hp[;mime;post] `$.bt.print[":http://%0"] .docker.paths.getUrl[path;data]}

d)fnc qai.docker.paths.post0
 Function to post openapi summary in pahs
 q) allProcs:.docker.containers.summary[]
 q).docker.paths.post0 ["/containers/{id}/stop";;.h.ty`txt;"phrase"] first select from allProcs where uid like "prx.sm.*"


.docker.paths.post:{[path;data] .docker.paths.post0[path;data;.h.ty`txt;""]}

d)fnc qai.docker.paths.post
 Function to post openapi summary in pahs
 q) allProcs:.docker.containers.summary[]
 q).docker.paths.post ["/containers/{id}/stop"] first select from allProcs where uid like "prx.sm.*"

.docker.paths.getVal:{[path0]
 allPaths:.docker.openapi.paths.summary[];
 if[max path0~/:(::;`);:allPaths];
 if[-11h = type path0;path0:string path0]; 
 result:select from allPaths where path like path0;
 result [0]`val
 }

d)fnc qai.docker.paths.getVal
 Function to get details from path
 q).docker.paths.getVal [] 
 q).docker.paths.getVal "/containers/json"
 q).docker.paths.getVal `$"/containers/json"


.docker.containers.summary:{
 allContainers:.docker.paths.get "/containers/json";
 if[0=count allContainers;:()];
 allContainers:(`$ lower string cols allContainers ) xcol allContainers ;
 tmp:`name`port xasc select name:`${1_x}@'names[;0],host:hostconfig,port:ports,`$id from allContainers;
 tmp1:ungroup  select name,port:{ r:x where {all `IP`PrivatePort`PublicPort`Type in key x}@'x;if["b"$count r;:r];:flip`IP`PrivatePort`PublicPort`Type!(enlist"nohost";enlist 0ni;enlist 0ni;enlist `) }@'port,id from tmp;
 tmp2:`uid`port xasc select uid:`${ssr[x;"-";"."]}@'string name,host:{if[x~"0.0.0.0";:`localhost];`$x }@'port[;`IP],port:"j"$port[;`PublicPort],id from tmp1;
 r:`uid`id xcols update uid:.Q.dd'[uid;i],id:`$6#/:string id,user:`,passwd:count[i]#enlist"",cid:id from tmp2;
 if[x~`subl;: 0!select by host,port from r where host like "localhost" ];
 r
 }

d)fnc qai.docker.containers.summary
 Function to get details from path
 q).docker.containers.summary [] 

.docker.containers.top:{[ids]
 if[isDic:99h=type ids;ids:enlist ids];
 result:.docker.containers.top0@'ids;
 if[isDic;:result 0];
 raze result
 }

.docker.containers.top0:{[id]
 r:.docker.paths.get0["/containers/{id}/top"] id;
 tbl:`id`cmd xcols update id:id`id from flip (`$lower r`Titles)!flip r`Processes
  }

d)fnc qai.docker.containers.top
 Function to get results of top
 q).docker.containers.top 0!select by id from .docker.containers.summary[]

.docker.containers.stop:{[ids]
 if[isDic:99h=type ids;ids:enlist ids];
 result:.docker.containers.stop0@'ids;
 if[isDic;:result 0];
 raze result
 }

.docker.containers.stop0:{[id]
 :.docker.paths.post ["/containers/{id}/stop"] id
 }

d)fnc qai.docker.containers.stop
 Function to get results of top
 q).docker.containers.stop 0!select by id from .docker.containers.summary[]

.docker.init[]
