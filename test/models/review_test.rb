require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "Review with all fields present and valid is valid" do
    reviews(:valid_review).valid?
    assert reviews(:valid_review).valid?
  end

  test "Reviews without a rating, title or description are invalid" do
    reviews(:no_rating_review).invalid?
    assert reviews(:no_rating_review).invalid?
    reviews(:no_title_review).invalid?
    assert reviews(:no_title_review).invalid?
    reviews(:no_description_review).invalid?
    assert reviews(:no_description_review).invalid?
  end

  test "Reviews with ratings that are not 1,2,3,4 or 5 are invalid" do
    reviews(:rating_too_high).invalid?
    assert reviews(:rating_too_high).invalid?
    reviews(:rating_too_low).invalid?
    assert reviews(:rating_too_low).invalid?
    reviews(:rating_decimal).invalid?
  end

end
