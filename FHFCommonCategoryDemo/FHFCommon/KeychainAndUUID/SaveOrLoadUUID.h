

//钥匙串需要进行功能申请： TARGETS->Capabilities->Keychain Sharing
/**********************具体请看：http://blog.csdn.net/fanhaofei1234/article/details/50592708************************/

#import <Foundation/Foundation.h>

@interface SaveOrLoadUUID : NSObject


+ (NSString *)loadUUID;
@end
