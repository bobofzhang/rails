var zmq = require('zmq'),
    sock = zmq.socket('push');
var socketio = require('socket.io-client'),
    mtgox    = require('mtgox-orderbook')

sock.bindSync('tcp://dockerhost:3001');
console.log('zmq push bound to port 3001');

var sockio = socketio.connect(mtgox.socketio_url)
var obook = mtgox.attach(sockio, 'usd')
console.log('connecting to mtgox')

obook.on('ticker', function(ticker){
  var data = JSON.stringify(ticker)
  console.log(data)
  sock.send(data);
})
