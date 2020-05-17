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

  describe 'custom methods' do
    describe "top ten" do
      it "returns 0 if no works in category" do
        result = Work.top_ten["movie"]
        expect(result.length).must_equal 0
      end 

      it "returns the top works highest votes < 10 works" do
        result = Work.top_ten["album"]
        expect(result.length).must_equal 1
      end 

      it "returns the top ten highest votes > 10 works" do
        15.times do |x|
          Work.create({
            category: "book",
            title: x,
            creator: "some creator",
            publication_year: 2020,
            description: "some description"
          })
        end

        result = Work.top_ten["book"]
        expect(result.length).must_equal 10
      end 
    end

    describe "order works" do
      it "order works by highest vote" do
        result = Work.order_works

        expect(result[0].title).must_equal works(:saucepan).title
        expect(result[1].title).must_equal works(:song).title
      end
    end
  end
end
