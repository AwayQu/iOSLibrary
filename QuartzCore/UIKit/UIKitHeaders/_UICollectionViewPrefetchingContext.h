//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSArray, NSMutableDictionary, NSMutableOrderedSet, NSObject<OS_dispatch_queue>;

__attribute__((visibility("hidden")))
@interface _UICollectionViewPrefetchingContext : NSObject
{
    NSArray *_remainingIndexPaths;
    NSMutableOrderedSet *_items;
    NSMutableDictionary *_itemsDict;
    NSObject<OS_dispatch_queue> *_dataAccessQueue;
}

+ (id)prefetchingContextWithItems:(id)arg1;
@property(retain, nonatomic) NSObject<OS_dispatch_queue> *dataAccessQueue; // @synthesize dataAccessQueue=_dataAccessQueue;
@property(retain, nonatomic) NSMutableDictionary *itemsDict; // @synthesize itemsDict=_itemsDict;
@property(retain, nonatomic) NSMutableOrderedSet *items; // @synthesize items=_items;
@property(retain, nonatomic) NSArray *remainingIndexPaths; // @synthesize remainingIndexPaths=_remainingIndexPaths;
- (void).cxx_destruct;
- (id)_items;
- (void)_invalidateRemainingIndexPaths;
- (id)popNextItem;
- (id)peekNextItem;
- (_Bool)hasRemainingItems;
- (void)prefetchCompleteForItemAtIndexPath:(id)arg1;
- (id)initWithPrefetchItems:(id)arg1;

@end

