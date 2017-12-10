//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <QuartzCore/CAContext.h>

__attribute__((visibility("hidden")))
@interface CAContextImpl : CAContext
{
    struct Context *_impl;
}

- (struct Context *)renderContext;
- (void)setObject:(id)arg1 forSlot:(unsigned int)arg2;
- (void)deleteSlot:(unsigned int)arg1;
- (unsigned int)createImageSlot:(struct CGSize)arg1 hasAlpha:(_Bool)arg2 extendedColors:(_Bool)arg3;
- (unsigned int)createImageSlot:(struct CGSize)arg1 hasAlpha:(_Bool)arg2;
- (unsigned int)createSlot;
- (void)invalidateFences;
- (void)setFence:(unsigned int)arg1 count:(unsigned int)arg2;
- (void)setFencePort:(unsigned int)arg1 commitHandler:(CDUnknownBlockType)arg2;
- (void)setFencePort:(unsigned int)arg1;
- (unsigned int)createFencePort;
- (_Bool)valid;
- (id)options;
- (float)desiredDynamicRange;
- (void)setDesiredDynamicRange:(float)arg1;
- (_Bool)isSecure;
- (void)setSecure:(_Bool)arg1;
- (float)level;
- (void)setLevel:(float)arg1;
- (void)orderBelow:(unsigned int)arg1;
- (void)orderAbove:(unsigned int)arg1;
- (void)setLayer:(id)arg1;
- (id)layer;
- (void)setContentsFormat:(id)arg1;
- (id)contentsFormat;
- (void)setColorMatchUntaggedContent:(_Bool)arg1;
- (_Bool)colorMatchUntaggedContent;
- (void)setCommitPriority:(unsigned int)arg1;
- (unsigned int)commitPriority;
- (void)setColorSpace:(struct CGColorSpace *)arg1;
- (struct CGColorSpace *)colorSpace;
- (unsigned int)contextId;
- (void)dealloc;
- (void)invalidate;
- (id)initRemoteWithOptions:(id)arg1;
- (id)initWithOptions:(id)arg1 localContext:(_Bool)arg2;

@end

