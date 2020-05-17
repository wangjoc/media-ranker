require "test_helper"

describe Vote do
  describe 'validations' do
    before do
      @vote = votes(:hatter_vote_saucepan)
    end

    it 'is valid when all fields are present' do
      result = @vote.valid?
      expect(result).must_equal true
    end

    it 'is invalid without a user' do
      @vote.user_id = nil
      result = @vote.valid?
    
      expect(result).must_equal false
      expect(@vote.errors.messages).must_include :user
    end

    it 'is invalid without a work' do
      @vote.work_id = nil
      result = @vote.valid?
    
      expect(result).must_equal false
      expect(@vote.errors.messages).must_include :work
    end
  end

  describe 'relations' do
    before do
      @work = works(:saucepan)

      @user_one = users(:hatter)
      @user_two = users(:howl)

      @vote_one = votes(:hatter_vote_saucepan)
      @vote_two = votes(:howl_vote_saucepan)
    end

    it "each vote belongs to one user and one work" do
      expect(@vote_one.user_id).must_equal @user_one.id
      expect(@vote_two.user_id).must_equal @user_two.id

      expect(@vote_one.work_id).must_equal @work.id
      expect(@vote_two.work_id).must_equal @work.id
    end
  end
end
