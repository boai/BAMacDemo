//
//  BABugsDoc.m
//  博爱
//
//  Created by 博爱 on 2016/12/1.
//  Copyright © 2016年 DS-Team. All rights reserved.
//

#import "BABugsDoc.h"
#import "BAModelData.h"

@implementation BABugsDoc

- (instancetype)initWithTitle:(NSString *)title rating:(float)rating thumbImage:(NSImage *)thumbImage fullImage:(NSImage *)fullImage{
    if (self = [super init]) {
        self.data = [[BAModelData alloc]initWithTitle:title rating:rating];
        self.thumbImage = thumbImage;
        self.fullImage = fullImage;
    }
    return self;
}

@end
