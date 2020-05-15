require "test_helper"

describe Work do

  describe 'validations' do
    before do
      @work = works(:song)
    end

    it 'is valid when all fields are present' do
      result = @work.valid?
      expect(result).must_equal true
    end

    it 'is invalid without a category' do
      @work.category = nil
      result = @work.valid?
    
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :category
    end

    it 'is invalid without a title' do
      @work.title = nil
      result = @work.valid?
    
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end

    it 'is invalid without a creator' do
      @work.creator = nil
      result = @work.valid?
    
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :creator
    end

    it 'is invalid without a publication_year' do
      @work.publication_year = nil
      result = @work.valid?
    
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :publication_year
    end

    it 'is invalid without a description' do
      @work.description = nil
      result = @work.valid?
    
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :description
    end

    it 'cannot create a work with an existing title' do
      @new_work = Work.new(
        category: @work.category,
        title: @work.title,
        creator: @work.creator,
        publication_year: @work.publication_year,
        description: @work.description,
      )
      result = @new_work.save

      expect(result).must_equal false
    end

    it 'can create a work with an diff title, all else same' do
      @new_work = Work.new(
        category: @work.category,
        title: "House of Many Ways",
        creator: @work.creator,
        publication_year: @work.publication_year,
        description: @work.description,
      )
      result = @new_work.save

      expect(result).must_equal true
    end
  end

  describe 'relations' do
    before do
      @work = works(:saucepan)

      @user_one = users(:hatter)
      @user_two = users(:howl)

      votes(:hatter_vote_saucepan)
      votes(:howl_vote_saucepan)
    end

    it "can establish multiple votes and indirect relation to works" do
      expect(@work.votes.length).must_equal 2
      expect(@work.users.length).must_equal 2

      expect(@work.users[0].id).must_equal @user_one.id
      expect(@work.users[1].id).must_equal @user_two.id
    end
  end


end
