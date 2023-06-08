gen-bootnode:
	bootnode -genkey boot.key
start-bootnode:
	bootnode -nodekey boot.key -addr :30305
new-account:
	geth --datadir network account new
geth-init:
	rm -rf network/node1/* network/node2/*
	geth --datadir network/node1 init network/genesis.json 
	geth --datadir network/node2 init network/genesis.json 
	cp -r network/keystore network/node1/
	cp -r network/keystore network/node2/
node1:
	geth --datadir network/node1 --networkid 12345 --port 30306 --http --http.port 1111 --allow-insecure-unlock \
	--http.api admin,clique,debug,eth,miner,personal,net,txpool \
	--syncmode full \
	--bootnodes enode://14662755d2d5a3b9d1295a98ed005ffc807dace1c174a22f2a61389ac9e158650b629d8d5d138cbfb0bf024cb6ee2c6322d59c62a9d52e904d985f778f09eff8@127.0.0.1:0?discport=30305
node2:
		geth --datadir network/node2 --networkid 12345 --port 30307 --http --http.port 2222 --allow-insecure-unlock \
	--http.api admin,clique,debug,eth,miner,personal,net,txpool \
	--syncmode full \
	--bootnodes enode://14662755d2d5a3b9d1295a98ed005ffc807dace1c174a22f2a61389ac9e158650b629d8d5d138cbfb0bf024cb6ee2c6322d59c62a9d52e904d985f778f09eff8@127.0.0.1:0?discport=30305 \
	--mine --miner.etherbase 0xB4c82e32F66d2AC07Af183D99D00Ef0a6CAd78E0 --unlock 0xB4c82e32F66d2AC07Af183D99D00Ef0a6CAd78E0 --password miner \
	--authrpc.port 8550