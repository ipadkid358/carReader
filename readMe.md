## carReader

View contents of a given `.car` file

 - idea by Jason Day
 - thanks to CoolStar for cardump to get me on the right path
 - [iOS-Artwork-Extractor](https://github.com/0xced/iOS-Artwork-Extractor/blob/master/Classes/ArtworkViewController.m) explained how to use `valueForKeyPath:`


## Documentaion on `_UIAssetManager`
```obj-c
// Private class in UIKit (public framework)
_UIAssetManager *assets;

// Below classes are in CoreUI (private framework)
CUICatalog *catalog = assets._catalog;
CUIStructuredThemeStore *themeStore = catalog._themeStore;

NSArray<NSString *> *allImageNames = themeStore.allImageNames;
```

### TODOs:
 - Fix filesystem dump to skip symlinks
