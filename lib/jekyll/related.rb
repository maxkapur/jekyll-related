# frozen_string_literal: true

require_relative "related/version"
require_relative "tag"

require "tokenizer"

TOKENIZER = Tokenizer::WhitespaceTokenizer.new
DEFAULT_FACTOR = 10.0

module Jekyll
  module Related
    class Generator < Jekyll::Generator
      def generate(site)
        # Count tokens within each post.
        post_tallies = site.posts.docs.to_h do |post|
          [post, (TOKENIZER.tokenize post.content.downcase).tally]
        end

        # Count global frequency of each token.
        global_tallies = post_tallies.values.each_with_object(Hash.new(0)) do |p_tally, g_tally|
          p_tally.each_pair do |token, count|
            g_tally[token] += count
          end
        end

        # Convert global frequencies into weights for each factor.
        factor = site.config.dig("related", "factor") || DEFAULT_FACTOR
        # Weights decay expontially with frequency, so the rarest tokens have
        # weight `1` and the most frequent token has weight `1 / factor`. Thus,
        # we need to choose `beta` so that `exp(beta * max_count) = 1 / factor`,
        # i.e.
        beta = -Math.log(factor) / global_tallies.values.max
        token_weights = global_tallies.transform_values do |count|
          Math.exp(beta * count) / factor
        end

        # Compute token volume for each post as token tally * weight. Also
        # compute the 2-norm of volumes since we will need it later.
        @post_token_volume = post_tallies.to_h do |post, tally|
          volume = tally.to_h do |token, count|
            [token, token_weights[token] * count]
          end
          volume.default = 0.0
          norm = Math.sqrt(volume.values.map { |x| x**2 }.sum)
          [post, {volume: volume, norm: norm}]
        end

        # Compute similarity score for each post against every other as cosine
        # similarity between the volumes.
        most_similar = nil, nil
        highest_similarity = -Float::INFINITY
        site.posts.docs.each do |current_post|
          current_post.data["related"] = site.posts.docs.filter do |related_post|
            related_post != current_post
          end.map do |related_post|
            score = similarity(current_post, related_post)
            if score > highest_similarity
              most_similar = current_post.data["title"], related_post.data["title"]
              highest_similarity = score
            end
            {"post" => related_post, "score" => score}
          end.sort_by { |item| -item["score"] }
        end

        n = site.posts.docs.length
        message = "Processed #{n} post" + ((n == 1) ? "" : "s")
        Jekyll.logger.info "Related posts:", message
        unless n == 1
          Jekyll.logger.info "Highest similarity:", "\"#{most_similar.first}\""
          Jekyll.logger.info "and", "\"#{most_similar.last}\""
          Jekyll.logger.info "with score", "#{"%.4f" % highest_similarity}."
        end
      end

      # Cosine similarity between the two count vectors
      def similarity(current_post, related_post)
        v_current = @post_token_volume[current_post][:volume]
        v_related = @post_token_volume[related_post][:volume]
        tokens = (v_current.keys + v_related.keys).uniq

        dot = tokens.reduce(0.0) do |sum, token|
          sum + v_current[token] * v_related[token]
        end
        dot / (@post_token_volume[current_post][:norm] * @post_token_volume[related_post][:norm])
      end
    end
  end
end
