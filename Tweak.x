#import <UIKit/UIKit.h>

// 1. 强制解除消息的“受限”状态（允许转发和复制）
%hook _TtC10Postbox7Message
- (bool)isCopyingRestricted {
    return NO;
}
%end

// 2. 暴力开启 SwiftGram 内部的增强开关
%hook _TtC11SwiftGramCore15SwiftGramConfig
- (bool)allowSavingRestrictedMedia {
    return YES;
}
- (bool)allowCapturingScreenshots {
    return YES;
}
%end

// 3. 强制在长按菜单里显示“保存”按钮
%hook _TtC7Display19NavigationController
- (bool)canPerformAction:(SEL)action withSender:(id)sender {
    NSString *selName = NSStringFromSelector(action);
    if ([selName containsString:@"saveToGallery"] || 
        [selName containsString:@"forward"]) {
        return YES;
    }
    return %orig;
}
%end
