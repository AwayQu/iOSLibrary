//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class UIImage;

__attribute__((visibility("hidden")))
@interface UISliderContent : NSObject
{
    UIImage *_thumb;
    UIImage *_minTrack;
    UIImage *_maxTrack;
}

@property(retain, nonatomic) UIImage *maxTrack; // @synthesize maxTrack=_maxTrack;
@property(retain, nonatomic) UIImage *minTrack; // @synthesize minTrack=_minTrack;
@property(retain, nonatomic) UIImage *thumb; // @synthesize thumb=_thumb;
- (void).cxx_destruct;
@property(readonly, nonatomic) _Bool isEmpty;

@end

