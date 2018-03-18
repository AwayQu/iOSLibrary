//
//     Generated by class-dump 3.5 (64 bit).
//
//     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2013 by Steve Nygard.
//

#import <UIKit/UITextInputStringTokenizer.h>

@class UITextInputController;

__attribute__((visibility("hidden")))
@interface _UITextInputControllerTokenizer : UITextInputStringTokenizer
{
    UITextInputController *_textInput;
    struct __CFStringTokenizer *_tokenizer;
    int _tokenizerType;
}

- (void).cxx_destruct;
- (struct _NSRange)_getClosestTokenRangeForPosition:(id)arg1 granularity:(long long)arg2 downstream:(_Bool)arg3;
- (long long)_indexForTextPosition:(id)arg1;
- (id)_positionFromPosition:(id)arg1 offset:(unsigned long long)arg2 affinity:(long long)arg3;
- (_Bool)_isDownstreamForDirection:(long long)arg1 atPosition:(id)arg2;
- (long long)_writingDirectionAtPosition:(id)arg1;
- (void)invalidateTokenizer;
- (void)dealloc;
- (id)initWithTextInputController:(id)arg1;

@end

