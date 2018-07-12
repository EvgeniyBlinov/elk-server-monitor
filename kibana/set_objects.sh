#!/bin/bash
#curl \
  #-X POST \
  #-H 'Content-Type: application/json' \
  #-H "kbn-xsrf: true" \
  #'http://localhost:5601/api/saved_objects/search 10' \
  #-d "@savedObjectsApiSearch.json"


curl -X POST \
  -H 'Content-Type: application/json' \
  -H "kbn-xsrf: true" \
  -d '{"attributes":{"title":"logstash-auth-*","timeFieldName":"@timestamp"}}' \
  'http://localhost:5601/api/saved_objects/index-pattern'
