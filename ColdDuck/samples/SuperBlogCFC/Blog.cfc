<cfcomponent displayname="Blog" extends="MyBaseClass"  output="false" hint="
I am a component that blogs. 
	
Not only that, I am really good at it!
">	
<cfscript>
				// Hmmmm.... apart from adding text to the component hint itself,
				// I cant think of a way to auto document these kinds of 
				// instance, variable or THIS declarations without deeply introspecting
				// the java classes (which, of course, is a possibility!)  
	instance.options = {};
	instance.options.commentSize = 1000;	
	instance.options.commentHeader = "Your comments:";
	
	variables.someStruct = {};
	
	THIS.myUUID = "ED1FD0C5-1C42-DD1E-7DF058B857426823";	
</cfscript>

<cffunction name="getOptions" returntype="struct" colddoc:generic="numeric,string" access="public" hint="
Return the current instance.options structure
">
	<cfscript>
		return instance.options;
	</cfscript>
</cffunction>

<cffunction name="addPost" returntype="any" access="public" hint="
I add a blog post
		 
You must always be nice in blog posts!
">
	<cfargument name="postText" type="string" required="yes" default="" hint="The text to post">
	<cfscript>
		return "";
	</cfscript>
</cffunction>


<cffunction name="removePost" returntype="numeric" access="public" hint="
I remove a blog post
">
	<cfargument name="postId" required="yes" hint="The postId">
	<cfscript>
		return arguments.postId;
	</cfscript>
</cffunction>

<cffunction name="countPosts" returntype="numeric" access="private" hint="
I count posts, optionally only for the supplied data structure
">
	<cfargument name="limitData" type="struct" colddoc:generic="string,numeric,boolean" required="no" default="#StructNew()#" hint="The data to tell us how to limit the search">
	<cfscript>
		return 0;
	</cfscript>
</cffunction>

</cfcomponent>