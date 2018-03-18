//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSArray, _UIDraggingSession;

@protocol _UIDraggingSessionDelegate <NSObject>

@optional
- (void)draggingSessionDidTransferItems:(_UIDraggingSession *)arg1;
- (void)draggingSessionDidEnd:(_UIDraggingSession *)arg1 withOperation:(unsigned long long)arg2;
- (void)draggingSessionWillEnd:(_UIDraggingSession *)arg1 withOperation:(unsigned long long)arg2;
- (void)draggingSession:(_UIDraggingSession *)arg1 willAddItems:(NSArray *)arg2;
- (void)draggingSessionDidMove:(_UIDraggingSession *)arg1;
- (void)draggingSessionWillBegin:(_UIDraggingSession *)arg1;
- (_Bool)draggingSessionDynamicallyUpdatesPrefersFullSizePreviews:(_UIDraggingSession *)arg1;
- (_Bool)draggingSessionPrefersFullSizePreviews:(_UIDraggingSession *)arg1;
- (unsigned long long)draggingSession:(_UIDraggingSession *)arg1 sourceOperationMaskForDraggingContext:(long long)arg2;
@end
