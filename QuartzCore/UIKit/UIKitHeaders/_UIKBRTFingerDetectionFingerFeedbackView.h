//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <UIKit/UIView.h>

@class UILabel, _UIKBRTFingerDetectionFingerCircleView;

__attribute__((visibility("hidden")))
@interface _UIKBRTFingerDetectionFingerFeedbackView : UIView
{
    struct CGPoint _framelocation;
    double _radiusInt;
    _Bool _unknownSeen;
    UILabel *_fingerLabel;
    _UIKBRTFingerDetectionFingerCircleView *_fingerDot;
}

@property(nonatomic) _Bool unknownSeen; // @synthesize unknownSeen=_unknownSeen;
@property(retain, nonatomic) _UIKBRTFingerDetectionFingerCircleView *fingerDot; // @synthesize fingerDot=_fingerDot;
@property(retain, nonatomic) UILabel *fingerLabel; // @synthesize fingerLabel=_fingerLabel;
- (void).cxx_destruct;
- (void)setNeedsDisplay;
- (void)centerOn:(struct CGPoint)arg1 withRadius:(double)arg2 andIdentifier:(unsigned long long)arg3;
- (void)layoutSubviews;
- (double)radius;
- (id)initWithFrame:(struct CGRect)arg1;

@end

