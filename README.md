# Care Home Search

### Search for care homes in your local area.

[![Build Status](https://travis-ci.org/NHSChoices/care-home-search.png)](https://travis-ci.org/NHSChoices/care-home-search)
[![Code Climate](https://codeclimate.com/github/NHSChoices/care-home-search.png)](https://codeclimate.com/github/NHSChoices/care-home-search)
[![Coverage Status](https://coveralls.io/repos/NHSChoices/care-home-search/badge.png?branch=master)](https://coveralls.io/r/NHSChoices/care-home-search?branch=master)

As well as allowing users to search for care homes in their local area, this application is intended to act as an example use of NHS Choices syndication data.

# Using NHS Choices Syndication Data
##An Example App

### Introduction

NHS Choices provides a lot of interesting, useful data through our Syndication feeds. This post describes the creation of an example application (source code on [github](http://github.com/NHSCHoices/care-home-search)) in the hope it provides some insight into the kind of things the syndication data could be used for, as well as how to use it.

The example we've chosen is a website that allows you to search for care homes in your local area. By the end of these posts we'll have done a couple of interesting things, including implementing a postcode search and using the Google Maps API to display the results on a map.

Our language of choice will be Ruby, and our web framework, perhaps inevitably, will be Rails. Don't worry too much if you code in something else: I'm going to leave out most of the details specific to Ruby and Rails and focus on the code related to the NHSChoices syndication API, so hopefully there'll still be plenty here you find useful!

### Getting started

The first thing we need to do is explore the Syndication API. We want to find out what relevant data there is, and how we access it. To do this we'll need an API key - in case you've yet to register for one, details of how to do so can be found [here](http://www.nhs.uk/aboutnhschoices/professionals/syndication/Pages/Webservices.aspx).

The root of the Syndication API can be found at the following URL. Replace `XXXX` with your API key.

    http://v1.syndication.nhschoices.nhs.uk/?apikey=XXXX

This is what you should see:


<img src="http://i.imgur.com/eJ7cv3z.png" width="100%"/>

Before continuing with this post, it's worth having a look around the different links to get a feel for the data that's available and how it's structured. Note, as well, the link in the top right which will give you access to the current page in a variety of different formats.

### Finding care homes

A good first bet could be that care homes will be listed under "Organisations". Following the link, we see that there's a subsection for "Care Providers".

<img src="http://i.imgur.com/0rzUmAc.png" width="100%"/>

Unfortunately, it soon becomes apparent that the "Care Providers" organisation type covers many more types of care than simply that for older people, such as care for the young and those with mental health issues. We're going to have to approach this by a different route.

Instead of looking straight for the providing organisation, let's search instead for the relevant *service*. As a single organisation can provide many services, this should give us much more fine-grained contol over what we're searching for.

So, back from the Syndication home page, we click "Services", then "Types", and scan through the list for the ones that are most relevant. Here, there's probably one main one: "Caring for adults over 65". Let's click on that. This is the page you should now see:

<img src="http://i.imgur.com/FqcnLjB.png" width="100%"/>

The "By postcode" search looks like exactly what we want. Let's investigate.

<img src="http://i.imgur.com/4fhPFnv.png" width="100%"/>

Performing a search for LS1 (Leeds city centre), we can see that the url we need to hit for a postcode search looks like this:

    http://v1.syndication.nhschoices.nhs.uk/services/types/srv0317/postcode/LS1?apikey=XXXX&range=50

Probably the best available format for our purposes is XML, which we can get by adding `.xml` before the query string, like this:

    http://v1.syndication.nhschoices.nhs.uk/services/types/srv0317/postcode/LS1.xml?apikey=XXXX&range=50

Now we know that, it should be easy for us to access a postcode search programmatically, substituting a user-entered postcode for `LS1`.

### Creating an app

I'm going to leave out the details of creating a new Rails app, as you either already know, don't care, or can find out elsewhere. But assuming you have your empty app up and running, here's one way to plug it into Syndication. You need:

* A HTTP library. I'm going to use [Faraday](https://github.com/lostisland/faraday).
* Some way of mapping the returned data to easier-to-handle Ruby models. Optional but *highly* recommended. I'm going to use [Id](https://github.com/rsslldnphy/id).

And that's it for now. This is what querying syndication looks like in Ruby. As I'm in Rails, I'm using the handy `Hash.from_xml` method to slurp up all the returned XML data into a slightly more friendly Ruby hash.


```ruby
def url
  http://v1.syndication.nhschoices.nhs.uk/services/types/srv0317/postcode/LS1.xml?apikey=XXXX&range=50
  end

  def search(postcode)

  end
```
