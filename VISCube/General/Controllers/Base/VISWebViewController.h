//
//  VISWebViewController.h
//  UPPayPluginEx
//
//  Created by liwang on 13-6-14.
//
//

#import <UIKit/UIKit.h>
#import "VISBaseViewController.h"

@interface VISWebViewController : VISBaseViewController<UIWebViewDelegate>
{
    UIWebView *_webView;
    UIActivityIndicatorView *_loadingIndicator;
}

@property(nonatomic, strong)NSString *barTitle;
@property(nonatomic, strong)NSURL *webViewUrl;
@property(nonatomic)BOOL shouldShowMenu;

- (id)initWithUrl:(NSURL *)url barTitle:(NSString *)title;


@end
