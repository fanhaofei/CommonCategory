

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
typedef enum DeviceStyle
{
    iPhone4,
    iPhone5,
    iPhone6,
    iPhone6p,
    iPad
}DeviceStyle;
@interface DeviceTool : NSObject
//判断手机型号
+ (int)currentDeviceStyle;
//获取当前系统版本号
+ (NSString *)currentSystemVersion;
//获取当前APP版本号
+ (NSString *)currentAPPVersion;
//获取当前系统UUID
+ (NSString *)UUID;
//获取运营商名称
+ (NSString *)cellularProvider;
//获取电池状态和等级  /********************摘录：http://blog.csdn.net/decajes/article/details/41807977
+ (NSString *)getBatteryState;
+ (float)getBatteryLevel;

@end
