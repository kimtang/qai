
.import.require`remote;

.bt.add[`.import.init;`.kdbai.init]{.kdbai.init[]}

.kdbai.conf:()!()
.kdbai.base_conf:`model`stream`embed!("llama3.1";0b;"all-minilm")
.kdbai.init:{
 .kdbai.conf:.util.deepMerge[.kdbai.base_conf].import.config`kdbai;
 .remote.add update uid:`kdbai.default from .kdbai.conf`connection;
 .kdbai.proc:`kdbai.default;
 }

d)lib qai.kdbai 
 Library for working with the os
 q).import.module`kdbai 
 q).import.module`qai.kdbai
 q).import.module"%qai%/qlib/kdbai/kdbai.q"


.kdbai.summary:{}

d)fnc qai.kdbai.summary 
 Give a summary of available models
 q) .kdbai.summary[]

.kdbai.col0:{[y] `c`t`a!(y 1;y 2;`) }
.kdbai.col1:{[y] `c`t`a!(y 1;("SE"!" E") "E"^(`sparse`!"SE") y 2 ;`) }
.kdbai.col2:{[x] flip{[x]  ((``embedding!(.kdbai.col0;.kdbai.col1)) (``embedding!``embedding) x 0)x } @' x    }
.kdbai.embedding0:{[x] 1_{[x;y] 
	if[`col=y 0;:x];
	if[`sparse=y 2;:x, enlist (`name`sparse!(`$"defaultIndexName",string -1+count x;`b)),y 3 ];
	x, enlist (`name`type!(`$"defaultIndexName",string -1+count x;y 2)),y 3
	} over enlist[{}],x } 
.kdbai.emdCol0:{ {[x;y] if[`col=y 0;:x];x,y 1    } over enlist[()],x }


.kdbai.cvdb0:{[vdb0;options;arg0]
 a:(`vdb`partn`vdbType!(vdb0;0b;`metaManaged)) ,options;
 a[`schema]:.kdbai.col2 arg0;
 a[`emdCol]:.kdbai.emdCol0 arg0;
 a[`idxParams]:.kdbai.embedding0 arg0;
 :a
 }



.kdbai.cvdb:{[vdb0;arg0] .kdbai.cvdb0[vdb0;()!();arg0]}
.kdbai.col:{[name;type0;arg0] enlist[(`col;name;type0)],arg0 }
.kdbai.embedding:{[name;type0;arg1;arg0] enlist[(`embedding;name;type0;arg1)],arg0 }
.kdbai.c0:()

d)fnc qai.kdbai.cvdb 
 Give a cvdb of available models
 q)c0:.kdbai.cvdb[`d0]
 q) .kdbai.col[`id;"s"]
 q) .kdbai.col[`tag;"s"]
 q) .kdbai.col[`text;"C"]
 q) .kdbai.embedding[`embeddings;`flat;`dims`metric!(1536;`L2)]
 q) .kdbai.c0
 q)c1:.kdbai.cvdb[`c1]
 q) .kdbai.col[`id;"C"]
 q) .kdbai.col[`tag;"C"]
 q) .kdbai.col[`text;"X"]
 q) .kdbai.embedding[`embeddings;`qflat;`dims`metric!(1536;`L2)]
 q) .kdbai.c0
 q)c2:.kdbai.cvdb[`c2]
 q) .kdbai.col[`id;"C"]
 q) .kdbai.col[`tag;"C"]
 q) .kdbai.col[`text;"X"]
 q) .kdbai.embedding[`embeddings;`ivf;`trainingVectors`metric`nclusters!(1000j;`CS;10j)]
 q) .kdbai.c0
 q)c3:.kdbai.cvdb[`c3]
 q) .kdbai.col[`id;"C"]
 q) .kdbai.col[`tag;"C"]
 q) .kdbai.col[`text;"X"]
 q) .kdbai.embedding[`embeddings;`ivfpq;`trainingVectors`metric`nclusters`nsplits`nbits!(5000j;`L2;50j;8j;8j)]
 q) .kdbai.c0
 q)c4:.kdbai.cvdb[`c4]
 q) .kdbai.col[`id;"C"]
 q) .kdbai.col[`tag;"C"]
 q) .kdbai.col[`text;"X"]
 q) .kdbai.embedding[`embeddings;`hnsw;`dims`metric`efConstruction`M!(1536j;`IP;8j;8j)]
 q) .kdbai.c0
 q)c5:.kdbai.cvdb[`c5]
 q) .kdbai.col[`id;"C"]
 q) .kdbai.col[`tag;"C"]
 q) .kdbai.col[`text;"X"]
 q) .kdbai.embedding[`embeddings;`sparse;`k`b!1.25 0.75f]
 q) .kdbai.c0
 q)c6:.kdbai.cvdb[`c6]
 q) .kdbai.col[`id;"C"]
 q) .kdbai.col[`tag;"C"]
 q) .kdbai.col[`text;"X"]
 q) .kdbai.embedding[`denseCol;`flat;`dims`metric!(1536;`L2)] 
 q) .kdbai.embedding[`sparseCol;`sparse;`k`b!1.25 0.75f]
 q) .kdbai.c0


.kdbai.getVdbMeta0:{[proc] .remote.qthrow[proc] "getVdbMeta[]"}
.kdbai.getVdbMeta:{ .kdbai.getVdbMeta0[.kdbai.proc] }

d)fnc qai.kdbai.getVdbMeta 
 Give a summary of available models
 q) .kdbai.getVdbMeta[]


.kdbai.getSupportedFilters0:{[proc] .remote.qthrow[proc] "getSupportedFilters[]"}
.kdbai.getSupportedFilters:{ .kdbai.getSupportedFilters0[.kdbai.proc] }

d)fnc qai.kdbai.getSupportedFilters 
 Give a summary of available models
 q) .kdbai.getSupportedFilters[]


.kdbai.getVersion0:{[proc] .remote.qthrow[proc] "getVersion[]"}
.kdbai.getVersion:{ .kdbai.getVersion0[.kdbai.proc] }


d)fnc qai.kdbai.getVersion 
 Give a summary of available models
 q) .kdbai.getVersion[]


.kdbai.vdbCreate0:{[proc;arg] .remote.qthrow[proc] enlist[`vdbCreate;arg]}
.kdbai.vdbCreate:{[arg] .kdbai.vdbCreate0[.kdbai.proc] arg}

d)fnc qai.kdbai.vdbCreate 
 Give a summary of available models
 q) .kdbai.vdbCreate 
 q)		.kdbai.cvdb[`d0]
 q) 		.kdbai.col[`id;"s"]
 q) 		.kdbai.col[`tag;"s"]
 q) 		.kdbai.col[`text;"C"]
 q) 		.kdbai.embedding[`embeddings;`flat;`dims`metric!(1536;`L2)]
 q) 		.kdbai.c0



.kdbai.vdbInsert0:{[proc;arg] .remote.qthrow[proc] (`vdbInsert;arg) }
.kdbai.vdbInsert:{[vdb;payload] .kdbai.vdbInsert0[.kdbai.proc] `vdb`payload!(vdb;payload) }

d)fnc qai.kdbai.vdbInsert 
 Give a summary of available models
 q) .kdbai.vdbInsert 


.kdbai.getData0:{[proc;arg] .remote.qthrow[proc] (`getData;arg)}
.kdbai.getData:{[vdb;opt]
 if[max(`;::)~\:opt;opt:()!()];
 .kdbai.getData0[.kdbai.proc] ((1#`vdb)!enlist vdb),opt
 }

d)fnc qai.kdbai.getData 
 Give a summary of available models
 q) .kdbai.getData 


