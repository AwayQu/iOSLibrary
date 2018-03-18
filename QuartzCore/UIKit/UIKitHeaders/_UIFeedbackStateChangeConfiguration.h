//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "NSCopying.h"

@class _UIFeedback<_UIFeedbackContinuousPlayable>, _UIFeedback<_UIFeedbackDiscretePlayable>;

@interface _UIFeedbackStateChangeConfiguration : NSObject <NSCopying>
{
    _UIFeedback<_UIFeedbackDiscretePlayable> *_thresholdFeedback;
    _UIFeedback<_UIFeedbackContinuousPlayable> *_approachFeedback;
    double _approachStart;
    double _approachEnd;
    double _approachCurvature;
    double _approachVolumeMax;
}

@property(nonatomic) double approachVolumeMax; // @synthesize approachVolumeMax=_approachVolumeMax;
@property(nonatomic) double approachCurvature; // @synthesize approachCurvature=_approachCurvature;
@property(nonatomic) double approachEnd; // @synthesize approachEnd=_approachEnd;
@property(nonatomic) double approachStart; // @synthesize approachStart=_approachStart;
@property(retain, nonatomic) _UIFeedback<_UIFeedbackContinuousPlayable> *approachFeedback; // @synthesize approachFeedback=_approachFeedback;
@property(retain, nonatomic) _UIFeedback<_UIFeedbackDiscretePlayable> *thresholdFeedback; // @synthesize thresholdFeedback=_thresholdFeedback;
- (void).cxx_destruct;
- (_Bool)isEqual:(id)arg1;
- (id)copyWithZone:(struct _NSZone *)arg1;

@end

