
d)lib kdbai.ollama 
 Library for working with the lib ollama
 q).import.module`ollama 
 q).import.module`kdbai.ollama
 q).import.module"%kdbai%/qlib/ollama/ollama.q"

.ollama.summary:{} 

d)fnc ollama.ollama.summary 
 Give a summary of this function
 q) ollama.summary[] 


.import.require`reQ


.ollama.path.READY_PATH:""
.ollama.path.GEN_PATH:"/api/generate"
/ .ollama.path.CONFIG_PATH:"/api/v1/config/table"
/ .ollama.path.CREATE_PATH:"/api/v1/config/table/"
/ .ollama.path.DROP_PATH:"/api/v1/config/table/"
/ .ollama.path.QUERY_PATH:"/api/v1/data"
/ .ollama.path.INSERT_PATH:"/api/v1/insert"
/ .ollama.path.TRAIN_PATH:"/api/v1/train"
/ .ollama.path.SEARCH_PATH:"/api/v1/kxi/search"
/ .ollama.path.HYBRID_SEARCH_PATH:"/api/v1/kxi/hybridSearch"

endpoint:"http://localhost:11434"

.ollama.ready:{[endpoint]
 if[not 99h=type endpoint;endpoint:.bt.md[`endpoint]endpoint];
 @[{ `$.req.get . x };(.bt.print["%endpoint%%READY_PATH%"] .ollama.path,endpoint;(`$("Content-type";"Accept"))!(.req.ty`json;.req.ty`json));{`BAD}]
 }

.ollama.ready endpoint

(::)endpoint:"http://localhost:11434"
(::)model:"llama3"
(::)prompt:"Why is the sky blue?"

.ollama.generate:{[endpoint;model;prompt]
 if[not 99h=type endpoint;endpoint:.bt.md[`endpoint]endpoint];
 data:`model`prompt`stream!(model;prompt;1b);
 r:.req.post[;(`$("Content-type";"Accept"))!(.req.ty`json;.req.ty`json);.j.j data] .bt.print["%endpoint%%GEN_PATH%"] .ollama.path,endpoint; 
 r
 }


.ollama.embedding:{[endpoint;model;prompt]
 if[not 99h=type endpoint;endpoint:.bt.md[`endpoint]endpoint];
 data:`model`prompt`stream!(model;prompt;1b);
 r:.req.post[;(`$("Content-type";"Accept"))!(.req.ty`json;.req.ty`json);.j.j data] .bt.print["%endpoint%%GEN_PATH%"] .ollama.path,endpoint; 
 r
 }