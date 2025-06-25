# Jekyll related posts plugin

Jekyll plugin to identify and link to related posts.

There are other related posts plugins for Jekyll,[^1][^2][^3] but this one is
mine. 😁

Prior to building your site, `jekyll-related` attaches a bit of metadata to each
posts that ranks all the other posts from most to least related. You can use
this metadata to recommend related posts to your readers, either by using the
included `{% related %}` tag or creating a customized template using the
`page.related` metadata the plugin defines.

"Relatedness" is computed by counting similar word frequencies, with a little
extra weight given to words that are rare (like "submodular") and less to words
that are frequent (like "then").

The [dogfood/](./dogfood/) directory contains a demo Jekyll site which uses the
plugin to rank the similarity of each of the articles in the UN Universal
Declaration of Human Rights. [You can view the demo site on GitHub pages
here.](https://maxkapur.com/jekyll-related/)

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

There are a few ways to use this plugin:

- Modify your post layout [like this example in the demo
  site](./dogfood/_layouts/post.html) to use the '{% related %}` tag. This
  inserts an `<ol class="related-post-list">` with the related post titles,
  links, and dates as list elements. As an easter egg, the links show the  <span
  title="Like this: 849">similarity score in the hover text.</span>
- Create your own template if you want to tweak the list appearance more
  precisely. The [Liquid template](./lib/jekyll/related.html) used by the
  `{% related %}` tag should get you started.

You may configure the following options in your site's `_config.yml`; the values
below are the defaults:

```yaml
related:
  # Number of related posts to show if using the {% related %} tag (the plugin
  # itself always ranks all posts in the metadata). nil means rank all of them.
  count: nil
  # Relative weight between the most and least frequent words in the corpus.
  # A value close to 1 means all words have similar weight; a high value means
  # rare words matter a lot. Decrease this value if your recommendations feel 
  # too random; increase this value if you are getting nearly the same
  # recommendations for every post.
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
