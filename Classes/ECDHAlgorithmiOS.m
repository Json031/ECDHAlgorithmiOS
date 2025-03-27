//
//  ECDHAlgorithmiOS.m
//
//  Created by MorganChen on 2025/3/26.
//

#import "ECDHAlgorithmiOS.h"

//Default Settings
#define ECDH_DefaultGMEllipticCurve GMEllipticCurveSecp256r1
#define ECDH_DefaultCompressedPublicKey YES

@interface ECDHAlgorithmiOS()

/// A shared key generated from the public key of another party (server or device) of 64 bytes and its own private key of 32 bytes
@property (nonatomic, strong) NSData * _Nullable sharedKey;


//GME elliptic curve encryption object
@property (nonatomic, strong) GMEllipticCurveCrypto * _Nullable gmellipticCurveCrypto;

@end

@implementation ECDHAlgorithmiOS

+ (instancetype)shareRequest {
    static ECDHAlgorithmiOS *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[ECDHAlgorithmiOS alloc] init];
    });
    return shared;
}

- (void)resetGMEllipticCurveCrypto {
    self.gmellipticCurveCrypto = nil;
}

- (void)setGmellipticCurve:(GMEllipticCurve)gmellipticCurve {
    _gmellipticCurve = gmellipticCurve;
    //GMEllipticCurveSecp256r1
    self.gmellipticCurveCrypto = [GMEllipticCurveCrypto generateKeyPairForCurve:gmellipticCurve];
}

//If false, the public key is 65 bytes, with the first byte being 04. If true, the public key is 32 bytes
- (void)setCompressedPublicKey:(Boolean)compressedPublicKey {
    _compressedPublicKey = compressedPublicKey;
    self.gmellipticCurveCrypto.compressedPublicKey = compressedPublicKey;
}

#pragma mark GMEllipticCurveCrypto
/// generate a key pair (64 bytes for public key and 32 bytes for private key)
/// - Parameters:
///   - gmellipticCurve: GMEllipticCurveSecp256r1
///   - compressedPublicKey: If false, the public key is 65 bytes, with the first byte being 04. If true, the public key is 32 bytes
- (void)generateKeys:(GMEllipticCurve)gmellipticCurve  compressedPublicKey:(Boolean)compressedPublicKey {
    self.gmellipticCurve = gmellipticCurve;
    self.compressedPublicKey = compressedPublicKey;
}

/// Obtain the public key and send it to the other party, the other party can get the share key with this public key
- (NSData *)getPublicKey {
    if (self.gmellipticCurveCrypto == nil) {
        [self generateKeys:ECDH_DefaultGMEllipticCurve compressedPublicKey:ECDH_DefaultCompressedPublicKey];
    }
    return [self.gmellipticCurveCrypto.publicKey subdataWithRange:NSMakeRange(1, self.gmellipticCurveCrypto.publicKey.length - 1)];
}



/// After sending one's own public key to the other party, the other party (server or device) returns the processing of the public key
/// Wait for the other party to notify and send its public key, call configThirdPublicKey to generate a share key by combining the other party's public key with its own private key
/// - Parameter otherPKStr: the other party public key
- (void)generateSharedKeyWithOtherPK:(NSString *)otherPKStr {
    if (self.gmellipticCurveCrypto == nil) {
        [self generateKeys:ECDH_DefaultGMEllipticCurve compressedPublicKey:ECDH_DefaultCompressedPublicKey];
    }
    // attach a 0x04 byte to the first byte of the received public key, call the compressPublicKey method to compress it into a 32-bit public key, and then pass it to the sharedSecretForPublicKey method to obtain the shared key
    Byte bytes[1];
    bytes[0] = 0x04;
    NSMutableData *data = [NSMutableData dataWithBytes:bytes length:1];
    NSData *opkData = [DataTool dataFromHexStr:otherPKStr];
    [data appendData:opkData];
    NSData *compressPublicKey = [self.gmellipticCurveCrypto compressPublicKey:data];
    //Generate a share key by combining the other party's public key with their own private key
    self.sharedKey = [self.gmellipticCurveCrypto sharedSecretForPublicKey:compressPublicKey];
    //send sharedKey to device or server for verification
}

/// A shared key generated from the public key of another party (server or device) of 64 bytes and its own private key of 32 bytes
- (NSData * _Nullable)getSharedKey {
    if (self.gmellipticCurveCrypto == nil) {
        [self generateKeys:GMEllipticCurveSecp256r1 compressedPublicKey:YES];
    }
    if (!self.sharedKey) {
        [NSException raise:@"Missing sharedKey" format:@"Please obtain the public key from a third party first, and then pass it to the sharedScreetForPublicKey method of GMEllipticCurveCrypto to generate the share key"];
    }
    return self.sharedKey;
}

@end
