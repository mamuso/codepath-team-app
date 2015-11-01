# codepath-team-app

## TODO

- [x] Add CocoaPods
- [x] Add Common/Base file
- [ ] We need a name!
- [x] How do we store variables persistently?? (https://gist.github.com/licvido/d2f624250dfc44d2f9dd)

- [ ] USER EDUCATION
  - [ ] Define steps

- [x] LOGIN
  - [x] Pocket API (Manuel)

- [ ] ARTICLES LISTING
  - [ ] Table Cells for Articles
  - [ ] Explore table cell design / Progress / Is a fav? (Angel) => nib file
  - [ ] Gestures - Share/Favorite — Archive (Angel)
  - [ ] Pull to refresh

- [ ] ARTICLE VIEW 
  - [ ] Pan gesture right to go back
  - [v1] Screen edge gesture left to expose – Design explorations (Magnolia)
  - [v1] Where / what are the actions? — Share, favorite (Magnolia)
 
- [ ] SETTINGS
  - [ ] Text size interaction (3 sizes) (Manuel)
  - [x] Light vs Dark view (applies everywhere) (Manuel)
  - [x] Unlink account??


## Installation notes

## Gems

To set up the development environment you should install the gem bundler

`sudo gem install bundler`

Once the gem it is installed, you should go to the folder of the project and run

`bundle install`

This should install for you all the gems you need.

## Cocoapods

To install the cocoapods for the project you need to type

`pod install`

This will ask you for the `PocketSdkConsumerKey`. This key is the one we shared in the slack chat.

Sometimes this process throws an error. If this is your case run `pod install` again and everything should be good.

## Problems Merging 

Try this is the tool we used to merge conflicted pbxproj is https://github.com/simonwagner/mergepbx