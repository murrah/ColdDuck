Ext.data.JsonP.blog({"guide":"<h1 id='blog-section-blog-cfc'>Blog.cfc</h1>\n\n<pre><code>&lt;cfcomponent displayname=\"Blog\" extends=\"MyBaseClass\"  output=\"false\" hint=\"\nI am a component that blogs. \n\nNot only that, I am really good at it!\n\"&gt;  \n&lt;cfscript&gt;\n                // Hmmmm.... apart from adding text to the component hint itself,\n                // I cant think of a way to auto document these kinds of \n                // instance, variable or THIS declarations without deeply introspecting\n                // the java classes (which, of course, is a possibility!)  \n    instance.options = {};\n    instance.options.commentSize = 1000;    \n    instance.options.commentHeader = \"Your comments:\";\n\n    variables.someStruct = {};\n\n    THIS.myUUID = \"ED1FD0C5-1C42-DD1E-7DF058B857426823\";    \n&lt;/cfscript&gt;\n\n&lt;cffunction name=\"getOptions\" returntype=\"struct\" colddoc:generic=\"numeric,string\" access=\"public\" hint=\"\nReturn the current instance.options structure\n\"&gt;\n    &lt;cfscript&gt;\n        return instance.options;\n    &lt;/cfscript&gt;\n&lt;/cffunction&gt;\n\n&lt;cffunction name=\"addPost\" returntype=\"any\" access=\"public\" hint=\"\nI add a blog post\n\nYou must always be nice in blog posts!\n\"&gt;\n    &lt;cfargument name=\"postText\" type=\"string\" required=\"yes\" default=\"\" hint=\"The text to post\"&gt;\n    &lt;cfscript&gt;\n        return \"\";\n    &lt;/cfscript&gt;\n&lt;/cffunction&gt;\n\n\n&lt;cffunction name=\"removePost\" returntype=\"numeric\" access=\"public\" hint=\"\nI remove a blog post\n\"&gt;\n    &lt;cfargument name=\"postId\" required=\"yes\" hint=\"The postId\"&gt;\n    &lt;cfscript&gt;\n        return arguments.postId;\n    &lt;/cfscript&gt;\n&lt;/cffunction&gt;\n\n&lt;cffunction name=\"countPosts\" returntype=\"numeric\" access=\"private\" hint=\"\nI count posts, optionally only for the supplied data structure\n\"&gt;\n    &lt;cfargument name=\"limitData\" type=\"struct\" colddoc:generic=\"string,numeric,boolean\" required=\"no\" default=\"#StructNew()#\" hint=\"The data to tell us how to limit the search\"&gt;\n    &lt;cfscript&gt;\n        return 0;\n    &lt;/cfscript&gt;\n&lt;/cffunction&gt;\n\n&lt;/cfcomponent&gt;\n</code></pre>\n","title":"Blog"});