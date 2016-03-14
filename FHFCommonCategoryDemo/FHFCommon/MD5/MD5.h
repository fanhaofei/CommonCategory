

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
@interface MD5 : NSObject
+(NSString*)jiami:(NSString*)password;
+(NSString *)getSignString:(NSDictionary *)dict;
@end
