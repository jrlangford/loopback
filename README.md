# Loopback

A container that is ready to execute node with loopback

## Getting started

A basic setup that uses a mysql container for storage is provided

Run the example server
```
$ ./app start
```

Access the server host
```
$ ./app inspect
```

Stop the example server
```
$ ./app stop
```

Explore the API through `localhost:3000/explorer` in your browser.


The image is available through the docker hub, you can also build it locally with the following command
```
$ ./app build
```
