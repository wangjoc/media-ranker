require "test_helper"

describe User do

  describe 'validations' do
    before do
      @user = users(:hatter)
      # @book = Book.new(title: 'test book', user: user)
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
end
