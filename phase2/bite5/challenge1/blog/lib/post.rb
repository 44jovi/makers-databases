class Post
  def initialize(content:, title:, author:)
    @content = content
    @title = title
    @author = author
    @comments = []
  end

  attr_accessor :author, :content, :title, :id, :comments
end