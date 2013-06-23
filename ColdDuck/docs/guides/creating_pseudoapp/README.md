# Creating the pseudoApp from your CFCs

Now that you have tested ColdDoc and installed JSDuck you are ready to create JSDuck documentation from your CFCs.

ColdDoc uses "plugins" called "strategies" to enable you to create different kinds of documentation files. We will be leveraging this system to create the pseudoApp in JavaScript format so that JSDuck can use those files to create the documentation.

These are the steps:

## Create a mapping
We have already [covered that here](../docs/#!/guide/colddoc_testing-section-create-a-mapping).
	
### For the SuperBlog sample:
If you are creating documentation for the SuperBlog sample app the mapping should still be set from your ColdDoc test. In that case you shouldnt need to do anything at this step.

### For your CFCs:
Make sure you have a mapping set to the location of your CFCs.

## Set the configuration
Open the builder/BuildColdDocs.cfm file. 
### For the SuperBlog sample: 
Make sure the options are set as follows:
	cfg = {};
	cfg.pathsToCFCs = [
       { inputDir = expandPath("/SuperBlog"),inputMapping = "SuperBlog"}
	];	 
	cfg.PathToGeneratedFiles	= expandPath("/SuperBlog") & "/pseudoapp";
	cfg.DocumentationTitle		= "SuperBlog";
	cfg.ColdDocStrategy			= "coldduck.ColdDuckStrategy";
	cfg.ColdDuckOptions			= {	
		PathToDocs				= expandPath("/SuperBlog") & "/docs"	
	};

### For your CFCs:
Make sure the options are set appropriate to your file locations and mappings. See the BuildColdDocs.cfm page for details.
 	
## Create the JS pseudoApp files
With your web browser navigate to your /ColdDuck/builder/BuildColdDocs.cfm file. This will run the script using the the configuration settings and create the files in the folder specifed by cfg.PathToGeneratedFiles (eg /pseudoapp).

## Next...
Go to [Creating JSDuck documentation](../docs/#!/guide/creating_jsduck)  