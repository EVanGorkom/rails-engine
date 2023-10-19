require 'rails_helper'

describe "Merchants API" do
  it "sends a list of Merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful
  end

  it "finds a single Merchant" do
    merchant = Merchant.create(name: "Bob's Burgers")

    get "/api/v1/merchants/#{merchant.id}"

    expect(response).to be_successful
  end
end