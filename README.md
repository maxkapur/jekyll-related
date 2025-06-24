---
layout: post
title:  "Super secret title for the README"
categories: jekyll update
---

# Jekyll related posts plugin

Jekyll plugin to identify and link to related posts.

There are other related posts plugins for Jekyll,[^1][^2][^3] but this one is
mine. 😁

Prior to building your site, `jekyll-related` attaches a bit of metadata to each
posts that ranks all the other posts from most to least related. You can use
this metadata as you wish in your post templates.

"Relatedness" is computed by counting similar word frequencies, with a little
extra weight given to words that are rare (like "submodular") and less to words
that are frequent (like "then").

[^1]: https://rubygems.org/gems/jekyll-related-posts
[^2]: https://rubygems.org/gems/jekyll-tfidf-related-posts
[^3]: https://rubygems.org/gems/jekyll-tagging-related_posts

## Installation

TODO: Replace
`UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG` with your
gem name right after releasing it to RubyGems.org. Please do not do it earlier
due to security reasons. Alternatively, replace this section with instructions
to install your gem from git if you don't plan to release to RubyGems.org.

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

If bundler is not being used to manage dependencies, install the gem by
executing:

```bash
gem install UPDATE_WITH_YOUR_GEM_NAME_IMMEDIATELY_AFTER_RELEASE_TO_RUBYGEMS_ORG
```

## Usage

TODO: I will flesh this out a bit more, but for now, see
[`_includes/related.html`](https://github.com/maxkapur/maxkapur.github.io/blob/e4b6bbc5c418039432a6e2628a287988437e3d0c/_includes/related.html)
in my personal site for an example of how to use the `.data["related"]` metadata
in a Liquid template.

You may configure the following options in your site's `_config.yml`; the values
below are the defaults:

```yaml
related:
  # Number of related posts to show. The plugin itself doesn't do anything with
  # this at the moment (it always ranks all posts); it's up to the template to
  # implement this functionality.
  count: 2
  # Relative weight between the most and least frequent words in the corpus.
  # A value close to 1 means all words have similar weight; a high value means
  # rare words matter a lot. Decrease this value if your recommendations feel 
  # too random; increase this value if your recommendations are too similar for
  # different posts.
  factor: 10.0
```

## Goals

Eventually, I would like to provide a `related_posts` Liquid tag that will
automatically produce the list of related posts. Or maybe I won't do that, since
there are lots of different ways you could choose to format it.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can
also run `bin/console` for an interactive prompt that will allow you to
experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and the created tag, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/maxkapur/jekyll-related.

## License

The gem is available as open source under the terms of the [MIT
License](https://opensource.org/licenses/MIT).
