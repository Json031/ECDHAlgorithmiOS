//
//  DataTool.m
//
//  Created by MorganChen on 2025/3/26.
//

#import "DataTool.h"

@implementation DataTool

/// convert hexStr to data
/// - Parameter hexStr: hexStr
+ (NSData *)dataFromHexStr:(NSString *)hexStr {
    if (!hexStr || [hexStr length] == 0) {
        return nil;
    }
    
    NSMutableData *data = [NSMutableData dataWithCapacity:[hexStr length] / 2];
    NSUInteger index = 0;
    NSUInteger length = [hexStr length];
    BOOL isOddLength = (length % 2) != 0;
    
    while (index < length) {
        NSRange range = NSMakeRange(index, 2);
        NSString *hexString = [hexStr substringWithRange:range];
        if (range.length > [hexStr length] - index) {
            // Handle case where string length is odd
            hexString = [hexStr substringWithRange:NSMakeRange(index, 1)];
            hexString = [NSString stringWithFormat:@"0%@", hexString]; // Pad with leading zero
        }
        
        unsigned int wholeNumber;
        NSScanner *scanner = [NSScanner scannerWithString:hexString];
        BOOL success = [scanner scanHexInt:&wholeNumber];
        if (!success) {
            // Handle error, e.g., return nil or log an error
            return nil;
        }
        
        uint8_t byte = (uint8_t)wholeNumber;
        [data appendBytes:&byte length:1];
        
        index += 2;
    }
    
    return data;
}

@end
