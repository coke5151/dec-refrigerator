# dec-refrigerator
A decentralized refrigerator accounting app.

# Geth

```bash
geth --datadir ./ --http --http.corsdomain "*" --http.port 8545 --http.api "eth,net,web3,personal,clique" --networkid 123456 --port 8000 --nodiscover --ipcdisable --authrpc.port 8551 --allow-insecure-unlock console
```

```bash
geth --datadir ./ --http --http.corsdomain "*" --http.port 8546 --http.api "eth,net,web3,personal,clique" --networkid 123456 --port 8081 --nodiscover --ipcdisable --authrpc.port 8552 --allow-insecure-unlock console
```
