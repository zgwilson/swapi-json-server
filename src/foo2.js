const Libp2p = require('libp2p')
const TCP = require('libp2p-tcp')
const { NOISE } = require('libp2p-noise')
const MPLEX = require('libp2p-mplex')
const process = require('process')
const { multiaddr } = require('multiaddr')
const Gossipsub = require('libp2p-gossipsub')
const Bootstrap = require('libp2p-bootstrap')
const bootstrapers = require('./bootstrapers')
const MulticastDNS = require('libp2p-mdns')
const { fromString: uint8ArrayFromString } = require('uint8arrays/from-string')
const { toString: uint8ArrayToString } = require('uint8arrays/to-string')

;(async () => {
  const node = await Libp2p.create({
    addresses: {
      listen: ['/ip4/0.0.0.0/tcp/0']
    },
    modules: {
      transport: [TCP],
      streamMuxer: [MPLEX],
      connEncryption: [NOISE],
      peerDiscovery: [MulticastDNS],
      pubsub: Gossipsub
    },
    config: {
      peerDiscovery: {
        mdns: {
          interval: 60e3,
          enabled: true
        }
      },
      pubsub: {
        enabled: true,
        emitSelf: true
      }
    }
  })

  node.connectionManager.on('peer:connect', (connection) => {
    console.log('Connection established to:', connection.remotePeer.toB58String())	// Emitted when a peer has been found
  })

  node.on('peer:discovery', (peerId) => {
    // No need to dial, autoDial is on
    console.log('Discovered:', peerId.toB58String())
  })



  
  console.log('My Node ID: ', node.peerId.toB58String())
//  console.log(node)

  await node.start()

  // now the node has started we can do our pubsub stuff

  const topic = 'news'
  node.pubsub.subscribe(topic)
  console.log('pubsub subscribe')

  node.pubsub.on(topic, (msg) => {
    console.log(`received: `, msg)
    console.log(`received data: ${uint8ArrayToString(msg.data)}`)
    console.log(`foo ${msg.from}`)
  })

})();
