

#import "NetworkUtils.h"
#import "CommonCrypto/CommonDigest.h"
@interface NetworkUtils()

@property (nonatomic,copy) NetworkFetcherCompletionHandle networkFetcherCompletionHandle;
@property (nonatomic,copy) NetworkFetcherErrorHandle networkFetcherErrorHandle;
@end

@implementation NetworkUtils
static NetworkUtils *sharedInstance;
+ (id)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkUtils alloc] init];
    });
    
    return sharedInstance;
}



-(void)requestWithUrl:(NSString*)url
                param:(NSDictionary*)param
     completionHandle:(NetworkFetcherCompletionHandle)completion
        failureHandle:(NetworkFetcherErrorHandle)failure
{
    
    self.networkFetcherCompletionHandle = completion;
    self.networkFetcherErrorHandle = failure;
    

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    request.timeoutInterval = 20;
    //自定义时间超时
//    _timer = nil;
//    _timer = [NSTimer scheduledTimerWithTimeInterval:30.0
//                                     target: self
//                                   selector: @selector(handleTimer)
//                                   userInfo:nil
//                                    repeats:NO];
    if ([self.httpMethod == POST){
        NSMutableDictionary *mDict = [self makeSignWithDict:param];
        [request setHTTPMethod:@"POST"];
        if (mDict != nil) {
            NSData *data=[NSJSONSerialization dataWithJSONObject:mDict options:NSJSONWritingPrettyPrinted error:nil];
            NSMutableData *mData = [NSMutableData dataWithData:data];
            [request setHTTPBody:mData];
        }
       
    }else{
        [request setHTTPMethod:@"GET"];
        NSString *urlStr = [self appendUrlWithDict:param andUrlStr:url];
        request.URL = [NSURL URLWithString:urlStr];
    }
    
    NSLog(@"net: %@",request.URL.absoluteString);
    NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:defaultConfiguration];
    //nsurlSessionDataTask默认是在异步线程中，刷新界面时需要跳回主线程
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        NSLog(@"json =======  %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        //定时器取消
        [_timer invalidate];
//        如果有错误，直接返回
        if (error != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
               
            self.networkFetcherErrorHandle(error);
                
            });
            return;
        }
        //进入主线程刷新界面
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dataDict =[[JSON objectFromJSONString:data] mutableCopy];
            self.networkFetcherCompletionHandle(dataDict);
        });
       
    }];
    [dataTask resume];
    


    
}



- (NSMutableDictionary *)makeSignWithDict:(NSDictionary *)dict
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
    
    NSString *signBufferMD5 = [self md5ForString:signBuffer];
    NSString *md5KeyString = @"";//与后台商议。
    NSString *sign = [self md5ForString:[NSString stringWithFormat:@"%@%@", signBufferMD5, md5KeyString]];
    
    NSMutableDictionary *mDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    [mDict setObject:sign forKey:@"sign"];
    
    
    //    NSData *data=[NSJSONSerialization dataWithJSONObject:mDict options:NSJSONWritingPrettyPrinted error:nil];
    //    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
    return mDict;
    
}

- (NSString *)md5ForString:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    // CC_MD5( cStr, strlen(cStr), digest ); 这里的用法明显是错误的，但是不知道为什么依然可以在网络上得以流传。当srcString中包含空字符（\0）时
    CC_MD5( cStr, (int)strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH ];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02X", digest[i]];
    
    return result;
}

- (NSString *)appendUrlWithDict:(NSDictionary *)dict andUrlStr:(NSString *)url
{
    //参数加密
    NSArray *keyArray;
    if (dict == nil) {
        NSLog(@"参数为空!...");
        return url;
    }else{
        NSComparator cmptr = ^(id obj1, id obj2){
            return [obj1 compare:obj2];
        };
        NSArray *tempArray = [dict allKeys];
        keyArray = [tempArray sortedArrayUsingComparator:cmptr];
        NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@?",url];
        for (int i = 0; i < keyArray.count; i++) {
            NSString *key = keyArray[i];
            NSString *tempStr;
            if (i == 0) {
                tempStr = [NSString stringWithFormat:@"%@=%@",key,dict[key]];
                
            }else{
                tempStr = [NSString stringWithFormat:@"&%@=%@",key,dict[key]];
            }
            [urlStr appendString:tempStr];
        }
        return urlStr;
    }
   
}

@end
