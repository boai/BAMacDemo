//
//  BABugsDoc.h
//  博爱
//
//  Created by 博爱 on 2016/12/1.
//  Copyright © 2016年 DS-Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BAModelData;
@interface BABugsDoc : NSObject

@property (nonatomic, strong) BAModelData  *data;
@property (nonatomic, strong) NSImage      *thumbImage; // 缩略图
@property (nonatomic, strong) NSImage      *fullImage;  // 全尺寸图


- (instancetype)initWithTitle:(NSString *)title rating:(float)rating thumbImage:(NSImage *)thumbImage fullImage:(NSImage *)fullImage;

@end
