## carReader

View contents of a given `.car` file

 - idea by Jason Day
 - thanks to CoolStar for cardump to get me on the right path
 - [iOS-Artwork-Extractor](https://github.com/0xced/iOS-Artwork-Extractor/blob/master/Classes/ArtworkViewController.m) explained how to use `valueForKeyPath:`

TODOs: 
 - Nicer UI (by Jason Day)
 - Better way to pick car files (maybe)

Known bugs:
 - If Assets.car is not in a valid NSBundle location, getting images can fail
 - Memory leak when scrolling
 - Scroll views (in image viewer area) that do not extend to the top of the screen have extra space at the top
