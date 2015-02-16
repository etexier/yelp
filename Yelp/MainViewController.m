//
//  MainViewController.m
//  Yelp
//
//  Created by Emmanuel Texier
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "YelpClient.h"
#import "Business.h"
#import "Businesscell.h"
#import "MBProgressHUD.h"
#import "UIHelper.h"
#import "BusinessesMapView.h"
#import "Filters.h"

// Yelp keys
NSString *const kYelpConsumerKey = @"hglIeq2RP56tBDlBFB1omA";
NSString *const kYelpConsumerSecret = @"E7ikJ1kWzg7itMokjzlMv4pL23Y";
NSString *const kYelpToken = @"zW60JK66xpVTz2rbfIRQTYTijolZLeTX";
NSString *const kYelpTokenSecret = @"-4MnwTvRtE93DRKn9eNfyblZxzw";



// other constants
//NSString *const kMapButtonTitle = @"Map";
NSString *const kFiltersButtonTitle = @"Filters";
NSString *const kTitle = @"List";
NSString *const kDefaultSearchText = @"Restaurant";


@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, FiltersViewControllerDelegate>

@property(nonatomic, strong) YelpClient *client;
@property (weak, nonatomic) IBOutlet BusinessesMapView *mapView;
@property(atomic, strong) NSArray *businesses;
@property(nonatomic, weak) IBOutlet UITableView *tableView;
@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) UIBarButtonItem *filtersButton;
@property(nonatomic, strong) UIBarButtonItem *mapButton;

@property (nonatomic) BOOL showingMap;


- (void)searchWithText:(NSString *)text params:(NSDictionary *)params;

@end

@implementation MainViewController

#pragma mark - View controller methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey
                                               consumerSecret:kYelpConsumerSecret
                                                  accessToken:kYelpToken
                                                 accessSecret:kYelpTokenSecret];

        [self searchWithText:kDefaultSearchText params:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // add search bar to navigation bar
    self.searchBar = [[UISearchBar alloc] init];
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.text = kDefaultSearchText;
    self.searchDisplayController.displaysSearchBarInNavigationBar = YES;

    // set navigation bar buttons
    self.filtersButton = [[UIBarButtonItem alloc] initWithTitle:kFiltersButtonTitle
                                                          style:UIBarButtonItemStylePlain
                                                         target:self
                                                         action:@selector(onFiltersButton)];
    UIImage *mapImage = [UIHelper getMapImage];
    self.mapButton = [[UIBarButtonItem alloc] initWithImage:mapImage landscapeImagePhone:mapImage
                                                      style:UIBarButtonItemStylePlain
                                                     target:self
                                                     action:@selector(onMapButton)];
    self.navigationItem.leftBarButtonItem = self.filtersButton;
    self.navigationItem.rightBarButtonItem = self.mapButton;
    self.filtersButton.enabled = YES;
    self.mapButton.enabled = YES;


    // delegates
    self.searchBar.delegate = self;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;


    // cell registration
    [self.tableView registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];

    // cell auto dim.
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    // not showing map yet.
    self.showingMap = NO;

    self.title = kTitle; // not seen anyway


}


#pragma mark - Table View delegate  methods

//  could be a iOS bug: the cell were squished when going back and forth b/w views
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    cell.business = self.businesses[(NSUInteger) indexPath.row];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    // remove selected color on cell
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data source methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.businesses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    cell.business = self.businesses[(NSUInteger) indexPath.row];
    return cell;
}

#pragma mark - Search bar delegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder]; // hide keyboard
    // do search
    [self searchWithText:self.searchBar.text params:nil];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder]; // hide keyboard
}

#pragma mark - Filters View Controller delegate methods

- (void)filtersViewController:(FiltersViewController *)filtersViewController
             didChangeFilters:(Filters *)filters {
    NSDictionary *params = filters.searchParameters;
    NSLog(@"Fire a new network event: %@", params);
    [self searchWithText:self.searchBar.text params:params];
}

#pragma mark - private methods

- (void)onFiltersButton {

    FiltersViewController *fvc = [[FiltersViewController alloc] init];
    fvc.delegate = self; // to receive the apply event
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:fvc];
    [self presentViewController:nvc animated:YES completion:nil];
}

- (void)onMapButton
{
    if (self.showingMap) {
        // flip back to the list
        [UIView transitionFromView:self.mapView
                            toView:self.tableView
                          duration:1.0
                           options:UIViewAnimationOptionTransitionFlipFromLeft|UIViewAnimationOptionShowHideTransitionViews
                        completion:nil];
        self.mapButton.title = @"Map";
        self.showingMap = NO;
        return;
    }
        // flip to the map
        [UIView transitionFromView:self.tableView
                            toView:self.mapView
                          duration:1.0
                           options:UIViewAnimationOptionTransitionFlipFromRight|UIViewAnimationOptionShowHideTransitionViews
                        completion:nil];
        self.mapButton.title = @"List";
        self.showingMap = YES;

}


- (void)searchWithText:(NSString *)searchText params:(NSDictionary *)params {

    // show spinner while searching
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.client searchWithTerm:searchText params:params success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"response: %@", response);
        // initialize model
        NSArray *businessDictionaries = response[@"businesses"];
        self.businesses = [Business businessesWithDictionaries:businessDictionaries];
        [self.tableView reloadData];
        // end spinner
        [MBProgressHUD hideHUDForView:self.view animated:YES];

        // now enable buttons
        self.filtersButton.enabled = YES;
        self.mapButton.enabled = YES;
    }                   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // TODO: error tab instead?
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network error" message:@"Check your connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        NSLog(@"error: %@", [error description]);

        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}


@end
