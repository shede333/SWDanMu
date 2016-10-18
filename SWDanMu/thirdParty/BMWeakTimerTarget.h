//
//  BMWeakTimerTarget.h
//  SWDanMuDemo
//
//  Created by shaowei on 18/10/2016.
//  Copyright © 2016 shaowei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMWeakTimerTarget : NSObject

- (instancetype) initWithTarget: (id) target andSelector: (SEL) selector;
- (void)timerDidFire:(NSTimer *)timer;

@end
