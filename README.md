# PH Spell Checker Twitter Bot
A Twitter Bot that sends a message if someone misspells "Philippines" on Twitter.

## Long Description
The script searches for any mention of "Philipines" (Which is incorrectly spelled) on Twitter, it then replies to each tweet with the phrase:

> Good day! Just a friendly reminder, the correct spelling is "Philippines". Mabuhay! #IAmABot

The bot uses the excellent browser automation tool, [iMacros](http://imacros.net/), and is intended to run with the free [Firefox Addon](https://addons.mozilla.org/en-US/firefox/addon/imacros-for-firefox/).

The code is written in Haxe and compiles to a Php which when run generates a .iim file, which can then be run through the iMacros firefox add on. 

## Notes
* The .iim file in the /output folder is a sample file that is generated when the program is run.
* Notice that the generated .iim file has loops baked into it directly. This is generally not a good idea as it would make the generated file bigger as you add more loops to it. It works for this small project though as it only needs a few (around 5) loops.

## FAQs
* Why is it written in Haxe? Why not code it directly in Php?
  * Because Haxe is the language I am most familiar with and I generally do not like Php.
* Why does it need to compile to Php?
  * Initially I planned to have the iMacros script run from Php. Later on I learned that there are better ways to launch iMacros scripts but did not bother to change the current system. Maybe I will in the future but for now it works.
* Why not use iMacros Commercial Version and make use of their powerful scripting system?
  * The commercial version, while packed with features, are sadly closed source and is a bit expensive for a project as simple as this.

## Todo
- [ ] Increase the number of tweets to reply to
- [ ] Exclude user names should be taken from a data source list
- [ ] Limit the search to only one day so that we don't have to rely on my flimsy timestamp system
