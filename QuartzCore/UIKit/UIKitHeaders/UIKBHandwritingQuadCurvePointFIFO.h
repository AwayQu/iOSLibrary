//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <UIKit/UIKBHandwritingPointFIFO.h>

@class NSMutableArray;

__attribute__((visibility("hidden")))
@interface UIKBHandwritingQuadCurvePointFIFO : UIKBHandwritingPointFIFO
{
    CDUnknownBlockType _emissionHandler;
    double _scale;
    NSMutableArray *_prevPoints;
    CDStruct_23d8ee2f _lastPoint;
}

@property(nonatomic) CDStruct_19cde01f lastPoint; // @synthesize lastPoint=_lastPoint;
@property(retain, nonatomic) NSMutableArray *prevPoints; // @synthesize prevPoints=_prevPoints;
@property(nonatomic) double scale; // @synthesize scale=_scale;
@property(copy) CDUnknownBlockType emissionHandler; // @synthesize emissionHandler=_emissionHandler;
- (void).cxx_destruct;
- (void)clear;
- (void)flush;
- (void)addPoint:(struct)arg1;
- (id)initWithFIFO:(id)arg1 scale:(double)arg2;

@end

