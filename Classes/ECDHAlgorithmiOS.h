//
//  ECDHAlgorithmiOS.h
//
//  Created by MorganChen on 2025/3/26.
//

#import <Foundation/Foundation.h>
#import "GMEllipticCurveCrypto.h"
#import "DataTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface ECDHAlgorithmiOS : NSObject


//GME elliptic curve encryption object
@property (nonatomic, strong) GMEllipticCurveCrypto * _Nullable gmellipticCurveCrypto;

+ (instancetype)shareRequest;
#pragma mark GMEllipticCurveCrypto
/// generate a key pair (64 bytes for public key and 32 bytes for private key)
/// - Parameters:
///   - gmellipticCurve: GMEllipticCurveSecp256r1
///   - compressedPublicKey: If false, the public key is 65 bytes, with the first byte being 04. If true, the public key is 32 bytes
- (void)generateKeys:(GMEllipticCurve *)gmellipticCurve  compressedPublicKey:(Boolean)compressedPublicKey;

/// Obtain the public key and send it to the other party, the other party can get the share key with this public key
- (NSData *)getPublicKey;

/// After sending one's own public key to the other party, the other party (server or device) returns the processing of the public key
/// Wait for the other party to notify and send its public key, call configThirdPublicKey to generate a share key by combining the other party's public key with its own private key
/// - Parameter otherPKStr: the other party public key
- (void)generateSharedKeyWithOtherPK:(NSString *)otherPKStr;

/// A shared key generated from the public key of another party (server or device) of 64 bytes and its own private key of 32 bytes
- (NSData * _Nullable)sharedKey;
@end

NS_ASSUME_NONNULL_END
