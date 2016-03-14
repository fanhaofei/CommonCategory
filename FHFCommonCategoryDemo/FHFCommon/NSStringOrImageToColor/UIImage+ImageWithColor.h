//
//  UIImage+ImageWithColor.h
//  FHFCommonCategory
//
//  Created by fhf on 16/3/8.
//  Copyright © 2016年 fhf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageWithColor)
/**
 Returns a 1x1 image with the single pixel set to the specified color.
 
 Usage Note: almost all of UIKit will stretch this UIImage when you set
 it as, eg. backgroundImage, hence you often don’t need the size variant.\
 填充
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 Returns an image of the requested size filled with the provided color.
 填充
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 Returns a (minimal) resizable image with the requested corner radius and
 filled with the provided color.
 平铺
 */
+ (UIImage *)resizableImageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius;
@end
