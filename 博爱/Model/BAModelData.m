//
//  BAModelData.m
//  博爱
//
//  Created by 博爱 on 2016/12/1.
//  Copyright © 2016年 DS-Team. All rights reserved.
//

#import "BAModelData.h"

@implementation BAModelData

- (instancetype)initWithTitle:(NSString *)title rating:(float)rating
{
    if (self =[super init])
    {
        self.title = title;
        self.rating = rating;
    }
    return self;
}

@end
