//
// Created by Emmanuel Texier on 2/14/15.
// Copyright (c) 2015 codepath. All rights reserved.
//

#import "Filters.h"
#import "YelpException.h"

@interface Filters()

@end

@implementation Filters

- (id)initWithDefaults {
    self = [super init];
    if (self) {
        self.selectedSortMode = @0;
        [self initSortModes];

        self.dealsOnlySelected = NO;

        self.selectedCategories = [NSMutableSet set];
        [self initCategories];

        self.selectedDistance = @0;
        self.selectedDistance = @0;
        [self initDistances];

    }
    return self;
}

- (void)initSortModes {
    self.sortModes =
            @[
                    @{@"name" : @"Best Match", @"value" : @0},
                    @{@"name" : @"Closest", @"value" : @1},
                    @{@"name" : @"Highest rated", @"value" : @2}
            ];

}


- (void)initDistances {
    self.distances =
            @[
                    @{@"name" : @"Auto", @"value" : @0},
                    @{@"name" : @"100 m", @"value" : @100},
                    @{@"name" : @"1 km", @"value" : @1000},
                    @{@"name" : @"5 kms", @"value" : @5000},
                    @{@"name" : @"10 kms", @"value" : @10000},
            ];
}

// restaurant categories only
- (void)initCategories {
    self.categories =
            @[
                    @{@"name" : @"Afghan", @"code" : @"afghani"},
                    @{@"name" : @"African", @"code" : @"african"},
                    @{@"name" : @"Senegalese", @"code" : @"senegalese"},
                    @{@"name" : @"South African", @"code" : @"southafrican"},
                    @{@"name" : @"American, New", @"code" : @"newamerican"},
                    @{@"name" : @"American, Traditional", @"code" : @"tradamerican"},
                    @{@"name" : @"Arabian", @"code" : @"arabian"},
                    @{@"name" : @"Argentine", @"code" : @"argentine"},
                    @{@"name" : @"Armenian", @"code" : @"armenian"},
                    @{@"name" : @"Asian Fusion", @"code" : @"asianfusion"},
                    @{@"name" : @"Australian", @"code" : @"australian"},
                    @{@"name" : @"Austrian", @"code" : @"austrian"},
                    @{@"name" : @"Bangladeshi", @"code" : @"bangladeshi"},
                    @{@"name" : @"Barbeque", @"code" : @"bbq"},
                    @{@"name" : @"Basque", @"code" : @"basque"},
                    @{@"name" : @"Belgian", @"code" : @"belgian"},
                    @{@"name" : @"Brasseries", @"code" : @"brasseries"},
                    @{@"name" : @"Brazilian", @"code" : @"brazilian"},
                    @{@"name" : @"Breakfast & Brunch", @"code" : @"breakfast_brunch"},
                    @{@"name" : @"British", @"code" : @"british"},
                    @{@"name" : @"Buffets", @"code" : @"buffets"},
                    @{@"name" : @"Burgers", @"code" : @"burgers"},
                    @{@"name" : @"Burmese", @"code" : @"burmese"},
                    @{@"name" : @"Cafes", @"code" : @"cafes"},
                    @{@"name" : @"Cafeteria", @"code" : @"cafeteria"},
                    @{@"name" : @"Cajun/Creole", @"code" : @"cajun"},
                    @{@"name" : @"Cambodian", @"code" : @"cambodian"},
                    @{@"name" : @"Caribbean", @"code" : @"caribbean"},
                    @{@"name" : @"Dominican", @"code" : @"dominican"},
                    @{@"name" : @"Haitian", @"code" : @"haitian"},
                    @{@"name" : @"Puerto Rican", @"code" : @"puertorican"},
                    @{@"name" : @"Trinidadian", @"code" : @"trinidadian"},
                    @{@"name" : @"Catalan", @"code" : @"catalan"},
                    @{@"name" : @"Cheesesteaks", @"code" : @"cheesesteaks"},
                    @{@"name" : @"Chicken Shop", @"code" : @"chickenshop"},
                    @{@"name" : @"Chicken Wings", @"code" : @"chicken_wings"},
                    @{@"name" : @"Chinese", @"code" : @"chinese"},
                    @{@"name" : @"Cantonese", @"code" : @"cantonese"},
                    @{@"name" : @"Dim Sum", @"code" : @"dimsum"},
                    @{@"name" : @"Shanghainese", @"code" : @"shanghainese"},
                    @{@"name" : @"Szechuan", @"code" : @"szechuan"},
                    @{@"name" : @"Comfort Food", @"code" : @"comfortfood"},
                    @{@"name" : @"Corsican", @"code" : @"corsican"},
                    @{@"name" : @"Creperies", @"code" : @"creperies"},
                    @{@"name" : @"Cuban", @"code" : @"cuban"},
                    @{@"name" : @"Czech", @"code" : @"czech"},
                    @{@"name" : @"Delis", @"code" : @"delis"},
                    @{@"name" : @"Diners", @"code" : @"diners"},
                    @{@"name" : @"Fast Food", @"code" : @"hotdogs"},
                    @{@"name" : @"Filipino", @"code" : @"filipino"},
                    @{@"name" : @"Fish & Chips", @"code" : @"fishnchips"},
                    @{@"name" : @"Fondue", @"code" : @"fondue"},
                    @{@"name" : @"Food Court", @"code" : @"food_court"},
                    @{@"name" : @"Food Stands", @"code" : @"foodstands"},
                    @{@"name" : @"French", @"code" : @"french"},
                    @{@"name" : @"Gastropubs", @"code" : @"gastropubs"},
                    @{@"name" : @"German", @"code" : @"german"},
                    @{@"name" : @"Gluten-Free", @"code" : @"gluten_free"},
                    @{@"name" : @"Greek", @"code" : @"greek"},
                    @{@"name" : @"Halal", @"code" : @"halal"},
                    @{@"name" : @"Hawaiian", @"code" : @"hawaiian"},
                    @{@"name" : @"Himalayan/Nepalese", @"code" : @"himalayan"},
                    @{@"name" : @"Hong Kong Style Cafe", @"code" : @"hkcafe"},
                    @{@"name" : @"Hot Dogs", @"code" : @"hotdog"},
                    @{@"name" : @"Hot Pot", @"code" : @"hotpot"},
                    @{@"name" : @"Hungarian", @"code" : @"hungarian"},
                    @{@"name" : @"Iberian", @"code" : @"iberian"},
                    @{@"name" : @"Indian", @"code" : @"indpak"},
                    @{@"name" : @"Indonesian", @"code" : @"indonesian"},
                    @{@"name" : @"Irish", @"code" : @"irish"},
                    @{@"name" : @"Italian", @"code" : @"italian"},
                    @{@"name" : @"Japanese", @"code" : @"japanese"},
                    @{@"name" : @"Ramen", @"code" : @"ramen"},
                    @{@"name" : @"Teppanyaki", @"code" : @"teppanyaki"},
                    @{@"name" : @"Korean", @"code" : @"korean"},
                    @{@"name" : @"Kosher", @"code" : @"kosher"},
                    @{@"name" : @"Laotian", @"code" : @"laotian"},
                    @{@"name" : @"Latin American", @"code" : @"latin"},
                    @{@"name" : @"Colombian", @"code" : @"colombian"},
                    @{@"name" : @"Salvadorean", @"code" : @"salvadorean"},
                    @{@"name" : @"Venezuelan", @"code" : @"venezuelan"},
                    @{@"name" : @"Live/Raw Food", @"code" : @"raw_food"},
                    @{@"name" : @"Malaysian", @"code" : @"malaysian"},
                    @{@"name" : @"Mediterranean", @"code" : @"mediterranean"},
                    @{@"name" : @"Falafel", @"code" : @"falafel"},
                    @{@"name" : @"Mexican", @"code" : @"mexican"},
                    @{@"name" : @"Middle Eastern", @"code" : @"mideastern"},
                    @{@"name" : @"Egyptian", @"code" : @"egyptian"},
                    @{@"name" : @"Lebanese", @"code" : @"lebanese"},
                    @{@"name" : @"Modern European", @"code" : @"modern_european"},
                    @{@"name" : @"Mongolian", @"code" : @"mongolian"},
                    @{@"name" : @"Moroccan", @"code" : @"moroccan"},
                    @{@"name" : @"Pakistani", @"code" : @"pakistani"},
                    @{@"name" : @"Persian/Iranian", @"code" : @"persian"},
                    @{@"name" : @"Peruvian", @"code" : @"peruvian"},
                    @{@"name" : @"Pizza", @"code" : @"pizza"},
                    @{@"name" : @"Polish", @"code" : @"polish"},
                    @{@"name" : @"Portuguese", @"code" : @"portuguese"},
                    @{@"name" : @"Poutineries", @"code" : @"poutineries"},
                    @{@"name" : @"Russian", @"code" : @"russian"},
                    @{@"name" : @"Salad", @"code" : @"salad"},
                    @{@"name" : @"Sandwiches", @"code" : @"sandwiches"},
                    @{@"name" : @"Scandinavian", @"code" : @"scandinavian"},
                    @{@"name" : @"Scottish", @"code" : @"scottish"},
                    @{@"name" : @"Seafood", @"code" : @"seafood"},
                    @{@"name" : @"Singaporean", @"code" : @"singaporean"},
                    @{@"name" : @"Slovakian", @"code" : @"slovakian"},
                    @{@"name" : @"Soul Food", @"code" : @"soulfood"},
                    @{@"name" : @"Soup", @"code" : @"soup"},
                    @{@"name" : @"Southern", @"code" : @"southern"},
                    @{@"name" : @"Spanish", @"code" : @"spanish"},
                    @{@"name" : @"Sri Lankan", @"code" : @"srilankan"},
                    @{@"name" : @"Steakhouses", @"code" : @"steak"},
                    @{@"name" : @"Sushi Bars", @"code" : @"sushi"},
                    @{@"name" : @"Taiwanese", @"code" : @"taiwanese"},
                    @{@"name" : @"Tapas Bars", @"code" : @"tapas"},
                    @{@"name" : @"Tapas/Small Plates", @"code" : @"tapasmallplates"},
                    @{@"name" : @"Tex-Mex", @"code" : @"tex-mex"},
                    @{@"name" : @"Thai", @"code" : @"thai"},
                    @{@"name" : @"Turkish", @"code" : @"turkish"},
                    @{@"name" : @"Ukrainian", @"code" : @"ukrainian"},
                    @{@"name" : @"Uzbek", @"code" : @"uzbek"},
                    @{@"name" : @"Vegan", @"code" : @"vegan"},
                    @{@"name" : @"Vegetarian", @"code" : @"vegetarian"},
                    @{@"name" : @"Vietnamese", @"code" : @"vietnamese"}
            ];

}

- (NSDictionary *)searchParameters {
    NSMutableDictionary *filters = [NSMutableDictionary dictionary];

    // categories
    if (self.selectedCategories.count > 0) {
        NSMutableArray *names = [NSMutableArray array];
        for (NSDictionary *category in self.selectedCategories) {
            [names addObject:category[@"code"]];
        }
        NSString *categoryFilter = [names componentsJoinedByString:@","];
        filters[@"category_filter"] = categoryFilter;

    }

    // distance
    NSUInteger distanceIndex = [self.selectedDistance unsignedIntegerValue];
    if (distanceIndex != 0) {
        filters[@"radius_filter"] = self.distances[distanceIndex][@"value"];
    }

    // sort mode
    NSUInteger sortModeIndex = [self.selectedSortMode unsignedIntegerValue];
    filters[@"sort"] = self.sortModes[sortModeIndex][@"value"];

    // deals only
    if (self.dealsOnlySelected) {
        filters[@"deals_filter"] = @"1";
    }

    return filters;
}




- (id)copyWithZone:(NSZone *)zone {
    Filters *copy = [[Filters allocWithZone:zone] init];
    copy.searchTerm = self.searchTerm;
    copy.selectedDistance = self.selectedDistance;
    copy.selectedSortMode = self.selectedSortMode;
    copy.dealsOnlySelected = self.dealsOnlySelected;
    copy.categories = [self.categories mutableCopy];
    return copy;
}



@end
