require "test_helper"

describe User do

  describe 'validations' do
    before do
      @user = users(:hatter)
    end

    it 'is valid when all fields are present' do
      result = @user.valid?
      expect(result).must_equal true
    end

    it 'is invalid without a username' do
      @user.username = nil
      result = @user.valid?
    
      expect(result).must_equal false
      expect(@user.errors.messages).must_include :username
    end

    it 'cannot create a user with an existing username' do
      @new_user = User.new(username: @user.username)
      result = @new_user.save

      expect(result).must_equal false
    end
  end

  describe 'relations' do
    before do
      @user = users(:hatter)
      @work_one = works(:song)
      @work_two = works(:saucepan)

      votes(:hatter_vote_song)
      votes(:hatter_vote_saucepan)
    end

    it "can establish multiple votes and indirect relation to works" do
      expect(@user.votes.length).must_equal 2
      expect(@user.works.length).must_equal 2

      expect(@user.works[0].id).must_equal @work_one.id
      expect(@user.works[1].id).must_equal @work_two.id
    end
  end

end
