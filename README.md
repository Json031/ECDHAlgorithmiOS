<h1 align="center"><a href="https://github.com/Json031/ECDHAlgorithmSwift"><img src="https://img.shields.io/badge/swift-5.0-orange?logo=swift" title="Swift version" float=left></a><strong><a href="https://github.com/Json031/ECDHAlgorithmSwift">Click here to go to the Swift version</a></strong></h1>

# ECDHAlgorithmiOS
<a name="top"></a>

[![CocoaPods](https://img.shields.io/cocoapods/v/ECDHAlgorithmiOS.svg)](https://cocoapods.org/pods/ECDHAlgorithmiOS)
[![License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](https://github.com/Json031/ECDHAlgorithmiOS/blob/main/LICENSE)

---

## 🌍 Language / 语言选择

**[English](#english)** | **[中文](#中文)**

---

## 📖 English
<a name="english"></a>

### Overview

An open-source project for Objective-C key exchange protocol algorithm based on elliptic curve cryptography (ECDH).

### Installation

#### CocoaPods

The [ECDHAlgorithmiOS SDK for iOS](https://github.com/Json031/ECDHAlgorithmiOS) is available through [CocoaPods](http://cocoapods.org). 

**First, install CocoaPods if you haven't already:**

```bash
brew install cocoapods
pod setup
```

**Add to your Podfile:**

```ruby
$iOSVersion = '11.0'

platform :ios, $iOSVersion
use_frameworks!

target 'YourProjectName' do
   pod 'ECDHAlgorithmiOS' # Full version with all features
end
```

#### Manual Installation

Drag the `Classes` folder into your project and import the header file:

```objective-c
#import "ECDHAlgorithmiOS.h"
```

### ECDH Algorithm

**Process of exchanging symmetric keys using ECDH asymmetric encryption:**

**Step 1:** Call the `generateKeys` method to generate a key pair (64 bytes for public key and 32 bytes for private key).

**Step 2:** Send the generated public key to the other party via Bluetooth or HTTP.

**Step 3:** Wait for the other party to send their public key (e.g., via Bluetooth Notify). Call `configThirdPublicKey` to generate a shared key using the other party's public key and your own private key. The other party will also generate a shared key using your public key and their private key. Based on the commutative property of elliptic curve point multiplication, these two shared keys will be identical.

**Step 4:** Send the shared key to the backend server. If the backend server verifies that both keys are the same, authentication is successful.

**Use Cases:**
- Mutual authentication and binding association between parties
- As a key for symmetric encryption algorithms in subsequent communication processes
- Based on the difficulty of the elliptic curve discrete logarithm problem, making it difficult for attackers to obtain the shared key from public communication information, ensuring data security

### ECDH Asymmetric Encryption Example

**Parameter:** Set `compressedPublicKey = false`

#### 1️⃣ GMEllipticCurveCrypto1 generateKeyPair:

```
publicKey1: "d4b78cec17668f06ae96943d71049c7f75a620cb50b6facff9bdb09a174f7a808c22f0e51f1b2578e9fd7682be17fb8e07deb6517b68880273baee7fc4d6efdd"
privateKey1: "jCfYOOEE+t2BHvUHjp1O0RObXhND7JLV9BaHGR1XDZE="
```

#### 2️⃣ GMEllipticCurveCrypto2 generateKeyPair:

```
publicKey2: "79cff9b55e086234c43f5c64a775eb20f39c7dc11bf3b2962677d6019c42af5cf57d6d5007fa7ccc94bddec7b1b8fdbf68e50642de88b7223e40007602290e50"
privateKey2: "ISfGAyQrHKX4ELRoZLls3TqBXVf7yqoahEgj7RMX0Us="
```

#### 3️⃣ generateSharedKeyWithOtherPK

```objective-c
sharedKey1 = GMEllipticCurveCrypto1.sharedSecret(forPublicKey: publicKey2)
sharedKey2 = GMEllipticCurveCrypto2.sharedSecret(forPublicKey: publicKey1)
```

#### ✅ Result: sharedKey1 should equal sharedKey2

```
sharedKey1: "2fd727d984828a28ab6a521f53dd2d06c67fbb80104aef8c1369a9e352094424"
sharedKey2: "2fd727d984828a28ab6a521f53dd2d06c67fbb80104aef8c1369a9e352094424"
```

### Troubleshooting

<details>
  <summary><code>Missing sharedKey，Please obtain the public key from a third party first, and then pass it to the sharedScreetForPublicKey method of GMEllipticCurveCrypto to generate the share key</code></summary>

Need to obtain the public key from a third party first, then go to `generateSharedKeyWithOtherPK`.

</details>

### License

This library is licensed under the [MIT License](https://github.com/Json031/ECDHAlgorithmiOS/blob/main/LICENSE).

---

## 📖 中文
<a name="中文"></a>

### 项目简介

一种基于椭圆曲线密码学的 Objective-C 密钥交换协议算法开源项目。

### 安装

#### CocoaPods

[ECDHAlgorithmiOS SDK for iOS](https://github.com/Json031/ECDHAlgorithmiOS) 可通过 [CocoaPods](http://cocoapods.org) 安装。

**首先，如果您还没有安装 CocoaPods，请先安装：**

```bash
brew install cocoapods
pod setup
```

**在 Podfile 中添加：**

```ruby
$iOSVersion = '11.0'

platform :ios, $iOSVersion
use_frameworks!

target 'YourProjectName' do
   pod 'ECDHAlgorithmiOS' # 包含所有功能的完整版本
end
```

#### 手动安装

将 `Classes` 文件夹拽入项目中，导入头文件：

```objective-c
#import "ECDHAlgorithmiOS.h"
```

### ECDH 算法

**ECDH 非对称加密方式交换对称密钥流程：**

**步骤 1：** 调用方法 `generateKeys` 生成密钥对（公钥 64 字节和私钥 32 字节）

**步骤 2：** 通过蓝牙或 HTTP 方式，将步骤 1 生成的公钥发给对方

**步骤 3：** 等待对方蓝牙 Notify 等方式发送它的公钥过来，调用 `configThirdPublicKey` 将对方的公钥和自己的私钥生成共享密钥（share key），对方也通过步骤 2 接收到的公钥与其私钥生成共享密钥，根据椭圆曲线点乘的交换性原理这两个共享密钥是一样的

**步骤 4：** 将共享密钥发送到后端服务器，如果后端服务器验证两者相同，则表示身份验证成功

**应用场景：**
- 可用于双方身份验证及绑定关联
- 还可以作为后续通信过程的数据对称加密算法的密钥
- 基于椭圆曲线离散对数问题的困难性，使得攻击者难以从公开的通信信息中获取共享密钥，确保了通信数据安全性

### ECDH 非对称加密示例

**参数：** 设置 `compressedPublicKey = false`

#### 1️⃣ GMEllipticCurveCrypto1 生成密钥对：

```
publicKey1: "d4b78cec17668f06ae96943d71049c7f75a620cb50b6facff9bdb09a174f7a808c22f0e51f1b2578e9fd7682be17fb8e07deb6517b68880273baee7fc4d6efdd"
privateKey1: "jCfYOOEE+t2BHvUHjp1O0RObXhND7JLV9BaHGR1XDZE="
```

#### 2️⃣ GMEllipticCurveCrypto2 生成密钥对：

```
publicKey2: "79cff9b55e086234c43f5c64a775eb20f39c7dc11bf3b2962677d6019c42af5cf57d6d5007fa7ccc94bddec7b1b8fdbf68e50642de88b7223e40007602290e50"
privateKey2: "ISfGAyQrHKX4ELRoZLls3TqBXVf7yqoahEgj7RMX0Us="
```

#### 3️⃣ 生成共享密钥 generateSharedKeyWithOtherPK

```objective-c
sharedKey1 = GMEllipticCurveCrypto1.sharedSecret(forPublicKey: publicKey2)
sharedKey2 = GMEllipticCurveCrypto2.sharedSecret(forPublicKey: publicKey1)
```

#### ✅ 结果：sharedKey1 应该等于 sharedKey2

```
sharedKey1: "2fd727d984828a28ab6a521f53dd2d06c67fbb80104aef8c1369a9e352094424"
sharedKey2: "2fd727d984828a28ab6a521f53dd2d06c67fbb80104aef8c1369a9e352094424"
```

### 故障排除

<details>
  <summary><code>缺少 sharedKey，请先从第三方获取公钥，然后将其传递给 GMEllipticCurveCrypto 的 sharedScreetForPublicKey 方法以生成共享密钥</code></summary>

需要先从第三方获取公钥，然后再执行 `generateSharedKeyWithOtherPK`。

</details>

### 许可证

本项目基于 [MIT License](https://github.com/Json031/ECDHAlgorithmiOS/blob/main/LICENSE) 开源协议。

---

**[⬆ Back to Top / 返回顶部](#top)**
