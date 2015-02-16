## Yelp

This is a Yelp search app using the [Yelp API](http://www.yelp.com/developers/documentation/v2/search_api).

Time spent: `13hr`

### Features

#### Required

- [X] Search results page
   - [X] Table rows should be dynamic height according to the content height
   - [X] Custom cells should have the proper Auto Layout constraints
   - [X] Search bar should be in the navigation bar (doesn't have to expand to show location like the real Yelp app does).
- [X] Filter page. Unfortunately, not all the filters are supported in the Yelp API.
   - [X] The filters you should actually have are: category, sort (best match, distance, highest rated), radius (meters), deals (on/off).
   - [X] The filters table should be organized into sections as in the mock.
   - [X] You can use the default UISwitch for on/off states. Optional: implement a custom switch
   - [X] Clicking on the "Search" button should dismiss the filters page and trigger the search w/ the new filter settings.
   - [X] Display some of the available Yelp categories (choose any 3-4 that you want).

#### Optional

- [ ] Search results page
   - [ ] Infinite scroll for restaurant results
   - [ ] Implement map view of restaurant results
- [ ] Filter page
   - [ ] Radius filter should expand as in the real Yelp app
   - [X] Categories should show a subset of the full list with a "See All" row to expand. 
- [ ] Implement the restaurant detail page.

### Additional notes

Note that I intended to use Rest2Mobile, but this meant completely redo what had been done in the walkthrough. The code simply uses AFNetworking.
### Walkthrough

![Video Walkthrough](...)



Credits
---------
* [Yelp API](http://www.yelp.com/developers/documentation)
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
* [Rest2Mobile](https://github.com/magnetsystems/rest2mobile)
* Icon made by [Google](http://www.google.com) from [FlatIcon](http://www.flaticon.com>, is licensed by [Creative Commons BY 3.0](http://creativecommons.org/licenses/by/3.0/)

### License

Licensed under the **[Apache License, Version 2.0] [license]** (the "License");
you may not use this software except in compliance with the License.
