echo --- stat x3 ---
curl http://localhost:8000/stat
curl http://localhost:8000/stat
curl http://localhost:8000/stat
echo
echo --- not-allowed methods ---
curl http://localhost:8000/item/stat -X POST
curl http://localhost:8000/item/key -X POST
curl http://localhost:8000/item/key/action -X GET
echo
echo --- all methods fail, last is BadRequest ---
curl http://localhost:8000/item/key
curl http://localhost:8000/item/key -X DELETE
curl http://localhost:8000/item/key/incr/2 -X POST
curl http://localhost:8000/item/key/reverse -X POST
curl http://localhost:8000/item/key/sort -X POST
curl http://localhost:8000/item/key/dedup -X POST
curl http://localhost:8000/item/key/non-exist-action -X POST
echo
echo --- current stat ---
curl http://localhost:8000/stat
echo
echo --- add 3 elements ---
curl http://localhost:8000/item/key1 -X PUT -L -d '{"data":{"value":"val1"}}'
curl http://localhost:8000/item/key2 -X PUT -L -d '{"data":{"value":"val2"}}'
curl http://localhost:8000/item/key3 -X PUT -L -d '{"data":{"value":"val3"}}'
echo
echo --- get 3rd element and then delete and try it again ---
curl http://localhost:8000/item/key3
curl http://localhost:8000/item/key3 -X DELETE
curl http://localhost:8000/item/key3

echo --- get 1st item, fail to increase, change, fail to increase, change, increase, get ---
curl http://localhost:8000/item/key1
curl http://localhost:8000/item/key1/incr/1 -X POST
curl http://localhost:8000/item/key1 -X PUT -L -d '{"data":{"value":"99"}}'
curl http://localhost:8000/item/key1/incr/abc -X POST
curl http://localhost:8000/item/key1/incr/11 -X POST
curl http://localhost:8000/item/key1
echo
echo --- change 2nd item, get, reverse, show, sort, show, dedup, show ---
curl http://localhost:8000/item/key2 -X PUT -L -d '{"data":{"value":"121213"}}'
curl http://localhost:8000/item/key2
curl http://localhost:8000/item/key2/reverse -X POST
curl http://localhost:8000/item/key2
curl http://localhost:8000/item/key2/sort -X POST
curl http://localhost:8000/item/key2
curl http://localhost:8000/item/key2/dedup -X POST
curl http://localhost:8000/item/key2
echo
echo --- current stat ---
curl http://localhost:8000/stat

