

#import "SaveOrLoadUUID.h"
#import "KeychainItemWrapper.h"

@implementation SaveOrLoadUUID


+ (NSString *)loadUUID
{
//    XCZRZQMCQ4.com.meifenqi.app
//
   
//#if TARGET_IPHONE_SIMULATOR
//    //如果虚拟器:
//    return @"000000000000000000";
//    
//#endif
    KeychainItemWrapper *chain = [[KeychainItemWrapper alloc] initWithIdentifier:@"uuid" accessGroup: @"XCZRZQMCQ4.com.meifenqi.app"];//id需要在keychainplist里面设置
    NSString *uuid =[chain objectForKey:(id)kSecValueData];//此处取出的值为空字符串而不是空对象
    //如果对key参数不理解 参考:http://my.oschina.net/w11h22j33/blog/206713
    if ([uuid isEqualToString:@""]) {
        
      //  获取uuid:
        CFUUIDRef puuid = CFUUIDCreate( nil );
        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
        uuid = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
        
        
        //保存钥匙串
        [chain setObject:uuid forKey:(id)kSecValueData];//注意在这必须使用系统给定的关键字，否则会崩溃
        
    }
    

//    NSLog(@"*********************_-----------------保存uuid = %@", uuid);
    return uuid;
}

@end
