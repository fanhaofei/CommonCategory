

#import <Foundation/Foundation.h>

@interface NSString (NsTimeInterval)

+ (NSString *)dateStingWithTimeintval:(NSTimeInterval)timeInterval;

+ (NSString *)dateStingWithTimeintval:(NSTimeInterval)timeInterval andStyle:(NSString *)style;

//默认样式：2014-01-23;
+ (NSTimeInterval)timeIntervalWithString:(NSString *)string;

+ (NSTimeInterval)timeIntervalWithString:(NSString *)string andStyle:(NSString *)style;

@end
