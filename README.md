<h1 align="center"><a href="https://github.com/Json031/ECDHAlgorithmSwift"><img src="https://img.shields.io/badge/swift-5.0-orange?logo=swift" title="Swift version" float=left></a><strong><a href="https://github.com/Json031/ECDHAlgorithmSwift">Click here to go to the Swift version</a></strong></h1>

# ECDHAlgorithmiOS
[![CocoaPods](https://img.shields.io/cocoapods/v/ECDHAlgorithmiOS.svg)](https://cocoapods.org/pods/ECDHAlgorithmiOS)
[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](https://github.com/Json031/ECDHAlgorithmiOS/blob/main/LICENSE)
<br>
一种基于椭圆曲线密码学的OC密钥交换协议算法开源项目。
<br>An open-source project for OC key exchange protocol algorithm based on elliptic curve cryptography.

# Installation 安装:

## CocoaPods
The [ECDHAlgorithmiOS SDK for iOS](https://github.com/Json031/ECDHAlgorithmiOS) is available through [CocoaPods](http://cocoapods.org). If CocoaPods is not installed, install it using the following command. Note that Ruby will also be installed, as it is a dependency of Cocoapods.
   ```bash
   brew install cocoapods
   pod setup
   ```
   ```bash
   $iOSVersion = '11.0'
   
   platform :ios, $iOSVersion
   use_frameworks!
   
   target 'YourProjectName' do
         pod 'ECDHAlgorithmiOS' # Full version with all features
   end
   ```

## 手动安装
将Classes文件夹拽入项目中，导入头文件：#import "ECDHAlgorithmiOS.h"

## ECDH算法

ECDH非对称加密方式交换对称密钥流程：
<br>1️⃣调用方法generateKeys生成密钥对(公钥64字节和私钥32字节)
<br>2️⃣通过蓝牙或http方式，将步骤1️⃣生成的公钥发给对方
<br>3️⃣等待对方蓝牙Notify等方式发送它的公钥过来，调用configThirdPublicKey将对方的公钥和自己的私钥生成share key，对方也通过步骤2️⃣接收到的公钥与其私钥生成share key，两个share key是一样的
<br>4️⃣将共享密钥发送到后端服务器，如果后端服务器验证两者相同，则表示身份验证成功；
<br>可用于双方身份验证及绑定关联；
<br>还可以作为后续通信过程的数据对称加密算法的密钥确保通信数据安全性；

The process of exchanging symmetric keys using ECDH asymmetric encryption method:
<br>1 Call method generateKeys to generate a key pair (64 bytes for public key and 32 bytes for private key).
<br>2 Call the sendPublicKey method to convert step 2 Send the public key to the other party.
<br>3 Wait for the other party to notify and send its public key, call configThirdPublicKey to generate a share key from the other party's public key and its own private key, and the other party also uses step 3 The received public key and its private key generate a share key, and the two share keys are the same.
<br>4 Send the share key to the backend server, and if the backend server verifies that both are the same, it indicates successful authentication.
<br>Can be used for mutual authentication and binding association;
<br>It can also serve as a key for data symmetric encryption algorithms in subsequent communication processes to ensure the security of communication data;

# ECDH asymmetric encryption example:
✳️Param: set compressedPublicKey = false

1️⃣GMEllipticCurveCrypto1 generateKeyPair:
<br>publicKey1: "d4b78cec17668f06ae96943d71049c7f75a620cb50b6facff9bdb09a174f7a808c22f0e51f1b2578e9fd7682be17fb8e07deb6517b68880273baee7fc4d6efdd"
<br>privateKey1: "jCfYOOEE+t2BHvUHjp1O0RObXhND7JLV9BaHGR1XDZE="

2️⃣GMEllipticCurveCrypto2 generateKeyPair:
<br>publicKey2: "79cff9b55e086234c43f5c64a775eb20f39c7dc11bf3b2962677d6019c42af5cf57d6d5007fa7ccc94bddec7b1b8fdbf68e50642de88b7223e40007602290e50"
<br>privateKey2: "ISfGAyQrHKX4ELRoZLls3TqBXVf7yqoahEgj7RMX0Us="

3️⃣generateSharedKeyWithOtherPK
<br>sharedKey1 = GMEllipticCurveCrypto1.sharedSecret(forPublicKey: publicKey2)
<br>sharedKey2 = GMEllipticCurveCrypto2.sharedSecret(forPublicKey: publicKey1)

✅Result: sharedKey1 should equal to sharedKey2
<br>sharedKey1: "2fd727d984828a28ab6a521f53dd2d06c67fbb80104aef8c1369a9e352094424"
<br>sharedKey2: "2fd727d984828a28ab6a521f53dd2d06c67fbb80104aef8c1369a9e352094424"

# Troubleshooting

<details>
  <summary><code>Missing sharedKey，Please obtain the public key from a third party first, and then pass it to the sharedScreetForPublicKey method of GMEllipticCurveCrypto to generate the share key</code></summary>

Need to obtain the public key from a third party first, then go to generateSharedKeyWithOtherPK.

</details>

<br>

# License
This library is licensed under the [MIT License](https://github.com/Json031/ECDHAlgorithmiOS/blob/main/LICENSE).
