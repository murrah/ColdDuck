
<cfcomponent extends="colddoc.strategy.AbstractTemplateStrategy" output="false" hint="

ColdDuck - A JSDuck Document Strategy for ColdDoc
Murray Hopkins.
v 0.1 21st June 2013
https://github.com/murrah/ColdDuck
												
This ColdDoc strategy writes your CFCs as JavaScript files to make a pseudo-application that
JSDuck can read and make nice documentation files out of. The JS functions are empty stubs but do have
the parameter lists.
		
I cloned it from the HTMLAPIStrategy.cfc file
		
1. Add a folder to ColdDoc/strategy called coldduck
2. Add this component to that folder
3. Read the accompanying documentation.
	
">

<!--- Ideas:
1. re colddoc:generic
Override getGenericTypes() 

to allow things like:
colddoc:generic="numeric:commentSize:The comment size,string:commentHeader:The comment header"
ie structure field type, name and hint

or even introspect that from a given variable name:
colddoc:generic="variables.mystruct"
ie supply a variable name to introspect and extract the fields in that variable (name, datatype)
but cant really get any hints from structures (apart from having meaningful fieldnames, of course)



 --->

<!------------------------------------------- PUBLIC ------------------------------------------->

<cfscript>
	// We dont need any resource templates
	//instance.static.TEMPLATE_PATH = "/colddoc/strategy/api/resources/templates";
				
				// New line string
	instance.NL = "#chr(13)&chr(10)#"; 
	
				// Set some option defaults
	instance.strategyOptions = {};

	instance.strategyOptions.MissingHintString = "";
	instance.strategyOptions.IgnorePrivateClasses = false;
	instance.strategyOptions.IgnorePrivateMethods = false;
				
				// For jsduckConfig.json file generation:
	instance.strategyOptions.PathToDocs = ""; 
	instance.strategyOptions.JSDuckConfig = '{
			    "--title"		: "{DocTitle}",
			    "--no-source"	: true,
			    "--external"	: "WEB-INF.cftags.component,numeric,any,struct,array,date,query,str",			    
			    "--warnings"	: ["-link", "-no_doc"],			    
			    "--"			: [{inputPath}],
			    "--output"		: "{outputPath}"
			}';
</cfscript>


<cffunction name="init" hint="Constructor" access="public" returntype="ColdDuckStrategy" output="false">
	<cfargument name="outputDir" hint="the output directory" type="string" required="Yes">
	<cfargument name="projectTitle" hint="the title of the project" type="string" required="No" default="Untitled">
	<cfscript>
		super.init();

		setOutputDir(arguments.outputDir);
		setProjectTitle(arguments.projectTitle);

		return this;
	</cfscript>
</cffunction>

<cffunction name="run" hint="Run this strategy" access="public" returntype="void" output="true">
	<cfargument name="qMetadata" hint="the meta data query" type="query" required="Yes">
	<cfscript>
					// Entry point for a ColdDoc strategy
		
					// Write the jsDuckConfig.json file if we have data for it.
					// We write it to the same folder that we are executing ColdDoc in
					// so it is available to the JSDuck execution in that folder.
					// This is just a helper function. You can run JSDuck from the command line
					// or with your own batch file if you wish.
					
					// instance.strategyOptions.JSDuckConfig is a text json file.
					// If you want to use different JSDuck options to the default ones, you need
					// to provide a COMPLETE set of options. You cant currently override 
					// just one JSDuck config setting (for example)
					
		if (trim(instance.strategyOptions.JSDuckConfig neq "") and trim(instance.strategyOptions.PathToDocs) neq "") {
			instance.strategyOptions.JSDuckConfig = replaceNoCase(instance.strategyOptions.JSDuckConfig,"{DocTitle}","#getProjectTitle()#","All");
			
			local.tmp = replaceNoCase(getOutputDir(), "\", "/", "all");
			instance.strategyOptions.JSDuckConfig = replaceNoCase(instance.strategyOptions.JSDuckConfig,"{inputPath}",'"#local.tmp#"',"All");
			
			instance.strategyOptions.PathToDocs = replaceNoCase(instance.strategyOptions.PathToDocs, "\", "/", "all");			
			instance.strategyOptions.JSDuckConfig = replaceNoCase(instance.strategyOptions.JSDuckConfig,"{outputPath}",instance.strategyOptions.PathToDocs,"All");
						
			local.jsduckConfigFilePath = expandPath(".") & "/jsduckConfig.json";
			fileWrite(jsduckConfigFilePath,instance.strategyOptions.JSDuckConfig);
		}

					// Generate the pseudoApp JS files
		writePackagePages(arguments.qMetaData);
    </cfscript>
</cffunction>

<!------------------------------------------- PACKAGE ------------------------------------------->

<!------------------------------------------- PRIVATE ------------------------------------------->


<cffunction name="writePackagePages" hint="writes the package summaries" access="private" returntype="void" output="true">
	<cfargument name="qMetadata" hint="the meta data query" type="query" required="Yes">
	<cfscript>
		var currentDir = 0;
		var qPackage = 0;
		var qClasses = 0;
		var qInterfaces = 0;
	</cfscript>

	<cfoutput query="arguments.qMetaData" group="package">
		<cfscript>
						// ie get all the CFCs in the folder determined by "package"
			qPackage = getMetaSubquery(arguments.qMetaData, "package = '#package#'", "name asc");
						// Pass that set of CFCs to buildClassPages() which will make a .js file
						// from each CFC
			buildClassPages(qPackage);						
		</cfscript>
	</cfoutput>
</cffunction>

<cffunction name="buildClassPages" hint="Builds the class pages for the CFCs contained in the package" access="private" returntype="void" output="true">
	<cfargument name="qPackage" hint="the query for a specific package" type="query" required="Yes">
	<cfscript>
		var qSubClass = 0;
		var qImplementing = 0;
		var currentDir = 0;
		var subClass = 0;
		var safeMeta = 0;
	</cfscript>

	<cfloop query="arguments.qPackage">
		<cfscript>
							// arguments.qPackage contains a query of all the CFCs 
							// that were found in the same package/folder
							
							// Make sure the output folder exists			
			currentDir = getOutputDir();
			ensureDirectory(currentDir);
			
							// Clone the component metadata
							// The metaData variable is in the query row. It was put there by ColdDoc.cfc
			safeMeta = structCopy(metadata);
			
								// Pass the desired output .js file name, the CFC metadata and the 
								// package name (again, from the query row).
								// Use that data to make the .js file.
								// Specify both the package and the name to avoid possible
								// overwriting files with the same name from different packages
			writePseudoJSFile(path=currentDir & "/#package#.#name#.js", metadata = safeMeta, package=package);
		</cfscript>
	</cfloop>

</cffunction>


<cffunction name="writePseudoJSFile" access="private" returntype="void" output="true" hint="
Writes a pseudo JS file for the given CFC whose metadata is contained in arguments.metaData.
		
By 'pseudo' I mean that the JS is valid, but the function bodies do not have any code in them. 
They are just 'stubs' containing the correct function names and parameter lists etc.
We add JSDuck annotations as required (eg @public @property etc)
	
We also add ExtJS class define and extend statements that JSDuck can understand.
">
	<cfargument name="path" hint="where to write the template" type="string" required="Yes">
	<cfargument name="metaData" hint="The class metadata" type="struct" required="Yes">
	<cfargument name="package" hint="The package name" type="string" required="Yes">

	<cfscript>
		var js = "";
		var local = {};
		var NL = instance.NL;		
		var stopAtEnd = false; // for debugging
		/* For debugging 
		if (arguments.metaData.name contains 'comments') { //superblog.blog
			writeDump(arguments);
			stopAtEnd = true;
		}
		*/
						// Get the metadata for the CFC file
		local.cfcMetadata = arguments.metaData;

		if (structKeyExists(cfcMetadata,'ColdDoc:ignore')) {
			if (fileExists(arguments.path)) fileDelete(arguments.path);
			RETURN;
		}
		
						// Check Access private/public
		local.access = "";
		if (structKeyExists(cfcMetadata,'access')){
			
									// Maybe only for private and public? What about 'remote' etc
			local.access = cfcMetadata.access; 						
			if (cfcMetadata.access eq "private") {				
									// If they have asked to Ignore Private classes, 
									// delete any existing instance of that output js file 
									// then RETURN now
				if (instance.strategyOptions.IgnorePrivateClasses) {
					if (fileExists(arguments.path)) fileDelete(arguments.path);
					RETURN;
				}				
			}
		}
										
						// Save the packageName to save passing it around
		instance.packageName = arguments.package;	

				
						// Just take note if the CFC is persistant. 
						// eg For a persistant (ORM) class.
						// Hmmmm What if the user has set persistant = false
						// Should we ignore the CFC altogether?
		local.isPersistent = (structKeyExists(cfcMetadata,'PERSISTENT'));	
				
						// Start creating the pseudo js file for this component / class 
						// by adding any Hint text from the cfcomponent tag
		js = "/**";
						// Set a default hint
		local.hint = instance.strategyOptions.MissingHintString;	
						
						// If there is a cfcomponent hint, use it
		if (structKeyExists(cfcMetadata,'hint')) hint = cfcMetadata.hint;

		hint = NL & hint & NL;
		
		if (local.access neq "" and local.access neq "public") {
			js = js & NL & "@" & local.access & NL; 
		}		
						// ColdDoc:abstract
		if (structKeyExists(cfcMetadata,'ColdDoc:abstract')){
			if (cfcMetadata['ColdDoc:abstract'] eq "true") {
				js = js & NL & "@abstract" & NL; 
			}
		}
		
						// Also just make note if this is a persistent CFC.
						// I dont think there is a relevant JSDuck tag for that
						// TODO: Add more ORM info eg relationship types etc
		if (structKeyExists(cfcMetadata,'TABLE') && isPersistent) {
			js = js & NL & 'I persist to the "#cfcMetadata.TABLE#" table.' &NL; 
		}
		
		js = js & hint & "*/" &NL; 
		
						// Now create the class name details as a JS class.
						// This will keep the dot notation eg myPackage.myClass
		local.pathStr = getPackageAndName(arguments.package,cfcMetadata.NAME);
		js = js & "Ext.define('#pathStr#',{" &NL;
		
						// Add Extend if it is present
		if (structKeyExists(cfcMetadata,'EXTENDS')){			
			if (structKeyExists(cfcMetadata.EXTENDS,'FULLNAME')){
				local.pathStr = getPackageAndName(arguments.package,cfcMetadata.EXTENDS.FULLNAME);
				js= js & 'extend: "#pathStr#",' & NL;	
			}	
		}

						// Get the CFC's PROPERTIES array (if it exists) and process the properties
						// into @property tags						
		if (structKeyExists(cfcMetadata,'PROPERTIES')){
			js = js & getPropertiesSection(cfcMetadata.Properties);		 			
		}
		
						// Now add the methods / functions for this CFC / class.															
						// Get the CFC's FUNCTIONS array and process it	
						// eg @param tags				
		if (structKeyExists(cfcMetadata,'FUNCTIONS')){
			js = js & getFunctionsSection(cfcMetadata.Functions, isPersistent);
		} 
		
						// Write the end of the CFC / JS Class
		js = js & NL & "});" & NL;	
						// Write the text as a .js file
		
		fileWrite(arguments.path, js);
		WriteOutput("<br>Wrote file:"&arguments.path);	

		
		if (stopAtEnd) {			
			//writeoutput("#js#");		
			writeoutput("<pre>#js#</pre>");		
			abort;		
		}

	</cfscript>
</cffunction>

<cffunction name="getFunctionsSection" access="private" returntype="string" output="true" hint="
Loop over the CFC Functions metadata and create the relevant JS function declarations as well
as the parameters, required, public, private, etc etc			
">
	<cfargument name="cfcFuncs" hint="The metadata functions array" type="array" required="Yes">
	<cfargument name="isPersistent" hint="Whether or not this CFC is persistent" type="boolean" required="Yes">
	<cfscript>
		var local = {};
		var cfcFunctions = arguments.cfcFuncs;
		var NL = instance.NL;
		var js = '';	
		
		for (local.i=1; i lte arrayLen(cfcFunctions); i=i+1) {
			
			local.access = '';
			local.includeThisFunction = true;
			
			if (structKeyExists(cfcFunctions[i],'ColdDoc:ignore')) includeThisFunction = false;
			
			if (includeThisFunction and structKeyExists(cfcFunctions[i],'access')){
				local.access = cfcFunctions[i].access;
				
				if (cfcFunctions[i].access eq "private") {				 
										// If they have asked to Ignore Private methods, 
					if (instance.strategyOptions.IgnorePrivateMethods) {
						includeThisFunction = false;
					}				
				}
			}
			
			if (includeThisFunction) {			
							// Start the JSDuck block for this function / method
				js = js & NL & "/**";
				
							// Get the method / function hint content, if it exists
				local.hint = "";
				if (structKeyExists(cfcFunctions[i],'hint')){
					hint = cfcFunctions[i].hint;
				} else {
					if (not arguments.isPersistent) hint = instance.strategyOptions.MissingHintString;	
				}
				
							// Add the function Hint text
				js = js & NL & hint & NL;
	
							
							// Public/Private method
				if (local.access neq "" and local.access neq "public") {
					js = js & NL & "@" & local.access & NL; 
				}
	
							
							// Get the function parameters and create the JSDuck notation
				local.parameterStruct = getParametersSection(cfcFunctions[i].parameters,arguments.isPersistent);
				
				local.methodAnnotation = parameterStruct.paramAnnotation;
				
							// Add the return type for the function
				local.returnType = "any";	
				if (structKeyExists(cfcFunctions[i],'returntype')) local.returnType = LCase(cfcFunctions[i].returntype);	
				methodAnnotation = methodAnnotation & "@return {#local.returnType#}" &NL;
	
										// If there is a colddoc:generic custom annotation on the function tag
										// it is telling us the data types of the return type
										// See the ColdDuck documentation for more details
										// TODO: could make this more meaningful.  See the IDEAS list at the top of this CFC
				if (structKeyExists(cfcFunctions[i],'colddoc:generic')){
					local.generics = getGenericTypes(cfcFunctions[i],instance.packageName);
					for (local.g=1; g lte arrayLen(generics); g=g+1) {
						methodAnnotation = methodAnnotation & "@return {#generics[g]#} return.property#g#" &NL;
					}
				}
				
										// End of function JSDuck annotation text
				js = js & methodAnnotation & "*/" &NL; 
										
										// Write the function declaration
				js = js & "#cfcFunctions[i].name#: function(#parameterStruct.parmList#){}";
	
										// Add a comma to the end of the function if it isnt the last function
										// JSDuck warns about invalid JS
				if (i neq arrayLen(cfcFunctions)) js = js & ",";
				
				js = js & NL;
			} // includeThisFunction			
		} // End loop cfcFunctions	
		
		return js;
	</cfscript>
</cffunction>

<cffunction name="getParametersSection" access="private" returntype="struct" output="true" hint="
Process the parameters / arguments array from a function 

Add property tags and related data			
">
	<cfargument name="cfcParams" hint="The metadata parameters array" type="array" required="Yes">
	<cfargument name="isPersistent" hint="Whether or not this CFC is persistent" type="boolean" required="Yes">
	<cfscript>
		var local = {};
		var parameters = arguments.cfcParams;
		var NL = instance.NL;

		local.parmList = '';
		local.paramAnnotation = '';
					// Loop over the function parameters, adding relevant JSDuck annotation
		for (local.p=1; p lte arrayLen(parameters); p=p+1) {			

					// Data type. Some of these are not known by JSDuck so will generate
					// warnings when it reads them. It allows them OK.
					// Use the --external command line option to suppress the warnings
					// eg --external=struct,query
			local.pType = "any";
			if (structKeyExists(parameters[p],'type')) pType = LCase(parameters[p].type);

					// Parameter hint
			hint = "";
			if (not arguments.isPersistent) hint = instance.strategyOptions.MissingHintString;
			if (structKeyExists(parameters[p],'hint')) hint = parameters[p].hint;
			
					// Process the parameter name
					// Look at whether it is required or not and any default values
			local.paramNameStr = parameters[p].name;
			local.paramNameAnnotateStr = paramNameStr;
			
			if (structKeyExists(parameters[p],'required')) {
				if (not parameters[p].required) {
								// Not required. Therefore there should be a 'default' attribute
					local.defValue = 'any';
					if (structKeyExists(parameters[p],'default')) {
						if (parameters[p]['default'] neq '') {
							if (parameters[p]['default'] eq '[runtime expression]') {
								defValue = 'expression';
							} else {
								defValue = parameters[p]['default'];
							}
							
						} else {
							defValue = "''";
						}
					}
					paramNameAnnotateStr = '[#parameters[p].name#=#defValue#]';
				} else {
					paramNameAnnotateStr = paramNameAnnotateStr & " Required";
				}
			}		
							
					// Save the parameter name to a list to use in the JS function() line
			parmList = ListAppend(parmList,paramNameStr);				
					
					// Make the param text
			paramAnnotation = paramAnnotation & "@param {#pType#} #paramNameAnnotateStr# #hint#" & NL;


									// If there is a colddoc:generic custom annotation on the arguments tag
									// it is telling us the data types of the argument type.
									// See the ColdDuck documentation for more details
									// TODO: could make this more meaningful. See the IDEAS list at the top of this CFC
			if (structKeyExists(parameters[p],'colddoc:generic')){
				local.generics = getGenericTypes(parameters[p],instance.packageName);
				for (local.g=1; g lte arrayLen(generics); g=g+1) {
					paramAnnotation = paramAnnotation & "@param {#generics[g]#} #paramNameStr#.property#g#" &NL;
				}
			}
				
								
		} // End loop function parameters
			
		return {
			parmList = parmList,
			paramAnnotation = paramAnnotation
		};
	</cfscript>
</cffunction>

<cffunction name="getPropertiesSection" access="private" returntype="string" output="true" hint="
Process the properties array from the CFC

Add property tags and related data			
">
	<cfargument name="cfcProps" hint="The metadata properties array" type="array" required="Yes">
	<cfscript>
		var local = {};
		var cfcProperties = arguments.cfcProps;
		var NL = instance.NL;
		var js = '';

						// NOTE: Support for ORM is limited at present.
						// Could do more here later. eg fieldType, persistant property, etc
																						
						// Loop over the metaData properties array and create 
						// the markup			
		for (local.i=1; i lte arrayLen(cfcProperties); i=i+1) {
						// Start the JSDuck block for the properties
			js = js & NL & "/**" &NL;
			
						// Get the hint content, if it exists
			local.hint = instance.strategyOptions.MissingHintString;
			if (structKeyExists(cfcProperties[i],'hint')){
				hint = cfcProperties[i].hint;
			}
			
						// Data type
			local.pType = "any";
			if (structKeyExists(cfcProperties[i],'type')) pType = LCase(cfcProperties[i].type);

						// Process the property name
						// Look at whether it is required or not and any default values
			local.propNameStr = cfcProperties[i].name;
			local.propNameAnnotateStr = propNameStr & " Required.";
			
			if (structKeyExists(cfcProperties[i],'required')) {
				if (not cfcProperties[i].required) {
								// Not required. Therefore there should be a 'default' attribute
					local.defValue = 'any';
					if (structKeyExists(cfcProperties[i],'default')) {
						if (cfcProperties[i]['default'] neq '') {
							defValue = LCase(cfcProperties[i]['default']);
						} else {
							defValue = "''";
						}
						
					}
					propNameAnnotateStr = '[#cfcProperties[i].name#=#defValue#]';
				}
			}

								// Write the tag
								// eg @property {Type} [name="default value"]
			js = js & "@property {#pType#} #propNameAnnotateStr# #hint#" & NL & "*/" & NL;
						
		} // End loop cfcProperties			
		return js;
	</cfscript>
</cffunction>

<cffunction name="getPackageAndName" access="private" returntype="string" output="true" hint="
Removes the extraneous path information and returns just the relevant package and name.

The CF Metadata Name / FullName properties contain dot notation of the path from the web root to 
the CFC in question. For documentation purposes we dont want the who path - well at least that is the decision I made.

This could be an option later.

What this does is returns just the right hand part of the path starting with the folder that was specified
in the parameters to ColdDoc. That way, the documentation starts with the 'package' in question. 
">
	<cfargument name="packageName" hint="The package name" type="string" required="Yes">
	<cfargument name="metaName" hint="The name from the component metadata" type="string" required="Yes">
	<cfscript>
		var local = {};
						// We could also pass the DisplayName and use that here instead of the cfc filename.
						// Set the last list item delimited by '.' to the DisplayName.
						// NOTE that you might run into issues if you are using extend and the extend is 
						// different to the displayName.
		local.PackAndName = arguments.metaName;
						// Find the package in the path
		local.packagePos = findNoCase(arguments.packageName,arguments.metaName);
						// If found, drop the left hand part of the path up to that point
						// If not found, it returns the whole path
		if (packagePos) {
			PackAndName = mid(arguments.metaName,packagePos,len(arguments.metaName));
		}
		return PackAndName;
	</cfscript>
</cffunction>

<cffunction name="setOptions" access="public" returntype="void" output="false">
	<cfargument name="opts" type="struct" required="no" default="#StructNew()#" hint="
	Set options for this Strategy
	">
	<cfscript>
		// Override the default options with any passed in
		for (opt in arguments.opts) {
			instance.strategyOptions[opt] = arguments.opts[opt];
		}
	</cfscript>	

</cffunction>

<!--- As per HTML strategy from here down --->
<cffunction name="getOutputDir" access="private" returntype="string" output="false">
	<cfreturn instance.outputDir />
</cffunction>

<cffunction name="setOutputDir" access="private" returntype="void" output="false">
	<cfargument name="outputDir" type="string" required="true">
	<cfset instance.outputDir = arguments.outputDir />
</cffunction>

<cffunction name="getProjectTitle" access="private" returntype="string" output="false">
	<cfreturn instance.projectTitle />
</cffunction>

<cffunction name="setProjectTitle" access="private" returntype="void" output="false">
	<cfargument name="projectTitle" type="string" required="true">
	<cfset instance.projectTitle = arguments.projectTitle />
</cffunction>


</cfcomponent>