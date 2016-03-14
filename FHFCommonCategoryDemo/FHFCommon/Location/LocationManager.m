

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import "JSON.h"
#import "Global.h"

@interface LocationManager ()<CLLocationManagerDelegate>

@property (nonatomic,strong)LocatioCompletionHandle completionHandle;
@property (nonatomic,strong)LocatioErrorHandle errorHandle;
@property (nonatomic,strong)CLLocationManager *locationManager;
//是否定位成功
@property (nonatomic, assign) BOOL isLocation;
@end

@implementation LocationManager

-(CLLocationManager*)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _isLocation = NO;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        if (IOS_VERSION_8_OR_ABOVE) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    return _locationManager;
}

static LocationManager *sharedManager;

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[LocationManager alloc] init];
        
    });
    
    
    return sharedManager;
}

-(void)startLocationCompletionHandle:(LocatioCompletionHandle)completionHandle
                         ErrorHandle:(LocatioErrorHandle)errorHandle{
    self.completionHandle = completionHandle;
    self.errorHandle = errorHandle;
//    if (TARGET_IPHONE_SIMULATOR) {
////        self.errorHandle(@"请使用真机调试");
//        
//        [self.locationManager startUpdatingLocation];
//    }
//    else{
//        if ([CLLocationManager locationServicesEnabled]) {
//            // 开始定位
//            if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
////                self.errorHandle(@"请前往\"设置-隐私-定位\"开启本软件的定位服务");
//            }
//            else{
//                [self.locationManager startUpdatingLocation];
//            }
//        }
//        else{
////            self.errorHandle(@"请前往\"设置-隐私-定位\"开启定位服务");
//        }
//    }
    [self.locationManager startUpdatingLocation];
    
}

- (void)stopUpdateLocation
{
    [self.locationManager stopUpdatingLocation];
}

#pragma  mark - CLLocationManager delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    if (_isLocation) {
        //停止重复定位
        return;
    }
    _isLocation = YES;
    //获取经纬度
    [self.locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
   
    
    //反向解析城市名称
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemark,NSError *error)
     {
         
         
         if (error==nil) {
             CLPlacemark *mark=[placemark objectAtIndex:0];
             NSString *city = mark.locality;
             
             if (!city) {
                 
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 
                 city = mark.administrativeArea;
                 
             }
             
//            NSLog(@"%f,%f",currentLocation.coordinate.longitude,currentLocation.coordinate.latitude);
             NSLog(@"当前城市:%@", city);
             self.completionHandle([self creatCityIDWithcity:city]);
         }
         else{
             NSLog(@"解析城市名称失败");
             self.errorHandle(@"定位失败，点击重新定位");
         }
     }];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    self.errorHandle(@"定位失败，点击重新定位");
}


- (int)creatCityIDWithcity:(NSString *)city
{
    return [self cityIDFromName:city];
}

- (int)cityIDFromName:(NSString *)name
{
    
//    [Global sharedInstance].cityIDArray;
//    [Global sharedInstance].cityNameArray;
    
    for (int i = 0; i < [Global sharedInstance].cityIDArray.count; i++) {
        if ([name containsString:[Global sharedInstance].cityNameArray[i]]) {
            return [[Global sharedInstance].cityIDArray[i] intValue];
        }
    }
    return 0;
//    if ([name rangeOfString:@"北京"].location != NSNotFound) {
//        return 1;
//    }else if ([name rangeOfString:@"上海"].location != NSNotFound) {
//        return 3;
//    } else if ([name rangeOfString:@"成都"].location != NSNotFound) {
//        return 225;
//    }else if ([name rangeOfString:@"重庆"].location != NSNotFound) {
//        return 4;
//    }else if ([name rangeOfString:@"三亚"].location != NSNotFound) {
//        return 256;
//    }else {
//        return 0;
//    }
    
}

@end

