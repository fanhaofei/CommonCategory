
#import "Confirmation.h"

@implementation Confirmation

+(BOOL)confirmationPhone:(NSString*)phone{
    //判断手机号格式
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(17[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:phone];
    if (!isMatch) {
        return NO;
    }
    else{
        return YES;
    }
}

+(BOOL)confirmationEmail:(NSString*)email{
    //判断邮箱格式
    NSString * regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:email];
    if (!isMatch) {
        return NO;
    }
    else{
        return YES;
    }
}

+(BOOL)confirmationPassword:(NSString*)password{
    if (password.length>=6&& password.length <=15) {
        return YES;
    }else if (password.length < 6){
        
        [MBHUDHelper showWarningWithText:@"新密码过短,请重新设置不少于6位密码！"];
        return NO;
    }
    else{
         [MBHUDHelper showWarningWithText:@"新密码过长，请重新设置不多于15位密码！"];
        return NO;
    }

}

+ (BOOL)validateIdentityCard: (NSString *)identityCard{
    //判断身份证号格式
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

@end
