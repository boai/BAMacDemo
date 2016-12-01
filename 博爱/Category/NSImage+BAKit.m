//
//  NSImage+BAKit.m
//  博爱
//
//  Created by 博爱 on 2016/12/1.
//  Copyright © 2016年 DS-Team. All rights reserved.
//

#import "NSImage+BAKit.h"

@implementation NSImage (BAKit)

- (NSImage*)ba_imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    NSImage *sourceImage = self;
    NSImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = ceil(width * scaleFactor);
        scaledHeight = ceil(height * scaleFactor);
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    newImage = [[NSImage alloc] initWithSize:NSMakeSize(scaledWidth, scaledHeight)];
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    NSRect imageRect = NSMakeRect(0.0, 0.0, imageSize.width,  imageSize.height);
    
    [newImage lockFocus];
    [self drawInRect:thumbnailRect fromRect:imageRect operation:NSCompositeCopy fraction:1.0];
    [newImage unlockFocus];
    /*
     UIGraphicsBeginImageContext(targetSize); // this will crop
     
     CGRect thumbnailRect = CGRectZero;
     thumbnailRect.origin = thumbnailPoint;
     thumbnailRect.size.width  = scaledWidth;
     thumbnailRect.size.height = scaledHeight;
     [sourceImage drawInRect:thumbnailRect fromRect:NSZeroRect operation:NSCompositeCopy fraction:1.0];
     //[sourceImage drawInRect:thumbnailRect];
     
     newImage = UIGraphicsGetImageFromCurrentImageContext();
     if(newImage == nil)
     NSLog(@"could not scale image");
     
     //pop the context to get back to the default
     UIGraphicsEndImageContext();
     
     */
    return newImage;
}
@end
