# Introduction

**This is a beta version (v0.2) - no guarantees!** Having said that it all seems to work nicely but I am the only tester so far. I have tested this using CF9, ColdDoc 1.0 and JSDuck 4.10.

##ColdDuck
... beautiful documentation for your ColdFusion classes using ColdDoc and JSDuck. 

## Background
I have been developing a set of ColdFusion CFCs recently and wanted to produce some nice documentation. After much searching I installed [ColdDoc](http://www.compoundtheory.com/?action=colddoc.index) and ran it. It produced a good set of documentation in the JavaDoc style. Thanks to [Mark Mandel at CompoundTheory](http://www.compoundtheory.com/)! 

Here is the ColdDoc JavaDoc style documentation: [http://markmandel.github.io/ColdDoc/docs/](http://markmandel.github.io/ColdDoc/docs/) 

As well as ColdFusion I use [ExtJS](http://www.sencha.com/products/extjs/). ExtJS and Sench Touch has great documentation that is created using [JSDuck](https://github.com/senchalabs/jsduck/wiki) (which is actually an open source Sencha product). Indeed, the very documentation you are reading now was created using JSDuck. 

A full implementation of JSDuck can be seen at the Sencha ExtJS API documentation site: [http://docs.sencha.com/extjs/4.1.3/](http://docs.sencha.com/extjs/4.1.3/)

I have been a consumer of the ExtJS documentation for a while now and wanted to be able to use JSDuck for my ColdFusion CFCs. But how? While I am a JSDuck novice I figured that trying to make JSDuck produce documentation directly from ColdFusion CFCs was likely to result in tears (mine!). So, after some thought, I came up with another strategy that users of other programming languages might want to consider.

**Note:** *I am a JSDuck novice, a part-time ColdFusion coder and a first time GitHub user. I don't know much about Macs so this is all a bit Windows-centric even though everything should work on a Mac (apart from the Windows command lines of course!). Any helpful advice will be gratefully accepted.*
    
## My CF to JSDuck strategy
Mark Mandel's ColdDoc can be extended to produce different kinds of output by utilising a "strategy" cfc. It comes with one that produces the JavaDoc style HTML format. Strategies utilise the CF ComponentMetaData. So, I made my own strategy that takes ColdFusion CFCs and makes a pseudo-app in JavaScript code that is annotated using JSDuck formatting. Of course it auto-documents functions etc and picks up the 'hint' attributes where it finds them and uses all that to produce the raw material for rich documentation. It also works with CF ORM CFCs (although this part could be made even richer than it is at present).

So, for example, this MyBaseClass.CFC
	<cfcomponent displayname="MyBaseClass"  output="false" hint="
	I am the base class.
		
	I have all sorts of wonderful functionality that my normal CFCs can inherit.
	">
	
		<cffunction name="writeToLog" returntype="void" access="private" hint="
		I write something to a log file.
		">
			<cfargument name="something" type="any" required="no" default="" hint="Some text or object or whatever that you want to log">
			<cfscript>
				var logPath = "";
				// Do something in here then return
				return "";
			</cfscript>
		</cffunction>
	
	</cfcomponent>
becomes this MyBaseClass.JS file in the generated pseudoApp folder:  
	/**
	I am the base class.
		
	I have all sorts of wonderful functionality that my normal CFCs can inherit.
	*/
	Ext.define('SuperBlog.MyBaseClass',{
	extend: "WEB-INF.cftags.component",
	
		/**
		I write something to a log file.
		
		@private
		@param {any} [something=''] Some text or object or whatever that you want to log
		@return {void}
		*/
		writeToLog: function(something){}
	
	});
Then, I simply use JSDuck to read the JS pseudoApp to produce the final documentation. You can see the sample result here: [../samples/superblogdocs/#!/api/SuperBlog.MyBaseClass](../samples/superblogdocs/#!/api/SuperBlog.MyBaseClass) (right click / command click to open in a new tab)

## Sample application
ColdDuck comes with a sample CF application called SuperBlog that has a few do-nothing CFCs so that you can play around with the system. 
  
You can view the SuperBlog sample application documented using the ColdDuck process here:
[../samples/superblogdocs/](../samples/superblogdocs/) (right click / command click to open in a new tab)

Ready to try it? Check out the [Setup ColdDuck](../docs/#!/guide/setup) page. 

Happy documenting!

Murray 

PS: While you are documenting your CFCs you might want to listen to our musical namesakes:[http://www.coldduck.com/tunes.php](http://www.coldduck.com/tunes.php) - very groovy!

