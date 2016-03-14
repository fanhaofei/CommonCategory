

#import <Foundation/Foundation.h>
#import "JSON.h"
typedef void(^NetworkFetcherCompletionHandle)(NSDictionary *dataDict);
typedef void(^NetworkFetcherErrorHandle)(NSError *error);

typedef enum HttpMethodStyle
{
    POST,
    GET
}HttpMethodStyle;

@interface NetworkUtils : NSObject
@property(nonatomic, copy)NSString *httpMethod;
/**
 *  post,get请求方法
 *
 *  @param url        请求地址
 *  @param param      post请求参数，get为nil
 *  @param completion 请求成功返回数据data
 *  @param failure    请求失败返回错误描述
 */
-(void)requestWithUrl:(NSString*)url
                param:(NSDictionary*)param
     completionHandle:(NetworkFetcherCompletionHandle)completion
        failureHandle:(NetworkFetcherErrorHandle)failure;


+ (id)shareInstance;


@end
