//
//  ClipImage.m
//  FHFCommonCategory
//
//  Created by fhf on 16/3/8.
//  Copyright © 2016年 fhf. All rights reserved.
//

#import "ClipImage.h"

@implementation ClipImage

//图片裁剪
+ (UIImage *)clipRectImage:(UIImage *)image

{
    if (image)
    {
        float min = MIN(image.size.width,image.size.height);
        CGRect rectMAX = CGRectMake((image.size.width-min)/2, (image.size.height-min)/2, min, min);
        
        CGImageRef subImageRef = CGImageCreateWithImageInRect(image.CGImage, rectMAX);
        
        UIGraphicsBeginImageContext(rectMAX.size);
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGContextDrawImage(context, CGRectMake(0, 0, min, min), subImageRef);
        UIImage *viewImage = [UIImage imageWithCGImage:subImageRef];
//        UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        CGImageRelease(subImageRef);
        return viewImage;
    }
    
    return nil;
}


//截取图片正中间的圆
+(UIImage *)clipEllipseImage:(UIImage*) superImage
{
    
    
    float min = MIN(superImage.size.width,superImage.size.height);
    CGRect subImageRect = CGRectMake((superImage.size.width-min)/2, (superImage.size.height-min)/2, min, min);

    CGSize subImageSize = CGSizeMake(min , min);
    //定义裁剪的区域相对于原图片的位置
    CGImageRef imageRef = superImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, subImageRect);
    
    UIGraphicsBeginImageContext(subImageSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIImage* subImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    CGContextSetLineWidth(context, 2);
    //    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGRect rect = CGRectMake(0, 0,min ,min );
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [subImage drawInRect:rect];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimg;
}
@end
