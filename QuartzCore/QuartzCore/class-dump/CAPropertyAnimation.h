//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <QuartzCore/CAAnimation.h>

@class CAValueFunction, NSString;

@interface CAPropertyAnimation : CAAnimation
{
}

+ (id)animationWithKeyPath:(id)arg1;
- (_Bool)cumulative;
- (_Bool)additive;
@property(retain) CAValueFunction *valueFunction;
@property(getter=isCumulative) _Bool cumulative;
@property(copy) NSString *keyPath;
@property(getter=isAdditive) _Bool additive;
- (unsigned int)_propertyFlagsForLayer:(id)arg1;
- (_Bool)_setCARenderAnimation:(struct Animation *)arg1 layer:(id)arg2;
- (void)applyForTime:(double)arg1 presentationObject:(id)arg2 modelObject:(id)arg3;

@end

