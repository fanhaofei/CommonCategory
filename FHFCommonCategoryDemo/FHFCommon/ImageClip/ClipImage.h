//
//  ClipImage.h
//  FHFCommonCategory
//
//  Created by fhf on 16/3/8.
//  Copyright © 2016年 fhf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClipImage : UIView

//图片裁剪
+ (UIImage *)clipRectImage:(UIImage *)image;
//获取图片正中间的圆
+ (UIImage *)clipEllipseImage:(UIImage*) superImage;
@end
