# MyBaseClass.cfc
	<cfcomponent displayname="MyBaseClass" colddoc:abstract="true" access="private" output="false" hint="
	I am the base class.
		
	I have all sorts of wonderful functionality that my normal CFCs can inherit.
	">
	
	<cffunction name="writeToLog" returntype="void" access="private" hint="
	I write something to a log file.
	">
		<cfargument name="something" type="any" required="no" default="" hint="Some text or object or whatever that you want to log">
		<cfscript>
			return "";
		</cfscript>
	</cffunction>
	
	
	</cfcomponent>
