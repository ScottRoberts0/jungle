require 'rails_helper'

RSpec.describe ProductSpec, type: :model do
  describe 'Validations' do
    
    
    it 'should exist after save' do
      c = Category.new
      c.name = "Math"
      c.save

      product = Product.new
      product.name = "Bill"
      product.price = 30
      product.quantity = 4
      product.category = c
    
       expect(product.save).to be true
    end


    it 'should validate if there is a name' do      
      c = Category.new
      c.name = "Math"
      c.save

      product = Product.new
      product.name = nil
      product.price = 30
      product.quantity = 4
      product.category = c
      product.save
      
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should validate if there is a price' do    
      c = Category.new
      c.name = "Math"
      c.save

      product = Product.new
      product.name = "Bill"
      product.price = nil
      product.quantity = 4
      product.category = c
      product.save
    
      expect(product.errors.full_messages).to include("Price can't be blank")

    end

    it 'should validate if there is a quanitity' do    
      c = Category.new
      c.name = "Math"
      c.save

      product = Product.new
      product.name = "Bill"
      product.price = 34
      product.quantity = nil
      product.category = c
      product.save
    
      expect(product.errors.full_messages).to include("Quantity can't be blank")

    end

    it 'should validate if there is a category' do    
      product = Product.new
      product.name = "Bill"
      product.price = 34
      product.quantity = 4
      product.category = nil
      product.save
    
      expect(product.errors.full_messages).to include("Category can't be blank")

    end
    
    
  
  end
end
