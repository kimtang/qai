
.import.require`reQ

.req.def:(!/) flip 2 cut (                                                               //default headers
  "User-Agent";     "kdb+/",string .Q.k;
  "Accept";         "*/*"
  )

d)lib kdbai.kdbai 
 Library for working with the os
 q).import.module`kdbai 
 q).import.module`kdbai.kdbai
 q).import.module"%kdbai%/qlib/kdbai/kdbai.q"

.kdbai.path.READY_PATH:"/api/v1/ready"
.kdbai.path.VERSION_PATH:"/api/v1/version"
.kdbai.path.CONFIG_PATH:"/api/v1/config/table"
.kdbai.path.CREATE_PATH:"/api/v1/config/table/"
.kdbai.path.DROP_PATH:"/api/v1/config/table/"
.kdbai.path.QUERY_PATH:"/api/v1/data"
.kdbai.path.INSERT_PATH:"/api/v1/insert"
.kdbai.path.TRAIN_PATH:"/api/v1/train"
.kdbai.path.SEARCH_PATH:"/api/v1/kxi/search"
.kdbai.path.HYBRID_SEARCH_PATH:"/api/v1/kxi/hybridSearch"

.kdbai.summary:{} 

d)fnc kdbai.kdbai.summary 
 Give a summary of this function
 q) kdbai.summary[] 


.kdbai.ready:{[endpoint]
 if[not 99h=type endpoint;endpoint:.bt.md[`endpoint]endpoint];
 @[{ `$.req.get . x };(.bt.print["%endpoint%%READY_PATH%"] .kdbai.path,endpoint;(`$("Content-type";"Accept"))!(.req.ty`json;.req.ty`json));{`BAD}]
 }


.kdbai.version:{[endpoint]
 if[not 99h=type endpoint;endpoint:.bt.md[`endpoint]endpoint];	
 .req.get[;(`$("Content-type";"Accept"))!(.req.ty`json;.req.ty`json)] .bt.print["%endpoint%%VERSION_PATH%"] .kdbai.path,endpoint
 }

.kdbai.get_tables:{[endpoint]
 if[not 99h=type endpoint;endpoint:.bt.md[`endpoint]endpoint];
 nschema:.req.get[;(`$("Content-type";"Accept"))!(.req.ty`json;.req.ty`json)] .bt.print["%endpoint%%CONFIG_PATH%"] .kdbai.path,endpoint;
 if[0=count nschema;:nschema];
 vschema:ungroup `name xcols update name:key nschema from ![;();1b;enlist[`type]!enlist (`$;`type)] value nschema;
 r:{{[x]update v:`long$'v from x where -9h=type@'v} {update v:`$v from x where 10h=type@'v} .util.ctable x}@'vschema;
 default:0!select by sym from raze {select sym,v:{first 1#0#x}@'v from x }@ 'r;
 default{exec sym!v from 0!select by {` sv x}@'sym from x,y}/:r
 }

.kdbai.ctable:{[r]
 r:.util.ctable @'r;
 default:0!select by sym from raze {select sym,v:{first 1#0#x}@'v from x }@ 'r;
 default{exec sym!v from 0!select by {` sv x}@'sym from x,y}/:r	
 }

.kdbai.cdict:{[x]
 {k:{` vs x}@'key x;.util.cdict select from ([]sym:k;v:value x) where (`type={` sv x}@'sym)or not null v}@'x
 }

.kdbai.create0:{[endpoint;name;schema]
 r:.req.post[;(`$("Content-type";"Accept"))!(.req.ty`json;.req.ty`json);.j.j schema] .bt.print["%endpoint%%CREATE_PATH%%name%"] .kdbai.path,`name`endpoint! (name;endpoint)
 }

.kdbai.create:{[endpoint;name;type0;schema]
 if[98h=type schema;schema:.kdbai.cdict schema];
 if[99h=type endpoint;endpoint:endpoint`endpoint];
 .kdbai.create0[endpoint;name;] `type`columns!(type0;schema)
 }


.kdbai.query:{[endpoint;name;param]
 param:param,(1#`table)!enlist name;
 result0:.req.post[;(`$("Content-type";"Accept"))!(.req.ty`json;"application/octet-stream");.j.j param] .bt.print["%endpoint%%QUERY_PATH%"] .kdbai.path,(1#`endpoint)! enlist endpoint;	
 result1:-9!"x"$result0;
 result1 1
 }


.kdbai.insert:{[endpoint;name;data]
 g:first 1?0ng;
 result0:.req.post[.bt.print["%endpoint%%INSERT_PATH%"] .kdbai.path,(1#`endpoint)! enlist endpoint;(`$("Content-type";"Accept"))!("application/octet-stream";.req.ty`json);] "c"$-8!(g;name;data);
 `$result0
 }

.kdbai.drop:{[endpoint;name]
 .req.del[;(`$("Content-type";"Accept"))!(.req.ty`json;.req.ty`json)] .bt.print["%endpoint%%DROP_PATH%%name%"] .kdbai.path,(`name`endpoint)! (name;endpoint)
 }


.kdbai.search:{[endpoint;name;vectors;n;params]
 params:params,`table`vectors`n!(name;vectors;n);
 result0:.req.post[.bt.print["%endpoint%%SEARCH_PATH%"] .kdbai.path,(1#`endpoint)! enlist endpoint;(`$("Content-type";"Accept"))!(.req.ty`json;"application/octet-stream");] .j.j params ;
 result1:-9!"x"$result0;
 raze result1 1
 }

.kdbai.train:{[endpoint;name;data]
 result0:.req.post[.bt.print["%endpoint%%TRAIN_PATH%"] .kdbai.path,(1#`endpoint)! enlist endpoint;(`$("Content-type";"Accept"))!("application/octet-stream";.req.ty`json);] "c"$-8!(name;data);
 `$result0
 }

.kdbai.hybrid_search:{[endpoint]}        