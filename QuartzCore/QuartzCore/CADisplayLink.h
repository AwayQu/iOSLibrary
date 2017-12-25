//
// Created by Away on 25/12/2017.
// Copyright (c) 2017 Away. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NSObject.h"

@class CADisplay;

@interface CADisplayLink : NSObject
{
    void *_impl;
}

+ (id)displayLinkWithTarget:(id)target selector:(SEL)sel;
+ (id)displayLinkWithDisplay:(id)display target:(id)target selector:(SEL)sel;
- (void)invalidate;
- (long long)actualFramesPerSecond;
@property(nonatomic) long long preferredFramesPerSecond;
@property(readonly, nonatomic) double targetTimestamp;
@property(nonatomic) long long frameInterval;
@property(nonatomic, getter=isPaused) _Bool paused;
@property(readonly, nonatomic) double duration;
@property(readonly, nonatomic) double timestamp;
- (void)removeFromRunLoop:(id)arg1 forMode:(id)arg2;
- (void)addToRunLoop:(id)arg1 forMode:(id)arg2;
- (void)dealloc;
- (id)_initWithDisplayLinkItem:(struct DisplayLinkItem *)item;
@property(readonly, nonatomic) long long minimumFrameDuration;
@property(readonly, nonatomic) double heartbeatRate;
@property(retain, nonatomic) id userInfo;
@property(readonly, nonatomic) double maximumRefreshRate;
@property(readonly, nonatomic) CADisplay *display;

@end
