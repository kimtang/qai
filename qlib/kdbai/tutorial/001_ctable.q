args:.Q.def[`name`port!("001_ctable.q";9032);].Q.opt .z.x

/ remove this line when using in production
/ 001_ctable.q:localhost:9032::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9032"; } @[hopen;`:localhost:9032;0];

.import.json:`kdbai

\l qlib.q
.import.require`remote`ollama`kdbai

.kdbai.vdbCreate c0:.kdbai.cvdb[`c0]
 .kdbai.col[`id;"c"]
 .kdbai.embedding[`vectors;`flat;`dims`metric!(8;`L2)]
 .kdbai.c0

.kdbai.vdbCreate c1:.kdbai.cvdb[`c1]
 .kdbai.col[`id;"c"]
 .kdbai.embedding[`vectors;`qFlat;`dims`metric!(8;`L2)]
 .kdbai.c0

.kdbai.vdbCreate c2:.kdbai.cvdb[`c2]
 .kdbai.col[`id;"c"]
 .kdbai.embedding[`vectors;`ivf;`trainingVectors`metric`nclusters!(8;`CS;8)]
 .kdbai.c0

.kdbai.vdbCreate c3:.kdbai.cvdb[`c3]
 .kdbai.col[`id;"c"]
 .kdbai.embedding[`vectors;`ivfpq;`trainingVectors`metric`nclusters`nsplits`nbits!(4;`L2;8;4j;4j)]
 .kdbai.c0

.kdbai.vdbCreate c4:.kdbai.cvdb[`c4]
 .kdbai.col[`id;"c"]
 .kdbai.embedding[`vectors;`hnsw;`dims`metric`efConstruction`M!(8j;`IP;8j;8j)]
 .kdbai.c0

.kdbai.vdbCreate c5:.kdbai.cvdb[`c5]
 .kdbai.col[`id;"c"]
 .kdbai.embedding[`vectors;`sparse;`k`b!1.25 0.75f]
 .kdbai.c0

.kdbai.vdbCreate c6:.kdbai.cvdb[`c6]
 .kdbai.col[`id;"c"]
 .kdbai.embedding[`denseCol;`flat;`dims`metric!(8;`L2)] 
 .kdbai.embedding[`sparseCol;`sparse;`k`b!1.25 0.75f]
 .kdbai.c0


.kdbai.getTables[]

.kdbai.vdbInsert[`c0] data:flip `id`vectors!("hello";8 cut 40?1.0)
.kdbai.vdbInsert[`c1] data

/ .kdbai.vdbInsert[`c2] data
/ .kdbai.vdbInsert[`c3] data
.kdbai.vdbInsert[`c4] data
/ .kdbai.vdbInsert[`c5] flip `id`vectors!("hello";8 cut 40?1e)

/ .kdbai.vdbInsert[`c6] data