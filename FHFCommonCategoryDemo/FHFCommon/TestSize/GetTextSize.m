

#import "GetTextSize.h"

@implementation GetTextSize

+(CGSize)text:(NSString*)text andFont:(CGFloat)font andCGSize:(CGSize)size{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont fontWithName:@"HiraKakuProN-W3" size:font]};
    CGSize sizeText = [text boundingRectWithSize:size options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return sizeText;
}

@end
