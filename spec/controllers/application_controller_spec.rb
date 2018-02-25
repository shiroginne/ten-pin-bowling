require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def index
      raise ActionController::UnknownFormat
    end

    def show
      raise ActiveRecord::RecordNotFound
    end
  end

  describe "handling UnknownFormat" do
    it "renders JSON with error" do
      get :index

      expect(response).to have_http_status(415)
      expect(response.body).to eq(I18n.t("unsupported_format"))
      expect(response.content_type).to eq("text/plain")
    end
  end

  describe "handling RecordNotFound exceptions" do
    it "renders text with error" do
      get :show, params: { id: 1, format: :json }

      expect(response).to have_http_status(404)
      expect(response.content_type).to eq("application/json")
    end
  end
end
