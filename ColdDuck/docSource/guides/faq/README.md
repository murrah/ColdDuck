# Frequently Asked Questions

## Building the pseudoApp
(no questions yet)

## Building the JSDuck documentation site
### Permission denied error in Windows
As at the time of writing there is a file locking problem running JSDuck on Windows. The error you might see amongst the warning messages in the command line console will be something like:

	'mkdir': Permission denied - {path/to/your/docs} (Errno::EACCES)
	
Each time you run JSDuck it attempts to delete the docs folder, create it again, then put the docs in there. It has been reported that the problem is that Windows locks the docs folder on the delete operation then wont let go when it tries to write to it.

I have also noticed that the problem does not seem to occur until I have used Windows Explorer (ie the folder/file browser, I dont mean Internet Explorer web browser) to navigate to a folder containing the output {path/to/your/docs} folder. It looks like once I touch it with Windows Explorer the problem begins. Anecdotal and random.

The workaround I have used is to simply execute the command line again. It is a pain but is seems to work in that the first execution deletes the folder before failing and the second execution is then clear to create it again. That's another good reason to use a batch file!
### Error while parsing {yourfile.js} Unexpected token var
CF allows a function parameter name of 'var'. JavaScript doesnt. Changing the parameter name in CF is the only solution. 

### Packages appearing multiple times in the JSDuck package tree
ColdFusion is not a case sensitive language. JavaScript is. 

So, if you have a CFC eg
	<cfcomponent extends="MyUtils.stringutils">
and somewhere else another CFC with different case on the package
    <cfcomponent extends="myutils.stringutils">
JSDuck will treat these as different packages. The documentation still works, it is just that the package appears twice.

### My component / class is missing from the package tree
If your component has an access="private" attribute it will be marked as 'Private' in JSDuck. The JSDuck default is to NOT show private classes. At the bottom of the package tree is an option 'Show private classes'. Select it and your Private classes will appear.

See also [colddoc:ignore](../docs/#!/guide/cfcoding-section-colddoc-annotations) 
  
### My method / function is missing from the class
If your function has an access="private" attribute it will be marked as 'Private' in JSDuck. The JSDuck default is to NOT show private methods. On the class toolbar on the right hand side there is a button called 'Show'. Click that then tick the 'Private' option and your Private methods will appear.

See also [colddoc:ignore](../docs/#!/guide/cfcoding-section-colddoc-annotations)

  