class Main
{
	/*
	  TODO:
	  - Exclude user names should be taken from a data source list
	  - Limit the search to only one day so that we don't have to rely on my flimsy timestamp system
	 */

	static var _startingLoop : Int = 1;
	static var _numOfLoops : Int = 5;

	static function main()
	{
		var macroString : String = "";
		macroString += "
VERSION BUILD=8970419 RECORDER=FX
TAB T=1

SET !EXTRACT_TEST_POPUP NO
URL GOTO=https://twitter.com/search?f=tweets&vertical=default&q=%22philipines%22<SP>-from%3AManilaVirgin&src=typd
";
		// To exclude from searches use the format below:
		// -from%3AUserName%2C AND -from%3AUserName

		for ( index in _startingLoop...(_startingLoop + _numOfLoops+1) ) {
			macroString += "
SET currentLoop " + index + " 

TAG POS={{currentLoop}} TYPE=SPAN ATTR=class:\"username js-action-profile-name*\" EXTRACT=TXT
SET !EXTRACT NULL
TAG POS=R1 TYPE=SPAN ATTR=class:\"_timestamp*\" EXTRACT=TXT

'' We get the timestamp. It returns NIL if the tweet is more than a day or invalid.
'' We do this by removing the 'm' and 'h' characters, which should return an integer
SET timeStamp EVAL(\"var extract = \\\"{{!EXTRACT}}\\\"; extract = extract.replace(/(h|m)/g,\\\"\\\"); parseInt(extract);\")

'' We then get the URL of the tweet
TAG POS={{currentLoop}} TYPE=DIV ATTR=class:\"tweet*js-actionable-tweet*\" EXTRACT=TXT
SET !EXTRACT NULL
TAG POS=R1 TYPE=A ATTR=class:\"tweet-timestamp*\" EXTRACT=HREF
SET tweetUrl {{!EXTRACT}}

SET !TIMEOUT_STEP 1
SET !ERRORIGNORE YES

'' If the timestamp is an integer, we then return the class name needed to proceed with the next step
SET buttonClass EVAL(\"var timeStamp = {{timeStamp}}; if ( Number.isInteger(timeStamp) ) { \\\"ProfileTweet-actionButton*\\\" } else { \\\"NULL\\\" }\")
SET buttonClass {{buttonClass}}
TAG POS=R1 TYPE=BUTTON ATTR=class:{{buttonClass}}

WAIT SECONDS=2

'' We type our message
EVENT TYPE=CLICK SELECTOR=\"#tweet-box-global\" BUTTON=0
EVENTS TYPE=KEYPRESS SELECTOR=\"#tweet-box-global\" CHARS=\"Good day! Just a friendly reminder, the correct spelling is \\\"Philippines\\\". Mabuhay! #IAmABot\"

WAIT SECONDS=3

'' We click on the submit button
TAG POS=1 TYPE=BUTTON ATTR=class:\"btn*tweet-action*tweet-btn\"

SET !ERRORIGNORE NO
SET !TIMEOUT_STEP 6

SET !EXTRACT NULL
ADD !EXTRACT {{!NOW:yyyy-mm-dd<SP>hhh<SP>nnmin}}
ADD !EXTRACT {{tweetUrl}}

SAVEAS TYPE=EXTRACT FOLDER=* FILE=ph_spell_checker_bot.csv

WAIT SECONDS=6
";
		}

		macroString += "
TAB CLOSEALLOTHERS
TAB T=1
TAB CLOSE
";
		sys.io.File.saveContent("C:\\Users\\ARebel\\Dropbox\\imacros\\macros\\ph_spell_checker_bot.iim", macroString);
	}
}
