require 'rails_helper'

describe "Items API endpoint" do
  it "sends a list of all Items" do
    merchant = create(:merchant)
    item_list = create_list(:item, 6)

    get "/api/v1/items"

    expect(response).to be_successful
  end

  it "can get one item by its id" do
    merchant = create(:merchant)
    item = Item.create(name: "Burger", description: "Yummy", unit_price: 10.0, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}"

    expect(response).to be_successful
  end

  it "can create a new item" do
    merchant = create(:merchant)
    items = create_list(:item, 6)

    item_params = ({
                    name: "Burger",
                    description: "Yummy",
                    unit_price: 10.0,
                    merchant_id: merchant.id
    })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful

    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
    expect(created_item.merchant_id).to eq(item_params[:merchant_id])
  end

  it "can update an existing item" do
    merchant = create(:merchant)
    create_list(:item, 6)

    item = Item.create(name: "Burg", description: "Yummy", unit_price: 10.0, merchant_id: merchant.id)

    previous_name = Item.last.name
    item_params = ({ 
                    name: "Big Burger",
                    description: item.description,
                    unit_price: item.unit_price,
                    merchant_id: item.merchant_id
    })
    headers = {"CONTENT_TYPE" => "application/json"}
  
    patch "/api/v1/items/#{item.id}", headers: headers, params: JSON.generate({item: item_params})
    found_item = Item.find_by(id: item.id)
  
    expect(response).to be_successful
    expect(found_item.name).to_not eq(previous_name)
    expect(found_item.name).to eq("Big Burger")
  end

  it "can delete an item by it's id" do
    merchant = create(:merchant)
    create_list(:item, 6)
    item = Item.create(name: "Burger", description: "Yummy", unit_price: 10.0, merchant_id: merchant.id)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect{Item.find(item.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it "can fetch the data of the merchant associated to the item" do
    merchant = create(:merchant)
    create_list(:item, 6)
    item = Item.create(name: "Burger", description: "Yummy", unit_price: 10.0, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful
  end
end