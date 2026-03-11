#import <UIKit/UIKit.h>

// 1. 基础权限全开（继续保留，这是大前提）
%hook _TtC10Postbox7Message
- (bool)isCopyingRestricted { return NO; }
%end

%hook _TtC10Postbox14CachedPeerData
- (bool)isCopyingRestricted { return NO; }
%end

// 2. 核心：强制 UI 渲染保存按钮
// Telegram 内部判断是否显示“保存到相册”的逻辑点
%hook _TtC7Display19NavigationController
- (bool)canPerformAction:(SEL)action withSender:(id)sender {
    NSString *sel = NSStringFromSelector(action);
    // 强制允许：保存视频、保存图片、转发、拷贝
    if ([sel containsString:@"save"] || 
        [sel containsString:@"Forward"] || 
        [sel containsString:@"Copy"]) {
        return YES;
    }
    return %orig;
}
%end

// 3. 针对 SwiftGram 内部开关的暴力破解
%hook _TtC11SwiftGramCore15SwiftGramConfig
- (bool)allowSavingRestrictedMedia { return YES; }
- (bool)allowCapturingScreenshots { return YES; }
- (bool)allowCopyingRestrictedContent { return YES; }
%end

// 4. 解决“保存至文件”消失的问题
%hook _TtC10Postbox10PeerConfig
- (bool)isCopyingRestricted { return NO; }
%end
