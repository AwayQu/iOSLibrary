//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

__attribute__((visibility("hidden")))
@interface UICellHighlightingSupport : NSObject
{
    struct __CFDictionary *_unhighlightedStates;
    id _cell;
}

- (void).cxx_destruct;
- (void)highlightView:(id)arg1;
- (void)applyState:(unsigned long long)arg1 toView:(id)arg2;
- (void)cacheState:(unsigned long long)arg1 forView:(id)arg2;
- (void)dealloc;
- (id)initWithCell:(id)arg1;

@end

