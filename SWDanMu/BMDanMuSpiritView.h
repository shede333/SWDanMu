//
//  BMDanMuSpiritView.h
//  SWDanMuDemo
//
//  Created by shaowei on 18/10/2016.
//  Copyright © 2016 shaowei. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 用于弹幕的精灵view，保证精灵运动过程中可以 准确 响应点击事件
 */
@interface BMDanMuSpiritView : UIButton

@property (nonatomic, strong, readonly) NSString *identifier;

- (instancetype)initWithIdentifier:(NSString *)identifier;

@end
