

#import "NSString+NsTimeInterval.h"

@implementation NSString (NsTimeInterval)

+ (NSString *)dateStingWithTimeintval:(NSTimeInterval)timeInterval
{
   
    return [self dateStingWithTimeintval:timeInterval andStyle:@"yyyy-MM-dd"];
}

+ (NSString *)dateStingWithTimeintval:(NSTimeInterval)timeInterval andStyle:(NSString *)style
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:style];
    NSString *time = [dateFormatter stringFromDate:date];
    
    return [NSString stringWithFormat:@"%@",time];
}

+ (NSTimeInterval)timeIntervalWithString:(NSString *)string
{
    return [self timeIntervalWithString:string andStyle:@"yyyy-MM-dd"];
}

+ (NSTimeInterval)timeIntervalWithString:(NSString *)string andStyle:(NSString *)style
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:style];
    NSDate *date = [dateFormatter dateFromString:string];
    return date.timeIntervalSince1970 * 1000;
}

@end
