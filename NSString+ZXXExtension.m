//
//  NSString+ZXXExtension.m
//  ZXXTextDemo
//
//  Created by Mortar on 2018/6/4.
//  Copyright © 2018年 Mortar. All rights reserved.
//

#import "NSString+ZXXExtension.h"

@implementation NSString (ZXXExtension)

/**
 无符号长整型转C字符串
 
 @param num 无符号长整型
 @param base 进制 2~36
 @return C字符串
 */
char *ultostr(unsigned long num, unsigned base) {
    static char string[64] = {'\0'};
    size_t max_chars = 64;
    char remainder;
    int sign = 0;
    if (base < 2 || base > 36) {
        return NULL;
    }
    for (max_chars --; max_chars > sign && num != 0; max_chars --) {
        remainder = (char)(num % base);
        if ( remainder <= 9 ) {
            string[max_chars] = remainder + '0';
        } else {
            string[max_chars] = remainder - 10 + 'A';
        }
        num /= base;
    }
    if (max_chars > 0) {
        memset(string, '\0', max_chars + 1);
    }
    return string + max_chars + 1;
}

/**
 十进制转换为二进制
 
 @param decimal 十进制数
 @return 二进制数
 */
+ (NSString *)getBinaryByDecimal:(NSInteger)decimal {
    char *hexChar = ultostr(decimal, 2);
    NSString *binary = [NSString stringWithUTF8String:hexChar];
    return binary;
}


/**
 二进制转换为十进制
 
 @param binary 二进制数
 @return 十进制数
 */
+ (NSInteger)getDecimalByBinary:(NSString *)binary {
    char *endptr = "";
    NSInteger decimal = strtoul([binary UTF8String], &endptr, 2);
    if (strlen(endptr)) {
        return 0;
    }
    return decimal;
}

/**
 十六进制转换十进制
 
 @param hex 十六进制数
 @return 十进制数
 */
+ (NSInteger)getDecimalByHex:(NSString *)hex {
    char *endptr = "";
    NSInteger decimal = strtoul([hex UTF8String], &endptr, 16);
    if (strlen(endptr)) {
        return 0;
    }
    return decimal;
}

/**
 十进制转换十六进制
 
 @param decimal 十进制数
 @return 十六进制数
 */
+ (NSString *)getHexByDecimal:(NSInteger)decimal {
    char *hexChar = ultostr(decimal, 16);
    NSString *hex = [NSString stringWithUTF8String:hexChar];
    return hex;
}

/**
 十六进制转换为二进制
 
 @param hex 十六进制数
 @return 二进制数
 */
+ (NSString *)getBinaryByHex:(NSString *)hex {
    // 十进制
    NSInteger decimal = [NSString getDecimalByHex:hex];
    // 二进制字符串
    NSString *binary = [NSString getBinaryByDecimal:decimal];
    return binary;
}




/**
 二进制转换成十六进制
 
 @param binary 二进制数
 @return 十六进制数
 */
+ (NSString *)getHexByBinary:(NSString *)binary {
    // 十进制
    NSInteger decimal = [NSString getDecimalByBinary:binary];
    // 十六进制
    NSString *hex = [NSString getHexByDecimal:decimal];
    return hex;
}

@end
