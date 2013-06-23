<cfcomponent output="false">

<cfscript>
	this.name = 'ColdDuckBuilder';
	
	/*  ColdDoc depends upon there being a CF Mapping to the folder that contains the CFCs
		that you wish the create documents for. If you already have such a mapping set in your
		CF Administrator, then you dont need to set one here.
		
		If you dont currently have such a mapping, create one below.	
	*/

	this.mappings[ "/SuperBlog" ] = ExpandPath("../") & "samples\SuperBlogCFC";
		
</cfscript>	
</cfcomponent>