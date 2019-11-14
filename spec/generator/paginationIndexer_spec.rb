require 'ostruct'
require_relative '../spec_helper.rb'

module Jekyll::PaginateV2::Generator
  describe PaginationIndexer do
    describe "#read_config_value_and_query_posts" do
      subject do
        PaginationIndexer.read_config_value_and_query_posts(config, "query", posts)
      end

      let(:config) { Hash["query" => "featured == true"] }
      let(:posts) do
        [
          create_post({ "id" => 1, "featured" => true }),
          create_post({ "id" => 2, "featured" => true }),
          create_post({ "id" => 3, "featured" => false }),
        ]
      end

      def create_post(data)
        OpenStruct.new(data: data)
      end

      it "filters posts by query" do
        _(subject).must_equal posts[0...-1]
      end

      describe "when posts are nil" do
        let(:posts) { nil }

        it "returns nil" do
          _(subject).must_be_nil
        end
      end

      describe "when config nil" do
        let(:config) { nil }

        it "returns posts" do
          _(subject).must_equal posts
        end
      end

      describe "when config does not contain 'query' key" do
        let(:config) { Hash[] }

        it "returns posts" do
          _(subject).must_equal posts
        end
      end
    end
  end
end
