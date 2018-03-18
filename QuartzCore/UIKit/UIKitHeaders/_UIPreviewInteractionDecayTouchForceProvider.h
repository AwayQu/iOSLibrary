//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

#import "_UIPreviewInteractionTouchForceProviding.h"

@class NSString;

__attribute__((visibility("hidden")))
@interface _UIPreviewInteractionDecayTouchForceProvider : NSObject <_UIPreviewInteractionTouchForceProviding>
{
    id <_UIPreviewInteractionTouchForceProviding> _touchForceProvider;
    double _initialTouchForce;
    struct CGPoint _location;
    id <UICoordinateSpace> _coordinateSpace;
    _Bool _active;
}

@property(nonatomic, getter=isActive) _Bool active; // @synthesize active=_active;
- (void).cxx_destruct;
- (void)cancelInteraction;
- (struct CGPoint)locationInCoordinateSpace:(id)arg1;
@property(readonly, nonatomic) double touchForce;
- (id)initWithTouchForceProvider:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;

@end

