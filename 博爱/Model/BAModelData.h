//
//  BAModelData.h
//  博爱
//
//  Created by 博爱 on 2016/12/1.
//  Copyright © 2016年 DS-Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAModelData : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) float rating;


- (instancetype)initWithTitle:(NSString *)title rating:(float)rating;

@end
