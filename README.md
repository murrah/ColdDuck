# ColdDuck

Beta v0.2

... beautiful documentation for your ColdFusion classes by leveraging [ColdDoc](https://github.com/markmandel/ColdDoc) and [JSDuck](https://github.com/senchalabs/jsduck). 

## Background
I have been a consumer of the Sencha ExtJS documentation for a while now and wanted to be able to use JSDuck for my ColdFusion CFCs. But how? While I am a JSDuck novice I figured that trying to make JSDuck produce documentation directly from ColdFusion CFCs was likely to result in tears (mine!). So, after some thought, I came up with another strategy that users of other programming languages might want to consider.

**Note:** *I am a JSDuck novice, a part-time ColdFusion coder and a first time GitHub user. I don't know much about Macs so this is all a bit Windows-centric even though everything should work on a Mac (apart from the Windows command lines of course!). Any helpful advice will be gratefully accepted.*

## My CF to JSDuck strategy
Mark Mandel's ColdDoc can be extended to produce different kinds of output by utilising a "strategy" cfc. It comes with one that produces the JavaDoc style HTML format. Strategies utilise the CF ComponentMetaData. So, I made my own strategy that takes ColdFusion CFCs and makes a pseudo-app in JavaScript code that is annotated using JSDuck formatting. Of course it auto-documents functions etc and picks up the 'hint' attributes where it finds them and uses all that to produce the raw material for rich documentation. It also works with CF ORM CFCs (although this part could be made even richer than it is at present).

### Video overview
Here is a really quick video to give an overview of what ColdDuck does: [http://www.screencast.com/t/5p4JqbvNR](http://www.screencast.com/t/5p4JqbvNR)

### Documentation
The ColdDuck package includes the documentation. You can also view it here [http://murrah.com.au/coldduck/docs](http://murrah.com.au/coldduck/docs)
### Sample output
Here is the sample SuperBlog app documented with ColdDoc in [JavaDoc format](http://murrah.com.au/coldduck/samples/superblogcfc/javadoc/)

Here is the sample SuperBlog app documented with ColdDuck in [JSDuck format](http://murrah.com.au/coldduck/samples/superblogcfc/docs)

A full implementation of JSDuck style documentation is here [http://docs.sencha.com/extjs/4.1.3/](http://docs.sencha.com/extjs/4.1.3/)

Almost all of that JSDuck functionality is available for you to use for your ColdFusion projects. I say "almost" because there are a few JSDuck features that are JavaScript specific (eg view JS class source). 

### Installation
1. Unzip / copy the /ColdDuck folder and contents into your ColdFusion webroot (or a sub folder)
1. Point your web browser at /ColdDuck/docs for the documentation

### Comments
Please leave your comments at [my blog post](http://murrayhopkins.wordpress.com/2013/06/25/coldduck-beautiful-documentation-for-coldfusion-cfcs/)

I hope you find this useful and fun. Perhaps you might like to improve it?

Thanks,
Murray

