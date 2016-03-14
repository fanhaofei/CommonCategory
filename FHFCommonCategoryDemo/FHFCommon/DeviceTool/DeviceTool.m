

#import "DeviceTool.h"
#import <UIKit/UIKit.h>
@implementation DeviceTool
+ (int)currentDeviceStyle
{
    
    float Height = [UIScreen mainScreen].bounds.size.height;
    float Width = [UIScreen mainScreen].bounds.size.width;
    //    NSLog(@"%f,,,, %f", Height, Width);
    
    if ([[UIDevice currentDevice].model isEqualToString:@"iPad"]) {
        return iPad;
    }else {
        if (Height == 667) {
            
            return iPhone6;
        }else{
            if (Height == 568&& Width == 320) {
                
                return iPhone5;
            }else{
                if (Height == 480) {
                    
                    return iPhone4;
                }else {
                    if (Height == 736.000000) {
                        
                        return iPhone6p;
                    }
                }
            }
        }

    }
    return iPad;
}

+ (NSString *)currentSystemVersion
{
    return [UIDevice currentDevice].systemVersion;
}

+ (NSString *)currentAPPVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)UUID
{
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString *uuid = (__bridge NSString *)((__bridge CFUUIDRef)((NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString))));
    CFRelease(puuid);
    CFRelease(uuidString);
    return uuid;
}

+ (NSString *)cellularProvider
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *mCarrier = [NSString stringWithFormat:@"%@",[carrier carrierName]];
    return mCarrier;
}

+ (NSString*) getBatteryState {
    UIDevice *device = [UIDevice currentDevice];
    if (device.batteryState == UIDeviceBatteryStateUnknown) {
        return @"UnKnow";
    }else if (device.batteryState == UIDeviceBatteryStateUnplugged){
        return @"Unplugged";//未充电
    }else if (device.batteryState == UIDeviceBatteryStateCharging){
        return @"Charging";//正在充电
    }else if (device.batteryState == UIDeviceBatteryStateFull){
        return @"Full";//满电
    }
    return nil;
}
//获取电量的等级，0.00~1.00
+ (float) getBatteryLevel {
    return [UIDevice currentDevice].batteryLevel;
}


@end
