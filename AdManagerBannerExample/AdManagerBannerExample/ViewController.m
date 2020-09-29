//
//  ViewController.m
//  AdManagerBannerExample
//
//  Created by Pramod on 29/09/20.
//

#import "ViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
static NSString *const kAdManagerAppEventsAdUnitID = @"/6499/example/APIDemo/AppEvents";

@interface ViewController ()<DFPBannerAdLoaderDelegate, GADAppEventDelegate>
@property(nonatomic, strong) GADAdLoader *adLoader;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *adTypes = [[NSMutableArray alloc] init];
    [adTypes addObject:kGADAdLoaderAdTypeDFPBanner];
    
    // Create banner options, set appEventDelegate
    DFPBannerViewOptions *bannerOptions = [[DFPBannerViewOptions alloc] init];
    bannerOptions.appEventDelegate = self;
    bannerOptions.enableManualImpressions = true;
    
    
    // Create GADAdLoader intance to load banner ad
    self.adLoader = [[GADAdLoader alloc] initWithAdUnitID:kAdManagerAppEventsAdUnitID
                                       rootViewController:self
                                                  adTypes:adTypes
                                                  options:@[bannerOptions ]];
    // Set delegate
    self.adLoader.delegate = self;
    
    // Load ad
    [self.adLoader loadRequest:[DFPRequest request]];
}

/// Called when the banner receives an app event.
- (void)adView:(nonnull GADBannerView *)banner
didReceiveAppEvent:(nonnull NSString *)name
      withInfo:(nullable NSString *)info {
    // Expected output -> color is <color_name>
    NSLog(@"%@ is %@",name,info);
}

- (void)adLoader:(GADAdLoader *)adLoader didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"%@ failed with error: %@", adLoader, [error localizedDescription]);
}

/// Asks the delegate which banner ad sizes should be requested.
- (nonnull NSArray<NSValue *> *)validBannerSizesForAdLoader:(nonnull GADAdLoader *)adLoader {
    return @[NSValueFromGADAdSize(kGADAdSizeBanner)
    ];
}

- (void)adLoader:(nonnull GADAdLoader *)adLoader
didReceiveDFPBannerView:(nonnull DFPBannerView *)bannerView {
    bannerView.backgroundColor = [UIColor redColor];
    
    // Attach banner ad to the center of view controller
    bannerView.center = CGPointMake(CGRectGetWidth(self.view.bounds)/2,
                                    CGRectGetHeight(self.view.bounds)/2);
    [self.view addSubview:bannerView];
}


@end
