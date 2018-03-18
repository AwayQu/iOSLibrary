//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import "NSObject.h"

@class NSMutableArray;

__attribute__((visibility("hidden")))
@interface _UIDebugLogReport : NSObject
{
    unsigned long long _currentIndentLevel;
    CDUnknownBlockType _fallbackMessagePrefixHandler;
    NSMutableArray *_statements;
    NSMutableArray *_prefixStack;
}

@property(retain, nonatomic, getter=_prefixStack) NSMutableArray *prefixStack; // @synthesize prefixStack=_prefixStack;
@property(retain, nonatomic, getter=_statements) NSMutableArray *statements; // @synthesize statements=_statements;
@property(copy, nonatomic) CDUnknownBlockType fallbackMessagePrefixHandler; // @synthesize fallbackMessagePrefixHandler=_fallbackMessagePrefixHandler;
@property(nonatomic) unsigned long long currentIndentLevel; // @synthesize currentIndentLevel=_currentIndentLevel;
- (void).cxx_destruct;
- (void)decrementIndentLevelAndPopMessagePrefix;
- (void)incrementIndentLevelAndPushMessagePrefix:(id)arg1;
- (id)_messagePrefixAtIndentLevel:(unsigned long long)arg1;
- (void)clearAllMessagePrefixes;
- (void)popMessagePrefix;
- (void)pushMessagePrefixHandler:(CDUnknownBlockType)arg1;
- (void)pushMessagePrefix:(id)arg1;
- (void)resetIndentLevel;
- (void)decrementIndentLevel;
- (void)incrementIndentLevel;
- (void)addLineBreak;
- (void)addMessage:(id)arg1;
- (void)addMessageWithFormat:(id)arg1;
@property(readonly, nonatomic) unsigned long long messageCount;
- (id)init;

@end

