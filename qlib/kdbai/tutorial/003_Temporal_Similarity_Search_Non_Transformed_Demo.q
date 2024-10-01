args:.Q.def[`name`port!("003_Temporal_Similarity_Search_Non_Transformed_Demo.bat.q";9034);].Q.opt .z.x

/ remove this line when using in production
/ 003_Temporal_Similarity_Search_Non_Transformed_Demo.bat.q:localhost:9034::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9034"; } @[hopen;`:localhost:9034;0];

.import.json:`kdbai

\l qlib.q
.import.require`remote`ollama`kdbai`repository`docker`pykx

b)cd C:\edev\work\kdb.ai\src\qlib\kdbai\tutorial
b)mkdir data
b)wget -P ./data https://raw.githubusercontent.com/KxSystems/kdbai-samples/main/TSS_non_transformed/data/marketTrades.parquet

pd:.pykx.import`pandas

(::)df:pd[`:read_parquet;`$"data/marketTrades.parquet"]`

.kdbai.vdbCreate schema:.kdbai.cvdb[`trade_tss]
 .kdbai.col[`index;"j"]
 .kdbai.col[`time;"p"] 
 .kdbai.col[`sym;"s"]
 .kdbai.col[`qty;"j"]
 .kdbai.embedding[`price;`tss;`type`metric!("f";`L2)]
 .kdbai.c0

.kdbai.vdbInsert[`trade_tss] df
.kdbai.vdbSearch[`trade_tss;;10;()!()] vec:1000#exec price from df where sym=`BBB
.kdbai.vdbSearch[`trade_tss;;10;()!()] vec0:(2*-1+1000?2.0) + vec
.kdbai.vdbSearch[`trade_tss;;-10;()!()] vec0


