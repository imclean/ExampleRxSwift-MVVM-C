# **BumpTestApp**

A simple app built around RxSwift and the Coordinator Pattern that presents a scrolling view of Trending Gifs from the Giphy Api.

### **Files**

**Model/Giphy.swif** - A Codable swift model that takes the required elements from the Json returned from the API and builds a model object.

**Feed/ViewController.swift** - A simple View Controller that conforms to the Storyboarded protocol. This creates a viewmodel, subscribes to the errors PublishSubject in order to display alert for errors. It also binds the tableview to the observable gifs of the viewmodel.

**Feed/ViewControllerViewModel.swift** - A simple ViewModel that once created will collect json from the Giphy api and decode it to an observable array of Gif objects.  This also adds errors on decoding and internet errors.


**Feed/FeedViewCell.swift** - A custom cell that loads the gif into a WKWebView, this will perform better than trying to load into a UIImageView and animating.

**Feed/FeedViewCell.xib** - A simple xib for the FeedViewCell

**Coordinators/Coordinator.swift** - A Coordinator protocol that requires a navigation controller and an implemented start function.

**Coordinators/MainCoordinator.swift** - A class implementation of the Coordinator protocol that enables the app to start with the correct view controller.

**Coordinators/Storyboardedr.swift** - A simple protocol that enables view controllers to be loaded from the storyboard using the associated storyboard name.

There are no Unit Tests employed within the app.

The following Cocoapods have been used:

RxSwift
RxCocoa