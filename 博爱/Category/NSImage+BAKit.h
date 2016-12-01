//
//  NSImage+BAKit.h
//  博爱
//
//  Created by 博爱 on 2016/12/1.
//  Copyright © 2016年 DS-Team. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSImage (BAKit)

- (NSImage*)ba_imageByScalingAndCroppingForSize:(CGSize)targetSize;

@end
