require_relative '../spec_helper.rb'

module Jekyll::PaginateV2::Generator
  describe PaginationModel do
    subject { PaginationModel.new(log, page_add, page_del, collection) }

    let(:log) { Proc.new {} }
    let(:page_add) { Proc.new {} }
    let(:page_del) { Proc.new {} }
    let(:collection) { Proc.new { |name| data.fetch(name) } }

    describe "#get_docs_in_collections" do
      let(:data) { Hash['posts' => posts] }
      let(:posts) do
        [
          { 'id' => 1, 'featured' => true, 'hidden' => true },
          { 'id' => 2, 'featured' => true, 'hidden' => false },
          { 'id' => 3, 'featured' => false, 'hidden' => false },
        ]
      end

      it "returns non hidden docs from collection" do
        _(subject.get_docs_in_collections(%w(posts))).must_equal posts[1..-1]
      end
    end
  end
end
