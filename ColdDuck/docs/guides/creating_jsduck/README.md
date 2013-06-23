# Creating JSDuck documentation from the pseudoApp

This page assumes you have completed all the steps on the [Setup ColdDuck](../docs/#!/guide/setup) page.

## The JSDuck command line
JSDuck runs as an executable and has many command line options. This guide is NOT a comprehensive tutorial on JSDuck - the JSDuck web site (and other tutorial sites) are the best places for that. Having said that, there are a few of the basics following.

To get a list of all the command line options you use the --help option.

*For Windows:*
	path/to/jsduck.exe --help
	
*For Mac:*
	jsduck --help
	
(NB: I am not a Mac user so I hope that is correct!)

## To create the documentation
**[Important note for Windows users](../docs/#!/guide/faq-section-building-the-jsduck-documentation-site)**
### Command line method
**For Windows:**
	path/to/jsduck.exe  path\to\your\pseudoapp --title "My Docs" --no-source --output path\to\your\docs 

eg for the SuperDocs sample (using Windows path syntax):
	path/to/jsduck.exe ..\samples\SuperBlogCFC\pseudoapp --title "ColdDuck Demo: SuperBlog" --no-source --output ..\samples\SuperBlogCFC\docs 

The only mandatory parameters are the input file and the --output file.

It is obviously useful to do this in a batch file. There is one provided here: 
	ColdDuck\builder\BuildDocs.bat 
See below for more on that.

**For Mac**
Adjust the file syntax above.

## JSDuck config file
JSDuck supports the use of a json encoded config file to avoid the need to have long command lines. To use the config file the syntax is:
	path/to/jsduck.exe --config=myConfig.json

In the BuildColdDocs.cfm configuration file you have the option of telling the ColdDuck strategy to create a JSDuck config file for you. You can set your JSDuck options there. ColdDuck will save a file called jsduckConfig.json to the same folder as BuildColdDocs.cfm so that it is ready to be used by the BuildDocs.bat file also in that folder. See BuildColdDocs.cfm for specific details. 
## BuildDocs.bat for Windows
This is a simple batch file that contains:
	path/to/jsduck.exe --config=jsduckConfig.json	
## BuildDocs for Mac 
*(help needed here)*

## To view your documentation
JSDuck generates a mini web site whose home page is {your cfg.PathToGeneratedFiles}/index.html.

This folder contains the required JavaScript libraries to enable the documentation to be viewed in your web browser of choice. It can also be run from the file system - you dont need a web server.

### For the SuperBlog sample: 
Navigate to /ColdDuck/SuperBlogCFC/docs and you should see your generated documentation!

### For your CFCs:
Navigate to the folder specifed by cfg.PathToGeneratedFiles in BuildColdDocs.cfm and you should see your generated documentation!

## Next...
[Tips for ColdFusion documentation](../docs/#!/guide/cfcoding)

[FAQ](../docs/#!/guide/faq)
	 
 


