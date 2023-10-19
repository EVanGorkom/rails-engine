require 'rails_helper'

describe "Items API endpoint" do
  it "sends a list of all Items" do
    merchant = Merchant.create(name: "Bob's Burgers")
    create_list(:item, 6)

    get "/api/v1/items"

    expect(response).to be_successful
  end

  it "can get one item by its id" do
    merchant = Merchant.create(name: "Bob's Burgers")
    create_list(:item, 6)
    item = Item.create(name: "Burger", description: "Yummy", unit_price: 10.0, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful
  end

  it "can create a new item" do
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

  it "can update an existing item" do
    merchant = Merchant.create(name: "Bob's Burgers")
    create_list(:item, 6)

    item = Item.create(name: "Burg", description: "Yummy", unit_price: 10.0, merchant_id: merchant.id)

    previous_name = Item.last.name
    item_params = { name: "Big Burg" }
    headers = {"CONTENT_TYPE" => "application/json"}
  
    patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: item.id)
  
    expect(response).to be_successful
    expect(item.name).to_not eq(previous_name)
    expect(item.name).to eq("Big Burg")
  end

  it "can delete an item by it's id" do
    merchant = Merchant.create(name: "Bob's Burgers")
    create_list(:item, 6)
    item = Item.create(name: "Burger", description: "Yummy", unit_price: 10.0, merchant_id: merchant.id)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end