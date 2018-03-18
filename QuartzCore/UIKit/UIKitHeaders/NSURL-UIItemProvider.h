//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSURL.h"

#import "UIItemProviderReading.h"
#import "UIItemProviderWriting.h"

@class NSArray, NSString;

@interface NSURL (UIItemProvider) <UIItemProviderReading, UIItemProviderWriting>
+ (id)newObjectWithItemProviderData:(id)arg1 typeIdentifier:(id)arg2 options:(id)arg3 error:(id *)arg4;
- (void)_NSItemProviderArchive_didUnarchiveCustomDictionary:(id)arg1;
- (id)_NSItemProviderArchive_customArchiveDictionary;
- (void)registerLoadHandlersToItemProvider:(id)arg1;

// Remaining properties
@property(readonly, copy) NSString *debugDescription;
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;
@property(readonly, copy, nonatomic) NSArray *writableTypeIdentifiersForItemProvider;
@end

