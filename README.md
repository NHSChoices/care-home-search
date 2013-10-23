# Care Home Search

### Search for care homes in your local area.

[![Build Status](https://travis-ci.org/NHSChoices/care-home-search.png)](https://travis-ci.org/NHSChoices/care-home-search)
[![Code Climate](https://codeclimate.com/github/NHSChoices/care-home-search.png)](https://codeclimate.com/github/NHSChoices/care-home-search)
[![Coverage Status](https://coveralls.io/repos/NHSChoices/care-home-search/badge.png?branch=master)](https://coveralls.io/r/NHSChoices/care-home-search?branch=master)

As well as allowing users to search for care homes in their local area, this application is intended to act as an example use of NHS Choices syndication data.

To download and run:

    git clone https://github.com/NHSChoices/care-home-search.git
    cd care-home-search
    bundle install
    bundle exec unicorn

Now visit `http://localhost:8080` in your browser.

# Using NHS Choices Syndication Data
##An Example App

### Introduction

NHS Choices provides a lot of interesting, useful data through our Syndication feeds. This post describes the creation of an example application (source code on [github](http://github.com/NHSCHoices/care-home-search)) in the hope it provides some insight into the kind of things the syndication data could be used for, as well as how to use it.

The example we've chosen is a website that allows you to search for care homes in your local area.

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

### Plugging it in

I'm going to leave out the details of creating a new Rails app, as you either already know, don't care, or can find out elsewhere. But assuming you have your empty app up and running, here's one way to plug it into Syndication. For this next step you'll need a HTTP library of your choice. I'll be using [Faraday](https://github.com/lostisland/faraday).

This is what querying syndication looks like in Ruby. As I'm in Rails, I'm using the handy `Hash.from_xml` method to slurp up all the returned XML data into a slightly more friendly Ruby hash. I'm also reading my API key from an environment variable.

```ruby
require 'faraday'

domain  = 'http://v1.syndication.nhschoices.nhs.uk'
action  = '/services/types/srv0317/postcode/'
api_key = ENV['API_KEY']
url     = "#{domain}#{action}#{postcode}?apikey=#{api_key}&range=50"
results = Hash.from_xml(Faraday.get(url))
```

You now have fresh new syndication data, ready to display to your users or do with as you wish. You'll probably want to convert it into model classes to make it a bit easier to work with. I use a library called [id](http://github.com/rsslldnphy/id) to do just this in Ruby. However, in this case, there's not quite enough information in the returned results for my purposes, so I'm going to extract the `id` of each entry with the following code:

```ruby
ids = results['feed']['entry'].map { |entry| entry['id'] }
```

With these ids I can now make individual HTTP requests for the pages of each individual result, getting me the extra info I need. The url for each will look something like this:

    "http://v1.syndication.nhschoices.nhs.uk/services/types/srv0317/#{id}.xml?apikey=#{api_key}"

If we collect the results of these requests in a variable called, for example, `providers`, we can map them to model objects with

```ruby
providers.map(&Provider)
```

The above code assumes the existence of a model class called `Provider`. As of the time of writing, here is its current definition:

```ruby
class Provider
  include Id::Model

  field :id
  field :type
  field :longitude
  field :latitude
  field :distance
  field :name,         key: 'deliverer',    default: "No data available"
  field :summary_html, key: 'summaryText',  optional: true
  field :phone,        key: 'phone',        optional: true
  field :fax,          key: 'fax',          optional: true
  field :website,      key: 'website',      optional: true

  has_one :address,    type: Address
  has_one :coordinate, type: Coordinate, key: 'geographicCoordinates'

  def summary
    summary_html.map(&CGI.method(:unescapeHTML))
  end

  def to_param
    id
  end

  def self.model_name
    ActiveModel::Name.new(self, nil, "Provider")
  end

end
```

And that's where I'm going to leave it for this post. To recap, we've investigated the Syndication API, found data that we want, and plugged in a postcode search using simple HTTP methods and parsed the returned data into nice, clean Ruby models. What you do with that data I'll leave up to you, but if you're interested in having a look at how it can be presented in a Rails app, take a look at the [github for the project](http://github.com/NHSChoices/care-home-search).
