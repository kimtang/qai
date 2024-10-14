args:.Q.def[`name`port!("999_ctable.q";9032);].Q.opt .z.x

/ remove this line when using in production
/ 999_ctable.q:localhost:9032::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9032"; } @[hopen;`:localhost:9032;0];

.import.json:`kdbai

\l qlib.q
.import.require`remote`ollama`kdbai


q)c0:.kdbai.cvdb[`c0]
q) .kdbai.col[`id;"s"]
q) .kdbai.col[`tag;"s"]
q) .kdbai.col[`text;"C"]
q) .kdbai.col0[`embeddings;
q) 	.kdbai.vectorIndex0[`flat] `dims`metric!(1536;`L2)
q) ] .kdbai.c0
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
q) 	.kdbai.sparseIndex0[`sparse;`k`b!1.25 0.75f]
q) ] .kdbai.c0
q)c6:.kdbai.cvdb[`c6]
q) .kdbai.col[`id;"C"]
q) .kdbai.col[`tag;"C"]
q) .kdbai.col[`text;"X"]
q) .kdbai.col0[`denseCol;
q) 	.kdbai.vectorIndex0[`flat;`dims`metric!(1536;`L2)] 
q) ]
q) .kdbai.col0[`sparseCol;
q) 	.kdbai.sparseIndex0[`sparse;`k`b!1.25 0.75f]
q) ]
q) .kdbai.c0
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


.kdbai.vdbCreate c6

(::)a:get `:../data/a
(::)b:get `:../data/b

a 5
b 5
c5

b) ls C:\edev\work\kdb.ai\vdbdata