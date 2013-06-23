<cfcomponent displayname="Comments" extends="MyBaseClass" output="false" hint="
## Comments class
I am a component that adds comments to posts.<br>I am being rendered using a combination of markdown and HTML. **Nifty!**
	
#### ColdFusion tip:
Since CF uses ## and so does Markdown, you need to double up your CF ## so that Markdown does the right thing.
#### You can include code samples by indenting 4 spaces
    My code example here

Finally, some more info could go here....
			
">

<cffunction name="init" returntype="Comments" colddoc:generic="Comments" access="public" hint="
I initialise the Comments object and return it.
">
	<cfscript>
		return this;
	</cfscript>
</cffunction>

<cffunction name="addComment" returntype="any" access="public" hint="
I add a comment to a blog post
	 
You must always be nice in blog posts!	
">
	<cfargument name="commentText" required="yes" hint="The comment text">
	<cfscript>
		return "";
	</cfscript>
</cffunction>

<cffunction name="removeComment" returntype="any" access="public" hint="
I remove a comment and optionally tell the client
">
	<cfargument name="commentId" required="yes" type="numeric" hint="The comment Id">
	<cfargument name="silent" type="boolean" required="no" default="false" hint="Send reply to client">
	<cfscript>
		return "";
	</cfscript>
</cffunction>

</cfcomponent>