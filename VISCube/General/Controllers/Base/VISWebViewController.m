//
//  VISWebViewController.m
//  UPPayPluginEx
//
//  Created by liwang on 13-6-14.
//
//

#import "VISWebViewController.h"



#define kSizeIndicator    22

@interface VISWebViewController ()
{
    UIActivityIndicatorView *_loadIndicator;
}
@end

@implementation VISWebViewController
@synthesize barTitle;
@synthesize webViewUrl;

- (id)initWithUrl:(NSURL *)url barTitle:(NSString *)title
{
    self = [super init];
    
    if (self) {
        self.webViewUrl = url;
        self.barTitle = title;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	// Do any additional setup after loading the view.
    self.title = self.barTitle;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.viewMaxWidth, self.viewMaxHeight)];
    _webView.delegate = self;
    _webView.backgroundColor = [UIColor whiteColor];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:webViewUrl];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
    // add loading indicator
    _loadIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_loadIndicator startAnimating];
    self.navigationItem.titleView = _loadIndicator;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    if (_shouldShowMenu) {
        [self addNavigationMenuItem];
    }
}





#pragma mark- UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.navigationItem.titleView = nil;
    if ([[webView.request.URL absoluteString] hasPrefix:[webViewUrl absoluteString]] ) {
        
    }
}



@end
