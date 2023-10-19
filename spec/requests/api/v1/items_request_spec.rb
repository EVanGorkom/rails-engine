require 'rails_helper'

describe "Items API endpoint" do
  it "This endpoint, sends a list of all Items" do
    merchant = Merchant.create(name: "Bob's Burgers")
    create_list(:item, 6)

    get "/api/v1/items"

    expect(response).to be_successful
  end

  it "This endpoint, can get one item by its id" do
    merchant = Merchant.create(name: "Bob's Burgers")
    create_list(:item, 6)
    item = Item.create(name: "Burger", description: "Yummy", unit_price: 10.0, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful
  end

  it "This endpoint, can create a new item" do
    merchant = Merchant.create(name: "Bob's Burgers")
    item_params = ({
                    name: "Burger",
                    description: "Yummy",
                    unit_price: 10.0,
                    merchant: merchant.id
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful
  end
end