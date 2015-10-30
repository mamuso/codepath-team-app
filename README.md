# codepath-team-app

## TODO

- [ ] Add CocoaPods
- [x] Add Common/Base file
- [ ] We need a name!
- [ ] How do we store variables persistently?? (Manuel)

- [ ] USER EDUCATION
  - [ ] Define steps

- [ ] LOGIN
  - [ ] Pocket API (Manuel)

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
  - [ ] Light vs Dark view (applies everywhere) (Manuel)
  - [ ] Unlink account??


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