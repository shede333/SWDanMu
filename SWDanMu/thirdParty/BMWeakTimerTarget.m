//
//  BMWeakTimerTarget.m
//  SWDanMuDemo
//
//  Created by shaowei on 18/10/2016.
//  Copyright © 2016 shaowei. All rights reserved.
//

#import "BMWeakTimerTarget.h"

@implementation BMWeakTimerTarget
{
    __weak id _target;
    SEL _selector;
}

- (instancetype) initWithTarget: (id) target andSelector: (SEL) selector
{
    self = [super init];
    if (self) {
        _target = target;
        _selector = selector;
    }
    return self;
}

- (void) dealloc
{
}

- (void)timerDidFire:(NSTimer *)timer
{
    if(_target)
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_target performSelector:_selector withObject:timer];
#pragma clang diagnostic pop
    }
    else
    {
        [timer invalidate];
    }
}


@end
