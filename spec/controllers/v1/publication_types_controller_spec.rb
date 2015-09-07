require 'rails_helper'

RSpec.describe V1::PublicationTypesController, type: :controller do

  describe "index" do
    it "should return a list of publication types" do    
      get :index, api_key: @api_key
      
      expect(json["publication_types"]).to_not be nil
      expect(json["publication_types"]).to be_an(Array)
      expect(json["publication_types"].count).to eq 3
    end
  end

  describe "show" do
    it "should return a publication type for an existing code" do     
      get :show, id: 'journal-articles', api_key: @api_key
      
      expect(json["publication_type"]).to_not be nil
      expect(json["publication_type"]).to be_an(Hash)
    end
    it "should return the publication type name for the default locale" do
      get :show, id: 'journal-articles', api_key: @api_key

      expect(json["publication_type"]["name"]).to_not be nil
      expect(json["publication_type"]["name"].empty?).to be false
    end
    it "should return the publication type name for the locale en" do
      get :show, id: 'journal-articles', locale: 'en', api_key: @api_key
      expect(json["publication_type"]["name"]).to_not be nil
      expect(json["publication_type"]["name"].empty?).to be false
    end
    it "should return an error message for a no existing id" do
      get :show, id: 'non-existing-type', api_key: @api_key
      
      expect(json["error"]).to_not be nil
    end
  end
end
