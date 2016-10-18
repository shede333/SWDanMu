//
//  BMDanMuModelManager.m
//  SWDanMuDemo
//
//  Created by shaowei on 18/10/2016.
//  Copyright © 2016 shaowei. All rights reserved.
//

#import "BMDanMuModelManager.h"

@interface BMDanMuModelManager()

@property (nonatomic, strong) NSMutableArray *arrOfOrigin; //未用过的资源
@property (nonatomic, strong) NSMutableArray *arrOfUsed; //用过的资源

@end

@implementation BMDanMuModelManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.arrOfOrigin = [NSMutableArray arrayWithCapacity:10];
        self.arrOfUsed = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

#pragma mark - Function - Public

- (void)resetResourceWithArray:(NSArray *)arr{
    [self.arrOfUsed removeAllObjects];
    [self.arrOfOrigin removeAllObjects];
    
    [self.arrOfOrigin addObjectsFromArray:arr];
}

- (id)getNextModel{
    id model = [_arrOfOrigin firstObject];
    if (model) {
        [_arrOfUsed addObject:model];
        [_arrOfOrigin removeObject:model];
    }
    
    if ([_arrOfOrigin count] <= 0 && [_arrOfUsed count] > 0) {
        [_arrOfOrigin addObjectsFromArray:_arrOfUsed];
        [_arrOfUsed removeAllObjects];
    }
    
    return model;
}

- (void)addModelToQueueFirst:(id)model{
    [_arrOfOrigin insertObject:model atIndex:0];
}

- (void)addModelToQueueEnd:(id)model{
    [_arrOfOrigin addObject:model];
}



@end
