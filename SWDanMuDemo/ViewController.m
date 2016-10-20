//
//  ViewController.m
//  SWDanMuDemo
//
//  Created by shaowei on 18/10/2016.
//  Copyright © 2016 shaowei. All rights reserved.
//

#import "ViewController.h"
#import "BMDanMuHeader.h"
#import "UIView+Sizes.h"

@interface ViewController ()<BMDanMuDelegate>;

@property (nonatomic, strong) BMDanMuController *dmCOntroller;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // add DanMu
    self.dmCOntroller = [[BMDanMuController alloc] init];
    self.dmCOntroller.view.size = CGSizeMake(self.view.width, self.view.width);
    self.dmCOntroller.delegate = self;
    [self.dmCOntroller registerClass:[BMDanMuSpiritView class] forCellReuseIdentifier:@"BMDanMuSpiritView"];
    
    self.dmCOntroller.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.dmCOntroller.view];
    
    [self.dmCOntroller.backgroundView setBackgroundColor:[UIColor redColor]];
    
    //start danmu
    [self actionStartDanMu:nil];
    
    //add test button
    [self addTestBtn];
}

- (void)addTestBtn{
    
    UILabel *promptLabel = [[UILabel alloc] init];
    promptLabel.textColor = [UIColor blackColor];
    promptLabel.text = @"提示：上面的spirit是可以点击的";
    [promptLabel sizeToFit];
    promptLabel.top = self.dmCOntroller.view.bottom + 10;
    promptLabel.centerX = self.view.width/2;
    [self.view addSubview:promptLabel];
    
    CGFloat centerY = self.dmCOntroller.view.bottom + (self.view.height - self.dmCOntroller.view.bottom)/2.0f;
    
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [startBtn setTitle:@"start DanMu" forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [startBtn setBackgroundColor:[UIColor redColor]];
    [startBtn sizeToFit];
    [startBtn addTarget:self action:@selector(actionStartDanMu:) forControlEvents:UIControlEventTouchUpInside];
    startBtn.right = self.view.width/2 - 10;
    startBtn.centerY = centerY;
    [self.view addSubview:startBtn];
    
    
    UIButton *stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [stopBtn setTitle:@"stop DanMu" forState:UIControlStateNormal];
    [stopBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [stopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [stopBtn setBackgroundColor:[UIColor redColor]];
    [stopBtn sizeToFit];
    [stopBtn addTarget:self action:@selector(actionStopDanMu:) forControlEvents:UIControlEventTouchUpInside];
    stopBtn.left = self.view.width/2 + 10;
    stopBtn.centerY = centerY;
    [self.view addSubview:stopBtn];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action

- (void)actionStartDanMu:(UIButton *)sender{
    //启动 弹幕
    BMDanMuConfig *config = [[BMDanMuConfig alloc] init];
    [self.dmCOntroller startWithConfig:config];
}

- (void)actionStopDanMu:(UIButton *)sender{
    //停止 弹幕
    [self.dmCOntroller stop];
}

- (void)actionSpiritClick:(UIButton *)sender{
    //点击 弹幕上的精灵
    NSLog(@"click: %@", sender.titleLabel.text);
    [sender setBackgroundColor:[UIColor whiteColor]];
}

#pragma mark - BMDanMuDelegate

- (BMDanMuSpiritView *)danMuControllerGetSpiritView:(BMDanMuController *)danMuController{
    BMDanMuSpiritView *btn = [danMuController dequeueReusableCellWithIdentifier:@"BMDanMuSpiritView"];
    [btn setTitle:[NSString stringWithFormat:@"this is a test hahaha: %d --", arc4random() % 1000]
         forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    
    [btn addTarget:self action:@selector(actionSpiritClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}




@end
