//
//  BMDanMuController.m
//  SWDanMuDemo
//
//  Created by shaowei on 18/10/2016.
//  Copyright © 2016 shaowei. All rights reserved.
//

#import "BMDanMuController.h"
#import "BMReuseManager.h"
#import "BMWeakTimerTarget.h"

@interface BMDanMuController()

@property (nonatomic, strong) BMReuseManager *reuseManager;

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *contentView; //所有的精灵都放在这个view上面
//@property (nonatomic, strong) NSMutableArray *spiritViews;
@property (nonatomic, strong) BMDanMuConfig *config;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BMDanMuControllerStatus status;

@property (nonatomic, strong) BMDanMuSpiritView *stashSpirit; //暂存的spirit，可能是当时没刷上去的



@end

@implementation BMDanMuController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.status = BMDanMuControllerStatusOfStop;
        self.reuseManager = [[BMReuseManager alloc] init];
        
        [self setupView];
    }
    return self;
}

- (void)dealloc
{
    [self stop];
}

- (void)setupView{
    self.view = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.backgroundView setBackgroundColor:[UIColor clearColor]];
    self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.backgroundView];
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.contentView];
}

- (void)timerFire:(NSTimer *)timer{
    [self insertNextSpirit];
}

- (void)insertNextSpirit{
    BMDanMuSpiritView *spiritView = self.stashSpirit;
    if (spiritView) {
        self.stashSpirit = nil;
    }else{
        //没有暂存的spirit
        spiritView = [_delegate danMuControllerGetSpiritView:self];
    }
    
    if (!spiritView) {
        //没有spirit；
        return;
    }
    
    CGFloat spiritTop = (self.contentView.height - self.config.spiritHeight) * ((arc4random() % 100) / 100.f);
    spiritView.origin= CGPointMake(self.contentView.width, spiritTop);
    
    BOOL isConflict = NO;
    for (UIView *tmpView in self.contentView.subviews) {
        if (CGRectIntersectsRect(tmpView.layer.presentationLayer.frame, spiritView.frame)) {
//            NSLog(@"新spirit的位置产生冲突, tmpView:%@, newSpirit:%@",
//                  NSStringFromCGRect(tmpView.frame),
//                  NSStringFromCGRect(spiritView.frame));
            isConflict = YES;
            break;
        }
    }
    
    if (isConflict) {
        self.stashSpirit = spiritView;
        NSLog(@"新spirit的位置产生冲突，pass下一个");
        return;
    }

    [self.contentView addSubview:spiritView];
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat duration = (spiritView.right + 10)/_config.speed;
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveLinear|UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         spiritView.right = -10;
                     } completion:^(BOOL finished) {
                         //回收资源
                         [weakSelf.reuseManager recycleItem:spiritView
                                                 identifier:spiritView.identifier];
                         [spiritView removeFromSuperview];
                     }];
}

#pragma mark - Function - Public

- (void)registerClass:(Class)itemClass forCellReuseIdentifier:(NSString *)identifier{
    [_reuseManager registerClass:itemClass forReuseIdentifier:identifier];
}

- (__kindof BMDanMuSpiritView *)dequeueReusableCellWithIdentifier:(NSString *)identifier{
    return [_reuseManager dequeueReusableWithIdentifier:identifier];
}

- (void)startWithConfig:(BMDanMuConfig *)config{
    if (self.status != BMDanMuControllerStatusOfStop) {
        [self stop];
    }
    self.status = BMDanMuControllerStatusOfRuning;
    
    self.config = config;
    
    if (self.timer) {
        [self.timer invalidate];
    }
    BMWeakTimerTarget *weakTarget = [[BMWeakTimerTarget alloc] initWithTarget: self andSelector: @selector(timerFire:)];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_config.timeInterval
                                                  target:weakTarget
                                                selector:@selector(timerDidFire:)
                                                userInfo:nil
                                                 repeats:YES];

}

- (void)stop{
    [self.timer invalidate];
    self.timer = nil;
    
    for (BMDanMuSpiritView *tmpView in self.contentView.subviews) {
        [tmpView.layer removeAllAnimations];
        [tmpView removeFromSuperview];
    }
    self.status = BMDanMuControllerStatusOfStop;
}

//- (void)suspend;
//
//- (void)resume;


@end
