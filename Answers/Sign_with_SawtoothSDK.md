```
BOYCOTT on russia! Don't buy, sell, support - HELP TO STOP WAR!
«Русский военный корабль, иди на хуй!» (c) Grybov, Ukrainian Frontier Guard

ATTENTION: By using this you agree do not repost any part of this code
           on StackOverflow site. Thanks, Asperi.
```

Q: trying to sign signature as well as verify using Sawtooth SDK from Sawtooth SDK but crash

A: It is cycled `Secp256k1` constructor (ie. it calls `Secp256k1()` within own `init`), that results in crash.

Here is possible variant of solution (tested & works with Xcode 11.4):

    public class Secp256k1 {
    
        private var signer: Signer
        private var privateKey: PrivateKey
        private static var context = Secp256k1Context()          // << shared !!
    
        public func sign(message: [UInt8]) -> String {
            var result = ""
            do {
                result = try signer.sign(data: message)
            } catch {
                print("Error signing")
            }
            return result
        }
    
        public static func getPrivateKey() -> PrivateKey {        // << shared !!
            if let privateKey = UserDefaults.standard.string(forKey: "privateKey") {
                return Secp256k1PrivateKey.fromHex(hexPrivKey: privateKey)
            } else {
                let privateKey = context.newRandomPrivateKey()
                UserDefaults.standard.set(privateKey.hex(), forKey: "privateKey" )
                do {
                    let pubKey = try context.getPublicKey(privateKey: privateKey)
                    UserDefaults.standard.set(pubKey.hex(), forKey: "publicKey" )
                } catch {
                    if #available(iOS 10.0, *) {
                        print("Error creating public key")
                    }
                }
                return privateKey
            }
        }
    
        public init() {
            self.privateKey = Secp256k1.getPrivateKey()       // no cycle now !!
            self.signer = Signer(context: Secp256k1.context, privateKey: self.privateKey)
        }
    }

