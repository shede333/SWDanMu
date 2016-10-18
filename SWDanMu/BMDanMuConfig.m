//
//  BMDanMuConfig.m
//  SWDanMuDemo
//
//  Created by shaowei on 18/10/2016.
//  Copyright © 2016 shaowei. All rights reserved.
//

#import "BMDanMuConfig.h"

@implementation BMDanMuConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.speed = 180;
        self.timeInterval = 0.5f;
        self.spiritHeight = 30;
    }
    return self;
}

@end
