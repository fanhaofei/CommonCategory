

#import "MD5.h"

@implementation MD5

+(NSString*)jiami:(NSString*)password
{
//    const char *cStr = [password UTF8String];
//    unsigned char result[CC_MD5_DIGEST_LENGTH];
//    CC_MD5(cStr, (int)strlen(cStr), result);
//    
//    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//             result[0], result[1], result[2], result[3],
//             result[4], result[5], result[6], result[7],
//             result[8], result[9], result[10], result[11],
//             result[12], result[13], result[14], result[15]
//             ] lowercaseString];
    
    const char *cStr = [password UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    // CC_MD5( cStr, strlen(cStr), digest ); 这里的用法明显是错误的，但是不知道为什么依然可以在网络上得以流传。当srcString中包含空字符（\0）时
    CC_MD5( cStr, (int)strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH ];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02X", digest[i]];
    return result;

}

+(NSString *)getSignString:(NSDictionary *)dict
{
    //参数加密
    NSArray *keyArray;
    if (dict == nil) {
        NSLog(@"参数为空!...");
        return nil;
    }else{
        NSComparator cmptr = ^(id obj1, id obj2){
            return [obj1 compare:obj2];
        };
        NSArray *tempArray = [dict allKeys];
        keyArray = [tempArray sortedArrayUsingComparator:cmptr];
        
    }
    
    NSMutableString *signBuffer = [NSMutableString string];
    for (int i = 0; i < keyArray.count; i++) {
        NSString *key = keyArray[i];
        NSString *tempStr = [NSString stringWithFormat:@"%@=%@",key,dict[key]];
        [signBuffer appendString:tempStr];
    }
    
    NSString *signBufferMD5 = [self jiami:signBuffer];
    NSString *sign = [self jiami:[NSString stringWithFormat:@"%@Xo+81y.0AA61j89],f|yu6", signBufferMD5]];
    return sign;
}
@end
