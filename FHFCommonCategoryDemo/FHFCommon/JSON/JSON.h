

#import <Foundation/Foundation.h>

@interface JSON : NSObject

/**
 *  object转化为json字符串
 *
 *  @param object 待转化的object
 *
 *  @return json字符串
 */
+ (NSString *)JSONStringFromObject:(id)object;

/**
 *  json字符串转化为object
 *
 *  @param jsonString 待转化的json字符串
 *
 *  @return object
 */
+ (id)objectFromJSONString:(NSString*)jsonString;

@end


