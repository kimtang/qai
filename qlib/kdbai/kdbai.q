
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

.kdbai.cvdb:{[vdb0;arg0] .kdbai.cvdb0[vdb0;()!()] .kmp:arg0}
.kdbai.cvdb0:{[vdb0;options;arg0]
 a:(`vdb`partn`vdbType!(vdb0;0b;`metaManaged)) ,options;
 a[`schema]:.kdbai.schema0 arg0;
 / is_tsc:.kdbai.is_tsc0 arg0;
 if[not ()~b:.kdbai.emdCol0 arg0;a[`emdCol]:b];
 if[not ()~b:.kdbai.idxParams0 arg0;a[`idxParams]:b];
 if[not ()~b:.kdbai.searchCol0 arg0;a[`searchCol]:b];
 if[not ()~b:.kdbai.embedding0 arg0;a[`embedding]:b]; 
 :a
 }

.kdbai.c0:()
.kdbai.col:{[name;type0;arg0] enlist[(`col;name;type0)],arg0 }
.kdbai.col0:{[name;arg0;arg1]
 r:" E" `vectorIndex in distinct arg0[;0];
 t:raze {enlist[x 0]!enlist (x 2),(1#`type)!(1#x 1)}@'arg0;
 enlist[(`col0;name;r;t)],arg1
 }

.kdbai.col1:{[name;type0;arg0;arg1]
 t:raze {enlist[x 0]!enlist (x 2),(1#`type)!(1#x 1)}@'arg0;	
 enlist[(`col1;name;type0;t)],arg1
 }


.kdbai.vectorIndex:{[type0;arg0;arg1] enlist[(`vectorIndex;type0;arg0)],arg1 }
.kdbai.vectorIndex0:{[type0;arg0] .kdbai.vectorIndex[type0;arg0] .kdbai.c0 }

.kdbai.embedding:{[type0;arg0;arg1] enlist[(`embedding;type0;arg0)],arg1 }
.kdbai.embedding0:{[type0;arg0] .kdbai.embedding[type0;arg0] .kdbai.c0 }

.kdbai.sparseIndex:{[type0;arg0;arg1] enlist[(`sparseIndex;type0;arg0)],arg1 }
.kdbai.sparseIndex0:{[type0;arg0] .kdbai.sparseIndex[type0;arg0] .kdbai.c0 }

.kdbai.schema0:{[arg0] `c`t`a!(flip arg0[;1 2]),enlist count[arg0]#`}
.kdbai.idxParams0:{[x] r:{[x;y]
	if[`col=y 0;:x];
	y3:y 3; / if[98h=type y3;y3:y3 0];
	if[`sparseIndex in key y3;:x, enlist (`name`sparse!(`$"defaultIndexName",string -1+count x;`b)),y3`sparseIndex];
	vectorIndex:y3`vectorIndex;
	if[`tss=vectorIndex`type;:x];
	x, enlist (`name`type!(`$"defaultIndexName",string -1+count x;y 2)),vectorIndex
	} over enlist[{}],x;
	if[{}~r;:()];
	1_r 
 }

.kdbai.searchCol0:{[x] r:{[x;y]
	if[`col=y 0;:x];
	y3:y 3; / if[98h=type y3;y3:y3 0];
	if[not `vectorIndex in key y3;:x];
	vectorIndex:y3`vectorIndex;
	if[not `tss=vectorIndex`type;:x];
	x, y 1
	} over enlist[{}],x;
	if[{}~r;:()];
	first 1_r 
 }

.kdbai.emdCol0:{[x] r:{[x;y]
	if[`col=y 0;:x];
	y3:y 3; / if[98h=type y3;y3:y3 0];
	if[not `vectorIndex in key y3;:x];
	vectorIndex:y3`vectorIndex;
	if[`tss=vectorIndex`type;:x];
	x, y 1
	} over enlist[{}],x;
	if[{}~r;:()];
	1_r 
 }

.kdbai.embedding0:{[x] r:{[x;y]
	if[`col=y 0;:x];
	y3:y 3; /if[98h=type y3;y3:y3 0];
	if[not `vectorIndex in key y3;:x];
	if[not `embedding in key y3;:x];	
	vectorIndex:y3`vectorIndex;
	if[`tss=vectorIndex`type;:x];
	embedding:y3`embedding;
	x, enlist embedding
	} over enlist[{}],x;
	if[{}~r;:()];
	1_r 
 }

d)fnc qai.kdbai.cvdb 
 Give a cvdb of available models
 q)c7:.kdbai.cvdb[`c7]
 q) .kdbai.col[`index;"i"]
 q) .kdbai.col[`sym;"s"]
 q) .kdbai.col[`time;"p"]
 q) .kdbai.col0[`price;
 q) 	.kdbai.vectorIndex[`flat;`dims`metric!(1536;`L2)]
 q) 	.kdbai.embedding[`tsc;`dims`on_insert_error!(8j;`reject_all)] 
 q) 	.kdbai.c0
 q) ]
 q) .kdbai.c0
 q)c0:.kdbai.cvdb[`c0]
 q) .kdbai.col[`id;"s"]
 q) .kdbai.col[`tag;"s"]
 q) .kdbai.col[`text;"C"]
 q) .kdbai.col0[`embeddings;
 q) 	.kdbai.vectorIndex0[`flat] `dims`metric!(1536;`L2)
 q) ]
 q) .kdbai.c0
 q)c1:.kdbai.cvdb[`c1]
 q) .kdbai.col[`id;"s"]
 q) .kdbai.col[`tag;"s"]
 q) .kdbai.col[`text;"C"]
 q) .kdbai.col0[`embeddings;
 q)	.kdbai.vectorIndex0[`qFlat] `dims`metric!(1536;`L2)
 q) ]
 q) .kdbai.c0
 q)c2:.kdbai.cvdb[`c2]
 q) .kdbai.col[`id;"C"]
 q) .kdbai.col[`tag;"C"]
 q) .kdbai.col[`text;"X"]
 q) .kdbai.col0[`embeddings;
 q)	.kdbai.vectorIndex0[`ivf] `trainingVectors`metric`nclusters!(1000j;`CS;10j)
 q) ]
 q) .kdbai.c0
 q)c3:.kdbai.cvdb[`c3]
 q) .kdbai.col[`id;"C"]
 q) .kdbai.col[`tag;"C"]
 q) .kdbai.col[`text;"X"]
 q) .kdbai.col0[`embeddings;
 q) 	.kdbai.vectorIndex0[`ivfpq;`trainingVectors`metric`nclusters`nsplits`nbits!(5000j;`L2;50j;8j;8j)]
 q) ]
 q) .kdbai.c0
 q)c4:.kdbai.cvdb[`c4]
 q) .kdbai.col[`id;"C"]
 q) .kdbai.col[`tag;"C"]
 q) .kdbai.col[`text;"X"]
 q) .kdbai.col0[`embeddings;
 q) 	.kdbai.vectorIndex0[`hnsw;`dims`metric`efConstruction`M!(1536j;`IP;8j;8j)]
 q) ]
 q) .kdbai.c0
 q)c5:.kdbai.cvdb[`c5]
 q) .kdbai.col[`id;"C"]
 q) .kdbai.col[`tag;"C"]
 q) .kdbai.col[`text;"X"]
 q) .kdbai.col0[`embeddings;
 q) 	.kdbai.vectorIndex0[`sparse;`k`b!1.25 0.75f]
 q) ]
 q) .kdbai.c0
 q)c6:.kdbai.cvdb[`c6]
 q) .kdbai.col[`id;"C"]
 q) .kdbai.col[`tag;"C"]
 q) .kdbai.col[`text;"X"]
 q) .kdbai.col0[`denseCol;
 q) 	.kdbai.vectorIndex0[`flat;`dims`metric!(1536;`L2)] 
 q) ]
 q) .kdbai.col0[`sparseCol;
 q) 	.kdbai.vectorIndex0[`sparse;`k`b!1.25 0.75f]
 q) ]
 q) .kdbai.c0


.kdbai.getVdbMeta0:{[proc;tbl]
 r:.remote.qthrow[proc] "getVdbMeta[]";
 if[max(`;::)~\:tbl;:r];
 if[t:0>type tbl;tbl:enlist tbl]; 
 r0:r`vdbMetaManaged;
 s0:0!select from r0 where vdb in tbl;
 if[t and 1=count s0 ;:s0 0];
 if[1<=count s0;:s0];

 r0:r`vdbMetaFromRef;
 s0:0!select from r0 where vdb in tbl;
 if[t and 1=count s0 ;:s0 0];
 if[1<=count s0;:s0];

 r 
 }

.kdbai.getVdbMeta:{[tbl]
 .kdbai.getVdbMeta0[.kdbai.proc;tbl]
 }

d)fnc qai.kdbai.getVdbMeta 
 Give a summary of available models
 q) .kdbai.getVdbMeta[]
 q) .kdbai.getVdbMeta`trade_tss_p


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


.kdbai.query0:{[proc;arg] .remote.qthrow[proc] (`getData;arg)}
.kdbai.query:{[vdb;opt]
 if[max(`;::)~\:opt;opt:()!()];
 .kdbai.query0[.kdbai.proc] ((1#`vdb)!enlist vdb),opt
 }

d)fnc qai.kdbai.query 
 Give a summary of available models
 q) .kdbai.query 


(::)proc:.kdbai.proc
(::)vdb:`trade_tss

.kdbai.vdbSearch1:{[proc;vdb;vectors;k;opt;m]
 if[max(`;::)~\:opt;opt:()!()];
 if[0>t:type vectors 0;vectors:enlist vectors];
 arg:`vdb`k!(vdb;k);
 arg[`searchCol]:m`searchCol;
 r:raze{[proc;arg0;arg1] .remote.qthrow[proc] enlist[`vdbSearch;] arg0,(1#`qry)!enlist arg1 }[proc;arg,opt] @'vectors;
 / if[0>t;:r 0];
 r
 }

.kdbai.vdbSearch0:{[proc;vdb;vectors;k;opt]
 if[max(`;::)~\:opt;opt:()!()];
 m:.kdbai.getVdbMeta0[proc]vdb;
 if[not ()~m`searchCol;:.kdbai.vdbSearch1[proc;vdb;vectors;k;opt;m]];
 if[0>t:type vectors 0;vectors:enlist vectors];
 idxParam:first m`idxParams;
 arg:`vdb`k!(vdb;k);
 arg[`weights]:(1#idxParam`name)!(enlist 1f);
 r:raze{[proc;arg0;arg1] .remote.qthrow[proc] enlist[`vdbSearch;] arg0,(1#`qry)!enlist arg1 }[proc;arg,opt] @'flip(1#idxParam`name)!(enlist vectors);
 / if[0>t;:r 0];
 r
 }

.kdbai.vdbSearch:{[vdb;vectors;k;opt] .kdbai.vdbSearch0[.kdbai.proc;vdb;vectors;k;opt]}


d)fnc qai.kdbai.vdbSearch[] 
 Give a summary of available models
 q) .kdbai.vdbSearch [`quickstartkdbai;0 0 0 0 0 0 0 0e;1;`]


.kdbai.getTables0:{[proc;vdb0]
 allMeta:.kdbai.getVdbMeta0[proc;vdb0];
 a:update type0:`vdbMetaManaged from 0!allMeta`vdbMetaManaged;
 b:update type0:`vdbMetaFromRef from 0!allMeta`vdbMetaFromRef;
 allTables:raze `vdb`type0`simSearch`numVec`idxParams`partn`vdbPath`emdCol`schema`partCnt`embedding#/:(a;b); 
 if[max(`;::)~\:vdb0;:allTables];
 first select from allTables where vdb=vdb0
 }


.kdbai.getTables:{[vdb].kdbai.getTables0[.kdbai.proc] vdb}

d)fnc qai.kdbai.getTables[] 
 Give a summary of available tables
 q) .kdbai.getTables[]
