args:.Q.def[`name`port!("002_quickstart.q";9033);].Q.opt .z.x

/ remove this line when using in production
/ 002_quickstart.q:localhost:9033::
{ if[not x=0; @[x;"\\\\";()]]; value"\\p 9033"; } @[hopen;`:localhost:9033;0];

.import.json:`kdbai

\l qlib.q
.import.require`remote`ollama`kdbai`repository`docker`pykx

p)from fastembed import TextEmbedding

.textEmbedding.class:.pykx.get`TextEmbedding
.textEmbedding.ctx:.textEmbedding.class[]
.textEmbedding.embed:.textEmbedding.ctx[`:embed;>]

(::)company_data:update company_name:`$company_name from  flip`company_name`company_description!flip 2 cut(
    "Apple"; "A technology company known for its iPhones, MacBooks, and innovative designs";
    "Google"; "A search engine giant that also specializes in advertising, cloud computing, and AI";
    "Brave"; "A privacy-focused search engine and browser.";
    "Perplexity"; "An answer engine that searches the internet and uses a large language model to summarize web data.";
    "Amazon"; "An e-commerce leader that offers a wide range of products and services, including AWS";
    "Microsoft"; "A technology company known for its software products like Windows and Office";
    "Facebook"; "A social media platform that connects people worldwide and owns Instagram and WhatsApp";
    "Tesla"; "An electric vehicle manufacturer known for its innovative and sustainable energy solutions";
    "Rivian"; "An electric vehicle company focusing on adventure-oriented trucks and SUVs";
    "Lucid Motors"; "A company specializing in high-performance electric luxury vehicles";
    "Netflix"; "A streaming service that offers a wide variety of TV shows, movies, and original content";
    "Hulu"; "A streaming platform providing a wide range of TV shows, movies, and original content";
    "Disney+"; "A streaming service offering movies, TV shows, and original content from Disney";
    "Uber"; "A ride-sharing company that also offers food delivery and freight services";
    "Lyft"; "A ride-sharing platform connecting passengers with drivers";
    "Didi"; "A Chinese ride-sharing company offering various transportation services";
    "Airbnb"; "A platform that allows people to rent out their homes or find lodging worldwide";
    "Vrbo"; "A vacation rental online marketplace where homeowners list their properties for short-term rentals";
    "Booking.com"; "An online travel agency offering lodging reservations and other travel products";
    "Spotify"; "A music streaming service offering a wide range of songs, albums, and podcasts";
    "Apple Music"; "A music and video streaming service developed by Apple Inc.";
    "YouTube Music"; "A music streaming service developed by YouTube";
    "Twitter"; "A social media platform for sharing short messages and real-time updates";
    "Instagram"; "A photo and video sharing social networking service";
    "Snapchat"; "A multimedia messaging app known for its disappearing messages";
    "LinkedIn"; "A professional networking platform for job seekers and employers";
    "Slack"; "A collaboration platform for team communication and project management";
    "Microsoft Teams"; "A collaboration platform for team communication and project management";
    "Zoom"; "A video conferencing platform used for virtual meetings and webinars"
    )
(::)embeddings:.pykx.list .textEmbedding.embed `$company_data`company_description

(::)company_data:update embeddings from company_data

.kdbai.getTables `company_data


/ .kdbai.vdbCreate schema:.kdbai.cvdb[`company_data]
/  .kdbai.col[`company_name;"s"]
/  .kdbai.col[`company_description;"C"] 
/  .kdbai.embedding[`embeddings;`flat;`dims`metric!(384;`CS)]
/  .kdbai.c0

.kdbai.vdbInsert[`company_data]company_data

.kdbai.query[`company_data]()!()
.kdbai.query[`company_data](1#`filter)!enlist(like; "company_name"; "A*")

(::)query_vector:.pykx.list .textEmbedding.embed `$"A company that helps facilitate meetings"

query = "A company that helps facilitate meetings"

.kdbai.vdbSearch[`company_data;query_vector;1]()!()
.kdbai.vdbSearch[`company_data;query_vector;3]()!()
.kdbai.vdbSearch[`company_data;query_vector;3] (1#`filter)!enlist enlist(<>; "company_name"; "Booking.com")


(::)query_vector:.pykx.list .textEmbedding.embed `$"A company that helps facilitate meetings"

(::)queries: .pykx.list .textEmbedding.embed `$( "A company with a music-related product";"A social media company")


.kdbai.vdbSearch[`company_data;queries;3] ()!()
.kdbai.vdbSearch[`company_data;queries;3] (1#`agg)!enlist `company_name

