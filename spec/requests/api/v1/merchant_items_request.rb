require 'rails_helper'

describe "Merchant's Items API endpoint" do
  it "sends a list of Items for a Merchant" do
    merchant = Merchant.create(name: "Bob's Burgers")
    create_list(:item, 6)

    get "/api/v1/merchants/#{merchant.id}/items"

    expect(response).to be_successful
  end
end