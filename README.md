# Infrared

![Infrared](https://github.com/infrared-io/infrared_ios/wiki/images/iphone_app@3x.png)

## Introduction  

Infrared is library for iOS development which allows updating app's UI, Interaction and resource without re-submitting app to App Store.  
How is this achieved:  
* UI:   
instead of defining it in ObjC code and Storyboard, Infrared uses JSON description files  
* Interaction:  
handling user's interaction is done in JavaScript    
(Interaction can also be handled in ObjC but distribution of those changes requires submitting new version to App Store.)   
* Resources:   
all resources used by app can be updated at any time. This includes localization, images, files, fonts, etc.

### JSON UI example

```json
{
  "id" : "label_id",
  "type" : "label",
    "backgroundColor" : "#ff000080",
    "text" : "IR Label",
    "textAlignment" : "NSTextAlignmentCenter",
    "textColor" : "#ffffffaa",
    "font" : "SystemBold, 16"
}
```

### JavaScript example

```javascript
infrared.plugin("main", {
    "data" : {
        "text_1" : 'value 1',
        "text_2" : 'value 2',
        "color"  : '#ffffff'
    },
    "actionMethods" : function () {
        // do some UI/Interaction/Data manipulation
    }
});
```

## App Structure

Entry point for Infrared based app is App.json where files for defining UI, Interaction and Resources are listed.

### App.json Example

```json
{
  "id": "app_name",
  "screens": [
    {
      "deviceType": "phone",
      "path": "lending_screen.json"
    },
    {
      "deviceType": "phone",
      "path": "signin_and_singup_screen.json"
    }
  ],
  "globalJSPluginPaths" : [
    "data_storage.js", "data_processing.js", "network_communication.js"
  ],
  "fonts" : [
    "Brandon_light.otf",
    "Brandon_light_it.otf"
  ],
  "mainScreenId": "lending_screen_id",
  "i18n" : {
    "default" : "en",
    "languages" : {
      "en" : "en.json",
      "fr" : "fr.json"
    }
  },
  "label": "dev",
  "version": 2
}
```


## Setup

Simplest way to use podfile and initiate library in AppDelegate.

### Podfile

```
pod "Infrared"
```

###Code in AppDelegate

```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];

    [[Infrared sharedInstance] buildInfraredAppFromPath:@"app.json"];

    return YES;
}
```

## Documentation

Detailed documentation can be find in projects [wiki page](https://github.com/infrared-io/infrared_ios/wiki)

----
IMPORTANT:  
- master branch is for development  
- tags are for stable versions

---

## License

infrared_ios is released under the Apache License, Version 2.0. See
[LICENSE](https://github.com/infrared-io/infrared_ios/blob/master/NOTICE).