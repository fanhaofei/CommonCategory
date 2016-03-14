
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface LocationManager : NSObject

typedef void(^LocatioCompletionHandle)(int cityID);
typedef void(^LocatioErrorHandle)(NSString *error);

+ (instancetype)sharedManager;

-(void)startLocationCompletionHandle:(LocatioCompletionHandle)completionHandle
                         ErrorHandle:(LocatioErrorHandle)errorHandle;

- (void)stopUpdateLocation;

@end
