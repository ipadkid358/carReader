## carReader

View contents of a given `.car` file

 - idea by Jason Day
 - thanks to CoolStar for cardump to get me on the right path
 - [iOS-Artwork-Extractor](https://github.com/0xced/iOS-Artwork-Extractor/blob/master/Classes/ArtworkViewController.m) explained how to use `valueForKeyPath:`

## TODOs:
 - Nicer UI (will be done with Jason Day)
 - Better way to pick car files (maybe)

### Known bugs:
 - If Assets.car is not in a valid NSBundle location, getting images can fail (not major)
 - Memory leak when scrolling
 - ScrollView can break when changing orientations
