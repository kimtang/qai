args:.Q.def[`name`port!("001_ctable.q";9132);].Q.opt .z.x

/ remove this line when using in production
/ 001_ctable.q:localhost:9132::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9132"; } @[hopen;`:localhost:9132;0];

.import.json:`kdbai

\l qlib.q
.import.require`remote`ollama`kdbai

c0:.kdbai.cvdb[`c0]
 .kdbai.col[`id;"s"]
 .kdbai.col[`tag;"s"]
 .kdbai.col[`text;"C"]
 .kdbai.col0[`embeddings;
 	.kdbai.vectorIndex0[`flat] `dims`metric!(1536;`L2)
 ] .kdbai.c0
c1:.kdbai.cvdb[`c1]
 .kdbai.col[`id;"s"]
 .kdbai.col[`tag;"s"]
 .kdbai.col[`text;"C"]
 .kdbai.col0[`embeddings;
	.kdbai.vectorIndex0[`qFlat] `dims`metric!(1536;`L2)
 ]
 .kdbai.c0
c2:.kdbai.cvdb[`c2]
 .kdbai.col[`id;"C"]
 .kdbai.col[`tag;"C"]
 .kdbai.col[`text;"X"]
 .kdbai.col0[`embeddings;
	.kdbai.vectorIndex0[`ivf] `trainingVectors`metric`nclusters!(1000j;`CS;10j)
 ]
 .kdbai.c0
c3:.kdbai.cvdb[`c3]
 .kdbai.col[`id;"C"]
 .kdbai.col[`tag;"C"]
 .kdbai.col[`text;"X"]
 .kdbai.col0[`embeddings;
 	.kdbai.vectorIndex0[`ivfpq;`trainingVectors`metric`nclusters`nsplits`nbits!(5000j;`L2;50j;8j;8j)]
 ]
 .kdbai.c0
c4:.kdbai.cvdb[`c4]
 .kdbai.col[`id;"C"]
 .kdbai.col[`tag;"C"]
 .kdbai.col[`text;"X"]
 .kdbai.col0[`embeddings;
 	.kdbai.vectorIndex0[`hnsw;`dims`metric`efConstruction`M!(1536j;`IP;8j;8j)]
 ]
 .kdbai.c0
c5:.kdbai.cvdb[`c5]
 .kdbai.col[`id;"C"]
 .kdbai.col[`tag;"C"]
 .kdbai.col[`text;"X"]
 .kdbai.col0[`embeddings;
 	.kdbai.sparseIndex0[`sparse;`k`b!1.25 0.75f]
 ] .kdbai.c0
c6:.kdbai.cvdb[`c6]
 .kdbai.col[`id;"C"]
 .kdbai.col[`tag;"C"]
 .kdbai.col[`text;"X"]
 .kdbai.col0[`denseCol;
 	.kdbai.vectorIndex0[`flat;`dims`metric!(1536;`L2)] 
 ]
 .kdbai.col0[`sparseCol;
 	.kdbai.sparseIndex0[`sparse;`k`b!1.25 0.75f]
 ]
 .kdbai.c0
c7:.kdbai.cvdb[`c7]
 .kdbai.col[`index;"i"]
 .kdbai.col[`sym;"s"]
 .kdbai.col[`time;"p"]
 .kdbai.col0[`price;
 	.kdbai.vectorIndex[`flat;`dims`metric!(1536;`L2)]
 	.kdbai.embedding[`tsc;`dims`on_insert_error!(8j;`reject_all)] 
 	.kdbai.c0
 ]
 .kdbai.c0


.kdbai.getTables[]

.kdbai.vdbInsert[`c0] data:flip `id`vectors!("hello";8 cut 40?1.0)
.kdbai.vdbInsert[`c1] data

/ .kdbai.vdbInsert[`c2] data
/ .kdbai.vdbInsert[`c3] data
.kdbai.vdbInsert[`c4] data
/ .kdbai.vdbInsert[`c5] flip `id`vectors!("hello";8 cut 40?1e)

/ .kdbai.vdbInsert[`c6] data