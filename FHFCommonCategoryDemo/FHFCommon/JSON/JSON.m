
#import "JSON.h"

@implementation JSON

+ (NSString *)JSONStringFromObject:(id)object{
    if (object == nil) {
        return @"";
    }
    NSData *data=[NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return jsonString;
}

+ (id)objectFromJSONString:(NSData *)data{
    if (data == nil) {
        return nil;
    }
    
//    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    
    return object;
}

@end
