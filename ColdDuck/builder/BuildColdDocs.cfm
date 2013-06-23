<cfscript>
	// Use ColdDoc to generate files

	// Set your configuration below then browse to this cfm script to execute it
	// When first installed these are the correct settings for the SuperBlog sample app
	// to generate JavaDoc style documentation. See the ColdDuck documentation for more details.
	// You can create a set of config files for each of your real CFC libraries
	
	cfg = {};
								// You can document CFCs from multiple separate folders.
								// Include a struct in this array for each discrete folder that 
								// you wish to include in this set of documentation.
								// ColdDoc recurses so sub folders of CFCs will be included automatically
								
								// inputDir = the full path to your CFCs folder								
								// inputMapping = the CF Mapping name to that same folder
	cfg.pathsToCFCs = [
       { inputDir = expandPath("/SuperBlog"),inputMapping = "SuperBlog"}
	];	 
								// The full path to the folder to save the files that ColdDoc generates
	cfg.PathToGeneratedFiles	= expandPath("/SuperBlog") & "/javadoc"; // For JavaDoc style docs
	//cfg.PathToGeneratedFiles	= expandPath("/SuperBlog") & "/pseudoapp"; // For JSDuck input files
				
								// The title that will be used in your documentation
	cfg.DocumentationTitle		= "SuperBlog";
	
								// The ColdDoc strategy to use. Choose one of these strategies.
								// api.HTMLAPIStrategy = generate the JavaDoc style documentation
								// If you use this strategy you MUST leave out the cfg.ColdDuckOptions altogether.
	cfg.ColdDocStrategy			= "api.HTMLAPIStrategy";
	
/* Commented out since we are using the api.HTMLAPIStrategy strategy to start with.
	
								// coldduck.ColdDuckStrategy = generate the JS files to use as input to JSDuck
								// Set the cfg.ColdDuckOptions below
	cfg.ColdDocStrategy			= "coldduck.ColdDuckStrategy";
								
								// ColdDuck options:
								// You can overwrite any single option by including it in your
								// cfg.ColdDuckOptions struct. The following are the default options for your information. 
								// NB: EXCEPT for PathToDocs which defaults to an empty string. 
								// 
								// You could leave them all out if you wish. ie just pass an empty struct:
								// cfg.ColdDuckOptions={}
								// However, if you DO leave them all out your jsduckConfig.json file wont be generated because
								// cfg.ColdDuckOptions.PathToDocs will be an empty string.
								// See below for details.
								
	cfg.ColdDuckOptions			= {
		MissingHintString		= '',		// What to say if there is no hint tag (cfcomponent, cffunction, cfproprty, cfargument) 
		IgnorePrivateClasses	= false,	// True = Dont document classes with access="private"
		IgnorePrivateMethods	= false,	// True = Dont document functions with access="private"
								
								
								// Options for the JSDuck generation part of the process.
								// ColdDuck will create a file called jsduckConfig.json each time you run 
								// this BuildColdDocs.cfm script as long as:
								// 1. PathToDocs is not empty, and
								// 2. JSDuckConfig is not an empty struct
								
								// jsduckConfig.json is a configuration file for JSDuck to make it easier than having
								// a long list of command line arguments to execute.
								// You can control the content of that json file here.
								
								// The full path to the folder in which to save your generated documentation		
		PathToDocs				= expandPath("/SuperBlog") & "/docs",
								
								// The JSDuck config in JSON format.
								// ColdDuck will replace:
								// {DocTitle} with your cfg.DocumentationTitle value
								// {inputPath} with your cfg.PathToGeneratedFiles value ie the output of ColdDoc becomes the input to JSDuck
								// {outputPath} with your cfg.ColdDuckOptions.PathToDocs value
								// If you wish to add or change any of the JSDuckConfig values you need
								// to pass the ENTIRE json data structure, not just your changed values. 
		JSDuckConfig			= '{			
			    "--title"		: "{DocTitle}",
			    "--no-source"	: true,
			    "--external"	: "WEB-INF.cftags.component,numeric,any,struct,array,date,query,str",			    
			    "--warnings"	: ["-link", "-no_doc"],			    
			    "--"			: [{inputPath}],
			    "--output"		: "{outputPath}"
		}'
			
	};
*/

	//======================== Dont need to touch below here ===================	
	WriteOutput("Your config file:");
	WriteDump(cfg); 
								// USe the cfg values to execute ColdDoc
	colddoc = createObject("component", "ColdDoc.coldDoc").init();
	strategy = createObject("component", "colddoc.strategy.#cfg.ColdDocStrategy#").init(cfg.PathToGeneratedFiles, cfg.DocumentationTitle);
	if (structKeyExists(cfg,'ColdDuckOptions')){
		strategy.setOptions(cfg.ColdDuckOptions);
	}
	colddoc.setStrategy(strategy);
	colddoc.generate(cfg.pathsToCFCs);
	
	if (cfg.ColdDocStrategy	eq "api.HTMLAPIStrategy") {
		WriteOutput('<p>Your <b>JavaDoc HTML</b> files are here: #cfg.PathToGeneratedFiles#\index.html</p>');
	}
	if (cfg.ColdDocStrategy	eq "coldduck.ColdDuckStrategy") {
		WriteOutput('<p>Your <b>generated JSDuck</b> input files are here: #cfg.PathToGeneratedFiles#</p>');
		WriteOutput('<p>You can now run JSDuck to generate your documentation.</p>');
	}		

</cfscript>