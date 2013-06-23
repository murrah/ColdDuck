# Testing your ColdDoc installation

Now that you have ColdDoc installed you can create documentation from your CFCs in the JavaDoc style. This will introduce you to the ColdDuck Builder configuration file and test your ColdDoc install.

These are the steps:

## Find the builder files
- Locate the ColdDuck/builder folder.  
- You will find three files there: an Application.cfc, a BuildColdDocs.cfm file, and a BuildDocs.bat Windows batch file. (Can a Mac user provide a Mac equivalent please?) 

Found them? Ok, read on...

## Create a mapping
ColdDoc depends upon there being a CF Mapping to the folder that contains the CFCs that you wish the create documents for. If you dont already have such a mapping set in your CF Administrator you will need to set one in Administrator or in the ColdDuck/builder/application.cfc file.
	
Open the ColdDuck/builder/application.cfc file and you will see that there is a mapping already set for the SuperBlog sample app. Later, when/if you need a mapping for your own CFCs, set it there.

## Set the configuration
Open the ColdDuck/builder/BuildColdDocs.cfm file. You will see a configuration set for the SuperBlog sample app.


If you havent changed it yet, this configuration will be set to use the HTML JavaDoc style documentation. ie
	cfg = {};
	cfg.pathsToCFCs = [
       { inputDir = expandPath("/SuperBlog"),inputMapping = "SuperBlog"}
	];	 
	cfg.PathToGeneratedFiles	= expandPath("/SuperBlog") & "/javadoc"; 
	cfg.DocumentationTitle		= "SuperBlog";
	cfg.ColdDocStrategy			= "api.HTMLAPIStrategy";
	
**NB** For testing your ColdDoc installation the config needs to look like the one shown above.

## Create the JavaDoc style documentation
With your web browser, navigate to your /ColdDuck/builder/BuildColdDocs.cfm file. This will run the script using the the configuration settings and create the documentation in the folder specifed by <b>cfg.PathToGeneratedFiles</b>.

## View your documentation
Navigate to /ColdDuck/SuperBlogCFC/javadoc and you should see your generated documentation!

## Test OK? Next ...
Go to the next step: [Setup ColdDuck](../docs/#!/guide/setup-section-include-the-coldduck-strategy-cfc-in-your-colddoc-installation)


	
	   