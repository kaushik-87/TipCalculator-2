# TipCalculator-2
# Pre-work - TipCalculator-2

TipCalculator-2 is a tip calculator application for iOS.

Submitted by: **Kaushik Thekkekere**

Time spent: **10** hours spent in total

## User Stories

The following **required** functionality is complete:

* [ ] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [ ] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [ ] UI layout supported both portrait/ landscape
* [ ] Used a custom key pad in main screen which makes easier to enter the bill amount.
* [ ] Split bill between certain number of people. Which can be changed in the settings.
* [ ] Using locale-specific currency and currency thousands separators.
* [ ] Minimum, Maximum value of the tip slider can be set in the settings.


The following **additional** features are implemented:

- [ ] List anything else that you can get done to improve the app functionality!

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/MWnlC2U.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='http://i.imgur.com/kLAbZs0.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Project Analysis

As part of your pre-work submission, please reflect on the app and answer the following questions below:

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:** This is one of the best development platform ever. The way app develoment ecosystem is created and the tools and support provided by Apple is really great and very user friendly. 
Oulets and actions are one of the way to vizualize the UI components and its action in the Interface builder. These are used by interface builder to connect the interface with your code. Outlets are the reference for a property in the view controller. It holds the name of the property and has the refernce inside xib in xml format. Actions are used to allow your methods to be associated with actions in Interface builder. It is nothing but internally representing the target/action methods. 

Question 2: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:** Strong refernce cycle is occured when the parent and the child object keeps the strong reference to one another. In this case both the objects stays in memory and never be destroyed. Suppose we have a class named person and it has two property one is Name a string type and other is closure which prints some message. So whenever we create a new person object and closure prints some message. This is fine because the person object is keeping a refernce to the closure. Whenever person object is destroyed the closure is also destroyed. 

Now suppose if the closure is keeping a strong refernce to the name variable like shown below. 
init() {
 self.personClosure = { print("\(self.name) the Developer") }
}

This is nothing but keeping the strong refernce back to parent object, Which will never be freed. The best solution to break this refernce cycle is by using 

self.personClosure = { [weak self] in
print("\(self?.name) the Developer")
}



## License

    Copyright [2017] [kaushik thekkekere]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
