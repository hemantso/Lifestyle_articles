require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @article = Article.new
  end

  test 'article should be valid' do
    assert_not @article.valid?
  end

  test 'title should be present' do
    @article.title = ' '

    assert_not @article.valid?
  end

  test 'title should not be too long' do
    @article.title = 'a' * 51

    assert_not @article.valid?
  end

  test 'title should not be too short' do
    @article.title = 'aa'

    assert_not @article.valid?
  end

  test 'text should be present' do
    @article.text = ' '

    assert_not @article.valid?
  end

  test 'text should not be too long' do
    @article.text = 'a' * 1001

    assert_not @article.valid?
  end

  test 'text should not be too short' do
    @article.text = 'aa'

    assert_not @article.valid?
  end
end
