# conversion
进制转换
####首先了解系统方法 
```objc
/**
 C字符串转无符号长整型

 @param __str C字符串
 @param __endptr 对类型为 char* 的对象的引用，其值为__str停止转换的下一个字符
 @param __base C字符串的进制 2~36
 @return 无符号长整型
 */
unsigned long  strtoul(const char *__str, char **__endptr, int __base);
```
#### strtoul 栗子
```objc
// 二进制字符串转整型
NSString *binary = @"1101";
char *endpth;
NSUInteger decimal = strtoul([binary UTF8String], &endpth, 2);
NSLog(@"decimal:%li, endpth:%@", decimal, [NSString stringWithUTF8String:endpth]);
输出:
2018-06-04 17:01:44.836182+0800 ZXXTestDemo[30806:2638721] decimal:13, endpth:
```
```objc
// 十六进制字符串转整型
NSString *hex = @"0X1A";
char *endpth;
NSUInteger decimal = strtoul([hex UTF8String], &endpth, 16);
NSLog(@"decimal:%li, endpth:%@", decimal, [NSString stringWithUTF8String:endpth]);
输出:
2018-06-04 17:07:38.029495+0800 ZXXTestDemo[31055:2666063] decimal:26, endpth:
```
```objc
// 字符串有误时, 可以根据 endpth 进行判断
NSString *binary = @"1121";
char *endpth;
NSUInteger decimal = strtoul([binary UTF8String], &endpth, 2);
NSLog(@"decimal:%li, endpth:%@", decimal, [NSString stringWithUTF8String:endpth]);
输出:
2018-06-04 17:08:11.607153+0800 ZXXTestDemo[30940:2653669] decimal:3, endpth:21
```
#### 但是居然没有与 strtoul 对应的 ultostr 方法, so 就自己写了一个类似的方法
```objc
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
```
#### ultostr 栗子
```objc
// 整型转二进制
NSUInteger decimal = 15;
char *binary = ultostr(decimal, 2);
NSLog(@"binary:%@", [NSString stringWithUTF8String:binary ? : "\0"]);
输出:
2018-06-04 17:25:46.674484+0800 ZXXTestDemo[31246:2693033] binary:1111
```
``` objc
NSUInteger decimal = 15;
char *hex = ultostr(decimal, 16);
NSLog(@"hex:%@", [NSString stringWithUTF8String:hex ? : "\0"]);
输出:
2018-06-04 17:28:29.335201+0800 ZXXTestDemo[31318:2700423] hex:F
```
### strtoul:任意进制的字符串可以转整型, ultostr:整型又可以转任意进制字符串, 那么进制间的转换就 so easy
