require 'rails_helper'

describe "Items API endpoint" do
  it "sends a list of all Items" do
    merchant = Merchant.create(name: "Bob's Burgers")
    create_list(:item, 6)

    get "/api/v1/items"

    expect(response).to be_successful
  end

  it "sends a single item with a specified id" do
    merchant = Merchant.create(name: "Bob's Burgers")
    create_list(:item, 6)
    item = Item.create(name: "Burger", description: "Yummy", unit_price: 10.0, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful
  end
end