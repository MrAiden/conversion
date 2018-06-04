//
//  NSString+ZXXExtension.h
//  ZXXTextDemo
//
//  Created by Mortar on 2018/6/4.
//  Copyright © 2018年 Mortar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZXXExtension)

/// 十进制转二进制
+ (NSString *)getBinaryByDecimal:(NSInteger)decimal;
/// 二进制转十进制
+ (NSInteger)getDecimalByBinary:(NSString *)binary;
/// 十六进制转十进制
+ (NSInteger)getDecimalByHex:(NSString *)hex;
/// 十进制转十六进制
+ (NSString *)getHexByDecimal:(NSInteger)decimal;
/// 十六进制转二进制
+ (NSString *)getBinaryByHex:(NSString *)hex;
/// 二进制转十六进制
+ (NSString *)getHexByBinary:(NSString *)binary;

@end
