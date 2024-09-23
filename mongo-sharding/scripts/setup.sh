#!/bin/bash
sleep 3
docker compose exec -T configSrv mongosh --port 27019 <<EOF
rs.initiate({_id: "config", configsvr: true, members: [
{_id: 0, host: "configSrv:27019"}
]}) 
EOF
echo "Wait mongos_router..."
sleep 10

docker compose exec -T shard1 mongosh --port 27018 <<EOF
rs.initiate({_id: "shard1", members: [
{_id: 0, host: "shard1:27018"}
]}) 
EOF

docker compose exec -T shard2 mongosh --port 27018 <<EOF
rs.initiate({_id: "shard2", members: [
{_id: 0, host: "shard2:27018"}
]}) 
EOF

docker compose exec -T mongos_router mongosh <<EOF
sh.addShard( "shard1/shard1:27018");
sh.addShard( "shard2/shard2:27018");
sh.enableSharding("somedb");
sh.shardCollection("somedb.helloDoc", { "name" : "hashed" } );
EOF

docker compose exec -T mongos_router mongosh <<EOF
use somedb
for(var i = 0; i < 1000; i++) db.helloDoc.insertOne({age:i, name:"ly"+i})
EOF