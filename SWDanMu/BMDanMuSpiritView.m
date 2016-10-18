//
//  BMDanMuSpiritView.m
//  SWDanMuDemo
//
//  Created by shaowei on 18/10/2016.
//  Copyright © 2016 shaowei. All rights reserved.
//

#import "BMDanMuSpiritView.h"

@interface BMDanMuSpiritView()

@property (nonatomic, strong) NSString *identifier;

@end

@implementation BMDanMuSpiritView

- (instancetype)initWithIdentifier:(NSString *)identifier{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.identifier = identifier;
    }
    return self;
    
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//    NSLog(@"%@\ntype:%d, subtype:%d\npre-layer:%@, convert:%@\n\n", NSStringFromCGPoint(point), event.type, event.subtype, NSStringFromCGRect(self.layer.presentationLayer.frame), NSStringFromCGPoint([self convertPoint:point toView:self.superview]));

    if (event.type == UIEventTypeTouches) {
        return CGRectContainsPoint(self.layer.presentationLayer.frame, [self convertPoint:point toView:self.superview]);
    }else{
        return [super pointInside:point withEvent:event];
    }
}

@end
