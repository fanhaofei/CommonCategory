

#import <Foundation/Foundation.h>

@interface Confirmation : NSObject
//验证手机号是否合法
+(BOOL)confirmationPhone:(NSString*)phone;
//验证邮件是否合法
+(BOOL)confirmationEmail:(NSString*)email;
//验证密码是否合法
+(BOOL)confirmationPassword:(NSString*)password;
//验证身份证是否合法
+ (BOOL)validateIdentityCard: (NSString *)identityCard;

@end
