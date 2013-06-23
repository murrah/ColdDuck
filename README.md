# ColdDuck

Beta v0.1

... beautiful documentation for your ColdFusion classes by leveraging [ColdDoc](https://github.com/markmandel/ColdDoc) and [JSDuck](https://github.com/senchalabs/jsduck). 

## Background
I have been a consumer of the Sencha ExtJS documentation for a while now and wanted to be able to use JSDuck for my ColdFusion CFCs. But how? While I am a JSDuck novice I figured that trying to make JSDuck produce documentation directly from ColdFusion CFCs was likely to result in tears (mine!). So, after some thought, I came up with another strategy that users of other programming languages might want to consider.

**Note:** *I am a JSDuck novice, a part-time ColdFusion coder and a first time GitHub user. I don't know much about Macs so this is all a bit Windows-centric even though everything should work on a Mac (apart from the Windows command lines of course!). Any helpful advice will be gratefully accepted.*

## My CF to JSDuck strategy
Mark Mandel's ColdDoc can be extended to produce different kinds of output by utilising a "strategy" cfc. It comes with one that produces the JavaDoc style HTML format. Strategies utilise the CF ComponentMetaData. So, I made my own strategy that takes ColdFusion CFCs and makes a pseudo-app in JavaScript code that is annotated using JSDuck formatting. Of course it auto-documents functions etc and picks up the 'hint' attributes where it finds them and uses all that to produce the raw material for rich documentation. It also works with CF ORM CFCs (although this part could be made even richer than it is at present).

Here is a really quick video to give an overview of what ColdDuck does: [http://www.screencast.com/t/5p4JqbvNR](http://www.screencast.com/t/5p4JqbvNR)

Full documentation is in this package, of course.

I hope you find this useful and fun. Perhaps you might like to improve it?

Thanks,
Murray

