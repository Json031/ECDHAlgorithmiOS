//
//  DataTool.h
//
//  Created by MorganChen on 2025/3/26.
//


@interface DataTool : NSObject

/// convert hexStr to data
/// - Parameter hexStr: hexStr
+ (NSData *)dataFromHexStr:(NSString *)hexStr;

@end
