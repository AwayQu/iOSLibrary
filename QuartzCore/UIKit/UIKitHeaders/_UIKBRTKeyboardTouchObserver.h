//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSArray;

__attribute__((visibility("hidden")))
@interface _UIKBRTKeyboardTouchObserver : NSObject
{
    int _homeRowOffsetIndex;
    NSArray *_rowOffsets;
    NSArray *_rowXEdges;
    NSArray *_rowYEdgesLeft;
    NSArray *_rowYEdgesRight;
    struct CGPoint _fCenter;
    struct CGPoint _jCenter;
    struct CGSize _keySize;
}

@property(retain, nonatomic) NSArray *rowYEdgesRight; // @synthesize rowYEdgesRight=_rowYEdgesRight;
@property(retain, nonatomic) NSArray *rowYEdgesLeft; // @synthesize rowYEdgesLeft=_rowYEdgesLeft;
@property(retain, nonatomic) NSArray *rowXEdges; // @synthesize rowXEdges=_rowXEdges;
@property(nonatomic) int homeRowOffsetIndex; // @synthesize homeRowOffsetIndex=_homeRowOffsetIndex;
@property(retain, nonatomic) NSArray *rowOffsets; // @synthesize rowOffsets=_rowOffsets;
@property(nonatomic) struct CGSize keySize; // @synthesize keySize=_keySize;
@property(nonatomic) struct CGPoint jCenter; // @synthesize jCenter=_jCenter;
@property(nonatomic) struct CGPoint fCenter; // @synthesize fCenter=_fCenter;
- (void).cxx_destruct;
- (void)removeTouchWithIdentifier:(id)arg1 touchCancelled:(_Bool)arg2;
- (void)removeTouchWithIdentifier:(id)arg1;
- (void)moveTouchWithIdentifier:(id)arg1 toLocation:(struct CGPoint)arg2 withRadius:(double)arg3 atTouchTime:(double)arg4;
- (void)addTouchLocation:(struct CGPoint)arg1 withRadius:(double)arg2 withTouchTime:(double)arg3 withIdentifier:(id)arg4;
- (void)addTouchLocation:(struct CGPoint)arg1 withRadius:(double)arg2 withIdentifier:(id)arg3;
- (void)updateWithFCenter:(struct CGPoint)arg1 jCenter:(struct CGPoint)arg2 keySize:(struct CGSize)arg3 rowOffsets:(id)arg4 homeRowOffsetIndex:(int)arg5;
- (void)reset;

@end

