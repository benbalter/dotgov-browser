# DotGov Browser

More than two years ago [I took a look at what technology powered Federeal Executive .gov's](http://ben.balter.com/2011/09/07/analysis-of-federal-executive-domains/). This is a WIP recreation of those efforts to see how things have changed.

## Is this information accurate?

Probably not. This data is to be treated as preliminary and is provided “as is” with no guarantee as to its validity. The source code for all tools used, including the resulting data, is [available in GitHub](github.com/benbalter/site-inspector-ruby). If you find a systemic error, I encourage you to fork the code and I will try my best to recrawl the list to improve the data’s accuracy.

## Where does this information come from?

An open source tool called [Site Inspector](github.com/benbalter/site-inspector-ruby)

## I found a mistake

Is it an issue with the site itself? [Open an issue here](https://github.com/benbalter/dotgov-browser/issues/new)

Is it an issue with the underlying data? [Open an issue on Site Inspector](https://github.com/benbalter/site-inspector-ruby/issues/new)

## Bootstrapping locally

`script/bootstrap`

Note: You'll need Mongo installed and running.

## Crawling and seeding the data

`script/setup`

## Running locally

`script/server`


`script/setup`
