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

@property(nonatomic, retain)NSString *barTitle;
@property(nonatomic, retain)NSURL *webViewUrl;


- (id)initWithUrl:(NSURL *)url barTitle:(NSString *)title;



@end
