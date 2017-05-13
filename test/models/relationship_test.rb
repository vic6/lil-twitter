require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: users(:victor).id,
                                     followed_id: users(:smitty).id)
  end

  test 'should be vailid' do
    assert @relationship.valid?
  end

  test 'shold require a follower' do
    assert @relationship.follower_id == users(:victor).id
  end

  test 'should require someone to be followd' do
    assert @relationship.followed_id == users(:smitty).id
  end
end
