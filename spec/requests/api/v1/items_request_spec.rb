require 'rails_helper'

describe "Items API endpoint" do
  it "sends a list of all Items" do
    merchant = Merchant.create(name: "Bob's Burgers")
    create_list(:item, 6)

    get "/api/v1/items"

    expect(response).to be_successful
  end
end