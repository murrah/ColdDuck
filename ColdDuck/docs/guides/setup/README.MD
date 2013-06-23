# Setup for using the ColdDuck system
## Download ColdDuck
Download from here: [https://github.com/murrah/ColdDuck](https://github.com/murrah/ColdDuck)

Unzip / copy the whole /ColdDuck folder somewhere into your CF web folder. It doesnt need to be a root folder. 

Follow the instructions below to set it up.
## Requirements in addition to the ColdDuck package
- ColdDoc
- JSDuck

## Download and install ColdDoc
If you don't already have ColdDoc on your system, get it here : [https://github.com/markmandel/ColdDoc](https://github.com/markmandel/ColdDoc)

Download and install it using the instructions supplied there.

### Test your ColdDoc install using the ColdDuck SuperBlog sample 
You can test your ColdDoc install by documenting the sample SuperBlog CFCs using ColdDoc's built-in HTML strategy. This will just make sure ColdDoc is working properly and your mappings are correct.

See [Testing your ColdDoc installation](../docs/#!/guide/colddoc_testing)

## Include the ColdDuck strategy cfc in your ColdDoc installation
Now that you have ColdDoc working you are ready to add the ColdDuck strategy file. 

In your ColdDuck package find the /ColdDuck/ColdDuckStrategy/coldduck folder. 

Copy that folder (ie the folder that contains the file ColdDuckStrategy.cfc) into the <b>ColdDoc</b>/Strategy folder (ie that's <b>ColdDoc</b> not ColdDuck). The path should be:
	/ColdDoc/strategy/coldduck/ColdDuckStrategy.cfc

## Download and install JSDuck
If you don't already have JSDuck on your system, get it here: [https://github.com/senchalabs/jsduck](https://github.com/senchalabs/jsduck)

Installation instructions are there.

And FYI there is another helpful quick tutorial / overview of JSDuck here:
[http://www.swarmonline.com/2013/02/documenting-your-sencha-apps-with-jsduck/](http://www.swarmonline.com/2013/02/documenting-your-sencha-apps-with-jsduck/)

## That's it!
Having done all that you are ready to go to [Getting Started](../docs/#!/guide/getting_started).



 

