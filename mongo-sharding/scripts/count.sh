#!/bin/bash
echo 'Число документов в шарде #1:'
docker compose exec -T shard1 mongosh --port 27018 --quiet --eval 'use somedb' --eval 'db.helloDoc.countDocuments()'
echo 'Число документов в шарде #2:'
docker compose exec -T shard2 mongosh --port 27018 --quiet --eval 'use somedb' --eval 'db.helloDoc.countDocuments()'
echo 'Общее число документов через роутер:'
docker compose exec -T mongos_router mongosh --quiet --eval 'use somedb' --eval 'db.helloDoc.countDocuments()'
echo 'Общее число документов через api:'
curl -X 'GET' 'http://localhost:8080/helloDoc/count' -H 'accept: application/json'