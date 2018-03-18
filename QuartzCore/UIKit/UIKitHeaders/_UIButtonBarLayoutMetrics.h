//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "NSCopying.h"
#import "_UIButtonBarLayoutMetricsData.h"

@class NSLayoutDimension, NSLayoutYAxisAnchor, NSString;

__attribute__((visibility("hidden")))
@interface _UIButtonBarLayoutMetrics : NSObject <_UIButtonBarLayoutMetricsData, NSCopying>
{
    _Bool _locked;
    _Bool _createsPopoverLayoutGuides;
    _Bool _allowsViewWrappers;
    NSLayoutDimension *_verticalSizeGuide;
    NSLayoutDimension *_minimumSpaceGuide;
    NSLayoutDimension *_flexibleSpaceGuide;
    NSLayoutYAxisAnchor *_popoverGuideTopAnchor;
    NSLayoutDimension *_groupSizeGuide;
    NSLayoutDimension *_groupSpacingGuide;
}

@property(nonatomic) _Bool allowsViewWrappers; // @synthesize allowsViewWrappers=_allowsViewWrappers;
@property(nonatomic) _Bool createsPopoverLayoutGuides; // @synthesize createsPopoverLayoutGuides=_createsPopoverLayoutGuides;
@property(retain, nonatomic) NSLayoutDimension *groupSpacingGuide; // @synthesize groupSpacingGuide=_groupSpacingGuide;
@property(retain, nonatomic) NSLayoutDimension *groupSizeGuide; // @synthesize groupSizeGuide=_groupSizeGuide;
@property(retain, nonatomic) NSLayoutYAxisAnchor *popoverGuideTopAnchor; // @synthesize popoverGuideTopAnchor=_popoverGuideTopAnchor;
@property(retain, nonatomic) NSLayoutDimension *flexibleSpaceGuide; // @synthesize flexibleSpaceGuide=_flexibleSpaceGuide;
@property(retain, nonatomic) NSLayoutDimension *minimumSpaceGuide; // @synthesize minimumSpaceGuide=_minimumSpaceGuide;
@property(retain, nonatomic) NSLayoutDimension *verticalSizeGuide; // @synthesize verticalSizeGuide=_verticalSizeGuide;
- (void).cxx_destruct;
@property(readonly, copy) NSString *description;
- (id)copyWithZone:(struct _NSZone *)arg1;
- (id)_upcastIfReadOnly;
- (id)_copyWithModifications:(CDUnknownBlockType)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

