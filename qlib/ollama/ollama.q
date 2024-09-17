.import.require`reQ;

d)lib qai.ollama 
 Library for working with the lib ollama
 q).import.module`ollama 
 q).import.module`qai.ollama
 q).import.module"%qai%/qlib/ollama/ollama.q"

.bt.add[`.import.init;`.ollama.init]{.ollama.init[]}

.ollama.conf:()!()
.ollama.base_conf:`base_url`model`stream!("http://host:port";"llama3.1";0b)

.ollama.init:{ .ollama.conf:.util.deepMerge[.ollama.base_conf].import.config`ollama;}

.ollama.summary:{ .ollama.conf }

d)fnc qai.ollama.summary 
 Give a summary of available models
 q) .ollama.summary[]


/ base_url:.ollama.conf.base_url:"http://pop-os:11434"
/ model:.ollama.conf.model:"llama3.1"
/ stream:.ollama.conf.stream:0b

.ollama.list0:{[conf]
 r:.req.g .bt.print["%base_url%/api/tags"] conf;
 r`models
 }

.ollama.list:{ .ollama.list0 .ollama.conf }

d)fnc qai.ollama.list 
 Give a list of available models
 q) .ollama.list[]

.ollama.generate0:{[conf;arg]
 url:.bt.print["%base_url%/api/generate"] conf;
 if[10=abs type arg;arg:(1#`prompt)!(enlist arg)];
 arg0:conf,arg;
 p:(key arg0) inter parameters:`model`prompt`suffix`images`format`options`system`template`context`stream`raw`keep_alive;
 .req.post[url; (enlist"Content_Type")!enlist .req.ty`json]  .j.j p#arg0  
 }

.ollama.generate:{[arg] .ollama.generate0[.ollama.conf] arg }

d)fnc qai.ollama.generate 
 Give a list of available models
 q) arg:`stream`model`prompt!(0b;"llama3.1";"Why is the sky blue?")
 q) .ollama.generate "Why is the sky blue?"


/ .ollama.embed0:{[conf;arg]
/  url:.bt.print["%base_url%/api/embed"] conf;
/  if[10=abs type arg;arg:(1#`input)!(enlist arg)];
/  arg0:conf,arg;
/  p:(key arg0) inter parameters:`model`prompt`suffix`images`format`options`system`template`context`stream`raw`keep_alive;
/  .req.post[url; (enlist"Content_Type")!enlist .req.ty`json]  .j.j p#arg0  
/  }

/ .ollama.embed:{[arg] .ollama.embed0[.ollama.conf] arg }

d)fnc qai.ollama.embed 
 Give a list of available models
 q) arg:`stream`model`prompt!(0b;"llama3.1";"Why is the sky blue?")
 q) .ollama.embed "Why is the sky blue?"

.o.r:(1#`context)!enlist 0#0f;

.o.e:{
 -1 "---";
 -1 "Q: ",x;
 .o.r:.ollama.generate `context`prompt!(.o.r`context;x);
 -1 "A: ",.o.r`response;
 .o.r`response
 }