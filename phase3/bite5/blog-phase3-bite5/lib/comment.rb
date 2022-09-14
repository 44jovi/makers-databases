class Comment
  def initialize(content:, author:, post_id:)
    @content = content
    @author = author
    @post_id = post_id
  end

  attr_accessor :content, :author, :post_id, :id
end