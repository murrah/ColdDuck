# Tips to improve the documentation of your CFCs

ColdDuck leverages ColdDoc. ColdDoc uses the CF ComponentMetaData to generate the documentation about classes/components (including ORM), functions, parameters, properties, etc. So, you dont need to do anything to get that information into your documentation. 

In other words most of the work is done for you. There are a few things you can do to customise your documentation.

## Hint attribute
ColdDuck looks for the 'hint' attribute on components, functions, parameters and properties and uses that information in the documentation. You can improve the look of the documentation by simply arranging your hint attributes in the following way.

If your hints are short then the usual will suffice:
	<cfargument name="commentText" required="yes" hint="The comment text">

If they are longer, I suggest the following format:
	<cffunction name="addComment" returntype="any" access="public" hint="
	I add a comment to a blog post
		 
	You must always be nice in blog posts!	
	">
ie make the hint the final attribute and start the text on a new line. It will look similar in the documentation - ie with line breaks, not just a long line of text. Of course, you could embed html tags in your text too - JSDuck renders the hints as HTML fragments. See [SuperBlog.Comments](../samples/superblogdocs/#!/api/SuperBlog.Comments) for an example. ie from the SuperBlog.Comments.CFC:
	## Comments class
	I am a component that adds comments to posts.<br>I am being rendered using a combination of markdown and HTML. **Nifty!**
		
	#### ColdFusion tip:
	Since CF uses ## and so does Markdown, you need to double up your CF ## so that Markdown does the right thing.
	#### You can include code samples by indenting 4 spaces
	    My code example here
	
	Finally, some more info could go here....
			
Just suggestions.
## Code samples in the Hint attribute
Markdown (which JSDuck uses) will treat any text that is indented by 4 spaces as a code sample. This is really useful. And there is a small pitfall. If you code your hints as suggested you need to watch out for the indenting in your CFCs. 

eg this will display the argument's hint text as normal text because evertying starts in column 1:
	<cffunction name="myClass" returntype="any" access="public" hint="
	My hint text ...
	">
	<cfargument name="myArgument" type="string" required="yes" hint="
	My argument text	
	">
	</cffunction>

while this will show the argument as a code sample because it is indented 4 spaces (assuming the cffunction tag is in column 1):
	<cffunction name="myClass" returntype="any" access="public" hint="
	My hint text ...
	">
		<cfargument name="myArgument" type="string" required="yes" hint="
		My argument text	
		">
	</cffunction>

## Markdown in Hints
You can include Markdown in your hints (and HTML too if you want). For bold and italic the markdown is **Bold** and *italic*. I have noticed that if you are starting a line with bold or italic in a hint you need to add an extra * to the start.
eg
	***This is bold** and **so is this**
	
	**This is italic* and *so is this* 

I think it is because JSDuck is assuming this kind of comment style:
	/**
	 * 
	 */
whereas for CF hints we dont want to be bothered with all the extra ** and ColdDuck doesnt generate them (on purpose).
 
## Component Displayname attribute
I have had a few issues when testing where sometimes (but not always) ColdDoc chokes if the cfcomponent tag does not have a 'displayname' attribute. I suspect it is something to do with my mapping tests or CF rather than ColdDoc. Just in case you experience this you can try adding the DisplayName.

And, at present, the DisplayName attribute is not used in the documentation. It should probably be an option. I prefer to know exactly what the CFC is called. Others probably have a different view. If you want, it should be easy to fix. See the comment in the ColdDuckStrategy.cfc file in the getPackageAndName() method. 
 
## ColdDoc annotations
ColdDoc provided a way to use custom ColdDoc "metatags" to provide ColdDoc specific functionality for annotating your code. See [https://github.com/markmandel/ColdDoc/wiki/List-of-Custom-Annotations](https://github.com/markmandel/ColdDoc/wiki/List-of-Custom-Annotations) for details.

I added colddoc:ignore to these (for the ColdDuck strategy only) 

### colddoc:abstract
Use it to mark a CFC as "abstract". It will be marked as such in JSDuck.
eg
	<cfcomponent displayname="MyBaseClass" colddoc:abstract="true" access="private" hint="I am the base class.">
Look at the [SuperBlog sample documentation for the MyBaseClass class](../samples/superblogdocs/#!/api/SuperBlog.MyBaseClass). You will see a grey "Abstract" tag next to the Class name. This class is also marked Private due to it having 'access="private"' specified in the cfcomponent tag.
### colddoc:generic
Provides a way to document the data types where a function return type or an argument is not a simple type. eg when passing or returning a CF struct.
eg if the getOptions() method returns a struct that has one numeric and one string field, this annotation will reveal that in the documentation. See the [SuperBlog.Blog class getOptions() method](../samples/superblogdocs/#!/api/SuperBlog.Blog-method-getOptions).

	<cffunction name="getOptions" returntype="struct" colddoc:generic="numeric,string" access="public" hint="Return the current instance.options structure">
At present, it does not provide a way to *automatically* include the field names or descriptions. Of course you could always hand code that into the hint of the function if you wished. And, someone might add that functionality to the ColdDuckStrategy.cfc ;-)

## ColdDuck annotations
### colddoc:ignore
There may be CFCs or functions that you do NOT want to include in the documentation. This is a separate situation to Abstract or Private classes. Setting this annotation means that the CFC or Function will NOT be included in the documentation. If the CFC is *extended* by other CFCs the child CFCs will still "inherit" the ignored CFC but the ignored CFC wont appear in the documentation as a class.
eg
	<cfcomponent displayname="Secret" extends="MyBaseClass" colddoc:ignore hint="My secret CFC">
At present this annotation is for ColdDuck only.

### <<coldducktable
Neither Markdown sytax nor JSDuck provide a way to include a table. You can, of course, use html in your Hint attributes in ColdFusion to hand code a table. I needed to do this and rather than coding the html I decided to add a special tag that you can include in any hint that will generate a html table for you.
eg  
	<<coldducktable{
		"tableAttr" : "border=1",
		"cellStyle"	: "padding:4px;",
		"delim"		: "^",
		"rows"		: [
			 "Style^Comment"
			,"font-size^Set the font size"
			,"color^Sets the font colour"
			,"background-color^Sets the background of the body of the comment"
		]						
	}
	>>
Now, if your table is small it would be easier to code it directly in html yourself. If it is longer, the syntax above might be more compact. It is just another option.

**Note** I tried using the html TABLE cellPadding attribute instead of adding the cellStyle to each TD, however it seems that jsDuck ignores the table cellPadding attribute.

See the ColdDuckStrategy.processColdDuckCustomTags() method. This is marked as experimental. 
 