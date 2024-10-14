args:.Q.def[`name`port!("004_temporal_Similarity_Search_Transformed_Demo.q";9035);].Q.opt .z.x

/ remove this line when using in production
/ 004_temporal_Similarity_Search_Transformed_Demo.q:localhost:9035::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9035"; } @[hopen;`:localhost:9035;0];

.import.json:`kdbai

\l qlib.q
.import.require`remote`ollama`kdbai`repository`docker`pykx
pd:.pykx.import`pandas

b)cd C:\edev\work\kdb.ai\src\qlib\kdbai\tutorial
(::)df:pd[`:read_parquet;`$"data/marketTrades1.parquet"]` / quite nice

.kdbai.getVdbMeta[`trade_p]

/ {'partn': False, 'emdCol': ['price'], 'idxParams': [{'name': 'defaultIndexName0', 'type': 'flat', 'metric': 'L2'}], 'embedding': [{'dims': 8, 'type': 'tsc', 'on_insert_error': 'reject_all'}], 'schema': {'c': ['index', 'sym', 'time', 'price'], 't': [b'j', b's', b'p', b'F'], 'a': ['', '', '', '']}, 'vdb': 'trade_p', 'vdbType': 'metaManaged'}


(::)schema:.kdbai.cvdb[`trade]
 .kdbai.col[`index;"j"]
 .kdbai.col[`sym;"s"]
 .kdbai.col[`time;"p"]
 .kdbai.col[`price;`vectorIndex`embedding!(`type`metric!`flat`L2;`dims`type`on_insert_error!(8;`tsc;`reject_all))]  
 .kdbai.embedding[`price;`tss;`type`metric!("f";`L2)]
 .kdbai.c0

(::)schema:.kdbai.cvdb[`trade]
 .kdbai.col[`index;"j"]
 .kdbai.col[`sym;"s"]
 .kdbai.col[`time;"p"]
 .kdbai.col1[`price;"f";
 	.kdbai.vectorIndex[`type`metric!`flat`L2]
 	.kdbai.embedding[`dims`type`on_insert_error!(8;`tsc;`reject_all)]
 	.kdbai.c0
 ]  
 .kdbai.embedding[`price;`tss;`type`metric!("f";`L2)]
 .kdbai.c0

 .kdbai.col0[`price;
 	.kdbai.vectorIndex[`type`metric!`flat`L2]
 	.kdbai.embedding[`dims`type`on_insert_error!(8;`tsc;`reject_all)]
 	.kdbai.c0
 ] 

 .kdbai.col1[`price;"f";
 	.kdbai.vectorIndex[`type`metric!`flat`L2]
 	.kdbai.embedding[`dims`type`on_insert_error!(8;`tsc;`reject_all)]
 	.kdbai.c0
 ] 
