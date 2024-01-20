require 'rails_helper'
RSpec.describe Product, type: :model do
  describe 'Validations' do
   it 'is valid and should save successfully when all attributes are set' do
    category = Category.create(name: 'EverGreens')
    product = Product.new(
      name: 'Lion Grapevine',
      quantity: 4,
      price: 34.49,
      category: category
    )
    expect(product).to be_valid
    expect(product.save).to be true
    end

  it 'is not valid when the name is missing' do
    category = Category.create(name: 'EverGreens')
    product = Product.new(
      name: nil,
      quantity: 4,
      price: 34.49,
      category: category
    )
    expect(product).not_to be_valid
    expect(product.errors.full_messages).to include("Name can't be blank")
    end
    it 'is not valid when the quantity is missing' do
    category = Category.create(name: 'EverGreens')
    product = Product.new(
        name: 'Lion Grapevine',
        quantity: nil,
        price: 34.49,
        category: category
    )
    expect(product).not_to be_valid
    expect(product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'is not valid when the price is missing' do
    category = Category.create(name: 'EverGreens')
    product = Product.new(
        name: 'Lion Grapevine',
        quantity: 4,
        price: nil,
        category: category
    )
    expect(product).not_to be_valid
    expect(product.errors.full_messages).to include("Price can't be blank")
    end
    it 'is not valid when the category is missing' do
    product = Product.new(
        name: 'Lion Grapevine',
        quantity: 4,
        price: 34.49,
        category: nil
    )
    expect(product).not_to be_valid
    expect(product.errors.full_messages).to include("Category can't be blank")
    end
end
end