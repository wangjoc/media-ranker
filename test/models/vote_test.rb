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
end
